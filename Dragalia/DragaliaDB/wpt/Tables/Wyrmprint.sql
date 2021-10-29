CREATE TABLE [wpt].[Wyrmprint] (
	[WyrmprintID] INT NOT NULL
	,[Wyrmprint] NVARCHAR(50) NOT NULL
	,[Rarity] INT NOT NULL
	,[RarityGroup] INT NOT NULL
	,[AffinityID] INT NULL
	,[Active] BIT NOT NULL CONSTRAINT [DF_Wyrmprint_Active] DEFAULT(1)
	,CONSTRAINT [PK_Wyrmprint] PRIMARY KEY ([WyrmprintID])
	,CONSTRAINT [FK_Wyrmprint_Affinity] FOREIGN KEY ([AffinityID]) REFERENCES [core].[Affinity]([AffinityID]) ON DELETE CASCADE
	)
GO
