CREATE TABLE [dbo].[Passive] (
	[PassiveID] INT NOT NULL
	,[WeaponTypeID] INT NOT NULL
	,[ElementID] INT NOT NULL
	,[AbilityID] INT NOT NULL
	,[AbilityNumber] INT NOT NULL
	,CONSTRAINT [PK_Passive] PRIMARY KEY ([PassiveID])
	,CONSTRAINT [FK_Passive_WeaponType] FOREIGN KEY ([WeaponTypeID]) REFERENCES [WeaponType]([WeaponTypeID]) ON DELETE CASCADE
	,CONSTRAINT [FK_Passive_Element] FOREIGN KEY ([ElementID]) REFERENCES [Element]([ElementID]) ON DELETE CASCADE
	,CONSTRAINT [FK_Passive_Ability] FOREIGN KEY ([AbilityID]) REFERENCES [Ability]([AbilityID]) ON DELETE CASCADE
	)
