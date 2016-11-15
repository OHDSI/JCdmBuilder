INSERT INTO cdm_source (
	cdm_source_name,
	cdm_source_abbreviation,
	cdm_holder,
	source_description,
	source_documentation_reference,
	cdm_etl_reference,
	source_release_date,
	cdm_release_date,
	cdm_version,
	vocabulary_version
	)
VALUES (
	'HCUP National (Nationwide) Inpatient Sample',
	'HCUP',
	NULL,
	'The HCUP National Inpatient Sample database represents hospital data, collected under sponsorship of the Agency for Healthcare Research and Quality (AHRQ). The data includes diagnoses, procedures, discharge status, demographics, and charges for hospital care in the United States, regardless of payer. Information on drugs and devices is not included. The HCUP data is based on hospital visits, with no information linking multiple visits of the same patient together. Cost information has not yet been included in the CDM.',
	'https://www.hcup-us.ahrq.gov/nisoverview.jsp',
	'https://github.com/OHDSI/JCdmBuilder',
	NULL,
	'@today',
	'5.0.1',
	'5.0'
	);
