/*******************************************************************************
 * Copyright 2016 Observational Health Data Sciences and Informatics
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
package org.ohdsi.jCdmBuilder.utilities;

import java.util.Iterator;
import java.util.List;

import javax.swing.JOptionPane;

import org.ohdsi.databases.RichConnection;
import org.ohdsi.jCdmBuilder.DbSettings;
import org.ohdsi.jCdmBuilder.EtlReport;
import org.ohdsi.jCdmBuilder.ObjectExchange;
import org.ohdsi.jCdmBuilder.cdm.CdmV4NullableChecker;
import org.ohdsi.utilities.StringUtilities;
import org.ohdsi.utilities.collections.OneToManyList;
import org.ohdsi.utilities.files.Row;

public class ETLUtils {
	public static String[]				tablesInsideOP			= new String[] { "condition_occurrence", "procedure_occurrence", "drug_exposure", "death",
			"visit_occurrence", "observation"					};
	public static String[]				fieldInTables			= new String[] { "condition_start_date", "procedure_date", "drug_exposure_start_date",
			"death_date", "visit_start_date", "observation_date" };
	
	private static CdmV4NullableChecker	cdmv4NullableChecker	= new CdmV4NullableChecker();
	
	public static boolean databaseAlreadyExists(DbSettings dbSettings) {
		RichConnection connection = new RichConnection(dbSettings.server, dbSettings.domain, dbSettings.user, dbSettings.password, dbSettings.dbType);
		if (connection.getDatabaseNames().contains(dbSettings.database.toLowerCase())) {
			if (ObjectExchange.frame == null) {
				System.out.println("DB already exists. Exiting");
				return true;
			} else {
				String message = "A DB called '" + dbSettings.database + "' alread exists. Do you want to remove it before proceeding?";
				String title = "CDM database already exists";
				int answer = JOptionPane.showConfirmDialog(ObjectExchange.frame, message, title, JOptionPane.YES_NO_OPTION);
				if (answer == JOptionPane.YES_OPTION) {
					StringUtilities.outputWithTime("Dropping database " + dbSettings.database);
					connection.dropDatabaseIfExists(dbSettings.database);
					return false;
				} else {
					System.out.println("DB already exists. Exiting");
					return true;
				}
			}
		} else
			return false;
	}
	
	public static void removeRowsOutsideOfObservationTime(OneToManyList<String, Row> tableToRows, EtlReport etlReport) {
		List<Row> observationPeriods = tableToRows.get("observation_period");
		long[] startDates = new long[observationPeriods.size()];
		long[] endDates = new long[observationPeriods.size()];
		int i = 0;
		Iterator<Row> observationPeriodIterator = observationPeriods.iterator();
		while (observationPeriodIterator.hasNext()) {
			Row observationPeriod = observationPeriodIterator.next();
			try {
				startDates[i] = StringUtilities.databaseTimeStringToDays(observationPeriods.get(i).get("observation_period_start_date"));
			} catch (Exception e) {
				etlReport.reportProblem("observation_period", "Illegal observation_period_start_date. Removing person", observationPeriod.get("person_id"));
				observationPeriodIterator.remove();
				startDates[i] = StringUtilities.MISSING_DATE;
				endDates[i] = StringUtilities.MISSING_DATE;
				continue;
			}
			try {
				endDates[i] = StringUtilities.databaseTimeStringToDays(observationPeriods.get(i).get("observation_period_end_date"));
			} catch (Exception e) {
				etlReport.reportProblem("observation_period", "Illegal observation_period_end_date. Removing person", observationPeriod.get("person_id"));
				observationPeriodIterator.remove();
				startDates[i] = StringUtilities.MISSING_DATE;
				endDates[i] = StringUtilities.MISSING_DATE;
				continue;
			}
			i++;
		}
		
		for (i = 0; i < tablesInsideOP.length; i++) {
			Iterator<Row> iterator = tableToRows.get(tablesInsideOP[i]).iterator();
			while (iterator.hasNext()) {
				Row row = iterator.next();
				boolean insideOP = false;
				try {
					long rowDate = StringUtilities.databaseTimeStringToDays(row.get(fieldInTables[i]));
					for (int j = 0; j < startDates.length; j++) {
						if (rowDate >= startDates[j] && rowDate <= endDates[j]) {
							insideOP = true;
							break;
						}
					}
					if (!insideOP) {
						iterator.remove();
						etlReport.reportProblem(tablesInsideOP[i], "Data outside observation period. Removed data", row.get("person_id"));
					}
				} catch (Exception e) {
					etlReport.reportProblem(tablesInsideOP[i], "Illegal " + fieldInTables[i] + ". Cannot add row", row.get("person_id"));
					iterator.remove();
					continue;
				}
			}
		}
	}
	
	public static void removeRowsWithNonNullableNulls(OneToManyList<String, Row> tableToRows, EtlReport etlReport) {
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
