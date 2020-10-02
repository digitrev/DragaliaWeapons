CREATE PROCEDURE [core].[spWeaponLevel]
AS
SELECT wt.WeaponType AS Weapon
	,ws.WeaponSeries AS [Type]
	,w.[Weapon] AS [Name]
	,m.[Material] AS Material
	,wl.Quantity
	,wl.WeaponLevel
FROM [core].Weapon AS w
INNER JOIN [core].WeaponSeries AS ws ON ws.WeaponSeriesID = w.WeaponSeriesID
INNER JOIN [core].WeaponType AS wt ON wt.WeaponTypeID = w.WeaponTypeID
INNER JOIN [core].Element AS e ON e.ElementID = w.ElementID
INNER JOIN [core].WeaponLevel AS wl ON wl.Rarity = w.Rarity
INNER JOIN [core].Material AS m ON m.MaterialID = wl.MaterialID
ORDER BY ws.SortOrder
	,wt.WeaponTypeID
	,w.Rarity
	,e.SortOrder
	,wl.WeaponLevel
	,m.MaterialID
