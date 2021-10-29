CREATE PROCEDURE [core].[spAdventurerJson]
AS
SELECT a.AdventurerID AS adventurerId
	,a.Adventurer AS adventurer
	,a.Rarity AS rarity
	,e.Element AS element
	,wt.WeaponType AS weaponType
	,a.MCLimit AS mcLimit
FROM [adv].Adventurer AS a
INNER JOIN core.Element AS e ON e.ElementID = a.ElementID
INNER JOIN core.WeaponType AS wt ON wt.WeaponTypeID = a.WeaponTypeID
ORDER BY e.SortOrder
	,a.WeaponTypeID
	,a.Rarity DESC
	,a.AdventurerID DESC
FOR JSON PATH
