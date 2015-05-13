SELECT old_drg.concept_code AS source_code,
	old_drg.concept_name AS source_name,
	old_drg.concept_id AS source_concept_id,
	YEAR(old_drg.valid_end_date) AS source_end_year,
	new_drg.domain_id AS target_domain,
	new_drg.concept_id AS target_concept_id,
	new_drg.concept_name AS target_name,
	new_drg.concept_code AS target_code
FROM concept old_drg
INNER JOIN concept_relationship
	ON old_drg.concept_id = concept_id_1
INNER JOIN concept new_drg
	ON new_drg.concept_id = concept_id_2
WHERE old_drg.vocabulary_id = 'DRG'
	AND relationship_id = 'Maps to'
	AND new_drg.standard_concept = 'S'
	AND new_drg.vocabulary_id = 'DRG'
ORDER BY old_drg.concept_code,
	old_drg.valid_end_date
