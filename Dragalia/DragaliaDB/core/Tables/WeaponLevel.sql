CREATE TABLE [core].[WeaponLevel] (
	[Rarity] INT NOT NULL
	,[WeaponLevel] INT NOT NULL
	,[MaterialID] NVARCHAR(50) NOT NULL
	,[Quantity] INT NOT NULL
	,[Active] BIT NOT NULL CONSTRAINT [DF_WeaponLevel_Active] DEFAULT(1)
	,CONSTRAINT [PK_WeaponLevel] PRIMARY KEY (
		[Rarity]
		,[WeaponLevel]
		,[MaterialID]
		)
	,CONSTRAINT [FK_WeaponLevel_Material] FOREIGN KEY ([MaterialID]) REFERENCES [core].[Material]([MaterialID]) ON DELETE CASCADE
	)
