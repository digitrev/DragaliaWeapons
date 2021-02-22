CREATE TABLE [core].[Passive] (
	[PassiveID] INT NOT NULL
	,[WeaponTypeID] INT NOT NULL
	,[ElementID] INT NOT NULL
	,[AbilityID] INT NOT NULL
	,[AbilityNumber] INT NOT NULL
	,[SortOrder] INT NOT NULL
	,[Active] BIT NOT NULL CONSTRAINT [DF_Passive_Active] DEFAULT(1)
	,CONSTRAINT [PK_Passive] PRIMARY KEY ([PassiveID])
	,CONSTRAINT [FK_Passive_WeaponType] FOREIGN KEY ([WeaponTypeID]) REFERENCES [core].[WeaponType]([WeaponTypeID]) ON DELETE CASCADE
	,CONSTRAINT [FK_Passive_Element] FOREIGN KEY ([ElementID]) REFERENCES [core].[Element]([ElementID]) ON DELETE CASCADE
	,CONSTRAINT [FK_Passive_Ability] FOREIGN KEY ([AbilityID]) REFERENCES [core].[Ability]([AbilityID]) ON DELETE CASCADE
	)
