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
package org.ohdsi.jCdmBuilder.vocabulary;

import java.io.File;
import java.util.Collection;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

import org.ohdsi.databases.RichConnection;
import org.ohdsi.jCdmBuilder.DbSettings;
import org.ohdsi.utilities.StringUtilities;
import org.ohdsi.utilities.files.ReadCSVFileWithHeader;
import org.ohdsi.utilities.files.Row;

public class InsertVocabularyInServer {

	// private static String[] tables = new String[] { "CONCEPT", "CONCEPT_ANCESTOR", "CONCEPT_RELATIONSHIP", "CONCEPT_SYNONYM", "RELATIONSHIP",
	// "SOURCE_TO_CONCEPT_MAP", "VOCABULARY", "DRUG_STRENGTH", "DRUG_APPROVAL" };

	public void process(String folder, DbSettings dbSettings) {
		RichConnection connection = new RichConnection(dbSettings.server, dbSettings.domain, dbSettings.user, dbSettings.password, dbSettings.dbType);
		connection.use(dbSettings.database);

		Set<String> tables = new HashSet<String>();
		for (String table : connection.getTableNames(dbSettings.database))
			tables.add(table.toLowerCase());

		for (File file : new File(folder).listFiles()) {
			if (file.getName().toLowerCase().endsWith(".csv")) {
				String table = file.getName().substring(0, file.getName().length() - 4);
				if (tables.contains(table.toLowerCase())) {
					StringUtilities.outputWithTime("Inserting data for table " + table);
					connection.execute("TRUNCATE " + table);
					Iterator<Row> iterator = new ReadCSVFileWithHeader(file.getAbsolutePath(), '\t').iterator();
					Iterator<Row> filteredIterator = new RowFilterIterator(iterator, connection.getFieldNames(table), table);
					connection.insertIntoTable(filteredIterator, table, false, true);
				}
			}
		}
		System.out.println("Finished inserting tables");
	}

	private static class RowFilterIterator implements Iterator<Row> {

		private Set<String>		allowedFields;
		private Iterator<Row>	iterator;
		private Set<String>		ignoredFields;

		public RowFilterIterator(Iterator<Row> iterator, Collection<String> allowedFields, String tableName) {
			this.allowedFields = new HashSet<String>();
			for (String field : allowedFields)
				this.allowedFields.add(field.toLowerCase());
			this.iterator = iterator;
			ignoredFields = new HashSet<String>();
		}

		@Override
		public boolean hasNext() {
			return iterator.hasNext();
		}

		@Override
		public Row next() {
			Row row = iterator.next();
			Row filteredRow = new Row();
			for (String fieldName : row.getFieldNames()) {
				if (allowedFields.contains(fieldName.toLowerCase()))
					filteredRow.add(fieldName, row.get(fieldName));
				else if (ignoredFields.add(fieldName))
					System.err.println("Ignoring field " + fieldName);
			}
			return filteredRow;
		}

		@Override
		public void remove() {
			throw new RuntimeException("Calling unimplemented method");
		}
	}
}
