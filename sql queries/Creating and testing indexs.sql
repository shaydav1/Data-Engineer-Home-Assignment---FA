--cloning tables before indexing and partitioning 

SELECT *
INTO [dbo].[Dim_Alarm_box_clone]
FROM [Dim_Alarm_box];

SELECT *
INTO [dbo].[Dim_Alarm_level_index_clone]
FROM [Dim_Alarm_level_index];

SELECT *
INTO [dbo].[Dim_Date_clone]
FROM [Dim_Date];

SELECT *
INTO [dbo].[Dim_Highest_alarm_level_clone]
FROM [Dim_Highest_alarm_level];

SELECT *
INTO [dbo].[Dim_Incident_borough_clone]
FROM [Dim_Incident_borough];

SELECT *
INTO [dbo].[Dim_Incident_classification_clone]
FROM [Dim_Incident_classification];

SELECT *
INTO [dbo].[Fact_incidents_clone]
FROM [Fact_incidents];

--if I were to use a columnar db that uses partitiones
create table [dbo].[Fact_incidents]...
partition by year(incident_date), month(incident_date), day(incident_date)


------------------------------------------------------------indexing------------------------------------------------------------

--Dim_Alarm_box
USE [FireArc]
GO


CREATE UNIQUE NONCLUSTERED INDEX [NonClusteredIndex-alarm_box_number+alarm_box_borough] ON [dbo].[Dim_Alarm_box]
(
	[alarm_box_key] ASC
)
INCLUDE([alarm_box_number],[alarm_box_borough]) ON [PRIMARY]
GO

--Dim_Alarm_level_index
USE [FireArc]
GO

CREATE UNIQUE NONCLUSTERED INDEX [NonClusteredIndex-alarm_level_index_description] ON [dbo].[Dim_Alarm_level_index]
(
	[alarm_level_index_description_key] ASC
)
INCLUDE([alarm_level_index_description]) ON [PRIMARY] 
GO

--Dim_Date
USE [FireArc]
GO

CREATE UNIQUE NONCLUSTERED INDEX [NonClusteredIndex-Date] ON [dbo].[Dim_Date]
(
	[DateKey] ASC
)
INCLUDE([Date]) ON [PRIMARY]
GO

--Dim_Highest_alarm_level
USE [FireArc]
GO

CREATE UNIQUE NONCLUSTERED INDEX [NonClusteredIndex-highest_alarm_level] ON [dbo].[Dim_Highest_alarm_level]
(
	[Highest_alarm_level_key] ASC
)
INCLUDE([highest_alarm_level]) ON [PRIMARY]
GO

--Dim_Incident_borough
USE [FireArc]
GO

CREATE UNIQUE NONCLUSTERED INDEX [NonClusteredIndex-incident_borough] ON [dbo].[Dim_Incident_borough]
(
	[incident_borough_key] ASC
)
INCLUDE([incident_borough]) ON [PRIMARY]
GO

--Dim_Incident_classification
USE [FireArc]
GO

CREATE UNIQUE NONCLUSTERED INDEX [NonClusteredIndex-incident_classification] ON [dbo].[Dim_Incident_classification]
(
	[incident_classification_key] ASC
)
INCLUDE([incident_classification]) ON [PRIMARY]
GO

--Fact_incidents
USE [FireArc]
GO

CREATE NONCLUSTERED INDEX [NonClusteredIndex-incident_datetime] ON [dbo].[Fact_incidents]
(
	[fact_incident_Key] ASC
)
INCLUDE([incident_date],[incident_time]) ON [PRIMARY]
GO

------------------------------demonstrate the effectiveness of indexes----------------------------------------

--Estimated Operator Cost 0.031 for scaning dim_date with index
select fact.*, ddate.Date
from Fact_incidents fact left join Dim_Date ddate on fact.date_key=ddate.DateKey 

--Estimated Operator Cost 0.166 for scaning dim_date without index
select fact.*, ddate.Date
from Fact_incidents_clone fact left join Dim_Date_clone ddate on fact.date_key=ddate.DateKey 

------------------------------------

--Estimated Operator Cost 0.026 for scaning Dim_Alarm_box with index
select box.alarm_box_borough ,sum(incident_response_seconds_qy) as sum_incident_response_seconds_qy
from Fact_incidents fact left join Dim_Alarm_box box on fact.alarm_box_key=box.alarm_box_key
group by alarm_box_borough
order by alarm_box_borough asc

--Estimated Operator Cost 0.044 for scaning dim_date without index
select box.alarm_box_borough ,sum(incident_response_seconds_qy) as sum_incident_response_seconds_qy
from Fact_incidents_clone fact left join Dim_Alarm_box_clone box on fact.alarm_box_key=box.alarm_box_key
group by alarm_box_borough
order by alarm_box_borough asc

------------------------------------

--Estimated Operator Cost 0.03 for scaning Dim_Alarm_box with index
select distinct MONTH(incident_date)
from Fact_incidents
where MONTH(incident_date)=07 and day(incident_date)=27
--Estimated Operator Cost 0.1 for scaning dim_date without index
select distinct MONTH(incident_date)
from Fact_incidents_clone
where MONTH(incident_date)=07 and day(incident_date)=27
