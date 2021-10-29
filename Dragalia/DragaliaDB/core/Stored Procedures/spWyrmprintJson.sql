CREATE PROCEDURE [core].[spWyrmprintJson]
AS
SELECT w.WyrmprintID AS wyrmprintId
	,w.Wyrmprint AS wyrmprint
	,w.Rarity AS rarity
	,af.[Affinity] AS [affinity]
	,(
		SELECT a.GenericName AS ability
		FROM core.WyrmprintAbility AS wa
		INNER JOIN core.Ability AS a ON a.AbilityID = wa.AbilityID
		WHERE wa.WyrmprintID = w.WyrmprintID
			AND wa.AbilityLevel = 3
		FOR JSON PATH
		) AS abilities
FROM core.Wyrmprint AS w
LEFT JOIN core.[Affinity] AS af ON af.AffinityID = w.AffinityID
ORDER BY w.Rarity DESC
	,w.WyrmprintID DESC
FOR JSON PATH
