CREATE PROCEDURE [drg].[spDragonUnbindJson]
AS
SELECT [DragonID]
	,[MaterialID]
	,[Quantity]
FROM [drg].[DragonUnbind]
FOR JSON PATH
