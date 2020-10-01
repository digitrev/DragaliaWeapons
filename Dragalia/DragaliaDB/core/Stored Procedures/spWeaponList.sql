CREATE PROCEDURE [core].[spWeaponList]
AS
SELECT wt.WeaponType AS Weapon
	,ws.WeaponSeries AS [Type]
	,w.WeaponName AS [Name]
	,w.Rarity
	,e.Element
FROM [core].Weapon AS w
INNER JOIN [core].WeaponSeries AS ws ON ws.WeaponSeriesID = w.WeaponSeriesID
INNER JOIN [core].WeaponType AS wt ON wt.WeaponTypeID = w.WeaponTypeID
INNER JOIN [core].Element AS e ON e.ElementID = w.ElementID
ORDER BY ws.SortOrder
	,wt.WeaponTypeID
	,w.Rarity
	,e.SortOrder
