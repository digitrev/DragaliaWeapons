CREATE TABLE [core].[Element] (
	[ElementID] INT NOT NULL
	,[Element] NVARCHAR(50) NULL
	,[SortOrder] INT NOT NULL
	,[Active] BIT NOT NULL CONSTRAINT [DF_Element_Active] DEFAULT(1)
	,CONSTRAINT [PK_Element] PRIMARY KEY ([ElementID])
	)
