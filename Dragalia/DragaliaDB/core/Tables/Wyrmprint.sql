CREATE TABLE [core].[Wyrmprint] (
	[WyrmprintID] INT NOT NULL
	,[Wyrmprint] NVARCHAR(50) NOT NULL
	,[Rarity] INT NOT NULL
	,[AffinityID] INT NULL
	,CONSTRAINT [PK_Wyrmprint] PRIMARY KEY ([WyrmprintID])
	,CONSTRAINT [FK_Wyrmprint_Affinity] FOREIGN KEY ([AffinityID]) REFERENCES [core].[Affinity]([AffinityID]) ON DELETE CASCADE
	)
