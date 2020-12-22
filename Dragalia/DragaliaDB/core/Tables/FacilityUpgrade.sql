CREATE TABLE [core].[FacilityUpgrade] (
	[FacilityID] INT NOT NULL
	,[MaterialID] NVARCHAR(50) NOT NULL
	,[FacilityLevel] TINYINT NOT NULL
	,[Quantity] INT NOT NULL
	,CONSTRAINT [PK_FacilityUpgrade] PRIMARY KEY (
		[FacilityID]
		,[MaterialID]
		,[FacilityLevel]
		)
	,CONSTRAINT [FK_FacilityUpgrade_Facility] FOREIGN KEY ([FacilityID]) REFERENCES [core].[Facility]([FacilityID]) ON DELETE CASCADE
	,CONSTRAINT [FK_FacilityUpgrade_Material] FOREIGN KEY ([MaterialID]) REFERENCES [core].[Material]([MaterialID]) ON DELETE CASCADE
	)
