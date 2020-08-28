CREATE TABLE [dbo].[WeaponType] (
    [WeaponTypeID] TINYINT       IDENTITY (1, 1) NOT NULL,
    [WeaponType]   NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_WeaponType] PRIMARY KEY CLUSTERED ([WeaponTypeID] ASC)
);

