source("HcupTestFramework.R")

# Mimick C++ for convenience:
personId <<- 1
personIdPlusPlus <- function() {
  personId <<- personId + 1
  return(personId - 1)
}

set_defaults_core(age = 20) # Else default values create invalid record

### Person ###

declareTest(101, "Person id")
add_core(key = "4200000000101")
expect_person(person_id = personIdPlusPlus(), person_source_value = "4200000000101")

declareTest(102, "Person gender mappings")
add_core(key = "4200000000102", female = 0)
add_core(key = "4200000000103", female = 1)
add_core(key = "4200000000104", female = 9)
expect_person(person_id = personIdPlusPlus(), gender_concept_id = 8507, gender_source_value = "0")
expect_person(person_id = personIdPlusPlus(), gender_concept_id = 8532, gender_source_value = "1")
expect_person(person_id = personIdPlusPlus(), gender_concept_id = 0, gender_source_value = "9")

declareTest(103, "Person year, month and day of birth: age > 0")
add_core(key = "4200000000105", year = 2010)
expect_person(person_id = personIdPlusPlus(), year_of_birth = 1990, month_of_birth = NULL, day_of_birth = NULL)

declareTest(103, "Person year, month and day of birth: age = 0")
add_core(key = "4200000000106", age = 0, ageday = 31, year = 2010, amonth = 2, aweekend = 0) # 1st of Feb 2010 is a Monday
expect_person(person_id = personIdPlusPlus(), year_of_birth = 2010, month_of_birth = 1, day_of_birth = 1)
add_core(key = "4200000000107", age = 0, ageday = 31, year = 2010, amonth = 2, aweekend = 1) # 6st of Feb 2010 is a Saturday
expect_person(person_id = personIdPlusPlus(), year_of_birth = 2010, month_of_birth = 1, day_of_birth = 6)

declareTest(104, "Person race and ethnicity")
add_core(key = "4200000000108", race = 1)
add_core(key = "4200000000109", race = 2)
add_core(key = "4200000000110", race = 3)
add_core(key = "4200000000111", race = 4)
add_core(key = "4200000000112", race = 5)
add_core(key = "4200000000113", race = 6)
add_core(key = "4200000000114", race = -9)
add_core(key = "4200000000115", race = -8)
expect_person(person_id = personIdPlusPlus(), race_concept_id = 8527, race_source_value = "1", ethnicity_concept_id = 0, ethnicity_source_value = NULL)
expect_person(person_id = personIdPlusPlus(), race_concept_id = 8516, race_source_value = "2", ethnicity_concept_id = 0, ethnicity_source_value = NULL)
expect_person(person_id = personIdPlusPlus(), race_concept_id = 8522, race_source_value = "3", ethnicity_concept_id = 38003563, ethnicity_source_value = "3")
expect_person(person_id = personIdPlusPlus(), race_concept_id = 8557, race_source_value = "4", ethnicity_concept_id = 0, ethnicity_source_value = NULL)
expect_person(person_id = personIdPlusPlus(), race_concept_id = 8657, race_source_value = "5", ethnicity_concept_id = 0, ethnicity_source_value = NULL)
expect_person(person_id = personIdPlusPlus(), race_concept_id = 0, race_source_value = "6", ethnicity_concept_id = 0, ethnicity_source_value = NULL)
expect_person(person_id = personIdPlusPlus(), race_concept_id = 0, race_source_value = "-9", ethnicity_concept_id = 0, ethnicity_source_value = NULL)
expect_person(person_id = personIdPlusPlus(), race_concept_id = 0, race_source_value = "-8", ethnicity_concept_id = 0, ethnicity_source_value = NULL)


### Visit_occurrence ###

declareTest(201, "Visit occurrence person ID")
add_core(key = "4200000000201")
expect_visit_occurrence(person_id = personIdPlusPlus())

declareTest(202, "Visit concept ID")
add_core(key = "4200000000202")
expect_visit_occurrence(person_id = personIdPlusPlus(), visit_concept_id = 9201, visit_source_concept_id = NULL, visit_source_value = NULL)

