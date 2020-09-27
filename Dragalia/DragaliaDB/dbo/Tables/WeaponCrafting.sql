CREATE TABLE [dbo].[WeaponCrafting] (
	[WeaponID] INT NOT NULL
	,[MaterialID] NVARCHAR(50) NOT NULL
	,[Quantity] INT NOT NULL
	,CONSTRAINT [PK_WeaponCrafting] PRIMARY KEY (
		[WeaponID]
		,[MaterialID]
		)
	,CONSTRAINT [FK_WeaponCrafting_Weapon] FOREIGN KEY ([WeaponID]) REFERENCES [Weapon]([WeaponID])
	,CONSTRAINT [FK_WeaponCrafting_Material] FOREIGN KEY ([MaterialID]) REFERENCES [Material]([MaterialID])
	)
