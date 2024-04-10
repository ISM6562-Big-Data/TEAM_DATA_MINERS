# UBER : Cassandra Query First Design

## Introduction
In this group project team is analysing the Uber's Ride Sharing application and all the relational data models for a passenger to book a ride. The first objective here is to build the Physical Relational Data model based on the sample ER diagram obtained from the public domain. Team also put together the applicaiton requirements considering application function and Query first design. Using those Queries team has designed the Data base with a NoSQL Database- Cassandra. 
In the next sections of this document detailed step by step processes and steps  followed are explained.

## RDBMS Schema Analysis
The below ER diagram(figure1.1) show the high level design for the Uber passenger ride app, using which the Relationational modeling with the tables and the columns are built and presented in Relational Modelling section (figure 1.2).
### Entity Relation

![alt text](images/Uber Logical Design.png)
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

![alt text](images/uber_cassandranewdesign.png)
_Figure 1-3. Cassandra Logical Datamodel_

## Discussion

## Conclusion
