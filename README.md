JCdmBuilder
==============

The JCdmBuilder is a Java program that offers various tools that can be used when contructing a data in the OMOP Common Data Model (CDM). It can also be used to transform some specific observational datasets from their native formats and schemas into the CDM.  

Features
========
* This builder supports the following ETLs:
  * Healthcare Cost and Utilization Project (HCUP) - Nationwide Inpatient Sample (NIS) to CDM version 4
  * Healthcare Cost and Utilization Project (HCUP) - Nationwide Inpatient Sample (NIS) to CDM version 5
* Creating the database structure and indices for CDM versions 4 or 5
* Loading the vocabulary from files into the database
* Load data in CDM format from CSV files into the database
* Automatically creating condition and drug eras 
* Supports SQL Server, Oracle and PostgreSQL

Screenshot
===========
<img src="https://github.com/OHDSI/JCdmBuilder/blob/master/man/Screenshot.png" alt="JCdmBuilder" title="JCdmBuilder" />

Technology
============
JCdmBuilder is a Java program.  

System Requirements
============
* Java

Dependencies
============
None
 
Getting Started
===============
JCdmBuilder is still under development. 

Getting Involved
=============
* User Guide:  To be developed
* Developer questions/comments/feedback: <a href="http://forums.ohdsi.org/c/developers">OHDSI Forum</a>
* We use the <a href="../../issues">GitHub issue tracker</a> for all bugs/issues/enhancements

License
=======
JCdmBuilder is licensed under Apache License 2.0

Development
===========

###Development status
Alpha

Acknowledgements
===========
Janssen Pharmaceutical Research & Development, LLC
