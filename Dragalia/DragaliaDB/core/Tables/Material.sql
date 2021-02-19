CREATE TABLE [core].[Material] (
	[MaterialID] NVARCHAR(50) NOT NULL
	,[Material] NVARCHAR(50) NOT NULL
	,[Active] BIT NOT NULL CONSTRAINT [DF_Material_Active] DEFAULT(1)
	,CONSTRAINT [PK_Material] PRIMARY KEY ([MaterialID])
	)
