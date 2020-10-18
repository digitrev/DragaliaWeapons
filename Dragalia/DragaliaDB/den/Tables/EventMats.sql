CREATE TABLE [den].[EventMats] (
	[Facility] NVARCHAR(50) NOT NULL
	,[BronzeMat] NVARCHAR(50) NOT NULL
	,[MaxLevel] INT NOT NULL
	,CONSTRAINT [PK_EventMats] PRIMARY KEY ([Facility])
	)
