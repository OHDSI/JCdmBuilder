DROP TABLE concept;
DROP TABLE concept_ancestor;
DROP TABLE concept_class;
DROP TABLE concept_relationship;
DROP TABLE concept_synonym;
DROP TABLE domain;
DROP TABLE drug_strength;
DROP TABLE relationship;
DROP TABLE source_to_concept_map;
DROP TABLE vocabulary;

SELECT * 
INTO concept
FROM @vocab_schema.dbo.concept;

SELECT * 
INTO concept_ancestor
FROM @vocab_schema.dbo.concept_ancestor;

SELECT * 
INTO concept_class
FROM @vocab_schema.dbo.concept_class;

SELECT * 
INTO concept_relationship
FROM @vocab_schema.dbo.concept_relationship;

SELECT * 
INTO concept_synonym
FROM @vocab_schema.dbo.concept_synonym;

SELECT * 
INTO domain
FROM @vocab_schema.dbo.domain;

SELECT * 
INTO drug_strength
FROM @vocab_schema.dbo.drug_strength;

SELECT * 
INTO relationship
FROM @vocab_schema.dbo.relationship;

SELECT * 
INTO source_to_concept_map
FROM @vocab_schema.dbo.source_to_concept_map

SELECT * 
INTO vocabulary
FROM @vocab_schema.dbo.vocabulary;

ALTER TABLE concept REBUILD WITH ( DATA_COMPRESSION = PAGE );
ALTER TABLE concept_ancestor REBUILD WITH ( DATA_COMPRESSION = PAGE );
ALTER TABLE concept_relationship REBUILD WITH ( DATA_COMPRESSION = PAGE );
ALTER TABLE concept_synonym REBUILD WITH ( DATA_COMPRESSION = PAGE );
ALTER TABLE domain REBUILD WITH ( DATA_COMPRESSION = PAGE );
ALTER TABLE drug_strength REBUILD WITH ( DATA_COMPRESSION = PAGE );
ALTER TABLE relationship REBUILD WITH ( DATA_COMPRESSION = PAGE );
ALTER TABLE source_to_concept_map REBUILD WITH ( DATA_COMPRESSION = PAGE );
ALTER TABLE vocabulary REBUILD WITH ( DATA_COMPRESSION = PAGE );
