CREATE TABLE [core].[WyrmprintLevelLimit] (
	[WyrmprintRarity] INT NOT NULL
	,[UnbindLevel] INT NOT NULL
	,[MaxWyrmprintLevel] INT NOT NULL
	,[Active] BIT NOT NULL CONSTRAINT [DF_WyrmprintLevelLimit_Active] DEFAULT(1)
	,CONSTRAINT [PK_WyrmprintLevelLimit] PRIMARY KEY (
		[WyrmprintRarity]
		,[UnbindLevel]
		)
	)
