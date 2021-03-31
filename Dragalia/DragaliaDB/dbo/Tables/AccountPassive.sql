CREATE TABLE [dbo].[AccountPassive] (
	[AccountID] INT NOT NULL
	,[PassiveID] INT NOT NULL
	,[Owned] BIT NOT NULL CONSTRAINT [DF_Passive_Owned] DEFAULT(0)
	,[Wanted] BIT NOT NULL CONSTRAINT [DF_Passive_Wanted] DEFAULT(0)
	,CONSTRAINT [PK_AccountPassive] PRIMARY KEY (
		[AccountID]
		,[PassiveID]
		)
	,CONSTRAINT [FK_AccountPassive_Account] FOREIGN KEY ([AccountID]) REFERENCES [Account]([AccountID])
	,CONSTRAINT [FK_AccountPassive_Passive] FOREIGN KEY ([PassiveID]) REFERENCES [core].[Passive]([PassiveID])
	)

GO
