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

import java.io.IOException;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;

import org.ohdsi.jCdmBuilder.DbSettings;
import org.ohdsi.utilities.StringUtilities;
import org.ohdsi.utilities.files.ReadCSVFileWithHeader;
import org.ohdsi.utilities.files.Row;

import org.ohdsi.databases.RichConnection;

public class InsertVocabularyInServer {
	
	// private static String[] tables = new String[] { "CONCEPT", "CONCEPT_ANCESTOR", "CONCEPT_RELATIONSHIP", "CONCEPT_SYNONYM", "RELATIONSHIP",
	// "SOURCE_TO_CONCEPT_MAP", "VOCABULARY", "DRUG_STRENGTH", "DRUG_APPROVAL" };
	
	public void process(String sourceVocabDataFile, DbSettings dbSettings) {
		RichConnection connection = new RichConnection(dbSettings.server, dbSettings.domain, dbSettings.user, dbSettings.password, dbSettings.dbType);
		connection.setContext(this.getClass());
		connection.setVerbose(false);
		
		connection.use(dbSettings.database);
		// StringUtilities.outputWithTime("Creating vocabulary data structure");
		// if (dbSettings.dbType == DbType.MYSQL)
		// connection.executeResource("CreateVocabStructureMySQL.sql");
		// else if (dbSettings.dbType == DbType.MSSQL)
		// connection.executeResource("CreateVocabStructureSQLServer.sql");
		// else if (dbSettings.dbType == DbType.POSTGRESQL)
		// connection.executeResource("CreateVocabStructurePostgreSQL.sql");
		// else
		// throw new RuntimeException("DBMS not supported");
		//
		try {
			
			ZipFile zipFile = new ZipFile(sourceVocabDataFile);
			Enumeration<? extends ZipEntry> e = zipFile.entries();
			while (e.hasMoreElements()) {
				ZipEntry entry = (ZipEntry) e.nextElement();
				String table = entry.getName().substring(0, entry.getName().length() - 4);
				StringUtilities.outputWithTime("Inserting data for table " + table);
				connection.execute("TRUNCATE TABLE " + table);
				Iterator<Row> iterator = new ReadCSVFileWithHeader(zipFile.getInputStream(entry)).iterator();
				boolean stringToNull = table.toLowerCase().equals("relationship") || table.toLowerCase().equals("drug_strength");
				connection.insertIntoTable(iterator, table, false, stringToNull);
			}
			zipFile.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		// StringUtilities.outputWithTime("Creating vocabulary indices");
		// connection.executeResource("CreateVocabIndices.sql");
		StringUtilities.outputWithTime("Finished inserting vocabulary in server");
	}
}
