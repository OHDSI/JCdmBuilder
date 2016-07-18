IF OBJECT_ID('test_results', 'U') IS NOT NULL
  DROP TABLE test_results;

CREATE TABLE test_results (id INT, description VARCHAR(512), test VARCHAR(256), status VARCHAR(5));


-- 101: Person id
INSERT INTO test_results SELECT 101 AS id, 'Person id' AS description, 'Expect person' AS test, CASE WHEN(SELECT COUNT(*) FROM person WHERE person_id = '1' AND person_source_value = '4200000000101') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;

-- 102: Person gender mappings
INSERT INTO test_results SELECT 102 AS id, 'Person gender mappings' AS description, 'Expect person' AS test, CASE WHEN(SELECT COUNT(*) FROM person WHERE person_id = '2' AND gender_concept_id = '8507' AND gender_source_value = '0') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;
INSERT INTO test_results SELECT 102 AS id, 'Person gender mappings' AS description, 'Expect person' AS test, CASE WHEN(SELECT COUNT(*) FROM person WHERE person_id = '3' AND gender_concept_id = '8532' AND gender_source_value = '1') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;
INSERT INTO test_results SELECT 102 AS id, 'Person gender mappings' AS description, 'Expect person' AS test, CASE WHEN(SELECT COUNT(*) FROM person WHERE person_id = '4' AND gender_concept_id = '0' AND gender_source_value = '9') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;

-- 103: Person year, month and day of birth: age > 0
INSERT INTO test_results SELECT 103 AS id, 'Person year, month and day of birth: age > 0' AS description, 'Expect person' AS test, CASE WHEN(SELECT COUNT(*) FROM person WHERE person_id = '5' AND year_of_birth = '1990' AND month_of_birth IS NULL AND day_of_birth IS NULL) = 0 THEN 'FAIL' ELSE 'PASS' END AS status;

-- 103: Person year, month and day of birth: age = 0
INSERT INTO test_results SELECT 103 AS id, 'Person year, month and day of birth: age = 0' AS description, 'Expect person' AS test, CASE WHEN(SELECT COUNT(*) FROM person WHERE person_id = '6' AND year_of_birth = '2010' AND month_of_birth = '1' AND day_of_birth = '1') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;
INSERT INTO test_results SELECT 103 AS id, 'Person year, month and day of birth: age = 0' AS description, 'Expect person' AS test, CASE WHEN(SELECT COUNT(*) FROM person WHERE person_id = '7' AND year_of_birth = '2010' AND month_of_birth = '1' AND day_of_birth = '6') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;

-- 104: Person race and ethnicity
INSERT INTO test_results SELECT 104 AS id, 'Person race and ethnicity' AS description, 'Expect person' AS test, CASE WHEN(SELECT COUNT(*) FROM person WHERE person_id = '8' AND race_concept_id = '8527' AND race_source_value = '1' AND ethnicity_concept_id = '0' AND ethnicity_source_value IS NULL) = 0 THEN 'FAIL' ELSE 'PASS' END AS status;
INSERT INTO test_results SELECT 104 AS id, 'Person race and ethnicity' AS description, 'Expect person' AS test, CASE WHEN(SELECT COUNT(*) FROM person WHERE person_id = '9' AND race_concept_id = '8516' AND race_source_value = '2' AND ethnicity_concept_id = '0' AND ethnicity_source_value IS NULL) = 0 THEN 'FAIL' ELSE 'PASS' END AS status;
INSERT INTO test_results SELECT 104 AS id, 'Person race and ethnicity' AS description, 'Expect person' AS test, CASE WHEN(SELECT COUNT(*) FROM person WHERE person_id = '10' AND race_concept_id = '8522' AND race_source_value = '3' AND ethnicity_concept_id = '38003563' AND ethnicity_source_value = '3') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;
INSERT INTO test_results SELECT 104 AS id, 'Person race and ethnicity' AS description, 'Expect person' AS test, CASE WHEN(SELECT COUNT(*) FROM person WHERE person_id = '11' AND race_concept_id = '8557' AND race_source_value = '4' AND ethnicity_concept_id = '0' AND ethnicity_source_value IS NULL) = 0 THEN 'FAIL' ELSE 'PASS' END AS status;
INSERT INTO test_results SELECT 104 AS id, 'Person race and ethnicity' AS description, 'Expect person' AS test, CASE WHEN(SELECT COUNT(*) FROM person WHERE person_id = '12' AND race_concept_id = '8657' AND race_source_value = '5' AND ethnicity_concept_id = '0' AND ethnicity_source_value IS NULL) = 0 THEN 'FAIL' ELSE 'PASS' END AS status;
INSERT INTO test_results SELECT 104 AS id, 'Person race and ethnicity' AS description, 'Expect person' AS test, CASE WHEN(SELECT COUNT(*) FROM person WHERE person_id = '13' AND race_concept_id = '0' AND race_source_value = '6' AND ethnicity_concept_id = '0' AND ethnicity_source_value IS NULL) = 0 THEN 'FAIL' ELSE 'PASS' END AS status;
INSERT INTO test_results SELECT 104 AS id, 'Person race and ethnicity' AS description, 'Expect person' AS test, CASE WHEN(SELECT COUNT(*) FROM person WHERE person_id = '14' AND race_concept_id = '0' AND race_source_value = '-9' AND ethnicity_concept_id = '0' AND ethnicity_source_value IS NULL) = 0 THEN 'FAIL' ELSE 'PASS' END AS status;
INSERT INTO test_results SELECT 104 AS id, 'Person race and ethnicity' AS description, 'Expect person' AS test, CASE WHEN(SELECT COUNT(*) FROM person WHERE person_id = '15' AND race_concept_id = '0' AND race_source_value = '-8' AND ethnicity_concept_id = '0' AND ethnicity_source_value IS NULL) = 0 THEN 'FAIL' ELSE 'PASS' END AS status;