declareTest(203, "Visit start date")
add_core(key = "4200000000203", year = 2010, amonth = 2, aweekend = 0) # 1st of Feb 2010 is a Monday
expect_visit_occurrence(person_id = personIdPlusPlus(), visit_start_date = "2010-02-01")
add_core(key = "4200000000204", year = 2010, amonth = 2, aweekend = 1) # 6st of Feb 2010 is a Saturday
expect_visit_occurrence(person_id = personIdPlusPlus(), visit_start_date = "2010-02-06")
add_core(key = "4200000000205", year = 2010, amonth = 2, aweekend = -9) # 1st of Feb 2010 is a Saturday
expect_visit_occurrence(person_id = personIdPlusPlus(), visit_start_date = "2010-02-01")

declareTest(204, "Visit end date")
add_core(key = "4200000000206", year = 2010, amonth = 2, aweekend = 0, los = 0) # 1st of Feb 2010 is a Monday
expect_visit_occurrence(person_id = personIdPlusPlus(), visit_end_date = "2010-02-01")
add_core(key = "4200000000207", year = 2010, amonth = 2, aweekend = 0, los = 2) # 1st of Feb 2010 is a Monday
expect_visit_occurrence(person_id = personIdPlusPlus(), visit_end_date = "2010-02-03")
add_core(key = "4200000000208", year = 2010, amonth = 2, aweekend = 0, los = -9) # 1st of Feb 2010 is a Monday
expect_visit_occurrence(person_id = personIdPlusPlus(), visit_end_date = "2010-02-01")

declareTest(205, "Visit type concept ID")
add_core(key = "4200000000209")
expect_visit_occurrence(person_id = personIdPlusPlus(), visit_type_concept_id = 44818517)

declareTest(206, "Visit care site")
add_core(key = "4200000000210", hospid = 12345)
expect_visit_occurrence(person_id = personIdPlusPlus(), care_site_id = 12345)


### Observation_period ###

declareTest(301, "Observation period person ID")
add_core(key = "4200000000301")
expect_observation_period(person_id = personIdPlusPlus())

declareTest(302, "Observation period start date")
add_core(key = "4200000000302", year = 2010, amonth = 2, aweekend = 0) # 1st of Feb 2010 is a Monday
expect_observation_period(person_id = personIdPlusPlus(), observation_period_start_date = "2010-02-01")
add_core(key = "4200000000303", year = 2010, amonth = 2, aweekend = 1) # 6st of Feb 2010 is a Saturday
expect_observation_period(person_id = personIdPlusPlus(), observation_period_start_date = "2010-02-06")
add_core(key = "4200000000304", year = 2010, amonth = 2, aweekend = -9) # 1st of Feb 2010 is a Saturday
expect_observation_period(person_id = personIdPlusPlus(), observation_period_start_date = "2010-02-01")

declareTest(303, "Observation period end date")
add_core(key = "4200000000305", year = 2010, amonth = 2, aweekend = 0, los = 0) # 1st of Feb 2010 is a Monday
expect_observation_period(person_id = personIdPlusPlus(), observation_period_end_date = "2010-02-01")
add_core(key = "4200000000306", year = 2010, amonth = 2, aweekend = 0, los = 2) # 1st of Feb 2010 is a Monday
expect_observation_period(person_id = personIdPlusPlus(), observation_period_end_date = "2010-02-03")
add_core(key = "4200000000307", year = 2010, amonth = 2, aweekend = 0, los = -9) # 1st of Feb 2010 is a Monday
expect_observation_period(person_id = personIdPlusPlus(), observation_period_end_date = "2010-02-01")

declareTest(304, "Observation period type concept ID")
add_core(key = "4200000000308")
expect_observation_period(person_id = personIdPlusPlus(), period_type_concept_id = 44814724)


### Location ###

declareTest(401, "Location id, state, and county")
add_core(key = "4200000000401", hospst = "NY", hospstco = "36061")
expect_location(location_id = 2, state = "NY", county = "New York County", location_source_value = "36061")
personIdPlusPlus()

