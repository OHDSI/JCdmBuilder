SELECT source_code,
	source_code_description,
	target_concept_id,
	concept_code,
	concept_name
FROM source_to_concept_map
INNER JOIN concept
	ON target_concept_id = concept_id
WHERE (
		source_vocabulary_id = 2
		OR source_vocabulary_id = 600
		)
	AND target_vocabulary_id = 1
	AND (
		concept.invalid_reason = ''
		OR concept.invalid_reason IS NULL
		);
