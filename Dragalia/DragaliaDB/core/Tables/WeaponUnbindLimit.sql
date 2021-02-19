CREATE TABLE [core].[WeaponUnbindLimit] (
	[WeaponRarity] INT NOT NULL
	,[RefinementLevel] INT NOT NULL
	,[MaxUnbindLevel] INT NOT NULL
	,[Active] BIT NOT NULL CONSTRAINT [DF_WeaponUnbindLimit_Active] DEFAULT(1)
	,CONSTRAINT [PK_WeaponUnbindLimit] PRIMARY KEY (
		[WeaponRarity]
		,[RefinementLevel]
		)
	)
