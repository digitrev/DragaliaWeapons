CREATE PROCEDURE [core].[spPassiveJson]
AS
SELECT p.PassiveID AS passiveId
	,p.AbilityNumber AS abilityNumber
	,a.Ability AS ability
	,e.Element AS element
	,wt.WeaponType AS weaponType
FROM [wpn].Passive AS p
INNER JOIN core.Ability AS a ON a.AbilityID = p.AbilityID
INNER JOIN core.Element AS e ON e.ElementID = p.ElementID
INNER JOIN core.WeaponType AS wt ON wt.WeaponTypeID = p.WeaponTypeID
ORDER BY wt.WeaponTypeID
	,e.SortOrder
	,p.SortOrder
FOR JSON PATH