-- 201: Visit occurrence person ID
INSERT INTO test_results SELECT 201 AS id, 'Visit occurrence person ID' AS description, 'Expect visit_occurrence' AS test, CASE WHEN(SELECT COUNT(*) FROM visit_occurrence WHERE person_id = '16') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;

-- 202: Visit concept ID
INSERT INTO test_results SELECT 202 AS id, 'Visit concept ID' AS description, 'Expect visit_occurrence' AS test, CASE WHEN(SELECT COUNT(*) FROM visit_occurrence WHERE person_id = '17' AND visit_concept_id = '9201' AND visit_source_value IS NULL AND visit_source_concept_id IS NULL) = 0 THEN 'FAIL' ELSE 'PASS' END AS status;

-- 203: Visit start date
INSERT INTO test_results SELECT 203 AS id, 'Visit start date' AS description, 'Expect visit_occurrence' AS test, CASE WHEN(SELECT COUNT(*) FROM visit_occurrence WHERE person_id = '18' AND visit_start_date = '2010-02-01') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;
INSERT INTO test_results SELECT 203 AS id, 'Visit start date' AS description, 'Expect visit_occurrence' AS test, CASE WHEN(SELECT COUNT(*) FROM visit_occurrence WHERE person_id = '19' AND visit_start_date = '2010-02-06') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;
INSERT INTO test_results SELECT 203 AS id, 'Visit start date' AS description, 'Expect visit_occurrence' AS test, CASE WHEN(SELECT COUNT(*) FROM visit_occurrence WHERE person_id = '20' AND visit_start_date = '2010-02-01') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;

-- 204: Visit end date
INSERT INTO test_results SELECT 204 AS id, 'Visit end date' AS description, 'Expect visit_occurrence' AS test, CASE WHEN(SELECT COUNT(*) FROM visit_occurrence WHERE person_id = '21' AND visit_end_date = '2010-02-01') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;
INSERT INTO test_results SELECT 204 AS id, 'Visit end date' AS description, 'Expect visit_occurrence' AS test, CASE WHEN(SELECT COUNT(*) FROM visit_occurrence WHERE person_id = '22' AND visit_end_date = '2010-02-03') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;
INSERT INTO test_results SELECT 204 AS id, 'Visit end date' AS description, 'Expect visit_occurrence' AS test, CASE WHEN(SELECT COUNT(*) FROM visit_occurrence WHERE person_id = '23' AND visit_end_date = '2010-02-01') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;

-- 205: Visit type concept ID
INSERT INTO test_results SELECT 205 AS id, 'Visit type concept ID' AS description, 'Expect visit_occurrence' AS test, CASE WHEN(SELECT COUNT(*) FROM visit_occurrence WHERE person_id = '24' AND visit_type_concept_id = '44818517') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;

-- 206: Visit care site
INSERT INTO test_results SELECT 206 AS id, 'Visit care site' AS description, 'Expect visit_occurrence' AS test, CASE WHEN(SELECT COUNT(*) FROM visit_occurrence WHERE person_id = '25' AND care_site_id = '12345') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;

-- 301: Observation period person ID
INSERT INTO test_results SELECT 301 AS id, 'Observation period person ID' AS description, 'Expect observation_period' AS test, CASE WHEN(SELECT COUNT(*) FROM observation_period WHERE person_id = '26') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;

