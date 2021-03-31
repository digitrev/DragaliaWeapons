CREATE TABLE [core].[MaterialQuest] (
	[MaterialID] NVARCHAR(50) NOT NULL
	,[QuestID] INT NOT NULL
	,CONSTRAINT [PK_MaterialQuest] PRIMARY KEY (
		[MaterialID]
		,[QuestID]
		)
	,CONSTRAINT [FK_MaterialQuest_Material] FOREIGN KEY ([MaterialID]) REFERENCES [core].[Material]([MaterialID])
	,CONSTRAINT [FK_MaterialQuest_Quest] FOREIGN KEY ([QuestID]) REFERENCES [core].[Quest]([QuestID])
	)
