CREATE TABLE [core].[Facility] (
	[FacilityID] INT NOT NULL
	,[Facility] NVARCHAR(50) NOT NULL
	,[Limit] INT NOT NULL
	,CONSTRAINT [PK_Facility] PRIMARY KEY ([FacilityID])
	)
