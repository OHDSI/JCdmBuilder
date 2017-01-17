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
package org.ohdsi.jCdmBuilder.cdm.v5;

import org.ohdsi.jCdmBuilder.cdm.CdmVx;

public class CdmV5 implements CdmVx {
	public String structureMSSQL() {
		return "OMOP CDM ddl - SQL Server.sql";
	}

	public String structurePostgreSQL() {
		return "OMOP CDM ddl - PostgreSQL.sql";
	}

	public String structureOracle() {
		return "OMOP CDM ddl - Oracle.sql";
	}

	public String indexesMSSQL() {
		return "OMOP CDM indexes required - SQL Server.sql";
	}

	public String indexesPostgreSQL() {
		return "OMOP CDM indexes required - PostgreSQL.sql";
	}

	public String indexesOracle() {
		return "OMOP CDM indexes required - Oracle  Without constraints.sql";
	}
}
