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

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.ohdsi.databases.DbType;
import org.ohdsi.databases.RichConnection;
import org.ohdsi.jCdmBuilder.DbSettings;
import org.ohdsi.jCdmBuilder.cdm.v4.CdmV4;
import org.ohdsi.jCdmBuilder.cdm.v5.CdmV5;
import org.ohdsi.utilities.StringUtilities;
import org.ohdsi.utilities.files.ReadTextFile;

/**
 * Helper class for creating CDM V4 and V5 structures and indices
 * 
 * @author MSCHUEMI
 * 
 */
public class Cdm {
	
	public static int	VERSION_4	= 4;
	public static int	VERSION_5	= 5;
	
	public static void createStructure(DbSettings dbSettings, int version, boolean idsToBigInt) {
		CdmVx cdm;
		if (version == VERSION_4)
			cdm = new CdmV4();
		else
			cdm = new CdmV5();
		
		String resourceName = null;
		if (dbSettings.dbType == DbType.ORACLE) {
			resourceName = cdm.structureOracle();
		} else if (dbSettings.dbType == DbType.MSSQL) {
			resourceName = cdm.structureMSSQL();
		} else if (dbSettings.dbType == DbType.POSTGRESQL) {
			resourceName = cdm.structurePostgreSQL();
		}
		List<String> sqlLines = new ArrayList<>();
		for (String line : new ReadTextFile(cdm.getClass().getResourceAsStream(resourceName)))
			sqlLines.add(line);
		
		RichConnection connection = new RichConnection(dbSettings.server, dbSettings.domain, dbSettings.user, dbSettings.password, dbSettings.dbType);
		connection.setContext(cdm.getClass());
		connection.use(dbSettings.database);
		StringUtilities.outputWithTime("Deleting old tables if they exist");
		for (String line : sqlLines) {
			String tableName = StringUtilities.findBetween(line, "CREATE TABLE ", " (").trim();
			if (tableName.length() != 0)
				connection.dropTableIfExists(tableName);
		}
		
		StringUtilities.outputWithTime("Creating CDM data structure");
		if (idsToBigInt) {
			System.out.println("- Converting IDs to BIGINT");
			Pattern pattern = Pattern.compile("[^t]_id\\s+integer");
			for (int i = 0; i < sqlLines.size(); i++) {
				String line = sqlLines.get(i);
				Matcher matcher = pattern.matcher(line.toLowerCase());
				if (matcher.find())
					sqlLines.set(i, line.replace("INTEGER", "BIGINT"));
			}
		}
		connection.execute(StringUtilities.join(sqlLines, "\n"));
		
		connection.close();
		StringUtilities.outputWithTime("Done");
	}
	
	public static void createIndices(DbSettings dbSettings, int version) {
		CdmVx cdm;
		if (version == VERSION_4)
			cdm = new CdmV4();
		else
			cdm = new CdmV5();
		
		String resourceName = null;
		if (dbSettings.dbType == DbType.ORACLE) {
			resourceName = cdm.indexesOracle();
		} else if (dbSettings.dbType == DbType.MSSQL) {
			resourceName = cdm.indexesMSSQL();
		} else if (dbSettings.dbType == DbType.POSTGRESQL) {
			resourceName = cdm.indexesPostgreSQL();
		}
		
		RichConnection connection = new RichConnection(dbSettings.server, dbSettings.domain, dbSettings.user, dbSettings.password, dbSettings.dbType);
		connection.setContext(cdm.getClass());
		
		StringUtilities.outputWithTime("Creating CDM indices");
		connection.use(dbSettings.database);
		connection.executeResource(resourceName);
		
		connection.close();
		StringUtilities.outputWithTime("Done");
	}
}
