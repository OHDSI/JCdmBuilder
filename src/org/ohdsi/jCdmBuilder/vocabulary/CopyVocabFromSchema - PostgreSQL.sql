DROP TABLE IF EXISTS concept;
DROP TABLE IF EXISTS concept_ancestor;
DROP TABLE IF EXISTS concept_class;
DROP TABLE IF EXISTS concept_relationship;
DROP TABLE IF EXISTS concept_synonym;
DROP TABLE IF EXISTS domain;
DROP TABLE IF EXISTS drug_strength;
DROP TABLE IF EXISTS relationship;
DROP TABLE IF EXISTS source_to_concept_map;
DROP TABLE IF EXISTS vocabulary;

CREATE TABLE concept AS 
SELECT * FROM @vocab_schema.concept;

CREATE TABLE concept_ancestor AS 
SELECT * FROM @vocab_schema.concept_ancestor;

CREATE TABLE concept_class AS 
SELECT * FROM @vocab_schema.concept_class;

CREATE TABLE concept_relationship AS 
SELECT * FROM @vocab_schema.concept_relationship;

CREATE TABLE concept_synonym AS 
SELECT * FROM @vocab_schema.concept_synonym;

CREATE TABLE domain AS 
SELECT * FROM @vocab_schema.domain;

CREATE TABLE drug_strength AS 
SELECT * FROM @vocab_schema.drug_strength;

CREATE TABLE relationship AS 
SELECT * FROM @vocab_schema.relationship;

CREATE TABLE source_to_concept_map AS 
SELECT * FROM @vocab_schema.source_to_concept_map;

CREATE TABLE vocabulary AS 
SELECT * FROM @vocab_schema.vocabulary;


