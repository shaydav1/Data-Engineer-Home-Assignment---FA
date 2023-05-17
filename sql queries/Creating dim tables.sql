--------------------------------------Creating dim-----------------------------------------

--Dim_Highest_alarm_level
with cte as(
	SELECT DISTINCT highest_alarm_level
	FROM Fire_Incident_Dispatch_Data)
SELECT ROW_NUMBER() over(order by highest_alarm_level) as Highest_alarm_level_key, 
	   highest_alarm_level
INTO Dim_Highest_alarm_level
FROM cte;

--sanity check
select * from Dim_Highest_alarm_level

--------------------------------------
go
--Dim_Incident_borough
with cte as(
	SELECT DISTINCT incident_borough
	FROM Fire_Incident_Dispatch_Data)
SELECT ROW_NUMBER() over(order by incident_borough) as incident_borough_key, 
	   incident_borough
INTO Dim_Incident_borough
FROM cte;

--sanity check
select * from Dim_Incident_borough 

--------------------------------------
go
--Dim_Alarm_level_index
with cte as(
	SELECT DISTINCT alarm_level_index_description
	FROM Fire_Incident_Dispatch_Data)
SELECT ROW_NUMBER() over(order by alarm_level_index_description) as alarm_level_index_description_key, 
	   alarm_level_index_description
INTO Dim_Alarm_level_index
FROM cte;

--sanity check
select * from Dim_Alarm_level_index 

--------------------------------------
go
--Dim_Incident_classification
with cte as(
	SELECT DISTINCT incident_classification, incident_classification_group
	FROM Fire_Incident_Dispatch_Data)
SELECT ROW_NUMBER() over(order by incident_classification) as incident_classification_key, 
	   incident_classification,
	   incident_classification_group
INTO Dim_Incident_classification
FROM cte;

--sanity check
select * from Dim_Incident_classification 

--------------------------------------
go
--Dim_Alarm_box
with cte as(
	SELECT DISTINCT alarm_box_number, alarm_box_borough, alarm_box_location
	FROM Fire_Incident_Dispatch_Data)
SELECT ROW_NUMBER() over(order by alarm_box_number, alarm_box_borough) as alarm_box_key, 
	   alarm_box_number,
	   alarm_box_borough,
	   alarm_box_location
INTO Dim_Alarm_box
FROM cte;

--sanity check
select * from Dim_Alarm_box 