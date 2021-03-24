CREATE TABLE [core].[DragonEssence] (
	[DragonID] INT NOT NULL
	,[MaterialID] NVARCHAR(50) NOT NULL
	,[Quantity] INT NOT NULL CONSTRAINT [DF_DragonEssence_Quantity] DEFAULT(50)
	,CONSTRAINT [PK_DragonEssence] PRIMARY KEY (
		[DragonID]
		,[MaterialID]
		)
	)