### Care site ###

declareTest(501, "Care site")
add_core(key = "4200000000501", hospst = "NY", hospstco = "36061", hospid = "999")
expect_care_site(care_site_id = 999, place_of_service_concept_id = 9201, location_id = 2, care_site_source_value = 999)
personIdPlusPlus()

### Condition occurrence ###

declareTest(601, "Condition occurrence person ID")
add_core(key = "4200000000601")
expect_condition_occurrence(person_id = personIdPlusPlus())

declareTest(602, "Condition occurrence concept mapping")
add_core(key = "4200000000602", dx1 = "486")
expect_condition_occurrence(person_id = personIdPlusPlus(), condition_concept_id = 255848, condition_source_value = "486", condition_source_concept_id = 44829009)

declareTest(603, "Condition occurrence concept mapping multiple codes")
add_core(key = "4200000000603", dx1 = "486", dx2 = "4019", dx3 = "25000")
expect_condition_occurrence(person_id = personId, condition_concept_id = 255848, condition_source_value = "486", condition_source_concept_id = 44829009)
expect_condition_occurrence(person_id = personId, condition_concept_id = 320128, condition_source_value = "4019", condition_source_concept_id = 44821949)
expect_condition_occurrence(person_id = personIdPlusPlus(), condition_concept_id = 201826, condition_source_value = "25000", condition_source_concept_id = 44836914)

declareTest(604, "Condition occurrence concept mapping to other domain")
add_core(key = "4200000000604", dx1 = "V3000", dx2 = NULL, dx3 = NULL, dx4 = NULL, dx5 = NULL, dx6 = NULL, dx7 = NULL, dx8 = NULL, dx9 = NULL, dx10 = NULL, dx11 = NULL, dx12 = NULL, dx13 = NULL, dx14 = NULL, dx15 = NULL, dx16 = NULL, dx17 = NULL, dx18 = NULL, dx19 = NULL, dx20 = NULL, dx21 = NULL, dx22 = NULL, dx23 = NULL, dx24 = NULL, dx25 = NULL)
expect_no_condition_occurrence(person_id = personIdPlusPlus())

declareTest(605, "Condition occurrence start and end date")
add_core(key = "4200000000605", dx1 = "486", year = 2010, amonth = 2, aweekend = 0) # 1st of Feb 2010 is a Monday
expect_condition_occurrence(person_id = personIdPlusPlus(), condition_start_date = "2010-02-01", condition_end_date = NULL)

declareTest(606, "Condition type concept ID")
add_core(key = "4200000000606", dx1 = "486", dx2 = NULL, dx3 = NULL, dx4 = NULL, dx5 = NULL, dx6 = NULL, dx7 = NULL, dx8 = NULL, dx9 = NULL, dx10 = NULL, dx11 = NULL, dx12 = NULL, dx13 = NULL, dx14 = NULL, dx15 = NULL, dx16 = NULL, dx17 = NULL, dx18 = NULL, dx19 = NULL, dx20 = NULL, dx21 = NULL, dx22 = NULL, dx23 = NULL, dx24 = NULL, dx25 = NULL)
expect_condition_occurrence(person_id = personIdPlusPlus(), condition_type_concept_id = 38000184)

declareTest(607, "Condition occurrence visit occurrence id")
add_core(key = "4200000000607", dx1 = "486")
expect_condition_occurrence(person_id = personId, visit_occurrence_id = personIdPlusPlus())

declareTest(608, "Condition row count")
add_core(key = "4200000000608", dx1 = "486", dx2 = NULL, dx3 = NULL, dx4 = NULL, dx5 = NULL, dx6 = NULL, dx7 = NULL, dx8 = NULL, dx9 = NULL, dx10 = NULL, dx11 = NULL, dx12 = NULL, dx13 = NULL, dx14 = NULL, dx15 = NULL, dx16 = NULL, dx17 = NULL, dx18 = NULL, dx19 = NULL, dx20 = NULL, dx21 = NULL, dx22 = NULL, dx23 = NULL, dx24 = NULL, dx25 = NULL)
expect_count_condition_occurrence(rowCount = 1, person_id = personIdPlusPlus())


