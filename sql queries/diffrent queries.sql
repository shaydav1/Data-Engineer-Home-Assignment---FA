create table Fire_Incident_Dispatch_Data
(
	STARFIRE_INCIDENT_ID int,
	INCIDENT_DATETIME datetime,
	ALARM_BOX_BOROUGH varchar(250),
	ALARM_BOX_NUMBER int,
	ALARM_BOX_LOCATION varchar(250),
	INCIDENT_BOROUGH varchar(250),
	ZIPCODE varchar(250),
	POLICEPRECINCT int,
	CITYCOUNCILDISTRICT int,
	COMMUNITYDISTRICT int,
	CONGRESSIONALDISTRICT int,
	ALARM_SOURCE_DESCRIPTION_TX varchar(250),
	ALARM_LEVEL_INDEX_DESCRIPTION varchar(250),
	HIGHEST_ALARM_LEVEL varchar(250),
	INCIDENT_CLASSIFICATION varchar(250),
	INCIDENT_CLASSIFICATION_GROUP varchar(250),
	DISPATCH_RESPONSE_SECONDS_QY int,
	FIRST_ASSIGNMENT_DATETIME datetime,
	FIRST_ACTIVATION_DATETIME datetime,
	FIRST_ON_SCENE_DATETIME datetime,
	INCIDENT_CLOSE_DATETIME datetime,
	VALID_DISPATCH_RSPNS_TIME_INDC varchar(250),
	VALID_INCIDENT_RSPNS_TIME_INDC varchar(250),
	INCIDENT_RESPONSE_SECONDS_QY int,
	INCIDENT_TRAVEL_TM_SECONDS_QY int,
	ENGINES_ASSIGNED_QUANTITY int,
	LADDERS_ASSIGNED_QUANTITY int,
	OTHER_UNITS_ASSIGNED_QUANTITY int
)

------------------------------------------------------------------------------
truncate table Fire_Incident_Dispatch_Data

select * from Fire_Incident_Dispatch_Data


------------------------------testing clusterd index on STARFIRE_INCIDENT_ID----------------------------------------

--looking for pk in order to create a clusterd index
select STARFIRE_INCIDENT_ID ,count(*)
from Fire_Incident_Dispatch_Data
group by STARFIRE_INCIDENT_ID
having count(*)>1

--Estimated Operator Cost 0.0032 after applying clusterd index
select * 
from Fire_Incident_Dispatch_Data 
where STARFIRE_INCIDENT_ID=2120803730111370

--using temp table to check cost without index
select * into temp
from Fire_Incident_Dispatch_Data

--Estimated Operator Cost 0.35, expensive then with index
select * 
from temp
where STARFIRE_INCIDENT_ID=2120803730111370



------------------------------testing Nonclusterd index on INCIDENT_DATETIME----------------------------------------

--Estimated Operator Cost 0.034
select year(INCIDENT_DATETIME), MONTH(INCIDENT_DATETIME), count(STARFIRE_INCIDENT_ID)
from Fire_Incident_Dispatch_Data
group by year(INCIDENT_DATETIME), MONTH(INCIDENT_DATETIME)

--using temp table to check cost without index
select * into temp2
from Fire_Incident_Dispatch_Data

--Estimated Operator Cost 0.33, expensive then with index
select year(INCIDENT_DATETIME), MONTH(INCIDENT_DATETIME), count(STARFIRE_INCIDENT_ID)
from temp2
group by year(INCIDENT_DATETIME), MONTH(INCIDENT_DATETIME)

--if I were to use a columnar db that uses partitiones
create table xyz()
partition by incident_datetime::datetime group by date_trunc('year', (incident_datetime)::date);


select * from DimDate
select * from dimdate join Fire_Incident_Dispatch_Data 
on DimDate.date=Fire_Incident_Dispatch_Data.INCIDENT_DATETIME



select * from [dbo].[Fire_Incident_Dispatch_Data] 
order by alarm_box_number

select alarm_box_number + ' ' + alarm_box_borough, alarm_box_location
from Fire_Incident_Dispatch_Data
where alarm_box_number=1071
order by alarm_box_borough

select distinct incident_borough
from Fire_Incident_Dispatch_Data

select distinct alarm_box_number + '-' + alarm_box_borough, alarm_box_location
from Fire_Incident_Dispatch_Data
where alarm_box_number=1071


with cte as(
select distinct alarm_box_number, alarm_box_borough, alarm_box_location
from Fire_Incident_Dispatch_Data
order by alarm_box_number)

select distinct alarm_level_index_description
from Fire_Incident_Dispatch_Data

select distinct alarm_source_description_tx
from Fire_Incident_Dispatch_Data

select distinct highest_alarm_level
from Fire_Incident_Dispatch_Data


select distinct alarm_level_index_description, highest_alarm_level
from Fire_Incident_Dispatch_Data


