Create TABLE Passenger (
  userID CHAR(5) PRIMARY KEY NOT NULL,
  overall_rating FLOAT,
  first_name VARCHAR(20),
  last_name VARCHAR(30),
  mobile_number CHAR(10),
  email VARCHAR(30)
)

Create TABLE Request (
  RequestID CHAR(5) PRIMARY KEY NOT NULL,
  Ride_Type CHAR(5),
  Pickup_lat FLOAT,
  Pickup_long FLOAT,
  Drop_lat FLOAT,
  Drop_long FLOAT,
  Seats INT,
  FOREIGN KEY (userID)			
	  REFERENCES Passenger(userID)
)

Create TABLE Driver (
  DriverID CHAR(5) PRIMARY KEY NOT NULL,
  overall_rating FLOAT,
  first_name VARCHAR(20),
  last_name VARCHAR(30),
  mobile_number CHAR(10),
  gender CHAR(1),
  email VARCHAR(30)
)

Create TABLE Request_to_Driver (
  RequestDriverID CHAR(5) PRIMARY KEY NOT NULL,
  isAccepted BOOLEAN
  FOREIGN KEY (DriverID)			
	  REFERENCES Driver(DriverID),
  FOREIGN KEY (userID)			
	  REFERENCES Passenger(userID)
)

Create TABLE Car (
  CarID CHAR(5) PRIMARY KEY NOT NULL,
  CarVIN_No CHAR(20),
  Plate_number CHAR(5),
  Make CHAR(10),
  Model CHAR(10),
  Seats INT,
  UberType CHAR(5),
  FOREIGN KEY (DriverID)			
	  REFERENCES Driver(DriverID)
)

Create TABLE CarLocation (
  CarID CHAR(5) PRIMARY KEY NOT NULL,
  Drop_lat FLOAT,
  Drop_long FLOAT,
  FOREIGN KEY (CarID)			
	  REFERENCES Car(CarID)
)

Create TABLE Trip (
  TripID CHAR(5) PRIMARY KEY NOT NULL,
  Start_Time TIMESTAMP,
  Duration int,
  Driver_Rating int,
  Passenger_Rating int,
  FOREIGN KEY (DriverID)			
	  REFERENCES Driver(DriverID),
  FOREIGN KEY (RequestID)			
	  REFERENCES Request(RequestID)
)