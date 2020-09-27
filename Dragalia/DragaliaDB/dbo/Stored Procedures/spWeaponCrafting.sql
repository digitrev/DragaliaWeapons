CREATE PROCEDURE [dbo].[spWeaponCrafting]
AS
SELECT wt.WeaponType AS Weapon
	,ws.WeaponSeries AS [Type]
	,w.WeaponName AS [Name]
	,m.MaterialName
	,wc.Quantity
FROM WeaponCrafting AS wc
INNER JOIN Weapon AS w ON w.WeaponID = wc.WeaponID
INNER JOIN Material AS m ON m.MaterialID = wc.MaterialID
INNER JOIN WeaponSeries AS ws ON ws.WeaponSeriesID = w.WeaponSeriesID
INNER JOIN WeaponType AS wt ON wt.WeaponTypeID = w.WeaponTypeID
INNER JOIN Element AS e ON e.ElementID = w.ElementID
ORDER BY ws.SortOrder
	,wt.WeaponTypeID
	,w.Rarity
	,e.SortOrder
	,m.MaterialID
