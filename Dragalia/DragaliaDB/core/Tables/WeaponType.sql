CREATE TABLE [core].[WeaponType] (
	[WeaponTypeID] INT NOT NULL
	,[WeaponType] NVARCHAR(50) NOT NULL
	,[Active] BIT NOT NULL CONSTRAINT [DF_WeaponType_Active] DEFAULT(1)
	,CONSTRAINT [PK_WeaponType] PRIMARY KEY ([WeaponTypeID])
	)