-- 302: Observation period start date
INSERT INTO test_results SELECT 302 AS id, 'Observation period start date' AS description, 'Expect observation_period' AS test, CASE WHEN(SELECT COUNT(*) FROM observation_period WHERE person_id = '27' AND observation_period_start_date = '2010-02-01') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;
INSERT INTO test_results SELECT 302 AS id, 'Observation period start date' AS description, 'Expect observation_period' AS test, CASE WHEN(SELECT COUNT(*) FROM observation_period WHERE person_id = '28' AND observation_period_start_date = '2010-02-06') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;
INSERT INTO test_results SELECT 302 AS id, 'Observation period start date' AS description, 'Expect observation_period' AS test, CASE WHEN(SELECT COUNT(*) FROM observation_period WHERE person_id = '29' AND observation_period_start_date = '2010-02-01') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;

-- 303: Observation period end date
INSERT INTO test_results SELECT 303 AS id, 'Observation period end date' AS description, 'Expect observation_period' AS test, CASE WHEN(SELECT COUNT(*) FROM observation_period WHERE person_id = '30' AND observation_period_end_date = '2010-02-01') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;
INSERT INTO test_results SELECT 303 AS id, 'Observation period end date' AS description, 'Expect observation_period' AS test, CASE WHEN(SELECT COUNT(*) FROM observation_period WHERE person_id = '31' AND observation_period_end_date = '2010-02-03') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;
INSERT INTO test_results SELECT 303 AS id, 'Observation period end date' AS description, 'Expect observation_period' AS test, CASE WHEN(SELECT COUNT(*) FROM observation_period WHERE person_id = '32' AND observation_period_end_date = '2010-02-01') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;

-- 304: Observation period type concept ID
INSERT INTO test_results SELECT 304 AS id, 'Observation period type concept ID' AS description, 'Expect observation_period' AS test, CASE WHEN(SELECT COUNT(*) FROM observation_period WHERE person_id = '33' AND period_type_concept_id = '44814724') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;

-- 401: Location id, state, and county
INSERT INTO test_results SELECT 401 AS id, 'Location id, state, and county' AS description, 'Expect location' AS test, CASE WHEN(SELECT COUNT(*) FROM location WHERE location_id = '2' AND state = 'NY' AND county = 'New York County' AND location_source_value = '36061') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;

-- 501: Care site
INSERT INTO test_results SELECT 501 AS id, 'Care site' AS description, 'Expect care_site' AS test, CASE WHEN(SELECT COUNT(*) FROM care_site WHERE care_site_id = '999' AND place_of_service_concept_id = '9201' AND location_id = '2' AND care_site_source_value = '999') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;

-- 601: Condition occurrence person ID
INSERT INTO test_results SELECT 601 AS id, 'Condition occurrence person ID' AS description, 'Expect condition_occurrence' AS test, CASE WHEN(SELECT COUNT(*) FROM condition_occurrence WHERE person_id = '36') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;

-- 602: Condition occurrence concept mapping
INSERT INTO test_results SELECT 602 AS id, 'Condition occurrence concept mapping' AS description, 'Expect condition_occurrence' AS test, CASE WHEN(SELECT COUNT(*) FROM condition_occurrence WHERE person_id = '37' AND condition_concept_id = '255848' AND condition_source_value = '486' AND condition_source_concept_id = '44829009') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;

-- 603: Condition occurrence concept mapping multiple codes
INSERT INTO test_results SELECT 603 AS id, 'Condition occurrence concept mapping multiple codes' AS description, 'Expect condition_occurrence' AS test, CASE WHEN(SELECT COUNT(*) FROM condition_occurrence WHERE person_id = '38' AND condition_concept_id = '255848' AND condition_source_value = '486' AND condition_source_concept_id = '44829009') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;
INSERT INTO test_results SELECT 603 AS id, 'Condition occurrence concept mapping multiple codes' AS description, 'Expect condition_occurrence' AS test, CASE WHEN(SELECT COUNT(*) FROM condition_occurrence WHERE person_id = '38' AND condition_concept_id = '320128' AND condition_source_value = '4019' AND condition_source_concept_id = '44821949') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;
INSERT INTO test_results SELECT 603 AS id, 'Condition occurrence concept mapping multiple codes' AS description, 'Expect condition_occurrence' AS test, CASE WHEN(SELECT COUNT(*) FROM condition_occurrence WHERE person_id = '38' AND condition_concept_id = '201826' AND condition_source_value = '25000' AND condition_source_concept_id = '44836914') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;

