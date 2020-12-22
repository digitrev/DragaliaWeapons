CREATE TABLE [dbo].[Wyrmprint] (
	[AccountID] INT NOT NULL
	,[WyrmprintID] INT NOT NULL
	,[WyrmprintLevel] INT NOT NULL CONSTRAINT [DF_Wyrmprint_WyrmprintLevel] DEFAULT(0)
	,[WyrmprintLevelWanted] INT NOT NULL CONSTRAINT [DF_Wyrmprint_WyrmprintLevelWanted] DEFAULT(0)
	,[Unbind] INT NOT NULL CONSTRAINT [DF_Wyrmprint_Unbind] DEFAULT(0)
	,[UnbindWanted] INT NOT NULL CONSTRAINT [DF_Wyrmprint_UnbindWanted] DEFAULT(0)
	,[Copies] INT NOT NULL CONSTRAINT [DF_Wyrmprint_Copies] DEFAULT(0)
	,[CopiesWanted] INT NOT NULL CONSTRAINT [DF_Wyrmprint_CopiesWanted] DEFAULT(0)
	,CONSTRAINT [PK_Wyrmprint] PRIMARY KEY (
		[AccountID]
		,[WyrmprintID]
		)
	,CONSTRAINT [FK_Wyrmprint_Account] FOREIGN KEY ([AccountID]) REFERENCES [Account]([AccountID])
	,CONSTRAINT [FK_Wyrmprint_Wyrmprint] FOREIGN KEY ([WyrmprintID]) REFERENCES [core].[Wyrmprint]([WyrmprintID])
	)
