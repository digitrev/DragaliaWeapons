CREATE TABLE [core].[WeaponLevelLimit] (
	[WeaponRarity] INT NOT NULL
	,[UnbindLevel] INT NOT NULL
	,[MaxWeaponLevel] INT NOT NULL
	,[Active] BIT NOT NULL CONSTRAINT [DF_WeaponLevelLimit_Active] DEFAULT(1)
	,CONSTRAINT [PK_WeaponLevelLimit] PRIMARY KEY (
		[WeaponRarity]
		,[UnbindLevel]
		)
	)
