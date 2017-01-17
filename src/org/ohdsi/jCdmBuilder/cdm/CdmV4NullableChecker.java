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
package org.ohdsi.jCdmBuilder.cdm;

import org.ohdsi.utilities.collections.OneToManySet;
import org.ohdsi.utilities.files.ReadCSVFileWithHeader;
import org.ohdsi.utilities.files.Row;

public class CdmV4NullableChecker {
	
	private OneToManySet<String, String>	tableToNotNullableFields;
	
	public CdmV4NullableChecker() {
		tableToNotNullableFields = new OneToManySet<String, String>();
		for (Row row : new ReadCSVFileWithHeader(this.getClass().getResourceAsStream("NotNullableV4.csv"))) {
			if (row.get("IS_NULLABLE").equals("NO"))
				tableToNotNullableFields.put(row.get("TABLE_NAME").toLowerCase(), row.get("COLUMN_NAME").toLowerCase());
		}
	}
	
	public String findNonAllowedNull(String tableName, Row row) {
		for (String notNullableField : tableToNotNullableFields.get(tableName))
			try {
				if (row.get(notNullableField).length() == 0)
					return notNullableField;
			} catch (Exception e) {
				return notNullableField;
			}
		return null;
	}
}
