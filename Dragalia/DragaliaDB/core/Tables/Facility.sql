CREATE TABLE [core].[Facility] (
	[FacilityID] INT NOT NULL
	,[Facility] NVARCHAR(50) NOT NULL
	,[Limit] INT NOT NULL
	,[CategoryID] INT NULL
	,[Active] BIT NOT NULL CONSTRAINT [DF_Facility_Active] DEFAULT(1)
	,CONSTRAINT [PK_Facility] PRIMARY KEY ([FacilityID])
	,CONSTRAINT [FK_Facility_Category] FOREIGN KEY ([CategoryID]) REFERENCES [core].[Category]([CategoryID]) ON DELETE SET NULL
	)
