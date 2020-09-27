CREATE TABLE [jsn].[Ability] (
    [JsonID]   INT            IDENTITY (1, 1) NOT NULL,
    [JsonText] NVARCHAR (MAX) NULL, 
    CONSTRAINT [PK_Ability] PRIMARY KEY ([JsonID])
);

