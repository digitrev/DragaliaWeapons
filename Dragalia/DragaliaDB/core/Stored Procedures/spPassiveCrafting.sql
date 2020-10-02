CREATE PROCEDURE [core].[spPassiveCrafting]
AS
SELECT wt.WeaponType
	,e.Element
	,a.GenericName
	,m.[Material]
	,pc.Quantity
FROM [core].Passive AS p
INNER JOIN [core].WeaponType AS wt ON wt.WeaponTypeID = p.WeaponTypeID
INNER JOIN [core].Element AS e ON e.ElementID = p.ElementID
INNER JOIN [core].Ability AS a ON a.AbilityID = p.AbilityID
INNER JOIN [core].PassiveCrafting AS pc ON pc.PassiveID = p.PassiveID
INNER JOIN [core].Material AS m ON m.MaterialID = pc.MaterialID
ORDER BY wt.WeaponTypeID
	,e.SortOrder
	,p.SortOrder
	,m.MaterialID
