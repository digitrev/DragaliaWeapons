CREATE TABLE [core].[UpgradeType] (
	[UpgradeTypeID] INT NOT NULL
	,[UpgradeType] NVARCHAR(50) NOT NULL
	,[Active] BIT NOT NULL CONSTRAINT [DF_UpgradeType_Active] DEFAULT(1)
	,CONSTRAINT [PK_UpgradeType] PRIMARY KEY ([UpgradeTypeID])
	)
