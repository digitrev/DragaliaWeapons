CREATE TABLE [dbo].[AccountAdventurer] (
	[AccountID] INT NOT NULL
	,[AdventurerID] INT NOT NULL
	,[CurrentLevel] INT NOT NULL CONSTRAINT [DF_AccountAdventurer_CurrentLevel] DEFAULT(0)
	,[WantedLevel] INT NOT NULL CONSTRAINT [DF_AccountAdventurer_WantedLevel] DEFAULT(0)
	,CONSTRAINT [PK_AccountAdventurer] PRIMARY KEY (
		[AccountID]
		,[AdventurerID]
		)
	,CONSTRAINT [FK_AccountAdventurer_Account] FOREIGN KEY ([AccountID]) REFERENCES [Account]([AccountID])
	,CONSTRAINT [FK_AccountAdventurer_Adventurer] FOREIGN KEY ([AdventurerID]) REFERENCES [core].[Adventurer]([AdventurerID])
	)
GO