### Death ###

declareTest(701, "Death")
add_core(key = "4200000000701", died = 1)
expect_death(person_id = personIdPlusPlus(), death_type_concept_id = 38003566)


### Procedure occurrence ###

declareTest(801, "Procedure occurrence person ID")
add_core(key = "4200000000801")
expect_procedure_occurrence(person_id = personIdPlusPlus())

declareTest(802, "Procedure occurrence concept mapping")
add_core(key = "4200000000802", pr1 = "7359")
expect_procedure_occurrence(person_id = personIdPlusPlus(), procedure_concept_id = 2004765, procedure_source_value = "7359", procedure_source_concept_id = 2004765)

declareTest(803, "Procedure occurrence concept mapping multiple codes")
add_core(key = "4200000000803", pr1 = "7359", pr2 = "9904", pr3 = "3722")
expect_procedure_occurrence(person_id = personId, procedure_concept_id = 2004765, procedure_source_value = "7359", procedure_source_concept_id = 2004765)
expect_procedure_occurrence(person_id = personId, procedure_concept_id = 2008238, procedure_source_value = "9904", procedure_source_concept_id = 2008238)
expect_procedure_occurrence(person_id = personIdPlusPlus(), procedure_concept_id = 2001537, procedure_source_value = "3722", procedure_source_concept_id = 2001537)

declareTest(804, "Procedure occurrence date")
add_core(key = "4200000000804", pr1 = "7359", prday1 = 3, year = 2010, amonth = 2, aweekend = 0, los = 4) # 1st of Feb 2010 is a Monday
expect_procedure_occurrence(person_id = personIdPlusPlus(), procedure_date = "2010-02-04")

declareTest(805, "Procedure occurrence date greater than los")
add_core(key = "4200000000805", pr1 = "7359", prday1 = 3, los = 0, pr2 = NULL, pr3 = NULL, pr4 = NULL, pr5 = NULL, pr6 = NULL, pr7 = NULL, pr8 = NULL, pr9 = NULL, pr10 = NULL, pr11 = NULL, pr12 = NULL, pr13 = NULL, pr14 = NULL, pr15 = NULL, dx1 = NULL, dx2 = NULL, dx3 = NULL, dx4 = NULL, dx5 = NULL, dx6 = NULL, dx7 = NULL, dx8 = NULL, dx9 = NULL, dx10 = NULL, dx11 = NULL, dx12 = NULL, dx13 = NULL, dx14 = NULL, dx15 = NULL, dx16 = NULL, dx17 = NULL, dx18 = NULL, dx19 = NULL, dx20 = NULL, dx21 = NULL, dx22 = NULL, dx23 = NULL, dx24 = NULL, dx25 = NULL)
expect_no_procedure_occurrence(person_id = personIdPlusPlus())

declareTest(806, "Procedure type concept ID")
add_core(key = "4200000000806", pr1 = "7359") 
expect_procedure_occurrence(person_id = personIdPlusPlus(), procedure_type_concept_id = 38000251)

declareTest(807, "Procedure from diagnosis code")
add_core(key = "4200000000807", dx1 = "V252") 
expect_procedure_occurrence(person_id = personIdPlusPlus(), procedure_concept_id = 4163273, procedure_source_concept_id = 44833073, procedure_source_value = "V252", procedure_type_concept_id = 38000184)

declareTest(808, "Procedure occurrence visit occurrence id")
add_core(key = "4200000000808", dx1 = "486")
expect_procedure_occurrence(person_id = personId, visit_occurrence_id = personIdPlusPlus())


### Measurement ###

declareTest(901, "Measurement person ID")
add_core(key = "4200000000901", dx1 = "25002")
expect_measurement(person_id = personIdPlusPlus())

