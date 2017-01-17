/*******************************************************************************
 * Copyright 2017 Observational Health Data Sciences and Informatics
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

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.ohdsi.databases.RichConnection;
import org.ohdsi.jCdmBuilder.DbSettings;
import org.ohdsi.jCdmBuilder.EtlReport;
import org.ohdsi.jCdmBuilder.cdm.CdmV5NullableChecker;
import org.ohdsi.jCdmBuilder.utilities.CodeToDomainConceptMap;
import org.ohdsi.jCdmBuilder.utilities.CodeToDomainConceptMap.CodeDomainData;
import org.ohdsi.jCdmBuilder.utilities.CodeToDomainConceptMap.TargetConcept;
import org.ohdsi.jCdmBuilder.utilities.QCSampleConstructor;
import org.ohdsi.utilities.StringUtilities;
import org.ohdsi.utilities.collections.OneToManyList;
import org.ohdsi.utilities.files.ReadCSVFileWithHeader;
import org.ohdsi.utilities.files.Row;

/**
 * Performs the ETL to CDM v5 for the HCUP Inpatient Sample. Assumes the vocabulary is already loaded in the target schema. In the HCUP IS all data used in the
 * ETL comes from the CORE table. This table contains one row per hospital visit. Since there is no way to link patients across visits, each visit is assigned a
 * unique personId.
 * 
 * @author MSCHUEMI
 * 
 */
public class HCUPETLToV5 {
	
	private static final double			QC_SAMPLE_PROBABILITY		= 0.000001;
	public static int					BATCH_SIZE					= 10000;
	public static String[]				diagnoseFields				= new String[] { "DX1", "DX2", "DX3", "DX4", "DX5", "DX6", "DX7", "DX8", "DX9", "DX10",
			"DX11", "DX12", "DX13", "DX14", "DX15", "DX16", "DX17", "DX18", "DX19", "DX20", "DX21", "DX22", "DX23", "DX24", "DX25", "ECODE1", "ECODE2" };
	public static String[]				procedureFields				= new String[] { "PR1", "PR2", "PR3", "PR4", "PR5", "PR6", "PR7", "PR8", "PR9", "PR10",
			"PR11", "PR12", "PR13", "PR14", "PR15" };
	public static String[]				procedureDayFields			= new String[] { "PRDAY1", "PRDAY2", "PRDAY3", "PRDAY4", "PRDAY5", "PRDAY6", "PRDAY7",
			"PRDAY8", "PRDAY9", "PRDAY10", "PRDAY11", "PRDAY12", "PRDAY13", "PRDAY14", "PRDAY15" };
	public static int[]					diagnoseFieldConceptIds		= new int[] { 38000184, 38000185, 38000186, 38000187, 38000188, 38000189, 38000190,
			38000191, 38000192, 38000193, 38000194, 38000195, 38000196, 38000197, 38000198, 38000198, 38000198, 38000198, 38000198, 38000198, 38000198,
			38000198, 38000198, 38000198, 38000198, 38000184, 38000185 };
	
	public static int[]					procedureFieldConceptIds	= new int[] { 38000251, 38000252, 38000253, 38000254, 38000255, 38000256, 38000257,
			38000258, 38000259, 38000260, 38000261, 38000262, 38000263, 38000264, 38000265 };
	
	private RichConnection				sourceConnection;
	private RichConnection				targetConnection;
	private QCSampleConstructor			qcSampleConstructor;
	private EtlReport					etlReport;
	private CdmV5NullableChecker		cdmv5NullableChecker		= new CdmV5NullableChecker();
	private OneToManyList<String, Row>	tableToRows;
	private long						personId;
	private long						observationPeriodId;
	private Integer						locationId;
	private long						drugExposureId;
	private long						conditionOccurrenceId;
	private long						visitOccurrenceId;
	private long						procedureOccurrenceId;
	private long						deviceExposureId;
	private long						measurementId;
	private long						observationId;
	private long						visitStartDate;
	private long						visitEndDate;
	
	private Map<String, Integer>		stateCountyToLocationId;
	private Set<Integer>				careSiteIds;
	
	private Map<String, String>			codeToCounty;
	private CodeToDomainConceptMap		icd9ToConcept;
	private CodeToDomainConceptMap		icd9ToValueConcept;
	private CodeToDomainConceptMap		icd9ProcToConcept;
	private CodeToDomainConceptMap		drgYearToConcept;
	
