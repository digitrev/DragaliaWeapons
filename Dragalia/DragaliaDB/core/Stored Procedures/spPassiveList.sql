CREATE PROCEDURE [core].[spPassiveList]
AS
SELECT wt.WeaponType
	,e.Element
	,a.GenericName
FROM [core].Passive AS p
INNER JOIN [core].WeaponType AS wt ON wt.WeaponTypeID = p.WeaponTypeID
INNER JOIN [core].Element AS e ON e.ElementID = p.ElementID
INNER JOIN [core].Ability AS a ON a.AbilityID = p.AbilityID
ORDER BY wt.WeaponTypeID
	,e.SortOrder
	,p.SortOrder
