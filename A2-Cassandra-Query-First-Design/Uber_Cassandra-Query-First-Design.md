# UBER : Cassandra Query First Design

## Introduction
In this group project team is analysing the Uber's Ride Sharing application and all the relational data models for a passenger to book a ride. The first objective here is to build the Physical Relational Data model based on the sample ER diagram obtained from the public domain. Team also put together the applicaiton requirements considering application function and Query first design. Using those Queries team has designed the Data base with a NoSQL Database- Cassandra. 
In the next sections of this document detailed step by step processes and steps  followed are explained.

## RDBMS Schema Analysis
The below ER diagram(figure1.1) show the high level design for the Uber passenger ride app, using which the Relationational modeling with the tables and the columns are built and presented in Relational Modelling section (figure 1.2).
### Entity Relation

![alt text](images/Uber%20Logical%20Design.png)
_Figure 1-1. Entity-relationship diagram for Uber application_

### Relational Modelling
The below diagram is built considering the Data driven approach.

![alt text](images/Uber Logical Design.png)

_Figure 1-2. Physical data model for Uber application_

## Query Analysis
Considering the query first approach team reviewed the fuctions and features of the Uber ride app and the flows. 
Below are the use cases /queries team has designed. 

#### Transaction Processing Queries

- Q1: Load customer profile and allow user to select business or personal accounts.
- Q2: Find nearby cars based on the passenger destination & Pick up location(x miles).
- Q3: Get Trip Details based on the Trip ID (How far is the driver, Confirmation number, Driver Name & Rating, Type of car, Drop off time,Fare)
- Q4: (Passenger checking Driver information) get driver details with given driver id(Rating, miles driven)
- Q5: Get Passenger details (Passenger ID, his rating).
- Q6: Compute the surge fare based on factors demand.
- Q7: Total Earnings per (day/date Range) for a given driver (driver id)
- Q8: What are the most common pickup locations across all trips?
- Q9: What are the most common destination locations across all trips?
- Q10: Calculate Fare (based on wait time, diversion, stops)

  
![image](https://github.com/ISM6562-Big-Data/TEAM_DATA_MINERS/assets/151387182/a9f2f20d-08d9-4426-945f-ac3f362ae813)


_Figure 1-3. Uber Ride application queries_


## Below work flow diagram shows the worksteps for the applicaiton

## Cassandra Schema Design

![alt text](images/Cassandra_RL.png)
_Figure 1-3. Cassandra Logical Datamodel_


## SQL Queries to Address the questions

-- Q1: Load customer profile for a given user_id
```
SELECT first_name, last_name, email, mobile_number, account_type
FROM user_profiles
WHERE user_id = 111222333;

-- Q2: Find nearby cars based on location (requires a function or stored procedure to calculate distance)
```
DELIMITER $$
```
DELIMITER $$

CREATE PROCEDURE nearbycars(Range DECIMAL(10,2))
BEGIN
    DECLARE target_lat DECIMAL(10,2);
    DECLARE target_lon DECIMAL(10,2);
    
    SET pax_lat = 100; -- Example passenger latitude that would come from APP
    SET pax_long = 200; -- Example passenger longitude that would come from APP

    SELECT car_id, driver_id
    FROM nearby_cars
    WHERE location_lat BETWEEN pax_lat - Range AND pax_lat + Range
      AND location_lon BETWEEN pax_long - Range AND pax_long + Range
      AND is_available = TRUE;
END$$

DELIMITER ;


-- Q3: Get Trip Details for a given trip_id
```
SELECT trip_id, driver_id, car_type, estimated_drop_off_time, fare, driver_first_name, driver_last_name, driver_overall_rating
FROM trip_details
WHERE trip_id = ?;

-- Q4: Get driver details for a given driver_id
```
SELECT first_name, last_name, overall_rating, miles_driven
FROM driver_information
WHERE driver_id = ?;

-- Q5: Get Passenger details for a given user_id
```
SELECT first_name, last_name, overall_rating, mobile_number, email
FROM passenger_details
WHERE user_id = ?;

-- Q6: Compute the surge fare based on demand level
```
SELECT multiplier
FROM surge_pricing
WHERE demand_level = ?;

-- Q7: Calculate Total Earnings for a driver within a date range
```
SELECT SUM(fare + tips) AS total_earnings
FROM driver_earnings
WHERE driver_id = ? AND start_datetime BETWEEN ? AND ?;

-- Q8: Identify the most common pickup locations
```
SELECT city, province, COUNT(*) AS total_pickups
FROM pickup_locations_analytics
GROUP BY city, province
ORDER BY total_pickups DESC
LIMIT 1;

-- Q9: Identify the most common destination locations
```
SELECT city, province, COUNT(*) AS total_destinations
FROM destination_locations_analytics
GROUP BY city, province
ORDER BY total_destinations DESC
LIMIT 1;

-- Q10: Calculate Fare for a trip (Assuming necessary data like tolls, tax rate, etc., are provided)
```
SELECT (base_fare + tolls + (tax_rate * (base_fare + tolls)) + (estimated_distance * pricing_per_mile)) AS total_fare
FROM fare_estimate
WHERE trip_id = ?;
```

## CQL Queries to Address the questions

-- Q1: Load customer profile for a given user_id
```
SELECT first_name, last_name, email, mobile_number, account_type
FROM user_profiles
WHERE user_id = 111222333

-- Q2: Find nearby cars based on location (requires a function or stored procedure to calculate distance)
```
SELECT car_id, driver_id FROM nearby_cars
WHERE location_lat = ? AND location_lon = ? AND is_available = true ALLOW FILTERING;

-- Q3: Get Trip Details for a given trip_id
```
SELECT trip_id, driver_id, car_type, estimated_drop_off_time, fare
FROM trip_details
WHERE trip_id = ?;

-- Q4: Get driver details for a given driver_id
```
SELECT first_name, last_name, overall_rating, miles_driven
FROM driver_information
WHERE driver_id = ?;

-- Q5: Get Passenger details for a given user_id
```
SELECT first_name, last_name, overall_rating, mobile_number, email
FROM passenger_details
WHERE user_id = ?;

-- Q6: Compute the surge fare based on demand level
```
SELECT surge_factor AS multiplier
FROM surge_pricing
WHERE location_lat = ? AND location_lon = ? AND demand_level = ? ALLOW FILTERING;

-- Q7: Calculate Total Earnings for a driver within a date range
```
In SQL, we can add up all the earnings for a driver over a specific period using the SUM() function. 
In Cassandra, it does not allow you to sum across multiple rows from different partitions by default. This is because such an operation could potentially involve gathering data from many different nodes in the cluster, which would be very slow and inefficient.
Instead, we will have to handle this by either:
•	When we insert earnings data, we could also update a separate record (Example: Total) that keeps a running total of the earnings for each driver for the date range in question. Something like 
•	I am assuming we will have a table structure to hold monthly or daily totals, we can query directly for the total earnings in a specific period.

SELECT total_earnings 
FROM driver_monthly_earnings 
WHERE driver_id = ? AND year_month = '2024-04';

-- Q8: Identify the most common pickup locations
```
In SQL, To find the most common pickup locations we can use a GROUP BY statement along with COUNT () and ORDER BY to group records by location and count them.
In Cassandra, GROUP BY clause is available but it’s has limited functionality.
Instead
•	We could maintain a counter for each location that increments every time a pickup is made. Then we can easily query to find the highest counters, make sense?
CREATE TABLE pickup_location_counters (
    city TEXT,
    province TEXT,
    pickups counter,
    PRIMARY KEY (city, province)
);
UPDATE pickup_location_counters 
SET pickups = pickups + 1 
WHERE city = 'CityName' AND province = 'ProvinceName';

-- Q9: Identify the most common destination locations
```
Same as in Q8, identifying the most common destination locations would require aggregation over multiple records to count occurrences.
Instead
•	Maintain counters: A counter table to keep track of the number of times a destination is used.
CREATE TABLE destination_location_counters (
    city TEXT,
    province TEXT,
    dropoffs counter,
    PRIMARY KEY (city, province)
);
UPDATE destination_location_counters 
SET dropoffs = dropoffs + 1 
WHERE city = 'CityName' AND province = 'ProvinceName';

-- Q10: Calculate Fare for a trip (Assuming necessary data like tolls, tax rate, etc., are provided)
```
SELECT (base_fare + tolls + (tax_rate * (base_fare + tolls)) + (estimated_distance * pricing_per_mile)) AS total_fare
FROM fare_details
WHERE trip_id = ?;

## Discussion

## Conclusion
