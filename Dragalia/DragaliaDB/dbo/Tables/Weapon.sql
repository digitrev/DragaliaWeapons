CREATE TABLE [dbo].[Weapon] (
    [WeaponID]       INT           NOT NULL,
    [ParentWeaponID] INT           NULL,
    [WeaponName]     NVARCHAR (50) NOT NULL,
    [WeaponTypeID]   TINYINT       NOT NULL,
    [Rarity]         INT           NOT NULL,
    [ElementID]      TINYINT       NOT NULL,
    [WeaponSourceID] TINYINT       NOT NULL,
    CONSTRAINT [PK_Weapon] PRIMARY KEY CLUSTERED ([WeaponID] ASC),
    CONSTRAINT [FK_Weapon_Element] FOREIGN KEY ([ElementID]) REFERENCES [dbo].[Element] ([ElementID]),
    CONSTRAINT [FK_Weapon_Weapon] FOREIGN KEY ([ParentWeaponID]) REFERENCES [dbo].[Weapon] ([WeaponID]),
    CONSTRAINT [FK_Weapon_WeaponSource] FOREIGN KEY ([WeaponSourceID]) REFERENCES [dbo].[WeaponSource] ([WeaponSourceID]),
    CONSTRAINT [FK_Weapon_WeaponType] FOREIGN KEY ([WeaponTypeID]) REFERENCES [dbo].[WeaponType] ([WeaponTypeID])
);

