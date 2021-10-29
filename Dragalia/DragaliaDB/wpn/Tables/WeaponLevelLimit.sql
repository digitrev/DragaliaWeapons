CREATE TABLE [wpn].[WeaponLevelLimit] (
	[WeaponRarity] INT NOT NULL
	,[UnbindLevel] INT NOT NULL
	,[MaxWeaponLevel] INT NOT NULL
	,CONSTRAINT [PK_WeaponLevelLimit] PRIMARY KEY (
		[WeaponRarity]
		,[UnbindLevel]
		)
	)
