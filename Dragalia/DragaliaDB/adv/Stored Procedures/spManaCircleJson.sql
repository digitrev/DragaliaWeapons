CREATE PROCEDURE [adv].[spManaCircleJson]
AS
SELECT [AdventurerID]
	,[ManaNode]
	,[MaterialID]
	,[Quantity]
FROM [adv].[ManaCircle]
FOR JSON PATH
