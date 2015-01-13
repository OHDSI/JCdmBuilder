/*******************************************************************************
 * Copyright 2015 Observational Health Data Sciences and Informatics
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *   http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 ******************************************************************************/
package org.ohdsi.jCdmBuilder.etls.hcup;

import java.util.Calendar;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import org.ohdsi.databases.RichConnection;
import org.ohdsi.jCdmBuilder.DbSettings;
import org.ohdsi.jCdmBuilder.EtlReport;
import org.ohdsi.jCdmBuilder.cdm.CdmV4NullableChecker;
import org.ohdsi.jCdmBuilder.utilities.CodeToConceptMap;
import org.ohdsi.jCdmBuilder.utilities.ConditionEraGenerator;
import org.ohdsi.jCdmBuilder.utilities.QCSampleConstructor;
import org.ohdsi.utilities.StringUtilities;
import org.ohdsi.utilities.collections.OneToManyList;
import org.ohdsi.utilities.files.ReadCSVFileWithHeader;
import org.ohdsi.utilities.files.Row;

/**
 * Performs the ETL to CDM v4 for the HCUP Inpatient Sample. Assumes the vocabulary is already loaded in the target schema, but that the CDM tables do not yet
 * exist. In the HCUP IS all data used in the ETL comes from the CORE table. This table contains one row per hospital visit. Since there is no way to link
 * patients across visits, each visit is assigned a unique personId.
 * 
 * @author MSCHUEMI
 * 
 */
public class HCUPETL {

	private static final double			QC_SAMPLE_PROBABILITY		= 0.000001;
	public static int					BATCH_SIZE					= 10000;
	public static String[]				diagnoseFields				= new String[] { "DX1", "DX2", "DX3", "DX4", "DX5", "DX6", "DX7", "DX8", "DX9", "DX10",
			"DX11", "DX12", "DX13", "DX14", "DX15", "DX16", "DX17", "DX18", "DX19", "DX20", "DX21", "DX22", "DX23", "DX24", "DX25", "ECODE1", "ECODE2" };
	public static String[]				procedureFields				= new String[] { "PR1", "PR2", "PR3", "PR4", "PR5", "PR6", "PR7", "PR8", "PR9", "PR10",
			"PR11", "PR12", "PR13", "PR14", "PR15"					};
	public static String[]				procedureDayFields			= new String[] { "PRDAY1", "PRDAY2", "PRDAY3", "PRDAY4", "PRDAY5", "PRDAY6", "PRDAY7",
			"PRDAY8", "PRDAY9", "PRDAY10", "PRDAY11", "PRDAY12", "PRDAY13", "PRDAY14", "PRDAY15" };
	public static int[]					diagnoseFieldConceptIds		= new int[] { 38000184, 38000185, 38000186, 38000187, 38000188, 38000189, 38000190,
			38000191, 38000192, 38000193, 38000194, 38000195, 38000196, 38000197, 38000198, 38000198, 38000198, 38000198, 38000198, 38000198, 38000198,
			38000198, 38000198, 38000198, 38000198, 38000184, 38000185 };

	public static int[]					procedureFieldConceptIds	= new int[] { 38000251, 38000252, 38000253, 38000254, 38000255, 38000256, 38000257,
			38000258, 38000259, 38000260, 38000261, 38000262, 38000263, 38000264, 38000265 };
	public static final long			SEED						= 0;

	private RichConnection				sourceConnection;
	private RichConnection				targetConnection;
	private QCSampleConstructor			qcSampleConstructor;
	private EtlReport					etlReport;
	private CdmV4NullableChecker		cdmv4NullableChecker		= new CdmV4NullableChecker();
	private OneToManyList<String, Row>	tableToRows;
	private long						personCount;
	private long						observationPeriodId;
	private Integer						locationId;
	private long						drugExposureId;
	private long						conditionOccurrenceId;
	private long						visitOccurrenceId;
	private long						procedureOccurrenceId;
	private long						procedureCostId;
	private long						visitStartDate;
	private long						visitEndDate;
	private long						primaryProcedureOccurrenceId;

	private Map<String, Integer>		stateCountyToLocationId;
	private Set<Integer>				careSiteIds;

	private Map<String, String>			codeToCounty;
	private CodeToConceptMap			icd9ToConcept;
	private CodeToConceptMap			icd9ToRxNorm;
	private CodeToConceptMap			icd9ProcToConcept;
	private CodeToConceptMap			drgYearToConcept;

