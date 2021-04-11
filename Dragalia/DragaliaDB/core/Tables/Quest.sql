CREATE TABLE [core].[Quest] (
	[QuestID] INT NOT NULL IDENTITY
	,[Quest] NVARCHAR(50) NOT NULL
	,[Stamina] INT NULL 
	,[Getherwing] INT NULL 
	,[SortPath] HIERARCHYID NOT NULL
	,CONSTRAINT [PK_Quest] PRIMARY KEY ([QuestID])
	)
