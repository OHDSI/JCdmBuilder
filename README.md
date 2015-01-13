JCdmBuilder
==============

Introduction
========

The JCdmBuilder is a Java program that can be used to transform observational datasets from their native formats and schemas into the OMOP Common Data Model (version 4).  

Features
========
* This builder can convert the following database:
  * Healthcare Cost and Utilization Project (HCUP) - Nationwide Inpatient Sample (NIS)

Screenshot
===========
<img src="https://github.com/OHDSI/JCdmBuilder/blob/master/man/ScreenShot.png" alt="JCdmBuilder" title="JCdmBuilder" />

Technology
============
JCdmBuilder is a Java program. It has been tested on SQL Server, but should support other platforms as well, including PostgreSQL and Oracle. JCdmBuilder pulls all data, and simultaneously insert the transformed data, so it could read from one platform, and write to another. 

System Requirements
============
* Java

Dependencies
============
Requires the OMOP Vocabulary to be already present in the target database, or else JCdmBuilder has a feature to insert the Vocabulary from a zip file containing the Vocabulary tables in CSV format.
 
Getting Started
===============
JCdmBuilder is still under development. Once officially released, you can download the application from the releases tab.

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