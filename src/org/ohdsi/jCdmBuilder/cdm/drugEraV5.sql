TRUNCATE TABLE drug_era;

WITH cte_source_periods (
	row_num,
	person_id,

	start_date,
	end_date,
	concept_id
	)
AS (
	-- normalize drug_exposure_end_date to either the existing drug exposure end date, or add days supply, or add 1 day to the start date
	SELECT ROW_NUMBER() OVER (ORDER BY person_id) AS row_num,
		person_id AS person_id,

		drug_exposure_start_date AS start_date,

		COALESCE(drug_exposure_end_date, DATEADD(DAY, days_supply, drug_exposure_start_date), DATEADD(DAY, 1, drug_exposure_start_date)) AS end_date,

		ancestor.concept_id
	FROM drug_exposure source_table

	INNER JOIN concept_ancestor
		ON descendant_concept_id = source_table.drug_concept_id
	INNER JOIN concept ancestor
		ON ancestor_concept_id = ancestor.concept_id

	WHERE ancestor.vocabulary_id = 'RxNorm'
		AND ancestor.concept_class_id  = 'Ingredient'
		

	),
cte_end_dates (
	person_id,
	concept_id,
	end_date
	)
AS -- the magic
	(
	SELECT person_id,
		concept_id,
		DATEADD(DAY, - 30, event_date) AS end_date -- unpad the end date
	FROM (
		SELECT person_id,
			concept_id,
			event_date,
			event_type,
			MAX(start_ordinal) OVER (
				PARTITION BY person_id,
				concept_id ORDER BY event_date,
					event_type rows unbounded preceding
				) AS start_ordinal, -- this pulls the current start down from the prior rows so that the nulls from the end dates will contain a value we can compare with 
			ROW_NUMBER() OVER (
				PARTITION BY person_id,
				concept_id ORDER BY event_date,
					event_type
				) AS overall_ord -- this re-numbers the inner union so all rows are numbered ordered by the event date
		FROM (
			-- select the start dates, assigning a row number to each
			SELECT person_id,
				concept_id,
				start_date AS event_date,
				- 1 AS event_type,
				ROW_NUMBER() OVER (
					PARTITION BY person_id,
					concept_id ORDER BY start_date
					) AS start_ordinal
			FROM cte_source_periods
			
			UNION ALL
			
			-- pad the end dates by 30 to allow a grace period for overlapping ranges.
			SELECT person_id,
				concept_id,
				DATEADD(DAY, 30, end_date),
				1 AS event_type,
				NULL
			FROM cte_source_periods
			) rawdata
		) e
	WHERE (2 * e.start_ordinal) - e.overall_ord = 0
	),
cte_ends (
	person_id,
	concept_id,

	start_date,
	end_date
	)
AS (
	SELECT d.person_id,
		d.concept_id,

		d.start_date,
		MIN(e.end_date) AS era_end_date
	FROM cte_source_periods d
	INNER JOIN cte_end_dates e
		ON d.person_id = e.person_id
			AND d.concept_id = e.concept_id
			AND e.end_date >= d.start_date
	GROUP BY d.row_num,
		d.person_id,
		d.concept_id,

		d.start_date
	)

INSERT INTO drug_era (
drug_era_id,
	person_id, 
	drug_concept_id, 

	drug_era_start_date, 
drug_exposure_count,	
	drug_era_end_date)

SELECT ROW_NUMBER() OVER (ORDER BY person_id) AS drug_era_id,
    person_id AS person_id,
	concept_id AS drug_concept_id,

	MIN(start_date) AS drug_era_start_date,
	COUNT(*) AS drug_exposure_count,	
	end_date AS drug_era_end_date
	
FROM cte_ends
GROUP BY person_id,
	concept_id,

	end_date
ORDER BY person_id,
	concept_id;