	public void process(String folder, DbSettings sourceDbSettings, DbSettings targetDbSettings, int maxPersons, int versionId) {
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
		
		targetConnection.execute("TRUNCATE TABLE _version");
		String date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		targetConnection.execute("INSERT INTO _version (version_id, version_date) VALUES (" + versionId + ", '" + date + "')");
		
		qcSampleConstructor = new QCSampleConstructor(folder + "/sample", QC_SAMPLE_PROBABILITY);
		etlReport = new EtlReport(folder);
		
		tableToRows = new OneToManyList<String, Row>();
		stateCountyToLocationId = new HashMap<String, Integer>();
		careSiteIds = new HashSet<Integer>();
		personId = 0;
		drugExposureId = 0;
		conditionOccurrenceId = 0;
		visitOccurrenceId = 0;
		procedureOccurrenceId = 0;
		deviceExposureId = 0;
		observationPeriodId = 0;
		measurementId = 0;
		observationId = 0;
		
		StringUtilities.outputWithTime("Populating CDM_Source table");
		populateCdmSourceTable();
		
		StringUtilities.outputWithTime("Processing persons");
		for (Row row : sourceConnection.query("SELECT * FROM core ORDER BY [key]")) {
			processPerson(row);
			if (personId == maxPersons) {
				System.out.println("Reached limit of " + maxPersons + " persons, terminating");
				break;
			}
			if (personId % BATCH_SIZE == 0) {
				insertBatch();
				System.out.println("Processed " + personId + " persons");
			}
		}
		insertBatch();
		System.out.println("Processed " + personId + " persons");
		
		qcSampleConstructor.addCdmData(targetConnection, targetDbSettings.database);
		
		String etlReportName = etlReport.generateETLReport(icd9ToConcept, icd9ProcToConcept, drgYearToConcept);
		System.out.println("An ETL report was generated and written to :" + etlReportName);
		if (etlReport.getTotalProblemCount() > 0) {
			String etlProblemListname = etlReport.generateProblemReport();
			System.out.println("An ETL problem list was generated and written to :" + etlProblemListname);
		}
		
		StringUtilities.outputWithTime("Finished ETL");
	}
	
	private void populateCdmSourceTable() {
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		targetConnection.executeResource("PopulateCdmSourceTable.sql", "@today", df.format(new Date()));
	}
	
	private void truncateTables(RichConnection targetConnection) {
		StringUtilities.outputWithTime("Truncating tables");
		String[] tables = new String[] { "attribute_definition", "care_site", "cdm_source", "cohort", "cohort_attribute", "cohort_definition", "condition_era",
				"condition_occurrence", "death", "cost", "device_exposure", "dose_era", "drug_era", "drug_exposure", "fact_relationship", "location",
				"measurement", "note", "observation", "observation_period", "payer_plan_period", "person", "procedure_occurrence", "provider", "specimen",
				"visit_occurrence" };
		for (String table : tables)
			targetConnection.execute("TRUNCATE TABLE " + table);
	}
	
	private void processPerson(Row row) {
		if (!row.get("KEY_NIS").equals("")) {
			// New data format: transform names to old format:
			row.set("KEY", row.get("KEY_NIS"));
			row.set("HOSPID", row.get("HOSP_NIS"));
		}
		etlReport.registerIncomingData("core", row);
		
		personId++;
		visitOccurrenceId++;
		observationPeriodId++;
		visitStartDate = computeVisitStartDate(row.get("YEAR"), row.get("AMONTH"), row.get("AWEEKEND"), row.get("KEY"));
		visitEndDate = computeVisitEndDate(visitStartDate, row.get("LOS"));
		qcSampleConstructor.registerPersonData("core", row, row.getLong("KEY"));
		
		if (addToPerson(row)) {
			List<Row> stemTable = createStemTable(row);
			addToLocation(row);
			addToCareSite(row);
			addToVisitOccurrence(row);
			addToObservationPeriod(row);
			addToConditionOccurrence(stemTable);
			addToDeath(row);
			addToDrugExposure(stemTable);
			addToDeviceExposure(stemTable);
			addToProcedureOccurrence(stemTable);
			addToMeasurement(stemTable);
			addToObservation(stemTable);
			addToObservation(row);
		}
	}
	
