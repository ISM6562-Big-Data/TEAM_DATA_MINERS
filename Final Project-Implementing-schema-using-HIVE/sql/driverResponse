-- 1) SQL Query for Updating and Recording the Driver's Response
DECLARE @is_accepted INT = 1; -- Driver's response for a given trip ID; coming from App
DECLARE @DriverID char(5)='DR392' -- provided by App
DECLARE @RequestID char(6)='REQ230' --provied by App
 
DECLARE @NextReqID NVARCHAR(255);
DECLARE @MaxNumber INT;  
SELECT @MaxNumber = ISNULL(MAX(CAST(SUBSTRING(requestdriverID, 4, LEN(requestdriverID) - 3) AS INT)), 0)
FROM Request_to_Driver;
SET @MaxNumber = @MaxNumber + 1;
-- Construct the next tripID with the incremented number
SET @NextReqID = 'RED' + RIGHT('000' + CAST(@MaxNumber AS VARCHAR(7)), 3);
INSERT INTO Request_to_Driver (requestdriverID, is_accepted, driverID, requestID)
VALUES (@NextReqID,@is_accepted,@DriverID, @RequestID);
SELECT * FROM Request_to_Driver
