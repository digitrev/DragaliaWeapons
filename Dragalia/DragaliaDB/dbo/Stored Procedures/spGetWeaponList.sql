CREATE PROCEDURE [dbo].[spGetWeaponList]
AS
SELECT wt.WeaponType
	,ws.WeaponSource
	,w.WeaponName
	,w.Rarity
	,e.Element
	,ISNULL(wa.Ability1, N'') AS Ability1
	,ISNULL(wa.Ability2, N'') AS Ability2
	,ISNULL(p.WeaponName, N'') as ParentWeapon
FROM Weapon AS w
INNER JOIN WeaponType AS wt ON wt.WeaponTypeID = w.WeaponTypeID
INNER JOIN WeaponSource AS ws ON ws.WeaponSourceID = w.WeaponSourceID
INNER JOIN Element AS e ON e.ElementID = w.ElementID
LEFT JOIN (
	SELECT wa.WeaponID
		,a.GenericName
		,RN = CONCAT (
			'Ability'
			,ROW_NUMBER() OVER (
				PARTITION BY wa.WeaponID ORDER BY wa.AbilityID
				)
			)
	FROM WeaponAbility AS wa
	INNER JOIN Ability AS a ON a.AbilityID = wa.AbilityID
	) AS src
PIVOT(MAX(src.GenericName) FOR RN IN (
			Ability1
			,Ability2
			)) AS wa ON wa.WeaponID = w.WeaponID
LEFT JOIN Weapon AS p ON p.WeaponID = w.ParentWeaponID
ORDER BY wt.WeaponType, ws.WeaponSource, w.Rarity, e.Element
