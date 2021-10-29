CREATE TABLE [wpn].[WeaponCrafting] (
	[WeaponID] INT NOT NULL
	,[MaterialID] NVARCHAR(50) NOT NULL
	,[Quantity] INT NOT NULL
	,CONSTRAINT [PK_WeaponCrafting] PRIMARY KEY (
		[WeaponID]
		,[MaterialID]
		)
	,CONSTRAINT [FK_WeaponCrafting_Weapon] FOREIGN KEY ([WeaponID]) REFERENCES [wpn].[Weapon]([WeaponID]) ON DELETE CASCADE
	,CONSTRAINT [FK_WeaponCrafting_Material] FOREIGN KEY ([MaterialID]) REFERENCES [core].[Material]([MaterialID]) ON DELETE CASCADE
	)
