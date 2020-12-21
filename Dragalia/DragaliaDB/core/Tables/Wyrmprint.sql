CREATE TABLE [core].[Wyrmprint] (
	[WyrmprintID] INT NOT NULL
	,[Wyrmprint] NVARCHAR(50) NOT NULL
	,[Rarity] INT NOT NULL
	,[AffinityGroupID] INT NULL
	,[WyrmprintUpgradeGroupID] INT NOT NULL
	,CONSTRAINT [PK_Wyrmprint] PRIMARY KEY ([WyrmprintID])
	)
