CREATE TABLE [dbo].[PassiveCrafting] (
	[PassiveID] INT NOT NULL
	,[MaterialID] NVARCHAR(50) NOT NULL
	,[Quantity] INT NOT NULL
	,CONSTRAINT [PK_PassiveCrafting] PRIMARY KEY (
		[PassiveID]
		,[MaterialID]
		)
	,CONSTRAINT [FK_PassiveCrafting_Passive] FOREIGN KEY ([PassiveID]) REFERENCES [Passive]([PassiveID]) ON DELETE CASCADE
	,CONSTRAINT [FK_PassiveCrafting_Material] FOREIGN KEY ([MaterialID]) REFERENCES [Material]([MaterialID]) ON DELETE CASCADE
	)
