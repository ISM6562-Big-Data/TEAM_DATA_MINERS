# UBER : Using HIVE Schema
## Section: I Introduction

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