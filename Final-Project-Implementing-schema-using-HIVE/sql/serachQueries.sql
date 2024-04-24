-- Q4  Find Nearest Car ( for each uberType)  - car , car_location 

DECLARE @Range DECIMAL(10,2)
set @Range = 20;     -- Serach Range 
DECLARE @pax_lat,@pax_long DECIMAL(10,2)
set @pax_lat = 72   -- Latitude of passenger requesting 
DECLARE  DECIMAL(10,2)
set @pax_long = -100 -- Longitude of passenger requesting 

SELECT   cc.ubertype,
		MIN(ACOS((SIN(RADIANS(@pax_lat)) * SIN(RADIANS(cl.[drop_lat ])))
		+ ((COS(RADIANS(@pax_lat))) * COS(RADIANS(cl.[drop_lat ])) * (COS(RADIANS(cl.drop_long) - RADIANS(@pax_long)))))) * 3958.756 AS distance_to_pax
FROM 
		CarLocation cl
		INNER JOIN Car cc ON cc.carID = cl.carID
WHERE 
		(cl.[drop_lat ]  BETWEEN (@pax_lat-@Range) AND (@pax_lat+@Range)) AND (cl.drop_long BETWEEN (@pax_long-@Range) AND (@pax_long+@Range)) 
GROUP BY 
		cc.ubertype

