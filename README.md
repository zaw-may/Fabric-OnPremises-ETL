### Disclaimer
This repository represents a real-world project. The information contained within is solely for demonstration purposes, showcasing a successfully completed project. No sensitive data, including Personally Identifiable Information (PII), client information, or any other confidential materials, has been used or included in this repository. Any resemblance to real individuals, companies, or sensitive data is purely coincidental. Whenever possible, sample-generated data is used instead of real data.

### Objective 
Transition from On-premises SQL Database to Microsoft Fabric SQL Database for enhanced analytics.

### Technologies
Microsoft Fabric Analytics, Data Pipeline, On-premises Data Gateway, SQL Server 2022, Fabric SQL Database

### Data Pipeline
<img width="753" alt="Z-Pipeline" src="https://github.com/user-attachments/assets/1537b5b8-f9d6-423a-82a0-8a8b3e297c68" />

### Scenario
* Currently, the company’s core data resides in an on-premises SQL Server environment. The SQL database contains multiple schemas and a large number of tables.
* The SQL database will also integrate with external systems, including third-party applications, file systems and, occasionally, APIs.
* In the future, the data is expected to grow beyond its current size.
* For cost-effectiveness, they want to use incremental data loading for large tables.
* During data ingestion, only lightweight data transformations are required. However, more complex transformations may be needed in the future.
* The client organization wants to process the data on a schedule and incremental refresh.
* They are also considering implementing the Medallion Architecture to improve data quality and consistency.

### Prerequisite
* SQL Server (including database tables you want to work with)
* Fabric SQL Database (including already-created stored procedures - you need to change them based on your requirements)
* On-premises data gateway (including a specific connection with your SQL Server)

### Article
https://medium.com/@zaw-may/moving-on-premises-data-into-microsoft-fabric-data-stores-c03e0399fdfc
