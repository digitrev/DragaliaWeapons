CREATE TABLE [wpt].[WyrmprintLevel] (
	[WyrmprintID] INT NOT NULL
	,[WyrmprintLevel] INT NOT NULL
	,[MaterialID] NVARCHAR(50) NOT NULL
	,[Quantity] INT NOT NULL
	,CONSTRAINT [PK_WyrmprintLevel] PRIMARY KEY (
		[WyrmprintID]
		,[WyrmprintLevel]
		,[MaterialID]
		)
	,CONSTRAINT [FK_WyrmprintLevel_Wyrmprint] FOREIGN KEY ([WyrmprintID]) REFERENCES [wpt].[Wyrmprint]([WyrmprintID]) ON DELETE CASCADE
	,CONSTRAINT [FK_WyrmprintLevel_Material] FOREIGN KEY ([MaterialID]) REFERENCES [core].[Material]([MaterialID]) ON DELETE CASCADE
	)
