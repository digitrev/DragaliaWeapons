﻿CREATE TABLE [wpt].[WyrmprintUpgrade] (
	[WyrmprintID] INT NOT NULL
	,[UpgradeTypeID] INT NOT NULL
	,[Step] INT NOT NULL
	,[MaterialID] NVARCHAR(50) NOT NULL
	,[Quantity] INT NOT NULL
	,CONSTRAINT [PK_WyrmprintUpgrade] PRIMARY KEY (
		[WyrmprintID]
		,[UpgradeTypeID]
		,[Step]
		,[MaterialID]
		)
	,CONSTRAINT [FK_WyrmprintUpgrade_Wyrmprint] FOREIGN KEY ([WyrmprintID]) REFERENCES [wpt].[Wyrmprint]([WyrmprintID]) ON DELETE CASCADE
	,CONSTRAINT [FK_WyrmprintUpgrade_UpgradeType] FOREIGN KEY ([UpgradeTypeID]) REFERENCES [core].[UpgradeType]([UpgradeTypeID]) ON DELETE CASCADE
	,CONSTRAINT [FK_WyrmprintUpgrade_Material] FOREIGN KEY ([MaterialID]) REFERENCES [core].[Material]([MaterialID]) ON DELETE CASCADE
	)
