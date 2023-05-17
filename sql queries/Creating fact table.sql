select starfire_incident_id,
	   cast(incident_datetime as date) as incident_date,
	   cast(incident_datetime as time) as incident_time,
	   dispatch_response_seconds_qy,
	   incident_response_seconds_qy,
	   incident_travel_tm_seconds_qy,
	   engines_assigned_quantity,
	   other_units_assigned_quantity,
	   b.DateKey as date_key,
	   c.alarm_box_key as alarm_box_key,
	   d.alarm_level_index_description_key as alarm_level_index_description_key,
	   e.Highest_alarm_level_key as Highest_alarm_level_key,
	   f.incident_borough_key as incident_borough_key,
	   g.incident_classification_key as incident_classification_key
from Fire_Incident_Dispatch_Data a 
     join Dim_Date b on cast(a.incident_datetime as date) = cast(b.Date as date)
	 join Dim_Alarm_box c on a.alarm_box_number + '' + a.alarm_box_borough + '' + a.alarm_box_location = c.alarm_box_number + '' + c.alarm_box_borough + '' + c.alarm_box_location
	 join Dim_Alarm_level_index d on a.alarm_level_index_description = d.alarm_level_index_description
	 join Dim_Highest_alarm_level e on a.highest_alarm_level = e.highest_alarm_level
	 join Dim_Incident_borough f on a.incident_borough = f.incident_borough
	 join Dim_Incident_classification g on a.incident_classification + '' + a.incident_classification_group = g.incident_classification + '' + g.incident_classification_group

select date from Dim_Date

select Highest_alarm_level_key,
	  highest_alarm_level
from Dim_Highest_alarm_level