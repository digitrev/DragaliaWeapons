CREATE TABLE [wpn].[WeaponUnbindLimit] (
	[WeaponRarity] INT NOT NULL
	,[RefinementLevel] INT NOT NULL
	,[MaxUnbindLevel] INT NOT NULL
	,CONSTRAINT [PK_WeaponUnbindLimit] PRIMARY KEY (
		[WeaponRarity]
		,[RefinementLevel]
		)
	)
