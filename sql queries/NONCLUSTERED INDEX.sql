USE [FireArc]
GO

/****** Object:  Index [incident_datetime]    Script Date: 16/05/2023 13:13:23 ******/
CREATE NONCLUSTERED INDEX [incident_datetime] ON [dbo].[Fire_Incident_Dispatch_Data]
(
	[incident_datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO


