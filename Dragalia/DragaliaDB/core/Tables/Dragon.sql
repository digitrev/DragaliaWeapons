CREATE TABLE [core].[Dragon] (
	[DragonID] INT NOT NULL
	,[Dragon] NVARCHAR(50) NOT NULL
	,[Rarity] INT NOT NULL
	,[ElementID] INT NOT NULL
	,[Active] BIT NOT NULL CONSTRAINT [DF_Dragon_Active] DEFAULT(1)
	,CONSTRAINT [PK_Dragon] PRIMARY KEY ([DragonID])
	,CONSTRAINT [FK_Dragon_Element] FOREIGN KEY ([ElementID]) REFERENCES [core].[Element]([ElementID])
	)
GO

CREATE TRIGGER [core].[Trigger_Dragon] ON [core].[Dragon]
AFTER INSERT
AS
BEGIN
	SET NOCOUNT ON

	EXEC dbo.spFillDragon
END
