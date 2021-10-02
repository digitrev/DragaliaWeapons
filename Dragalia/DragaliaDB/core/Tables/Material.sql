CREATE TABLE [core].[Material] (
	[MaterialID] NVARCHAR(50) NOT NULL
	,[Material] NVARCHAR(50) NOT NULL
	,[CategoryID] INT NULL
	,[Active] BIT NOT NULL CONSTRAINT [DF_Material_Active] DEFAULT(1)
	,[SortPath] HIERARCHYID NOT NULL CONSTRAINT [DF_Material_SortPath] DEFAULT(HIERARCHYID::GetRoot())
	,CONSTRAINT [PK_Material] PRIMARY KEY ([MaterialID])
	,CONSTRAINT [FK_Material_Category] FOREIGN KEY ([CategoryID]) REFERENCES [core].[Category]([CategoryID]) ON DELETE SET NULL
	)
GO