declareTest(902, "Measurement concept mapping")
add_core(key = "4200000000902", dx1 = "25002")
expect_measurement(person_id = personIdPlusPlus(), measurement_concept_id = 40482801, measurement_source_value = "25002", measurement_source_concept_id = 44836915)

declareTest(903, "Measurement date")
add_core(key = "4200000000903", dx1 = "25002", year = 2010, amonth = 2, aweekend = 0) # 1st of Feb 2010 is a Monday
expect_measurement(person_id = personIdPlusPlus(), measurement_date = "2010-02-01")

declareTest(904, "Measurement type concept ID")
add_core(key = "4200000000904", dx1 = "25002", dx2 = NULL, dx3 = NULL, dx4 = NULL, dx5 = NULL, dx6 = NULL, dx7 = NULL, dx8 = NULL, dx9 = NULL, dx10 = NULL, dx11 = NULL, dx12 = NULL, dx13 = NULL, dx14 = NULL, dx15 = NULL, dx16 = NULL, dx17 = NULL, dx18 = NULL, dx19 = NULL, dx20 = NULL, dx21 = NULL, dx22 = NULL, dx23 = NULL, dx24 = NULL, dx25 = NULL)
expect_measurement(person_id = personIdPlusPlus(), measurement_type_concept_id = 38000184)

declareTest(905, "Measurement visit occurrence id")
add_core(key = "4200000000905", dx1 = "25002")
expect_measurement(person_id = personId, visit_occurrence_id = personIdPlusPlus())


### Observation ###

declareTest(1001, "Observation person ID")
add_core(key = "4200000001001")
expect_observation(person_id = personIdPlusPlus())

declareTest(1002, "Observation concept mapping")
add_core(key = "4200000001002", dx1 = "V3000")
expect_observation(person_id = personIdPlusPlus(), observation_concept_id = 4014295, observation_source_value = "V3000", observation_source_concept_id = 44833089)

declareTest(1003, "Observation date")
add_core(key = "4200000001003", dx1 = "V3000", year = 2010, amonth = 2, aweekend = 0) # 1st of Feb 2010 is a Monday
expect_observation(person_id = personIdPlusPlus(), observation_date = "2010-02-01")

declareTest(1004, "Observation type concept ID")
add_core(key = "4200000001004", dx1 = "V3000", dx2 = NULL, dx3 = NULL, dx4 = NULL, dx5 = NULL, dx6 = NULL, dx7 = NULL, dx8 = NULL, dx9 = NULL, dx10 = NULL, dx11 = NULL, dx12 = NULL, dx13 = NULL, dx14 = NULL, dx15 = NULL, dx16 = NULL, dx17 = NULL, dx18 = NULL, dx19 = NULL, dx20 = NULL, dx21 = NULL, dx22 = NULL, dx23 = NULL, dx24 = NULL, dx25 = NULL)
expect_observation(person_id = personIdPlusPlus(), observation_type_concept_id = 38000184)

declareTest(1005, "Observation visit occurrence id")
add_core(key = "4200000001005", dx1 = "V3000")
expect_observation(person_id = personId, visit_occurrence_id = personIdPlusPlus())

write(insertSql, "insert.sql")
write(testSql, "test.sql")


### Execute tests ###

library(DatabaseConnector)
connectionDetails <- createConnectionDetails(user = "cdm_builder",
                                             password = Sys.getenv("pwCdmBuilder"),
                                             dbms = "sql server",
                                             server = "RNDUSRDHIT09.jnj.com")
connection <- connect(connectionDetails)

executeSql(connection, "USE hcup_nis_test")
executeSql(connection, paste(insertSql, collapse = "\n"))

# Run JCdmBuilder

executeSql(connection, "USE hcup_nis_cdm")
executeSql(connection, paste(testSql, collapse = "\n"))

querySql(connection, "SELECT * FROM test_results")

querySql(connection, "SELECT person_id FROM person WHERE person_source_value = '4200000000608'")
querySql(connection, "SELECT * FROM measurement WHERE person_id = 55")

