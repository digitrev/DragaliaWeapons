CREATE PROCEDURE [core].[spWeaponCrafting]
AS
SELECT wt.WeaponType AS Weapon
	,ws.WeaponSeries AS [Type]
	,w.[Weapon] AS [Name]
	,m.[Material]
	,wc.Quantity
FROM [core].WeaponCrafting AS wc
INNER JOIN [core].Weapon AS w ON w.WeaponID = wc.WeaponID
INNER JOIN [core].Material AS m ON m.MaterialID = wc.MaterialID
INNER JOIN [core].WeaponSeries AS ws ON ws.WeaponSeriesID = w.WeaponSeriesID
INNER JOIN [core].WeaponType AS wt ON wt.WeaponTypeID = w.WeaponTypeID
INNER JOIN [core].Element AS e ON e.ElementID = w.ElementID
ORDER BY ws.SortOrder
	,wt.WeaponTypeID
	,w.Rarity
	,e.SortOrder
	,m.MaterialID
