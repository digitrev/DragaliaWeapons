CREATE TABLE [dbo].[WeaponUpgrade] (
	[WeaponID] INT NOT NULL
	,[UpgradeTypeID] INT NOT NULL
	,[Step] INT NOT NULL
	,[MaterialID] NVARCHAR(50) NOT NULL
	,[Quantity] INT NOT NULL
	,CONSTRAINT [PK_WeaponUpgrade] PRIMARY KEY (
		[WeaponID]
		,[UpgradeTypeID]
		,[Step]
		,[MaterialID]
		)
	,CONSTRAINT [FK_WeaponUpgrade_Weapon] FOREIGN KEY ([WeaponID]) REFERENCES [Weapon]([WeaponID])
	,CONSTRAINT [FK_WeaponUpgrade_UpgradeType] FOREIGN KEY ([UpgradeTypeID]) REFERENCES [UpgradeType]([UpgradeTypeID])
	,CONSTRAINT [FK_WeaponUpgrade_Material] FOREIGN KEY ([MaterialID]) REFERENCES [Material]([MaterialID])
	)
