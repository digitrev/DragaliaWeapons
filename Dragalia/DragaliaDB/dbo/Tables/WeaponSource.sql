CREATE TABLE [dbo].[WeaponSource] (
    [WeaponSourceID] TINYINT       IDENTITY (1, 1) NOT NULL,
    [WeaponSource]   NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_WeaponSource] PRIMARY KEY CLUSTERED ([WeaponSourceID] ASC)
);

