CREATE TABLE [core].[DragonUnbind] (
	[DragonID] INT NOT NULL
	,[MaterialID] NVARCHAR(50) NOT NULL
	,[Quantity] INT NOT NULL CONSTRAINT [DF_DragonEssence_Quantity] DEFAULT(50)
	,CONSTRAINT [PK_DragonEssence] PRIMARY KEY (
		[DragonID]
		,[MaterialID]
		)
	,CONSTRAINT [FK_DragonEssence_Dragon] FOREIGN KEY ([DragonID]) REFERENCES [core].[Dragon]([DragonID])
	,CONSTRAINT [FK_DragonEssence_Material] FOREIGN KEY ([MaterialID]) REFERENCES [core].[Material]([MaterialID])
	)
