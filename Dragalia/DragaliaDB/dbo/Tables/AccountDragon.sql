CREATE TABLE [dbo].[AccountDragon] (
	[AccountID] INT NOT NULL
	,[DragonID] INT NOT NULL
	,[Unbind] INT NOT NULL CONSTRAINT [DF_AccountDragon_CurrentLevel] DEFAULT(0)
	,[UnbindWanted] INT NOT NULL CONSTRAINT [DF_AccountDragon_WantedLevel] DEFAULT(0)
	,CONSTRAINT [PK_AccountDragon] PRIMARY KEY (
		[AccountID]
		,[DragonID]
		)
	,CONSTRAINT [FK_AccountDragon_Account] FOREIGN KEY ([AccountID]) REFERENCES [Account]([AccountID])
	,CONSTRAINT [FK_AccountDragon_Dragon] FOREIGN KEY ([DragonID]) REFERENCES [core].[Dragon]([DragonID])
	)
GO
