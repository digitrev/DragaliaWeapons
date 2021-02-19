CREATE TABLE [core].[WyrmprintAbility] (
	[WyrmprintID] INT NOT NULL
	,[AbilityID] INT NOT NULL
	,[AbilitySlot] INT NOT NULL
	,[AbilityLevel] INT NOT NULL
	,[Active] BIT NOT NULL CONSTRAINT [DF_WyrmprintAbility_Active] DEFAULT(1)
	,CONSTRAINT [PK_WyrmprintAbility] PRIMARY KEY (
		[WyrmprintID]
		,[AbilityLevel]
		,[AbilityID]
		,[AbilitySlot]
		)
	,CONSTRAINT [FK_WyrmprintAbility_Wyrmprint] FOREIGN KEY ([WyrmprintID]) REFERENCES [core].[Wyrmprint]([WyrmprintID]) ON DELETE CASCADE
	,CONSTRAINT [FK_WyrmprintAbility_Ability] FOREIGN KEY ([AbilityID]) REFERENCES [core].[Ability]([AbilityID]) ON DELETE CASCADE
	)