	public void process(String folder, DbSettings sourceDbSettings, DbSettings targetDbSettings, int maxPersons) {
		loadMappings(targetDbSettings);

		sourceConnection = new RichConnection(sourceDbSettings.server, sourceDbSettings.domain, sourceDbSettings.user, sourceDbSettings.password,
				sourceDbSettings.dbType);
		sourceConnection.setContext(this.getClass());
		sourceConnection.use(sourceDbSettings.database);

		targetConnection = new RichConnection(targetDbSettings.server, targetDbSettings.domain, targetDbSettings.user, targetDbSettings.password,
				targetDbSettings.dbType);
		targetConnection.setContext(this.getClass());
		targetConnection.use(targetDbSettings.database);

		truncateTables(targetConnection);

		qcSampleConstructor = new QCSampleConstructor(folder + "/sample", QC_SAMPLE_PROBABILITY);
		etlReport = new EtlReport(folder);

		tableToRows = new OneToManyList<String, Row>();
		stateCountyToLocationId = new HashMap<String, Integer>();
		careSiteIds = new HashSet<Integer>();
		personCount = 0;
		drugExposureId = 0;
		conditionOccurrenceId = 0;
		visitOccurrenceId = 0;
		procedureOccurrenceId = 0;
		procedureCostId = 0;
		observationPeriodId = 0;

		StringUtilities.outputWithTime("Processing persons");
		for (Row row : sourceConnection.query("SELECT * FROM core")) {
			processPerson(row);
			if (personCount == maxPersons) {
				System.out.println("Reached limit of " + maxPersons + " persons, terminating");
				break;
			}
			if (personCount % BATCH_SIZE == 0) {
				insertBatch();
				System.out.println("Processed " + personCount + " persons");
			}
		}
		insertBatch();
		System.out.println("Processed " + personCount + " persons");

		qcSampleConstructor.addCdmData(targetConnection, targetDbSettings.database);

		String etlReportName = etlReport.generateETLReport(drgYearToConcept, icd9ProcToConcept, icd9ToConcept, icd9ToRxNorm);
		System.out.println("An ETL report was generated and written to :" + etlReportName);
		if (etlReport.getTotalProblemCount() > 0) {
			String etlProblemListname = etlReport.generateProblemReport();
			System.out.println("An ETL problem list was generated and written to :" + etlProblemListname);
		}

		StringUtilities.outputWithTime("Finished ETL");
	}

	private void truncateTables(RichConnection targetConnection) {
		StringUtilities.outputWithTime("Truncating tables");
		targetConnection
				.execute("TRUNCATE TABLE VISIT_OCCURRENCE;\nTRUNCATE TABLE PROVIDER;\nTRUNCATE TABLE PROCEDURE_OCCURRENCE;\nTRUNCATE TABLE PROCEDURE_COST;\nTRUNCATE TABLE PERSON;\nTRUNCATE TABLE PAYER_PLAN_PERIOD;\nTRUNCATE TABLE ORGANIZATION;\nTRUNCATE TABLE OBSERVATION_PERIOD;\nTRUNCATE TABLE OBSERVATION;\nTRUNCATE TABLE LOCATION;\nTRUNCATE TABLE DRUG_EXPOSURE;\nTRUNCATE TABLE DRUG_ERA;\nTRUNCATE TABLE DEATH;\nTRUNCATE TABLE CONDITION_OCCURRENCE;\nTRUNCATE TABLE CONDITION_ERA;\nTRUNCATE TABLE COHORT;\nTRUNCATE TABLE CARE_SITE;");
	}

	private void processPerson(Row row) {
		etlReport.registerIncomingData("core", row);

		personCount++;
		visitOccurrenceId++;
		observationPeriodId++;
		primaryProcedureOccurrenceId = -1;
		visitStartDate = computeVisitStartDate(row.get("YEAR"), row.get("AMONTH"), row.get("AWEEKEND"), row.get("KEY"));
		visitEndDate = computeVisitEndDate(visitStartDate, row.get("LOS"));
		qcSampleConstructor.registerPersonData("core", row, row.getLong("KEY"));

		if (addToPerson(row)) {
			addToLocation(row);
			addToCareSite(row);
			addToVisitOccurrence(row);
			addToObservationPeriod(row);
			addToConditionOccurrence(row);
			addToDeath(row);
			addToDrugExposure(row);
			addToProcedureOccurrence(row);
			addToProcedureCost(row);
		}
	}

