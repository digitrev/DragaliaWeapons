CREATE TABLE [cht].[Chest] (
	[ChestID] INT NOT NULL IDENTITY
	,[ChestGroupID] INT NOT NULL
	,[QuestID] INT NOT NULL
	,CONSTRAINT [PK_Chest] PRIMARY KEY ([ChestID])
	,CONSTRAINT [FK_Chest_ChestGroup] FOREIGN KEY ([ChestGroupID]) REFERENCES [cht].[ChestGroup]([ChestGroupID]) ON DELETE CASCADE
	,CONSTRAINT [FK_Chest_Quest] FOREIGN KEY ([QuestID]) REFERENCES [core].[Quest]([QuestID]) ON DELETE CASCADE
	,CONSTRAINT [AK_Chest_ChestGroup_Quest] UNIQUE (
		[ChestGroupID]
		,[QuestID]
		)
	)
