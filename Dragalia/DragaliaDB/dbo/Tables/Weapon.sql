CREATE TABLE [dbo].[Weapon] (
	[WeaponID] INT NOT NULL
	,[WeaponName] NVARCHAR(50) NOT NULL
	,[WeaponSeriesID] INT NOT NULL
	,[WeaponTypeID] INT NOT NULL
	,[Rarity] INT NOT NULL
	,[ElementID] INT NOT NULL
	,CONSTRAINT [PK_Weapon] PRIMARY KEY ([WeaponID])
	,CONSTRAINT [FK_Weapon_WeaponSeries] FOREIGN KEY ([WeaponSeriesID]) REFERENCES [WeaponSeries]([WeaponSeriesID]) ON DELETE CASCADE
	,CONSTRAINT [FK_Weapon_WeaponType] FOREIGN KEY ([WeaponTypeID]) REFERENCES [WeaponType]([WeaponTypeID]) ON DELETE CASCADE
	)
