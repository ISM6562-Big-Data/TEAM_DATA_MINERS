DECLARE @current_long real = 123.22; -- Correctly assign real without quotes
DECLARE @current_lat real = 90.00; -- Correct the latitude to a valid value
DECLARE @carID varchar(5) = 'CR611'; -- Provided by App
DECLARE @NextCarlocID NVARCHAR(255);
DECLARE @MaxNumber INT;

SELECT @MaxNumber = ISNULL(MAX(CAST(SUBSTRING(carlocationID, 3, LEN(carlocationID) - 2) AS INT)), 0)
FROM CarLocation;
SET @MaxNumber = @MaxNumber + 1;
SET @NextCarlocID = 'CL' + RIGHT('000' + CAST(@MaxNumber AS VARCHAR(3)), 3);
INSERT INTO CarLocation(carlocationID, carID, current_lat, current_long)
VALUES (@NextCarlocID, @carID, @current_lat, @current_long);
SELECT * FROM CarLocation;
