CREATE PROCEDURE [dbo].[spWeaponList]
AS
SELECT wt.WeaponType AS Weapon
	,ws.WeaponSeries AS [Type]
	,w.WeaponName AS [Name]
	,w.Rarity
	,e.Element
FROM Weapon AS w
INNER JOIN WeaponSeries AS ws ON ws.WeaponSeriesID = w.WeaponSeriesID
INNER JOIN WeaponType AS wt ON wt.WeaponTypeID = w.WeaponTypeID
INNER JOIN Element AS e ON e.ElementID = w.ElementID
ORDER BY ws.SortOrder
	,wt.WeaponTypeID
	,w.Rarity
	,e.SortOrder
