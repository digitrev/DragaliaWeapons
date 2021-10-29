CREATE TABLE [cht].[ChestDrop] (
	[ChestDropID] INT NOT NULL IDENTITY
	,[ChestID] INT NOT NULL
	,[MaterialID] NVARCHAR(50) NOT NULL
	,CONSTRAINT [PK_ChestDrop] PRIMARY KEY ([ChestDropID])
	,CONSTRAINT [FK_ChestDrop_Chest] FOREIGN KEY ([ChestID]) REFERENCES [cht].[Chest]([ChestID]) ON DELETE CASCADE
	,CONSTRAINT [FK_ChestDrop_Material] FOREIGN KEY ([MaterialID]) REFERENCES [core].[Material]([MaterialID]) ON DELETE CASCADE
	)
