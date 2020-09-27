CREATE TABLE [jsn].[Weapon] (
    [JsonID]   INT            IDENTITY (1, 1) NOT NULL,
    [JsonText] NVARCHAR (MAX) NULL, 
    CONSTRAINT [PK_Weapon] PRIMARY KEY ([JsonID])
);

