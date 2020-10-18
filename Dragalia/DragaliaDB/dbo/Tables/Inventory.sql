CREATE TABLE [dbo].[Inventory] (
	[AccountID] INT NOT NULL
	,[MaterialID] NVARCHAR(50) NOT NULL
	,[Quantity] INT NOT NULL CONSTRAINT [DF_Inventory_Quantity] DEFAULT(0)
	,CONSTRAINT [PK_Inventory] PRIMARY KEY (
		[AccountID]
		,[MaterialID]
		)
	,CONSTRAINT [FK_Inventory_Account] FOREIGN KEY ([AccountID]) REFERENCES [Account]([AccountID])
	,CONSTRAINT [FK_Inventory_Material] FOREIGN KEY ([MaterialID]) REFERENCES [core].[Material]([MaterialID])
	)
