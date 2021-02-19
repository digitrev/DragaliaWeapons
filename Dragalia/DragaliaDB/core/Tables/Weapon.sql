CREATE TABLE [core].[Weapon] (
	[WeaponID] INT NOT NULL
	,[Weapon] NVARCHAR(50) NOT NULL
	,[WeaponSeriesID] INT NOT NULL
	,[WeaponTypeID] INT NOT NULL
	,[Rarity] INT NOT NULL
	,[ElementID] INT NOT NULL
	,[Active] BIT NOT NULL CONSTRAINT [DF_Weapon_Active] DEFAULT(1)
	,CONSTRAINT [PK_Weapon] PRIMARY KEY ([WeaponID])
	,CONSTRAINT [FK_Weapon_WeaponSeries] FOREIGN KEY ([WeaponSeriesID]) REFERENCES [core].[WeaponSeries]([WeaponSeriesID]) ON DELETE CASCADE
	,CONSTRAINT [FK_Weapon_WeaponType] FOREIGN KEY ([WeaponTypeID]) REFERENCES [core].[WeaponType]([WeaponTypeID]) ON DELETE CASCADE
	,CONSTRAINT [FK_Weapon_Element] FOREIGN KEY ([ElementID]) REFERENCES [core].[Element]([ElementID]) ON DELETE CASCADE
	)
