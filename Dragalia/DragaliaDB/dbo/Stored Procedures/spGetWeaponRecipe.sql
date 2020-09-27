CREATE PROCEDURE [dbo].[spGetWeaponRecipe]
AS
SELECT wt.WeaponType
	,ws.WeaponSource
	,w.WeaponName
	,i.ItemName
	,wc.Quantity
FROM Weapon AS w
CROSS APPLY dbo.fnGetWeaponCraftingCounts(w.WeaponID) AS wc
INNER JOIN WeaponType AS wt ON wt.WeaponTypeID = w.WeaponTypeID
INNER JOIN WeaponSource AS ws ON ws.WeaponSourceID = w.WeaponSourceID
INNER JOIN Item AS i ON i.ItemID = wc.ItemID
ORDER BY w.WeaponID
	,i.ItemID
