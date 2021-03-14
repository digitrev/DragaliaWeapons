CREATE TABLE [den].[QuestHierarchy] (
	[QuestHierachyID] INT NOT NULL IDENTITY
	,[ItemLevel] INT NOT NULL
	,[Quest] NVARCHAR(50) NOT NULL
	,[SortPath] HIERARCHYID NULL
	)
