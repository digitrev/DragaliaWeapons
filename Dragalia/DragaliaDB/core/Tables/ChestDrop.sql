CREATE TABLE [core].[ChestDrop] (
	[ChestDropID] INT NOT NULL IDENTITY
	,[ChestID] INT NOT NULL
	,[MaterialID] INT NOT NULL
	,[Quantity] INT NOT NULL
	,CONSTRAINT [PK_ChestDrop] PRIMARY KEY ([ChestDropID])
	,CONSTRAINT [FK_ChestDrop_Chest] FOREIGN KEY ([ChestID]) REFERENCES [core].[Chest]([ChestID])
	,CONSTRAINT [FK_ChestDrop_Material] FOREIGN KEY ([MaterialID]) REFERENCES [core].[Material]([MaterialID])
	)
