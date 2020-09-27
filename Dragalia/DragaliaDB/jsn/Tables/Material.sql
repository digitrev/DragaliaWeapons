CREATE TABLE [jsn].[Material]
(
	[JsonID] INT NOT NULL IDENTITY, 
    [JsonText] NVARCHAR(MAX) NULL, 
    CONSTRAINT [PK_Material] PRIMARY KEY ([JsonID]) 
)