-- 604: Condition occurrence concept mapping to other domain
INSERT INTO test_results SELECT 604 AS id, 'Condition occurrence concept mapping to other domain' AS description, 'Expect condition_occurrence' AS test, CASE WHEN(SELECT COUNT(*) FROM condition_occurrence WHERE person_id = '39') != 0 THEN 'FAIL' ELSE 'PASS' END AS status;

-- 605: Condition occurrence start and end date
INSERT INTO test_results SELECT 605 AS id, 'Condition occurrence start and end date' AS description, 'Expect condition_occurrence' AS test, CASE WHEN(SELECT COUNT(*) FROM condition_occurrence WHERE person_id = '40' AND condition_start_date = '2010-02-01' AND condition_end_date IS NULL) = 0 THEN 'FAIL' ELSE 'PASS' END AS status;

-- 606: Condition type concept ID
INSERT INTO test_results SELECT 606 AS id, 'Condition type concept ID' AS description, 'Expect condition_occurrence' AS test, CASE WHEN(SELECT COUNT(*) FROM condition_occurrence WHERE person_id = '41' AND condition_type_concept_id = '38000184') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;

-- 607: Condition occurrence visit occurrence id
INSERT INTO test_results SELECT 607 AS id, 'Condition occurrence visit occurrence id' AS description, 'Expect condition_occurrence' AS test, CASE WHEN(SELECT COUNT(*) FROM condition_occurrence WHERE person_id = '42' AND visit_occurrence_id = '42') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;

-- 608: Condition row count
INSERT INTO test_results SELECT 608 AS id, 'Condition row count' AS description, 'Expect condition_occurrence' AS test, CASE WHEN(SELECT COUNT(*) FROM condition_occurrence WHERE person_id = '43') != 1 THEN 'FAIL' ELSE 'PASS' END AS status;

-- 701: Death
INSERT INTO test_results SELECT 701 AS id, 'Death' AS description, 'Expect death' AS test, CASE WHEN(SELECT COUNT(*) FROM death WHERE person_id = '44' AND death_type_concept_id = '38003566') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;

-- 801: Procedure occurrence person ID
INSERT INTO test_results SELECT 801 AS id, 'Procedure occurrence person ID' AS description, 'Expect procedure_occurrence' AS test, CASE WHEN(SELECT COUNT(*) FROM procedure_occurrence WHERE person_id = '45') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;

-- 802: Procedure occurrence concept mapping
INSERT INTO test_results SELECT 802 AS id, 'Procedure occurrence concept mapping' AS description, 'Expect procedure_occurrence' AS test, CASE WHEN(SELECT COUNT(*) FROM procedure_occurrence WHERE person_id = '46' AND procedure_concept_id = '2004765' AND procedure_source_value = '7359' AND procedure_source_concept_id = '2004765') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;

-- 803: Procedure occurrence concept mapping multiple codes
INSERT INTO test_results SELECT 803 AS id, 'Procedure occurrence concept mapping multiple codes' AS description, 'Expect procedure_occurrence' AS test, CASE WHEN(SELECT COUNT(*) FROM procedure_occurrence WHERE person_id = '47' AND procedure_concept_id = '2004765' AND procedure_source_value = '7359' AND procedure_source_concept_id = '2004765') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;
INSERT INTO test_results SELECT 803 AS id, 'Procedure occurrence concept mapping multiple codes' AS description, 'Expect procedure_occurrence' AS test, CASE WHEN(SELECT COUNT(*) FROM procedure_occurrence WHERE person_id = '47' AND procedure_concept_id = '2008238' AND procedure_source_value = '9904' AND procedure_source_concept_id = '2008238') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;
INSERT INTO test_results SELECT 803 AS id, 'Procedure occurrence concept mapping multiple codes' AS description, 'Expect procedure_occurrence' AS test, CASE WHEN(SELECT COUNT(*) FROM procedure_occurrence WHERE person_id = '47' AND procedure_concept_id = '2001537' AND procedure_source_value = '3722' AND procedure_source_concept_id = '2001537') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;

-- 804: Procedure occurrence date
INSERT INTO test_results SELECT 804 AS id, 'Procedure occurrence date' AS description, 'Expect procedure_occurrence' AS test, CASE WHEN(SELECT COUNT(*) FROM procedure_occurrence WHERE person_id = '48' AND procedure_date = '2010-02-04') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;

-- 805: Procedure occurrence date greater than los
INSERT INTO test_results SELECT 805 AS id, 'Procedure occurrence date greater than los' AS description, 'Expect procedure_occurrence' AS test, CASE WHEN(SELECT COUNT(*) FROM procedure_occurrence WHERE person_id = '49') != 0 THEN 'FAIL' ELSE 'PASS' END AS status;

