CREATE TABLE [dbo].[AccountPassive] (
	[AccountID] INT NOT NULL
	,[PassiveID] INT NOT NULL
	,[Owned] BIT NOT NULL CONSTRAINT [DF_Passive_Owned] DEFAULT(0)
	,[Wanted] BIT NOT NULL CONSTRAINT [DF_Passive_Wanted] DEFAULT(0)
	,CONSTRAINT [PK_Passive] PRIMARY KEY (
		[AccountID]
		,[PassiveID]
		)
	,CONSTRAINT [FK_Passive_Account] FOREIGN KEY ([AccountID]) REFERENCES [Account]([AccountID])
	,CONSTRAINT [FK_Passive_Passive] FOREIGN KEY ([PassiveID]) REFERENCES [core].[Passive]([PassiveID])
	)
