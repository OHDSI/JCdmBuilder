TRUNCATE TABLE condition_era;

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

		condition_start_date AS start_date,

		COALESCE(condition_end_date, condition_start_date) AS end_date,

		condition_concept_id AS concept_id
	FROM condition_occurrence source_table
	WHERE condition_concept_id != 0

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

INSERT INTO condition_era (
condition_era_id,
	person_id, 
	condition_concept_id, 

	condition_era_start_date, 
condition_occurrence_count,	
	condition_era_end_date)

SELECT ROW_NUMBER() OVER (ORDER BY person_id) AS condition_era_id,
    person_id AS person_id,
	concept_id AS condition_concept_id,

	MIN(start_date) AS condition_era_start_date,
	COUNT(*) AS condition_occurrence_count,	
	end_date AS condition_era_end_date
	
FROM cte_ends
GROUP BY person_id,
	concept_id,

	end_date
ORDER BY person_id,
	concept_id;
