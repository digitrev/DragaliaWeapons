CREATE TABLE [adv].[ManaCircle] (
	[AdventurerID] INT NOT NULL
	,[ManaNode] INT NOT NULL
	,[MaterialID] NVARCHAR(50) NOT NULL
	,[Quantity] INT NOT NULL
	,CONSTRAINT [PK_ManaCircle] PRIMARY KEY (
		[AdventurerID]
		,[ManaNode]
		,[MaterialID]
		)
	,CONSTRAINT [FK_ManaCircle_Adventurer] FOREIGN KEY ([AdventurerID]) REFERENCES [adv].[Adventurer]([AdventurerID])
	,CONSTRAINT [FK_ManaCircle_Material] FOREIGN KEY ([MaterialID]) REFERENCES [core].[Material]([MaterialID])
	)
