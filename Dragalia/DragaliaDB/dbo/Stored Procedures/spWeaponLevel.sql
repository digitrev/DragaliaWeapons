CREATE PROCEDURE [dbo].[spWeaponLevel]
AS
SELECT wt.WeaponType AS Weapon
	,ws.WeaponSeries AS [Type]
	,w.WeaponName AS [Name]
	,m.MaterialName AS Material
	,wl.Quantity
	,wl.WeaponLevel
FROM Weapon AS w
INNER JOIN WeaponSeries AS ws ON ws.WeaponSeriesID = w.WeaponSeriesID
INNER JOIN WeaponType AS wt ON wt.WeaponTypeID = w.WeaponTypeID
INNER JOIN Element AS e ON e.ElementID = w.ElementID
INNER JOIN WeaponLevel AS wl ON wl.Rarity = w.Rarity
INNER JOIN Material AS m ON m.MaterialID = wl.MaterialID
ORDER BY ws.SortOrder
	,wt.WeaponTypeID
	,w.Rarity
	,e.SortOrder
	,wl.WeaponLevel
	,m.MaterialID
