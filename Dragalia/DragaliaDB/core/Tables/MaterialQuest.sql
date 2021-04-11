CREATE TABLE [core].[MaterialQuest] (
	[MaterialID] NVARCHAR(50) NOT NULL
	,[QuestID] INT NOT NULL
	,[MinDrops] INT NOT NULL CONSTRAINT DF_MaterialQuest_MinDrops DEFAULT(1)
	,[MaxDrops] INT NOT NULL CONSTRAINT DF_MaterialQuest_MaxDrops DEFAULT(1)
	,CONSTRAINT [PK_MaterialQuest] PRIMARY KEY (
		[MaterialID]
		,[QuestID]
		)
	,CONSTRAINT [FK_MaterialQuest_Material] FOREIGN KEY ([MaterialID]) REFERENCES [core].[Material]([MaterialID])
	,CONSTRAINT [FK_MaterialQuest_Quest] FOREIGN KEY ([QuestID]) REFERENCES [core].[Quest]([QuestID])
	)
