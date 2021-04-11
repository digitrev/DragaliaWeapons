CREATE TABLE [jsn].[DenData]
(
	[JsonID] INT NOT NULL , 
    [JsonText] NVARCHAR(MAX) NOT NULL, 
    [TableName] VARCHAR(128) NOT NULL, 
    CONSTRAINT [PK_DenData] PRIMARY KEY ([JsonID])
)