	private void addToConditionEra() {
		ConditionEraGenerator eraGenerator = new ConditionEraGenerator();
		for (Row row : tableToRows.get("condition_occurrence")) {
			long startDate = StringUtilities.databaseTimeStringToDays(row.get("condition_start_date"));
			eraGenerator.addCondition(row.getLong("person_id"), startDate, startDate, row.getLong("condition_concept_id"));
		}
		tableToRows.putAll("condition_era", eraGenerator.generateRows());
	}

	private void addToLocation(Row row) {
		String stateCounty = row.get("HOSPST") + "\t" + (row.get("HOSPSTCO").equals("-9999") ? "" : row.get("HOSPSTCO"));
		locationId = stateCountyToLocationId.get(stateCounty);
		if (locationId == null) {
			locationId = stateCountyToLocationId.size() + 1;
			stateCountyToLocationId.put(stateCounty, locationId);

			Row location = new Row();
			location.add("location_id", locationId);
			location.add("state", row.get("HOSPST"));
			String county = codeToCounty.get(row.get("HOSPSTCO"));
			if (county == null)
				county = "";
			if (county.length() > 20)
				county = county.substring(0, 20); // County field in CDM limited to 20 chars
			location.add("county", county);
			location.add("location_source_value", row.get("HOSPSTCO"));
			tableToRows.put("location", location);
		}
	}

	private void addToCareSite(Row row) {
		if (careSiteIds.add(row.getInt("HOSPID"))) {
			Row careSite = new Row();
			careSite.add("care_site_id", row.get("HOSPID"));
			careSite.add("care_site_source_value", row.get("HOSPID"));
			careSite.add("location_id", locationId);
			tableToRows.put("care_site", careSite);
		}
	}

	private void addToVisitOccurrence(Row row) {
		Row visitOccurrence = new Row();
		visitOccurrence.add("person_id", row.get("KEY"));
		visitOccurrence.add("visit_occurrence_id", visitOccurrenceId);
		visitOccurrence.add("visit_start_date", StringUtilities.daysToDatabaseDateString(visitStartDate));
		visitOccurrence.add("visit_end_date", StringUtilities.daysToDatabaseDateString(visitEndDate));
		visitOccurrence.add("care_site_id", row.get("HOSPID"));
		visitOccurrence.add("place_of_service_concept_id", 9201); // Inpatient visit
		tableToRows.put("visit_occurrence", visitOccurrence);
	}

	private void addToObservationPeriod(Row row) {
		Row observationPeriod = new Row();
		observationPeriod.add("observation_period_id", observationPeriodId);
		observationPeriod.add("person_id", row.get("KEY"));
		observationPeriod.add("observation_period_start_date", StringUtilities.daysToDatabaseDateString(visitStartDate));
		observationPeriod.add("observation_period_end_date", StringUtilities.daysToDatabaseDateString(visitEndDate));
		tableToRows.put("observation_period", observationPeriod);
	}

	private boolean addToPerson(Row row) {
		if (row.getInt("AGE") < 0 || (row.getInt("AGE") == 0 && row.getInt("AGEDAY") < 0)) { // No age specified. Cannot create person, since birth year is
																								// required field
			etlReport.reportProblem("Person", "No age specified so cannot create row", row.get("KEY"));
			return false;
		}

		Row person = new Row();
		person.add("person_id", row.get("KEY"));
		person.add("person_source_value", row.get("KEY"));
		person.add("gender_source_value", row.get("FEMALE"));
		person.add("gender_concept_id", row.get("FEMALE").equals("1") ? "8532" : row.get("FEMALE").equals("0") ? "8507" : "8551");

		if (row.getInt("AGE") > 0) {
			int yearOfBirth = Integer.parseInt(StringUtilities.daysToCalendarYear(visitStartDate)) - row.getInt("AGE");
			person.add("year_of_birth", yearOfBirth);
			person.add("month_of_birth", "");
			person.add("day_of_birth", "");

		} else if (row.getInt("AGEDAY") >= 0) {
			long dateOfBirth = visitStartDate - row.getInt("AGEDAY");
			person.add("year_of_birth", StringUtilities.daysToCalendarYear(dateOfBirth));
			person.add("month_of_birth", StringUtilities.daysToCalendarMonth(dateOfBirth));
			person.add("day_of_birth", StringUtilities.daysToCalendarDayOfMonth(dateOfBirth));
		} else {
			person.add("year_of_birth", "");
			person.add("month_of_birth", "");
			person.add("day_of_birth", "");
		}

		person.add("race_source_value", row.get("RACE"));
		if (row.get("RACE").equals("1")) // White
			person.add("race_concept_id", "8527");
		else if (row.get("RACE").equals("2")) // Black
			person.add("race_concept_id", "8516");
		else if (row.get("RACE").equals("4")) // Pacific islander
			person.add("race_concept_id", "8557");
		else if (row.get("RACE").equals("5")) // Native American
			person.add("race_concept_id", "8657");
		else if (row.get("RACE").equals("3")) // Hispanic, should be coded as 'other'
			person.add("race_concept_id", "8522");
		else if (row.get("RACE").equals("6")) // Other
			person.add("race_concept_id", "8522");
		else
			person.add("race_concept_id", "");

		if (row.get("RACE").equals("3")) {// Hispanic
			person.add("ethnicity_source_value", "3");
			person.add("ethnicity_concept_id", "38003563");
		} else {
			person.add("ethnicity_source_value", "");
			person.add("ethnicity_concept_id", "0");
		}

		tableToRows.put("person", person);
		return true;
	}

