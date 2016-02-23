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
package org.ohdsi.jCdmBuilder.vocabulary;

import org.ohdsi.utilities.files.Row;
import org.ohdsi.utilities.files.WriteCSVFileWithHeader;

import org.ohdsi.databases.DbType;
import org.ohdsi.databases.RichConnection;


public class FetchVocabularyFromServer {
	
	public static String server = "RNDUSRDHIT06";
	public static String database = "[OMOP_Vocabulary_v5.0_20141020]";
	public static String outputFolder = "S:/Data/VocabV5/";
	//public static String[] tables = new String[]{"CONCEPT","CONCEPT_ANCESTOR","CONCEPT_RELATIONSHIP","CONCEPT_SYNONYM","RELATIONSHIP","SOURCE_TO_CONCEPT_MAP","VOCABULARY","DRUG_STRENGTH","DRUG_APPROVAL"};
	
	public static void main(String[] args) {
		RichConnection connection = new RichConnection(server, null, null, null,  DbType.MSSQL);
		connection.use(database);
		
		for (String table : connection.getTableNames(database)){
			System.out.println("Writing table " + table);
			
			WriteCSVFileWithHeader out = new WriteCSVFileWithHeader(outputFolder+table+".csv");
			for (Row row : connection.query("SELECT * FROM " + table))
				out.write(row);
			out.close();
		}
		
		
	}
	
}
