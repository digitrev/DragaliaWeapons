CREATE TABLE [jsn].[TableJson]
(
	[JsonID] INT NOT NULL IDENTITY, 
    [JsonText] NVARCHAR(MAX) NOT NULL, 
    [TableName] VARCHAR(128) NOT NULL, 
    CONSTRAINT [PK_GamepediaJson] PRIMARY KEY ([JsonID]) 
)
