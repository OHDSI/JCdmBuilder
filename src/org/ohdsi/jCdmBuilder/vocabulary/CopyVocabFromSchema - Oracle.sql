BEGIN
  EXECUTE IMMEDIATE 'TRUNCATE TABLE concept;
  EXECUTE IMMEDIATE 'DROP TABLE concept;
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -942 THEN
      RAISE;
    END IF;
END;

BEGIN
  EXECUTE IMMEDIATE 'TRUNCATE TABLE concept_ancestor;
  EXECUTE IMMEDIATE 'DROP TABLE concept_ancestor;
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -942 THEN
      RAISE;
    END IF;
END;

BEGIN
  EXECUTE IMMEDIATE 'TRUNCATE TABLE concept_class;
  EXECUTE IMMEDIATE 'DROP TABLE concept_class;
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -942 THEN
      RAISE;
    END IF;
END;

BEGIN
  EXECUTE IMMEDIATE 'TRUNCATE TABLE concept_relationship;
  EXECUTE IMMEDIATE 'DROP TABLE concept_relationship;
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -942 THEN
      RAISE;
    END IF;
END;

BEGIN
  EXECUTE IMMEDIATE 'TRUNCATE TABLE concept_synonym;
  EXECUTE IMMEDIATE 'DROP TABLE concept_synonym;
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -942 THEN
      RAISE;
    END IF;
END;

BEGIN
  EXECUTE IMMEDIATE 'TRUNCATE TABLE domain;
  EXECUTE IMMEDIATE 'DROP TABLE domain;
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -942 THEN
      RAISE;
    END IF;
END;

BEGIN
  EXECUTE IMMEDIATE 'TRUNCATE TABLE drug_strength;
  EXECUTE IMMEDIATE 'DROP TABLE drug_strength;
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -942 THEN
      RAISE;
    END IF;
END;

BEGIN
  EXECUTE IMMEDIATE 'TRUNCATE TABLE relationship;
  EXECUTE IMMEDIATE 'DROP TABLE relationship;
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -942 THEN
      RAISE;
    END IF;
END;

BEGIN
  EXECUTE IMMEDIATE 'TRUNCATE TABLE source_to_concept_map;
  EXECUTE IMMEDIATE 'DROP TABLE source_to_concept_map;
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -942 THEN
      RAISE;
    END IF;
END;

BEGIN
  EXECUTE IMMEDIATE 'TRUNCATE TABLE vocabulary;
  EXECUTE IMMEDIATE 'DROP TABLE vocabulary;
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -942 THEN
      RAISE;
    END IF;
END;

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
SELECT * FROM @vocab_schema.source_to_concept_map

CREATE TABLE vocabulary AS 
SELECT * FROM @vocab_schema.vocabulary;


