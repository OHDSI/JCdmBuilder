library(DatabaseConnector)
library(SqlRender)

dbms <- "pdw"
user <- NULL
pw <- NULL
server <- "JRDUSAPSCTL01"
port <- 17001
schema <- "CDM_Truven_MDCD_V521"
outputFolder <- "s:/data/MdcdSample"
connectionDetails <- DatabaseConnector::createConnectionDetails(dbms = dbms,
                                                                server = server,
                                                                user = user,
                                                                password = pw,
                                                                port = port,
                                                                schema = schema)
con <- connect(connectionDetails)

executeSql(con, "CREATE TABLE #sample WITH (LOCATION = USER_DB, DISTRIBUTION = HASH(person_id)) AS SELECT TOP 100000 person_id FROM person")

tables <- c("person", "observation_period", "condition_occurrence", "condition_era", "drug_exposure", "drug_era", "procedure_occurrence", "observation", "measurement", "death")

if (!file.exists(outputFolder))
  dir.create(outputFolder)
for (table in tables) {
  writeLines(paste("Dumping table", table))
  sql <- "SELECT @table.* FROM @table INNER JOIN #sample sample ON sample.person_id = @table.person_id"
  sql <- renderSql(sql, table = table)$sql
  data <- querySql(con, sql)
  for (colname in grep("_ID$", colnames(data))) {
    data[, colname] <- formatC(data[,colname], format = "f", digits = 0)
    data[data[,colname] == "NA", colname] <- NA
  }
  write.csv(data, file = file.path(outputFolder, paste0(table, ".csv")), row.names = FALSE, na = "")
}
