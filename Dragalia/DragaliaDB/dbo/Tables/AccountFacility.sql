CREATE TABLE [dbo].[AccountFacility] (
	[AccountID] INT NOT NULL
	,[FacilityID] INT NOT NULL
	,[CopyNumber] INT NOT NULL
	,[CurrentLevel] INT NOT NULL CONSTRAINT [DF_Facility_CurrentLevel] DEFAULT(0)
	,[WantedLevel] INT NOT NULL CONSTRAINT [DF_Facility_WantedLevel] DEFAULT(0)
	,CONSTRAINT [PK_AccountFacility] PRIMARY KEY (
		[AccountID]
		,[FacilityID]
		,[CopyNumber]
		)
	,CONSTRAINT [FK_AccountFacility_Account] FOREIGN KEY ([AccountID]) REFERENCES [Account]([AccountID])
	,CONSTRAINT [FK_AccountFacility_Facility] FOREIGN KEY ([FacilityID]) REFERENCES [core].[Facility]([FacilityID])
	)
