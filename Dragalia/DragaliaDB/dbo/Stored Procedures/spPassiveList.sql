CREATE PROCEDURE [dbo].[spPassiveList]
AS
SELECT wt.WeaponType
	,e.Element
	,a.GenericName
FROM Passive AS p
INNER JOIN WeaponType AS wt ON wt.WeaponTypeID = p.WeaponTypeID
INNER JOIN Element AS e ON e.ElementID = p.ElementID
INNER JOIN Ability AS a ON a.AbilityID = p.AbilityID
ORDER BY wt.WeaponTypeID
	,e.SortOrder
	,p.SortOrder
