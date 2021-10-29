CREATE PROCEDURE [core].[spDragonJson]
AS
SELECT d.DragonID AS dragonId
	,d.Dragon AS dragon
	,d.Rarity AS rarity
	,e.Element AS element
FROM [drg].Dragon AS d
INNER JOIN core.Element AS e ON e.ElementID = d.ElementID
ORDER BY e.SortOrder
	,d.Rarity DESC
	,d.DragonID DESC
FOR JSON PATH