	private void addToConditionOccurrence(Row row) {
		for (int i = 0; i < diagnoseFields.length; i++)
			if (row.get(diagnoseFields[i]).trim().length() != 0) {
				int conceptId = icd9ToConcept.getConceptId(row.get(diagnoseFields[i]).trim());
				if (conceptId == 4014295 && row.getInt("AGE") < 12) { // 4014295 = Single live birth
					etlReport.reportProblem("Condition_occurrence", "Person < 12 years old with live birth. Removing condition_occurrence", row.get("KEY"));
					continue;
				}
				if (conceptId == 4014295 && row.get("FEMALE").equals("0")) { // 4014295 = Single live birth
					etlReport.reportProblem("Condition_occurrence", "Male with live birth. Removing condition_occurrence", row.get("KEY"));
					continue;
				}
				Row conditionOccurrence = new Row();
				conditionOccurrence.add("person_id", row.get("KEY"));
				conditionOccurrence.add("condition_occurrence_id", ++conditionOccurrenceId);
				conditionOccurrence.add("condition_source_value", row.get(diagnoseFields[i]));
				conditionOccurrence.add("condition_concept_id", conceptId);
				conditionOccurrence.add("condition_type_concept_id", diagnoseFieldConceptIds[i]);
				conditionOccurrence.add("condition_start_date", StringUtilities.daysToDatabaseDateString(visitStartDate));
				conditionOccurrence.add("visit_occurrence_id", visitOccurrenceId);
				tableToRows.put("condition_occurrence", conditionOccurrence);
			}
	}

	private void addToDeath(Row row) {
		if (row.get("DIED").equals("1")) {
			Row death = new Row();
			death.add("person_id", row.get("KEY"));
			death.add("death_date", StringUtilities.daysToDatabaseDateString(visitEndDate));
			death.add("death_type_concept_id", 38003566); // EHR record patient status "Deceased"
			tableToRows.put("death", death);
		}
	}

	private void addToDrugExposure(Row row) {
		for (int i = 0; i < procedureFields.length; i++)
			if (row.get(procedureFields[i]).trim().length() != 0) {
				int conceptId = icd9ToRxNorm.getConceptId(row.get(procedureFields[i]).trim());
				if (conceptId != 0) {
					Row drugExposure = new Row();
					drugExposure.add("drug_exposure_id", ++drugExposureId);
					drugExposure.add("person_id", row.get("KEY"));
					int day = row.getInt(procedureDayFields[i]);
					if (day < 0)
						day = 0;
					if (day > visitEndDate - visitStartDate) {
						etlReport.reportProblem("Drug_exposure", "Drug exposure date beyond length of stay, removing drug exposure", row.get("KEY"));
						continue;
					}
					drugExposure.add("drug_exposure_start_date", StringUtilities.daysToDatabaseDateString(visitStartDate + day));
					drugExposure.add("drug_source_value", row.get(procedureFields[i]));
					drugExposure.add("drug_concept_id", conceptId);
					drugExposure.add("drug_type_concept_id", 38000179); // Physician administered drug (identified as procedure)
					drugExposure.add("visit_occurrence_id", visitOccurrenceId);
					tableToRows.put("drug_exposure", drugExposure);
				}
			}
	}