-- 806: Procedure type concept ID
INSERT INTO test_results SELECT 806 AS id, 'Procedure type concept ID' AS description, 'Expect procedure_occurrence' AS test, CASE WHEN(SELECT COUNT(*) FROM procedure_occurrence WHERE person_id = '50' AND procedure_type_concept_id = '38000251') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;

-- 807: Procedure from diagnosis code
INSERT INTO test_results SELECT 807 AS id, 'Procedure from diagnosis code' AS description, 'Expect procedure_occurrence' AS test, CASE WHEN(SELECT COUNT(*) FROM procedure_occurrence WHERE person_id = '51' AND procedure_concept_id = '4163273' AND procedure_type_concept_id = '38000184' AND procedure_source_value = 'V252' AND procedure_source_concept_id = '44833073') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;

-- 808: Procedure occurrence visit occurrence id
INSERT INTO test_results SELECT 808 AS id, 'Procedure occurrence visit occurrence id' AS description, 'Expect procedure_occurrence' AS test, CASE WHEN(SELECT COUNT(*) FROM procedure_occurrence WHERE person_id = '52' AND visit_occurrence_id = '52') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;

-- 901: Measurement person ID
INSERT INTO test_results SELECT 901 AS id, 'Measurement person ID' AS description, 'Expect measurement' AS test, CASE WHEN(SELECT COUNT(*) FROM measurement WHERE person_id = '53') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;

-- 902: Measurement concept mapping
INSERT INTO test_results SELECT 902 AS id, 'Measurement concept mapping' AS description, 'Expect measurement' AS test, CASE WHEN(SELECT COUNT(*) FROM measurement WHERE person_id = '54' AND measurement_concept_id = '40482801' AND measurement_source_value = '25002' AND measurement_source_concept_id = '44836915') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;

-- 903: Measurement date
INSERT INTO test_results SELECT 903 AS id, 'Measurement date' AS description, 'Expect measurement' AS test, CASE WHEN(SELECT COUNT(*) FROM measurement WHERE person_id = '55' AND measurement_date = '2010-02-01') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;

-- 904: Measurement type concept ID
INSERT INTO test_results SELECT 904 AS id, 'Measurement type concept ID' AS description, 'Expect measurement' AS test, CASE WHEN(SELECT COUNT(*) FROM measurement WHERE person_id = '56' AND measurement_type_concept_id = '38000184') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;

-- 905: Measurement visit occurrence id
INSERT INTO test_results SELECT 905 AS id, 'Measurement visit occurrence id' AS description, 'Expect measurement' AS test, CASE WHEN(SELECT COUNT(*) FROM measurement WHERE person_id = '57' AND visit_occurrence_id = '57') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;

-- 1001: Observation person ID
INSERT INTO test_results SELECT 1001 AS id, 'Observation person ID' AS description, 'Expect observation' AS test, CASE WHEN(SELECT COUNT(*) FROM observation WHERE person_id = '58') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;

-- 1002: Observation concept mapping
INSERT INTO test_results SELECT 1002 AS id, 'Observation concept mapping' AS description, 'Expect observation' AS test, CASE WHEN(SELECT COUNT(*) FROM observation WHERE person_id = '59' AND observation_concept_id = '136997' AND observation_source_value = '38651' AND observation_source_concept_id = '44823095') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;

-- 1003: Observation date
INSERT INTO test_results SELECT 1003 AS id, 'Observation date' AS description, 'Expect observation' AS test, CASE WHEN(SELECT COUNT(*) FROM observation WHERE person_id = '60' AND observation_date = '2010-02-01') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;

-- 1004: Observation type concept ID
INSERT INTO test_results SELECT 1004 AS id, 'Observation type concept ID' AS description, 'Expect observation' AS test, CASE WHEN(SELECT COUNT(*) FROM observation WHERE person_id = '61' AND observation_type_concept_id = '38000184') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;

-- 1005: Observation visit occurrence id
INSERT INTO test_results SELECT 1005 AS id, 'Observation visit occurrence id' AS description, 'Expect observation' AS test, CASE WHEN(SELECT COUNT(*) FROM observation WHERE person_id = '62' AND visit_occurrence_id = '62') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;

-- 1006: Observation from sample weight
INSERT INTO test_results SELECT 1006 AS id, 'Observation from sample weight' AS description, 'Expect observation' AS test, CASE WHEN(SELECT COUNT(*) FROM observation WHERE person_id = '63' AND observation_concept_id = '0' AND observation_date = '2010-02-01' AND observation_type_concept_id = '900000003' AND value_as_number = '7.5' AND observation_source_value = 'DISCWT') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;
