CREATE TABLE [core].[WyrmprintLevel] (
	[Rarity] INT NOT NULL
	,[WyrmprintLevel] INT NOT NULL
	,[MaterialID] NVARCHAR(50) NOT NULL
	,[Quantity] INT NOT NULL
	,[Active] BIT NOT NULL CONSTRAINT [DF_WyrmprintLevel_Active] DEFAULT(1)
	,CONSTRAINT [PK_WyrmprintLevel] PRIMARY KEY (
		[Rarity]
		,[WyrmprintLevel]
		,[MaterialID]
		)
	,CONSTRAINT [FK_WyrmprintLevel_Material] FOREIGN KEY ([MaterialID]) REFERENCES [core].[Material]([MaterialID]) ON DELETE CASCADE
	)