	private void addToProcedureOccurrence(Row row) {
		for (int i = 0; i < procedureFields.length; i++)
			if (row.get(procedureFields[i]).trim().length() != 0) {
				int day = row.getInt(procedureDayFields[i]);
				if (day < 0)
					day = 0;
				if (day > visitEndDate - visitStartDate) {
					etlReport.reportProblem("Procedure_occurrence", "Procedure date beyond length of stay, removing procedure", row.get("KEY"));
					continue;
				}
				Row procedureOccurrence = new Row();
				procedureOccurrence.add("procedure_occurrence_id", ++procedureOccurrenceId);
				procedureOccurrence.add("person_id", row.get("KEY"));
				procedureOccurrence.add("procedure_date", StringUtilities.daysToDatabaseDateString(visitStartDate + day));
				procedureOccurrence.add("procedure_source_value", row.get(procedureFields[i]));
				procedureOccurrence.add("procedure_concept_id", icd9ProcToConcept.getConceptId(row.get(procedureFields[i]).trim()));
				procedureOccurrence.add("procedure_type_concept_id", procedureFieldConceptIds[i]);
				procedureOccurrence.add("visit_occurrence_id", visitOccurrenceId);
				tableToRows.put("procedure_occurrence", procedureOccurrence);

				if (procedureFields[i].equals("PR1"))
					primaryProcedureOccurrenceId = procedureOccurrenceId;
			}
	}

	private void addToProcedureCost(Row row) {
		if (primaryProcedureOccurrenceId != -1) {
			String drg = row.get("DRG").trim();
			int conceptId;
			if (StringUtilities.isInteger(drg)) {
				conceptId = drgYearToConcept.getConceptId(String.format("%03d", Integer.parseInt(drg)) + "_" + row.get("YEAR"));
			} else
				conceptId = drgYearToConcept.getConceptId(drg + "_" + row.get("YEAR"));

			procedureCostId++;
			Row procedureCost = new Row();
			procedureCost.add("procedure_occurrence_id", primaryProcedureOccurrenceId);
			procedureCost.add("procedure_cost_id", procedureCostId);
			procedureCost.add("disease_class_source_value", row.get("DRG"));
			procedureCost.add("disease_class_concept_id", conceptId);
			tableToRows.put("procedure_cost", procedureCost);
		}
	}

	private long computeVisitStartDate(String year, String amonth, String aweekend, String key) {
		if (Integer.parseInt(amonth) < 1)
			amonth = Integer.toString(Math.abs(hash(key) % 12) + 1);
		boolean isWeekend = aweekend.equals("1");
		Calendar calendar = Calendar.getInstance();
		calendar.set(Integer.parseInt(year), Integer.parseInt(amonth) - 1, 1);
		while (isWeekend(calendar) != isWeekend)
			calendar.add(Calendar.DATE, 1);
		long time = calendar.getTimeInMillis();
		time += calendar.getTimeZone().getOffset(time);
		// Millenium is added because for negative numbers, integer division truncates upwards! (-8/10 = 0). This is reversed in the daysToDatabaseDateString
		// function
		return (((StringUtilities.MILLENIUM + time) / StringUtilities.DAY) - (1000 * 365));
	}

	private long computeVisitEndDate(long visitStartDate, String los) {
		int lengthOfStay = Integer.parseInt(los);
		if (lengthOfStay < 0)
			lengthOfStay = 0;
		return visitStartDate + lengthOfStay;
	}

	private int hash(String string) {
		int hashCode = string.hashCode();
		hashCode ^= (hashCode >>> 20) ^ (hashCode >>> 12);
		return hashCode ^ (hashCode >>> 7) ^ (hashCode >>> 4);
	}

	private boolean isWeekend(Calendar calendar) {
		int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
		return (dayOfWeek == Calendar.SATURDAY || dayOfWeek == Calendar.SUNDAY);
	}

	private void insertBatch() {
		// addToDrugEra();
		addToConditionEra();
		removeRowsWithNonNullableNulls();

		etlReport.registerOutgoingData(tableToRows);
		for (String table : tableToRows.keySet())
			targetConnection.insertIntoTable(tableToRows.get(table).iterator(), table, false, true);
		tableToRows.clear();
	}

