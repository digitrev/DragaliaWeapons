CREATE TABLE [core].[WyrmprintLevelLimit] (
	[WyrmprintRarity] INT NOT NULL
	,[UnbindLevel] INT NOT NULL
	,[MaxWyrmprintLevel] INT NOT NULL
	,CONSTRAINT [PK_WyrmprintLevelLimit] PRIMARY KEY (
		[WyrmprintRarity]
		,[UnbindLevel]
		)
	)
