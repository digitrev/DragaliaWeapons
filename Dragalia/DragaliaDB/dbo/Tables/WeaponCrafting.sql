CREATE TABLE [dbo].[WeaponCrafting] (
    [WeaponID] INT      NOT NULL,
    [ItemID]   SMALLINT NOT NULL,
    [Quantity] INT      NOT NULL,
    CONSTRAINT [PK_WeaponCrafting] PRIMARY KEY CLUSTERED ([WeaponID] ASC, [ItemID] ASC),
    CONSTRAINT [FK_WeaponCrafting_Item] FOREIGN KEY ([ItemID]) REFERENCES [dbo].[Item] ([ItemID]),
    CONSTRAINT [FK_WeaponCrafting_Weapon] FOREIGN KEY ([WeaponID]) REFERENCES [dbo].[Weapon] ([WeaponID])
);