	private void loadMappings(DbSettings dbSettings) {
		StringUtilities.outputWithTime("Loading mappings from server");
		RichConnection connection = new RichConnection(dbSettings.server, dbSettings.domain, dbSettings.user, dbSettings.password, dbSettings.dbType);
		connection.setContext(this.getClass());
		connection.use(dbSettings.database);

		System.out.println("- Loading ICD-9 to SNOMED concept_id mapping");
		icd9ToConcept = new CodeToConceptMap("ICD-9 to SNOMED concept_id mapping");
		for (Row row : connection.queryResource("icd9ToSnomed.sql")) {
			row.upperCaseFieldNames();
			icd9ToConcept.add(row.get("SOURCE_CODE").replace(".", ""), row.get("SOURCE_CODE_DESCRIPTION"), row.getInt("TARGET_CONCEPT_ID"),
					row.get("CONCEPT_CODE"), row.get("CONCEPT_NAME"));
		}

		System.out.println("- Loading ICD-9 to RxNorm concept_id mapping");
		icd9ToRxNorm = new CodeToConceptMap("ICD-9 to RxNorm concept_id mapping");
		String query = "SELECT DISTINCT source_code,source_code_description,target_concept_id,concept_code,concept_name FROM source_to_concept_map INNER JOIN concept ON target_concept_id = concept_id WHERE  target_vocabulary_id = 8 AND source_vocabulary_id in (3,4,5) AND primary_map = 'Y' AND COALESCE(source_to_concept_map.invalid_reason,'') != 'D'";
		for (Row row : connection.query(query)) {
			row.upperCaseFieldNames();
			icd9ToRxNorm.add(row.get("SOURCE_CODE").replace(".", ""), row.get("SOURCE_CODE_DESCRIPTION"), row.getInt("TARGET_CONCEPT_ID"),
					row.get("CONCEPT_CODE"), row.get("CONCEPT_NAME"));
		}
		System.out.println("- Loading ICD-9 Procedure to concept_id mapping");
		icd9ProcToConcept = new CodeToConceptMap("ICD-9 Procedure to concept_id mapping");
		query = "SELECT concept_id,concept_name,concept_code FROM concept WHERE vocabulary_id = 3";
		for (Row row : connection.query(query)) {
			row.upperCaseFieldNames();
			icd9ProcToConcept.add(row.get("CONCEPT_CODE").replace(".", ""), row.get("CONCEPT_NAME"), row.getInt("CONCEPT_ID"), row.get("CONCEPT_CODE"),
					row.get("CONCEPT_NAME"));
		}
		System.out.println("- Loading DRG to concept_id mapping");
		drgYearToConcept = new CodeToConceptMap("DRG to concept_id mapping");
		query = "SELECT concept_id,concept_name,source_code,YEAR(stcm.valid_end_date) AS end_year,concept_code FROM SOURCE_TO_CONCEPT_MAP stcm INNER JOIN concept ON target_concept_id = concept_id WHERE SOURCE_VOCABULARY_ID = 40 ORDER BY source_code,stcm.valid_start_date";
		// Need to create drg_year combinations for every year for easy retrieval later on:
		String oldSourceCode = "";
		int year = 1999;
		for (Row row : connection.query(query)) {
			row.upperCaseFieldNames();
			if (!row.get("SOURCE_CODE").equals(oldSourceCode)) {
				oldSourceCode = row.get("SOURCE_CODE");
				year = 1999;
			}
			for (; year <= row.getInt("END_YEAR"); year++)
				drgYearToConcept.add(row.get("SOURCE_CODE") + "_" + year, row.get("CONCEPT_NAME"), row.getInt("CONCEPT_ID"), row.get("CONCEPT_CODE"),
						row.get("CONCEPT_NAME"));
		}
		System.out.println("- Loading county code to name mapping");
		codeToCounty = new HashMap<String, String>();
		for (Row row : new ReadCSVFileWithHeader(this.getClass().getResourceAsStream("national_county.txt")))
			codeToCounty.put(row.get("State ANSI") + row.get("County ANSI"), row.get("County Name"));

		StringUtilities.outputWithTime("Finished loading mappings");
	}

	private void removeRowsWithNonNullableNulls() {
		for (String table : tableToRows.keySet()) {
			Iterator<Row> iterator = tableToRows.get(table).iterator();
			while (iterator.hasNext()) {
				Row row = iterator.next();
				String nonAllowedNullField = cdmv4NullableChecker.findNonAllowedNull(table, row);
				if (nonAllowedNullField != null) {
					if (row.getFieldNames().contains("person_id"))
						etlReport.reportProblem(table, "Column " + nonAllowedNullField + " is null, could not create row", row.get("person_id"));
					else
						etlReport.reportProblem(table, "Column " + nonAllowedNullField + " is null, could not create row", "");
					iterator.remove();
				}
			}
		}
	}
}
