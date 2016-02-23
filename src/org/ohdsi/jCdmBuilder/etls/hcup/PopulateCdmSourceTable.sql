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
	'The National (Nationwide) Inpatient Sample (NIS) is part of a family of databases and software tools developed for the Healthcare Cost and Utilization Project (HCUP). The NIS is the largest publicly available all-payer inpatient health care database in the United States, yielding national estimates of hospital inpatient stays. Unweighted, it contains data from more than 7 million hospital stays each year. Weighted, it estimates more than 36 million hospitalizations nationally.',
	'https://www.hcup-us.ahrq.gov/nisoverview.jsp',
	'https://github.com/OHDSI/JCdmBuilder',
	NULL,
	'@today',
	'5.0',
	'5.0'
	);
