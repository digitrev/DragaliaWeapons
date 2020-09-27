CREATE PROCEDURE [dbo].[spPassiveCrafting]
AS
SELECT wt.WeaponType
	,e.Element
	,a.GenericName
	,m.MaterialName
	,pc.Quantity
FROM Passive AS p
INNER JOIN WeaponType AS wt ON wt.WeaponTypeID = p.WeaponTypeID
INNER JOIN Element AS e ON e.ElementID = p.ElementID
INNER JOIN Ability AS a ON a.AbilityID = p.AbilityID
INNER JOIN PassiveCrafting AS pc ON pc.PassiveID = p.PassiveID
INNER JOIN Material AS m ON m.MaterialID = pc.MaterialID
ORDER BY wt.WeaponTypeID
	,e.SortOrder
	,p.SortOrder
	,m.MaterialID
