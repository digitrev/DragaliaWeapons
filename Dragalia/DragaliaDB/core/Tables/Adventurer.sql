CREATE TABLE [core].[Adventurer] (
	[AdventurerID] INT NOT NULL
	,[Adventurer] NVARCHAR(50) NOT NULL
	,[Rarity] INT NOT NULL
	,[ElementID] INT NOT NULL
	,[WeaponTypeID] INT NOT NULL
	,[MCLimit] INT NOT NULL
	,[Active] BIT NOT NULL CONSTRAINT [DF_Adventurer_Active] DEFAULT(1)
	,CONSTRAINT [PK_Adventurer] PRIMARY KEY ([AdventurerID])
	,CONSTRAINT [FK_Adventurer_Element] FOREIGN KEY ([ElementID]) REFERENCES [core].[Element]([ElementID])
	,CONSTRAINT [FK_Adventurer_WeaponType] FOREIGN KEY ([WeaponTypeID]) REFERENCES [core].[WeaponType]([WeaponTypeID])
	)
