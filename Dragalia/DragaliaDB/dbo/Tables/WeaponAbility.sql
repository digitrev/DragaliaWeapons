CREATE TABLE [dbo].[WeaponAbility] (
    [WeaponID]  INT NOT NULL,
    [AbilityID] INT NOT NULL,
    CONSTRAINT [PK_WeaponAbility] PRIMARY KEY CLUSTERED ([WeaponID] ASC, [AbilityID] ASC),
    CONSTRAINT [FK_WeaponAbility_Ability] FOREIGN KEY ([AbilityID]) REFERENCES [dbo].[Ability] ([AbilityID]),
    CONSTRAINT [FK_WeaponAbility_Weapon] FOREIGN KEY ([WeaponID]) REFERENCES [dbo].[Weapon] ([WeaponID])
);

