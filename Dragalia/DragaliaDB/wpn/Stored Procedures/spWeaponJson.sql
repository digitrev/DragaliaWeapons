CREATE PROCEDURE [wpn].[spWeaponJson]
AS
SELECT w.WeaponID AS weaponId
	,w.Weapon AS weapon
	,ws.WeaponSeries AS weaponSeries
	,wt.WeaponType AS weaponType
	,w.Rarity AS rarity
	,e.Element AS element
FROM [wpn].Weapon AS w
INNER JOIN [wpn].WeaponSeries AS ws ON ws.WeaponSeriesID = w.WeaponSeriesID
INNER JOIN core.WeaponType AS wt ON wt.WeaponTypeID = w.WeaponTypeID
INNER JOIN core.Element AS e ON e.ElementID = w.ElementID
ORDER BY ws.SortOrder
	,wt.WeaponTypeID
	,w.Rarity
	,e.SortOrder
FOR JSON PATH
