CREATE PROCEDURE [core].[spWeaponUpgrade] @UpgradeType NVARCHAR(50)
AS
SELECT wt.WeaponType AS Weapon
	,ws.WeaponSeries AS [Type]
	,w.WeaponName AS [Name]
	,m.MaterialName AS Material
	,wu.Quantity
	,wu.Step
FROM [core].Weapon AS w
INNER JOIN [core].WeaponSeries AS ws ON ws.WeaponSeriesID = w.WeaponSeriesID
INNER JOIN [core].WeaponType AS wt ON wt.WeaponTypeID = w.WeaponTypeID
INNER JOIN [core].Element AS e ON e.ElementID = w.ElementID
INNER JOIN [core].WeaponUpgrade AS wu ON wu.WeaponID = w.WeaponID
INNER JOIN [core].UpgradeType AS ut ON ut.UpgradeTypeID = wu.UpgradeTypeID
INNER JOIN [core].Material AS m ON m.MaterialID = wu.MaterialID
WHERE ut.UpgradeType = @UpgradeType
ORDER BY ws.SortOrder
	,wt.WeaponTypeID
	,w.Rarity
	,e.SortOrder
	,wu.Step
	,m.MaterialID
