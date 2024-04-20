Create TABLE Passenger (
  userID CHAR(6) PRIMARY KEY NOT NULL,
  first_name VARCHAR(30),
  last_name VARCHAR(30),
  gender VARCHAR(25),
  overall_rating DECIMAL(10,1),
  mobile_number CHAR(25),
  email VARCHAR(30)
)

CREATE TABLE Request (   -- Need to store the first line of the address too . 
  requestID CHAR(6) PRIMARY KEY NOT NULL,
  userID CHAR(6),  
  ride_type VARCHAR(20),
  pickup_lat FLOAT,
  pickup_long FLOAT,
  drop_lat FLOAT,
  drop_long FLOAT,
  seats INT,
  FOREIGN KEY (userID) 
  REFERENCES Passenger(userID)
)

Create TABLE Driver (
  driverID CHAR(5) PRIMARY KEY NOT NULL,
  first_name VARCHAR(30),
  last_name VARCHAR(30),
  gender VARCHAR(25),
  overall_rating DECIMAL(10,1),
  mobile_number CHAR(25),
  email VARCHAR(30)
)


CREATE TABLE Request_to_Driver (
  requestdriverID CHAR(6) PRIMARY KEY NOT NULL,
  is_accepted BIT NOT NULL,
  driverID CHAR(5) NOT NULL,  
  requestID CHAR(6) NOT NULL,    
  FOREIGN KEY (driverID) 
  REFERENCES Driver(driverID),
  FOREIGN KEY (requestID) 
  REFERENCES Request(requestID)
)

Create TABLE Trip (
  tripID CHAR(6) PRIMARY KEY NOT NULL,
  start_time DateTime2,
  duration varchar(20),  --- Not sure about this 
  driver_rating DECIMAL(10,1),
  passenger_rating DECIMAL(10,1),
  driverID CHAR(5) NOT NULL,  
  requestID CHAR(6) NOT NULL,
  FOREIGN KEY (driverID)			
	  REFERENCES Driver(driverID),
  FOREIGN KEY (requestID)			
	  REFERENCES Request(requestID)
)


Create TABLE Car (
  carID CHAR(5) PRIMARY KEY NOT NULL,
  carVIN_No CHAR(20),
  plate_number CHAR(5),
  make CHAR(10),
  model CHAR(10),
  seats INT,
  uberType CHAR(5),
  driverID CHAR(5) NOT NULL,
  FOREIGN KEY (driverID)			
	  REFERENCES Driver(driverID)
)

Create TABLE CarLocation (
  carlocationID CHAR(5) PRIMARY KEY NOT NULL,
  carID CHAR(5),
  drop_lat FLOAT,   -- this needs to be current lat , long
  drop_long FLOAT,
  FOREIGN KEY (carID)			
	  REFERENCES Car(carID)
)