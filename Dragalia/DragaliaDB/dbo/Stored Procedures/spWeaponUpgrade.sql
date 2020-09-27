CREATE PROCEDURE [dbo].[spWeaponUpgrade] @UpgradeType NVARCHAR(50)
AS
SELECT wt.WeaponType AS Weapon
	,ws.WeaponSeries AS [Type]
	,w.WeaponName AS [Name]
	,m.MaterialName AS Material
	,wu.Quantity
	,wu.Step
FROM Weapon AS w
INNER JOIN WeaponSeries AS ws ON ws.WeaponSeriesID = w.WeaponSeriesID
INNER JOIN WeaponType AS wt ON wt.WeaponTypeID = w.WeaponTypeID
INNER JOIN Element AS e ON e.ElementID = w.ElementID
INNER JOIN WeaponUpgrade AS wu ON wu.WeaponID = w.WeaponID
INNER JOIN UpgradeType AS ut ON ut.UpgradeTypeID = wu.UpgradeTypeID
INNER JOIN Material AS m ON m.MaterialID = wu.MaterialID
WHERE ut.UpgradeType = @UpgradeType
ORDER BY ws.SortOrder
	,wt.WeaponTypeID
	,w.Rarity
	,e.SortOrder
	,wu.Step
	,m.MaterialID