	private List<Row> createStemTable(Row row) {
		List<Row> stemTable = new ArrayList<Row>();
		for (int i = 0; i < diagnoseFields.length; i++)
			if (row.get(diagnoseFields[i]).trim().length() != 0) {
				CodeDomainData data = icd9ToConcept.getCodeData(row.get(diagnoseFields[i]).trim());
				for (TargetConcept targetConcept : data.targetConcepts) {
					if (targetConcept.conceptId == 4014295 && row.getInt("AGE") < 12) { // 4014295 = Single live birth
						etlReport.reportProblem("Condition_occurrence", "Person < 12 years old with live birth. Removing condition_occurrence", row.get("KEY"));
						continue;
					}
					if (targetConcept.conceptId == 4014295 && row.get("FEMALE").equals("0")) { // 4014295 = Single live birth
						etlReport.reportProblem("Condition_occurrence", "Male with live birth. Removing condition_occurrence", row.get("KEY"));
						continue;
					}
					
					Row stemRow = new Row();
					stemRow.add("person_id", personId);
					stemRow.add("source_value", row.get(diagnoseFields[i]));
					stemRow.add("source_concept_id", data.sourceConceptId);
					stemRow.add("concept_id", targetConcept.conceptId);
					stemRow.add("domain_id", targetConcept.domainId);
					stemRow.add("type_concept_id", diagnoseFieldConceptIds[i]);
					stemRow.add("start_date", StringUtilities.daysToDatabaseDateString(visitStartDate));
					stemRow.add("visit_occurrence_id", visitOccurrenceId);
					stemRow.add("index", i);
					stemTable.add(stemRow);
				}
			}
		
		for (int i = 0; i < procedureFields.length; i++)
			if (row.get(procedureFields[i]).trim().length() != 0) {
				int day = row.getInt(procedureDayFields[i]);
				if (day < 0)
					day = 0;
				if (day > visitEndDate - visitStartDate) {
					etlReport.reportProblem("Procedure", "Procedure date beyond length of stay, removing procedure", row.get("KEY"));
					continue;
				}
				CodeDomainData data = icd9ProcToConcept.getCodeData(row.get(procedureFields[i]).trim());
				for (TargetConcept targetConcept : data.targetConcepts) {
					Row stemRow = new Row();
					stemRow.add("person_id", personId);
					stemRow.add("source_value", row.get(procedureFields[i]));
					stemRow.add("source_concept_id", data.sourceConceptId);
					stemRow.add("concept_id", targetConcept.conceptId);
					stemRow.add("domain_id", targetConcept.domainId);
					stemRow.add("type_concept_id", procedureFieldConceptIds[i]);
					stemRow.add("start_date", StringUtilities.daysToDatabaseDateString(visitStartDate + day));
					stemRow.add("visit_occurrence_id", visitOccurrenceId);
					stemRow.add("index", i);
					stemTable.add(stemRow);
				}
			}
		
		String drgYear = row.get("DRG").trim() + "_" + row.get("YEAR");
		CodeDomainData data = drgYearToConcept.getCodeData(drgYear);
		for (TargetConcept targetConcept : data.targetConcepts) {
			Row stemRow = new Row();
			stemRow.add("person_id", personId);
			stemRow.add("source_value", drgYear);
			stemRow.add("source_concept_id", data.sourceConceptId);
			stemRow.add("concept_id", targetConcept.conceptId);
			stemRow.add("domain_id", targetConcept.domainId);
			stemRow.add("type_concept_id", 38000276); // Problem list from EHR
			stemRow.add("start_date", StringUtilities.daysToDatabaseDateString(visitStartDate));
			stemRow.add("visit_occurrence_id", visitOccurrenceId);
			stemRow.add("index", 0);
			stemTable.add(stemRow);
		}
		return stemTable;
	}
	
