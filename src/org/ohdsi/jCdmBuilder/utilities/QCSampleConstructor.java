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
package org.ohdsi.jCdmBuilder.utilities;

import java.io.File;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.Set;

import org.ohdsi.utilities.StringUtilities;
import org.ohdsi.utilities.collections.RowUtilities;
import org.ohdsi.utilities.files.Row;
import org.ohdsi.utilities.files.WriteCSVFile;
import org.ohdsi.utilities.files.MultiRowIterator.MultiRowSet;

import org.ohdsi.databases.RichConnection;

/**
 * Creates a sample of patient records pre and post ETL for Quality Control
 * 
 * @author MSCHUEMI
 */
public class QCSampleConstructor {

	private double					sampleProbability	= 0.001;
	private String					folder;
	private Random					random				= new Random(0);
	private Set<Long>				sampledPersonIds;
	private Map<Integer, String>	conceptIdToName;

	/**
	 * 
	 * @param folder
	 *            Path to the folder where the sample will be created
	 * @param sampleProbability
	 *            Probability of a person being sampled
	 */
	public QCSampleConstructor(String folder, double sampleProbability) {
		this.sampleProbability = sampleProbability;
		File f = new File(folder);

		if (f.exists()) {
			System.out.println("Folder " + folder + " exists: deleting all entries in folder");
			for (File file : f.listFiles())
				file.delete();
		} else {
			System.out.println("Folder " + folder + " does not exists. Creating");
			f.mkdir();
		}
		this.folder = folder;
		sampledPersonIds = new HashSet<Long>();
	}

	/**
	 * Register source data of 1 person, with their person_id. Use this function for datasets with 1 table, and 1 row per person.
	 * 
	 * @param table
	 *            Name of the source table
	 * @param row
	 *            Row in the source table containing all data for 1 person
	 * @param personId
	 *            The person_id that will be used for this person in the CDM
	 */
	public void registerPersonData(String table, Row row, Long personId) {
		if (random.nextDouble() < sampleProbability) {
			sampledPersonIds.add(personId);
			MultiRowSet multiRowSet = new MultiRowSet(new String[] { table });
			multiRowSet.get(table).add(row);
			outputToFile(multiRowSet, folder + "/" + personId + "_SOURCE.csv");
		}
	}

	/**
	 * Register source data of 1 person, with their person_id
	 * 
	 * @param multiRowSet
	 *            The set of rows in one or several tables containing all data for 1 person
	 * @param personId
	 *            The person_id that will be used for this person in the CDM
	 */
	public void registerPersonData(MultiRowSet multiRowSet, Long personId) {
		if (random.nextDouble() < sampleProbability) {
			sampledPersonIds.add(personId);
			outputToFile(multiRowSet, folder + "/" + personId + "_SOURCE.csv");
		}
	}

	/**
	 * For the sampled persons, retrieve all records from the CDM
	 * 
	 * @param connection
	 *            Connection to the CDM instance
	 * @param database
	 *            Name of the CDM database
	 */
	public void addCdmData(RichConnection connection, String database) {
		StringUtilities.outputWithTime("Adding CDM data to sample for quality control");
		loadConceptIdToName(connection);
		List<String> tables = getTablesWithPersonIdField(connection, database);
		for (Long personId : sampledPersonIds) {
			WriteCSVFile out = new WriteCSVFile(folder + "/" + personId + "_CDM.csv");
			for (String table : tables) {
				String sortField = null;
				for (String fieldName : connection.getFieldNames(table))
					if (fieldName.endsWith("_DATE")) {
						sortField = fieldName;
						break;
					}

				boolean first = true;
				for (Row row : connection.query("SELECT * FROM " + table + " WHERE person_id = " + personId
						+ (sortField == null ? "" : " ORDER BY " + sortField))) {
					if (first) {
						first = false;
						List<String> tableHeader = new ArrayList<String>(2);
						tableHeader.add("Table:");
						tableHeader.add(table);
						out.write(tableHeader);

						List<String> headerPlus = new ArrayList<String>();
						for (String fieldName : row.getFieldNames()) {
							headerPlus.add(fieldName);
							if (fieldName.endsWith("_CONCEPT_ID"))
								headerPlus.add("(" + fieldName.replace("_CONCEPT_ID", "_CONCEPT_NAME") + ")");
						}
						out.write(headerPlus);
					}
					List<String> rowPlus = new ArrayList<String>();
					for (String fieldName : row.getFieldNames()) {
						rowPlus.add(row.get(fieldName));
						if (fieldName.endsWith("_CONCEPT_ID")) {
							String conceptId = row.get(fieldName);
							if (StringUtilities.isNumber(conceptId)) {
								String name = conceptIdToName.get(Integer.parseInt(conceptId));
								if (name == null)
									rowPlus.add("");
								else
									rowPlus.add(name);
							} else
								rowPlus.add("");
						}
					}
					out.write(rowPlus);
				}
				if (!first)
					out.write(new ArrayList<String>());
			}

			out.close();
		}
		conceptIdToName = null;
	}

	private List<String> getTablesWithPersonIdField(RichConnection connection, String database) {
		List<String> tables = new ArrayList<String>();
		for (String table : connection.getTableNames(database))
			if (connection.getFieldNames(table).contains("PERSON_ID"))
				tables.add(table);
		return tables;
	}

	private void loadConceptIdToName(RichConnection connection) {
		conceptIdToName = new HashMap<Integer, String>();
		for (Row row : connection.query("SELECT concept_id, concept_name FROM concept;")){
			row.upperCaseFieldNames();
			conceptIdToName.put(row.getInt("CONCEPT_ID"), row.get("CONCEPT_NAME"));
		}
	}

	private void outputToFile(MultiRowSet multiRowSet, String filename) {
		List<String> tables = new ArrayList<String>(multiRowSet.keySet());
		Collections.sort(tables);
		WriteCSVFile out = new WriteCSVFile(filename);
		for (String table : tables) {
			List<String> tableHeader = new ArrayList<String>(2);
			tableHeader.add("Table:");
			tableHeader.add(table);
			out.write(tableHeader);
			List<Row> rows = multiRowSet.get(table);
			if (rows.size() != 0) {
				out.write(rows.get(0).getFieldNames());
				for (String fieldName : rows.get(0).getFieldNames())
					if (fieldName.endsWith("_DATE")) {
						RowUtilities.sort(rows, fieldName);
						break;
					}
			}
			for (Row row : rows)
				out.write(row.getCells());
			out.write(new ArrayList<String>());
		}
		out.close();
	}

}
