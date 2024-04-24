# UBER : Using HIVE Schema
## Section: I Introduction
**Introduction to Apache Hive**

Apache Hive is a robust data warehousing solution built atop the Hadoop ecosystem, originally developed by Facebook. Hive facilitates easy querying, data summarization, and analysis of vast datasets distributed across a Hadoop environment. It converts SQL-like queries, known as HiveQL, into MapReduce jobs, making it ideal for SQL-knowledgeable users transitioning into big data roles.

**Overview of Apache Hive**

Hive is tailored for handling structured data on HDFS (Hadoop Distributed File System) and excels at scalable data processing. While Hive is not geared towards real-time querying, it is highly effective for batch processing large volumes of data. Its SQL-like interface allows for complex analytical queries, which makes Hive a fundamental tool in big data analytics.

**Relevance to Big Data**

Handling big data involves challenges like managing large volumes of data, ensuring quick data processing, and accommodating various data types. Hive addresses these through its ability to manage petabytes of data and its scalable architecture, which supports efficient parallel processing across multiple servers.

**Purpose of Implementing RDBMS Schema in Hive**

The project's goal is to translate a traditional RDBMS schema into Apache Hive, providing a hands-on exploration of Hive's data warehousing capabilities within a big data context. This exercise is crafted to yield comprehensive learning outcomes

****Schema Adaptation and Optimization:****

**Transition from RDBMS to Hive:** We aim to understand how relational schemas can be adapted for big data environments, including necessary modifications for Hive optimization. 

**Optimization Techniques:**
We will explore strategies such as partitioning and bucketing, which are crucial for improving data management and query performance in Hive.


**Leveraging SQL-like Capabilities in Big Data:**

Utilizing HiveQL will demonstrate the convergence of traditional SQL skills with big data technologies, easing the transition for those familiar with conventional databases and enhancing our strategic capabilities in data manipulation and query formulation.

**Performance and Scalability Analysis**

A thorough comparison of Hive’s performance with traditional RDBMS and Apache Cassandra will highlight the distinct advantages and potential limitations of Hive in handling large-scale data sets, focusing on scalability, efficiency, and throughput.

**Hands-on Data Warehousing Experience:**

The project serves as a practical application of data warehousing principles in the context of big data, preparing us for real-world scenarios where large-scale data management, processing, and analytics are crucial.

Through this project, we aim to replicate and enhance the structured data model from traditional databases in Hive, deepening our understanding of big data operations and improving our skills in data architecture for advanced data-driven decision-making.

## Section: II Schema Implementation in Hive

File needs to be added in to HDFS 

### Implementing RDBMS schema into Hive

#### Create Table 

#### Alter Table
```
ALTER TABLE Passenger CLUSTERED BY (userID)
INTO 10 BUCKETS;
```
### HiveQL statements
Q1 Book a request to drivers 

Q2 Update Driver response 

Q3 Update Car location

Q4 Find Nearest Car
```
SET hivevar:pax_lat = 72.0;
SET hivevar:pax_long = -100.0;
SET hivevar:Range = 20.0;

SELECT cc.ubertype,
       MIN(ACOS(SIN(RADIANS(${hivevar:pax_lat})) * SIN(RADIANS(cl.current_lat)) +
                COS(RADIANS(${hivevar:pax_lat})) * COS(RADIANS(cl.current_lat)) *
                COS(RADIANS(cl.current_long) - RADIANS(${hivevar:pax_long})))) * 3958.756 AS distance_to_pax
FROM CarLocation cl
JOIN Car cc ON cc.car_id = cl.carid
WHERE cl.current_lat BETWEEN (${hivevar:pax_lat} - ${hivevar:Range}) AND (${hivevar:pax_lat} + ${hivevar:Range})
  AND cl.current_long BETWEEN (${hivevar:pax_long} - ${hivevar:Range}) AND (${hivevar:pax_long} + ${hivevar:Range})
GROUP BY cc.ubertype;
```
Q5  Recommend most common pickup locations across all trips

Q6 Get driver earnings report for a day or date range


## Section: III Data Manipulation and Querying

### HiveQL queries to perform data insertion, updating, deletion, and retrieval

## Section: IV Performance Considerations

## Section: V Challenges and Learnings

## Section: VI Conclusion

## Section: VII Appendix
