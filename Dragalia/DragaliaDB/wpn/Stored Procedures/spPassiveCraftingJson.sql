CREATE PROCEDURE [wpn].[spPassiveCraftingJson]
AS
SELECT [PassiveID]
	,[MaterialID]
	,[Quantity]
FROM [wpn].[PassiveCrafting]
FOR JSON PATH
