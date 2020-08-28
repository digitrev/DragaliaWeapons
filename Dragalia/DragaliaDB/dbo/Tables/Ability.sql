CREATE TABLE [dbo].[Ability] (
    [AbilityID]   INT            NOT NULL,
    [GenericName] NVARCHAR (100) NOT NULL,
    [AbilityName] NVARCHAR (100) NOT NULL,
    CONSTRAINT [PK_Ability] PRIMARY KEY CLUSTERED ([AbilityID] ASC)
);

