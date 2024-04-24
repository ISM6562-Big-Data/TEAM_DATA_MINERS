--1) SQL Query for Booking a Request
 
DECLARE @userID CHAR(6) = 'PAS101';
DECLARE @ride_type VARCHAR(20) = 'Uber Green';
DECLARE @pickup_lat FLOAT = 40.000023459;
DECLARE @pickup_long FLOAT = 45.000023459;
DECLARE @drop_lat FLOAT = 100.000023459;
DECLARE @drop_long FLOAT = 80.000023459;
DECLARE @seats INT = 5;
 
DECLARE @NextRequestID NVARCHAR(255);
DECLARE @MaxNumber INT;
 
-- Find the highest request number by extracting the numeric part of the requestID and incrementing it by 1
SELECT @MaxNumber = ISNULL(MAX(CAST(SUBSTRING(requestID, 4, LEN(requestID) - 3) AS INT)), 0)
FROM Request;
 
SET @MaxNumber = @MaxNumber + 1;
 
-- Construct the next requestID with the incremented number
SET @NextRequestID = 'REQ' + RIGHT('000' + CAST(@MaxNumber AS VARCHAR(7)), 3);
 
-- Insert a new ride request
INSERT INTO Request (requestID, userID, ride_type, pickup_lat, pickup_long, drop_lat, drop_long, seats)
VALUES (@NextRequestID, @userID, @ride_type, @pickup_lat, @pickup_long, @drop_lat, @drop_long, @seats);
