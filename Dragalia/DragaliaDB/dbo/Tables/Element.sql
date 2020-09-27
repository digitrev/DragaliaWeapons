CREATE TABLE [dbo].[Element] (
	[ElementID] INT NOT NULL
	,[Element] NVARCHAR(50) NULL
	,[SortOrder] INT NOT NULL , 
    CONSTRAINT [PK_Element] PRIMARY KEY ([ElementID])
	)
