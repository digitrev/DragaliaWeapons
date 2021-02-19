CREATE TABLE [core].[WeaponUpgrade] (
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
	,CONSTRAINT [FK_WeaponUpgrade_Weapon] FOREIGN KEY ([WeaponID]) REFERENCES [core].[Weapon]([WeaponID]) ON DELETE CASCADE
	,CONSTRAINT [FK_WeaponUpgrade_UpgradeType] FOREIGN KEY ([UpgradeTypeID]) REFERENCES [core].[UpgradeType]([UpgradeTypeID]) ON DELETE CASCADE
	,CONSTRAINT [FK_WeaponUpgrade_Material] FOREIGN KEY ([MaterialID]) REFERENCES [core].[Material]([MaterialID]) ON DELETE CASCADE
	)
