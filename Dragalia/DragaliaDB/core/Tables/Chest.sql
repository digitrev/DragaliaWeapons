CREATE TABLE [core].[Chest] (
	[ChestID] INT NOT NULL IDENTITY
	,[ChestGroupID] INT NOT NULL
	,[QuestID] INT NOT NULL
	,CONSTRAINT [PK_Chest] PRIMARY KEY ([ChestID])
	,CONSTRAINT [FK_Chest_ChestGroup] FOREIGN KEY ([ChestGroupID]) REFERENCES [core].[ChestGroup]([ChestGroupID])
	,CONSTRAINT [FK_Chest_Quest] FOREIGN KEY ([QuestID]) REFERENCES [core].[Quest]([QuestID])
	,CONSTRAINT [AK_Chest_ChestGroup_Quest] UNIQUE (
		[ChestGroupID]
		,[QuestID]
		)
	)