	private void addToLocation(Row row) {
		if (row.get("HOSPST").equals("") && row.get("HOSPSTCO").equals("")) {
			locationId = null;
			return;
		}
		
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
			if (locationId == null)
				careSite.add("location_id", "");
			else
				careSite.add("location_id", locationId);
			careSite.add("place_of_service_concept_id", 9201); // Inpatient visit
			tableToRows.put("care_site", careSite);
		}
	}
	
	private void addToVisitOccurrence(Row row) {
		Row visitOccurrence = new Row();
		visitOccurrence.add("person_id", personId);
		visitOccurrence.add("visit_occurrence_id", visitOccurrenceId);
		visitOccurrence.add("visit_start_date", StringUtilities.daysToDatabaseDateString(visitStartDate));
		visitOccurrence.add("visit_end_date", StringUtilities.daysToDatabaseDateString(visitEndDate));
		visitOccurrence.add("care_site_id", row.get("HOSPID"));
		visitOccurrence.add("visit_concept_id", 9201); // Inpatient visit
		visitOccurrence.add("visit_type_concept_id", 44818517); // Visit derived from encounter on claim
		tableToRows.put("visit_occurrence", visitOccurrence);
	}
	
	private void addToObservationPeriod(Row row) {
		Row observationPeriod = new Row();
		observationPeriod.add("observation_period_id", observationPeriodId);
		observationPeriod.add("person_id", personId);
		observationPeriod.add("observation_period_start_date", StringUtilities.daysToDatabaseDateString(visitStartDate));
		observationPeriod.add("observation_period_end_date", StringUtilities.daysToDatabaseDateString(visitEndDate));
		observationPeriod.add("period_type_concept_id", 44814724); // Period covering healthcare encounters
		tableToRows.put("observation_period", observationPeriod);
	}
	
	private boolean addToPerson(Row row) {
		if (row.getInt("AGE") < 0) { // No age specified. Cannot create person, since birth year is required field
			etlReport.reportProblem("Person", "No age specified so cannot create row", row.get("KEY"));
			return false;
		}
		
		Row person = new Row();
		person.add("person_id", personId);
		person.add("person_source_value", row.get("KEY"));
		person.add("gender_source_value", row.get("FEMALE"));
		person.add("gender_concept_id", row.get("FEMALE").equals("1") ? "8532" : row.get("FEMALE").equals("0") ? "8507" : "0");
		
		if (row.getInt("AGE") > 0) {
			int yearOfBirth = Integer.parseInt(StringUtilities.daysToCalendarYear(visitStartDate)) - row.getInt("AGE");
			person.add("year_of_birth", yearOfBirth);
			person.add("month_of_birth", "");
			person.add("day_of_birth", "");
		} else if (row.get("AGEDAY").equals("") && row.get("AGE_NEONATE").equals("1")) {
			int yearOfBirth = Integer.parseInt(StringUtilities.daysToCalendarYear(visitStartDate));
			person.add("year_of_birth", yearOfBirth);
			person.add("month_of_birth", "");
			person.add("day_of_birth", "");
		} else if ((row.get("AGEDAY").equals("") && !row.get("AGE_NEONATE").equals("1")) || row.getInt("AGEDAY") < 0) {
			long dateOfBirth = visitStartDate - 180;
			person.add("year_of_birth", StringUtilities.daysToCalendarYear(dateOfBirth));
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
			person.add("race_concept_id", "0");
		else
			person.add("race_concept_id", "0");
		
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
	
	private void addToConditionOccurrence(List<Row> stemTable) {
		for (Row stemRow : stemTable) {
			if (stemRow.get("domain_id").equals("Condition")) {
				Row conditionOccurrence = new Row();
				conditionOccurrence.add("person_id", stemRow.get("person_id"));
				conditionOccurrence.add("condition_occurrence_id", ++conditionOccurrenceId);
				conditionOccurrence.add("condition_source_value", stemRow.get("source_value"));
				conditionOccurrence.add("condition_source_concept_id", stemRow.get("source_concept_id"));
				conditionOccurrence.add("condition_concept_id", stemRow.get("concept_id"));
				conditionOccurrence.add("condition_type_concept_id", stemRow.get("type_concept_id"));
				conditionOccurrence.add("condition_start_date", stemRow.get("start_date"));
				conditionOccurrence.add("visit_occurrence_id", stemRow.get("visit_occurrence_id"));
				tableToRows.put("condition_occurrence", conditionOccurrence);
			}
		}
	}
	
	private void addToDeviceExposure(List<Row> stemTable) {
		for (Row stemRow : stemTable) {
			if (stemRow.get("domain_id").equals("Device")) {
				Row deviceExposure = new Row();
				deviceExposure.add("person_id", stemRow.get("person_id"));
				deviceExposure.add("device_exposure_id", ++deviceExposureId);
				deviceExposure.add("device_source_value", stemRow.get("source_value"));
				deviceExposure.add("device_source_concept_id", stemRow.get("source_concept_id"));
				deviceExposure.add("device_concept_id", stemRow.get("concept_id"));
				deviceExposure.add("device_type_concept_id", stemRow.get("type_concept_id"));
				deviceExposure.add("device_exposure_start_date", stemRow.get("start_date"));
				deviceExposure.add("visit_occurrence_id", stemRow.get("visit_occurrence_id"));
				tableToRows.put("device_exposure", deviceExposure);
			}
		}
	}
	
	private void addToDeath(Row row) {
		if (row.get("DIED").equals("1")) {
			Row death = new Row();
			death.add("person_id", personId);
			death.add("death_date", StringUtilities.daysToDatabaseDateString(visitEndDate));
			death.add("death_type_concept_id", 38003566); // EHR record patient status "Deceased"
			tableToRows.put("death", death);
		}
	}
	
	private void addToDrugExposure(List<Row> stemTable) {
		for (Row stemRow : stemTable) {
			if (stemRow.get("domain_id").equals("Drug")) {
				Row drugExposure = new Row();
				drugExposure.add("person_id", stemRow.get("person_id"));
				drugExposure.add("device_exposure_id", ++drugExposureId);
				drugExposure.add("drug_source_value", stemRow.get("source_value"));
				drugExposure.add("drug_source_concept_id", stemRow.get("source_concept_id"));
				drugExposure.add("drug_concept_id", stemRow.get("concept_id"));
				drugExposure.add("drug_type_concept_id", stemRow.get("type_concept_id"));
				drugExposure.add("drug_exposure_start_date", stemRow.get("start_date"));
				drugExposure.add("visit_occurrence_id", stemRow.get("visit_occurrence_id"));
				tableToRows.put("drug_exposure", drugExposure);
			}
		}
	}
	
	private void addToProcedureOccurrence(List<Row> stemTable) {
		for (Row stemRow : stemTable) {
			if (stemRow.get("domain_id").equals("Procedure")) {
				Row procedureOccurrence = new Row();
				procedureOccurrence.add("person_id", stemRow.get("person_id"));
				procedureOccurrence.add("procedure_occurrence_id", ++procedureOccurrenceId);
				procedureOccurrence.add("procedure_source_value", stemRow.get("source_value"));
				procedureOccurrence.add("procedure_source_concept_id", stemRow.get("source_concept_id"));
				procedureOccurrence.add("procedure_concept_id", stemRow.get("concept_id"));
				procedureOccurrence.add("procedure_type_concept_id", stemRow.get("type_concept_id"));
				procedureOccurrence.add("procedure_date", stemRow.get("start_date"));
				procedureOccurrence.add("visit_occurrence_id", stemRow.get("visit_occurrence_id"));
				tableToRows.put("procedure_occurrence", procedureOccurrence);
			}
		}
	}
	
	private void addToMeasurement(List<Row> stemTable) {
		for (Row stemRow : stemTable) {
			if (stemRow.get("domain_id").equals("Measurement")) {
				Row measurement = new Row();
				measurement.add("person_id", stemRow.get("person_id"));
				measurement.add("measurement_id", ++measurementId);
				measurement.add("measurement_source_value", stemRow.get("source_value"));
				measurement.add("measurement_source_concept_id", stemRow.get("source_concept_id"));
				measurement.add("measurement_concept_id", stemRow.get("concept_id"));
				measurement.add("measurement_type_concept_id", stemRow.get("type_concept_id"));
				measurement.add("measurement_date", stemRow.get("start_date"));
				measurement.add("visit_occurrence_id", stemRow.get("visit_occurrence_id"));
				CodeDomainData codeData = icd9ToValueConcept.getCodeData(stemRow.get("source_value"));
				if (codeData.targetConcepts.get(0).conceptId == 0) {
					measurement.add("value_as_concept_id", 4181412); // 'Present'
				} else {
					measurement.add("value_as_concept_id", codeData.targetConcepts.get(0).conceptId);
				}
				tableToRows.put("measurement", measurement);
			}
		}
	}
	
	private void addToObservation(List<Row> stemTable) {
		for (Row stemRow : stemTable) {
			if (stemRow.get("domain_id").equals("Observation")) {
				Row observation = new Row();
				observation.add("person_id", stemRow.get("person_id"));
				observation.add("observation_id", ++observationId);
				observation.add("value_as_number", "");
				observation.add("observation_source_value", stemRow.get("source_value"));
				observation.add("observation_source_concept_id", stemRow.get("source_concept_id"));
				observation.add("observation_concept_id", stemRow.get("concept_id"));
				observation.add("observation_type_concept_id", stemRow.get("type_concept_id"));
				observation.add("observation_date", stemRow.get("start_date"));
				CodeDomainData codeData = icd9ToValueConcept.getCodeData(stemRow.get("source_value"));
				if (codeData.targetConcepts.get(0).conceptId == 0) {
					observation.add("value_as_concept_id", 45877994); // 'Yes'
				} else {
					observation.add("value_as_concept_id", codeData.targetConcepts.get(0).conceptId);
				}
				observation.add("visit_occurrence_id", stemRow.get("visit_occurrence_id"));
				tableToRows.put("observation", observation);
			}
		}
	}
	
	private void addToObservation(Row row) {
		Row observation = new Row();
		observation.add("person_id", personId);
		observation.add("observation_id", ++observationId);
		observation.add("value_as_number", row.get("DISCWT"));
		observation.add("observation_source_value", "DISCWT");
		observation.add("value_as_concept_id", "");
		observation.add("observation_source_concept_id", "");
		observation.add("observation_concept_id", "0");
		observation.add("observation_type_concept_id", "900000003");
		observation.add("observation_date", StringUtilities.daysToDatabaseDateString(visitStartDate));
		observation.add("visit_occurrence_id", visitOccurrenceId);
		tableToRows.put("observation", observation);
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
		
		System.out.println("- Loading ICD-9 to concept_id mapping");
		icd9ToConcept = new CodeToDomainConceptMap("ICD-9 to concept_id mapping", "Condition");
		for (Row row : connection.queryResource("icd9ToConditionProcMeasObsDevice.sql")) {
			row.upperCaseFieldNames();
			icd9ToConcept.add(row.get("SOURCE_CODE"), row.get("SOURCE_NAME"), row.getInt("SOURCE_CONCEPT_ID"), row.getInt("TARGET_CONCEPT_ID"),
					row.get("TARGET_CODE"), row.get("TARGET_NAME"), row.get("DOMAIN_ID"));
		}
		
		System.out.println("- Loading ICD-9 to observation value concept_id mapping");
		icd9ToValueConcept = new CodeToDomainConceptMap("ICD-9 to value concept_id mapping", "Observation");
		for (Row row : connection.queryResource("icd9ToObservationValue.sql")) {
			row.upperCaseFieldNames();
			icd9ToValueConcept.add(row.get("SOURCE_CODE"), row.get("SOURCE_NAME"), row.getInt("SOURCE_CONCEPT_ID"), row.getInt("TARGET_CONCEPT_ID"),
					row.get("TARGET_CODE"), row.get("TARGET_NAME"), row.get("DOMAIN_ID"));
		}
		
		System.out.println("- Loading ICD-9 Procedure to concept_id mapping");
		icd9ProcToConcept = new CodeToDomainConceptMap("ICD-9 Procedure to concept_id mapping", "Procedure");
		for (Row row : connection.queryResource("icd9ProcToProcMeasObsDrugCondition.sql")) {
			row.upperCaseFieldNames();
			icd9ProcToConcept.add(row.get("SOURCE_CODE"), row.get("SOURCE_NAME"), row.getInt("SOURCE_CONCEPT_ID"), row.getInt("TARGET_CONCEPT_ID"),
					row.get("TARGET_CODE"), row.get("TARGET_NAME"), row.get("DOMAIN_ID"));
		}
		
		System.out.println("- Loading DRG to concept_id mapping");
		drgYearToConcept = new CodeToDomainConceptMap("DRG to concept_id mapping", "Observation");
		// Need to create drg_year combinations for every year for easy retrieval later on:
		String oldSourceCode = "";
		int year = 1999;
		for (Row row : connection.queryResource("drgToConcept.sql")) {
			row.upperCaseFieldNames();
			if (!row.get("SOURCE_CODE").equals(oldSourceCode)) {
				oldSourceCode = row.get("SOURCE_CODE");
				year = 1999;
			}
			for (; year <= row.getInt("SOURCE_END_YEAR"); year++)
				drgYearToConcept.add(row.get("SOURCE_CODE") + "_" + year, row.get("SOURCE_NAME"), row.getInt("SOURCE_CONCEPT_ID"),
						row.getInt("TARGET_CONCEPT_ID"), row.get("TARGET_CODE"), row.get("TARGET_NAME"), row.get("TARGET_DOMAIN"));
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
				String nonAllowedNullField = cdmv5NullableChecker.findNonAllowedNull(table, row);
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
