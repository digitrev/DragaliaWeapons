CREATE PROCEDURE [cht].[spChestGroupJson]
AS
SELECT cg.ChestGroupID AS chestGroupId
	,cg.ChestGroup AS chestGroup
	,f.Frequency AS frequency
	,cg.Quantity AS quantity
	,(
		SELECT TOP 3 c.ChestID AS chestId
			,c.QuestID AS questId
			,q.QuestID AS [quest.questId]
			,q.Quest AS [quest.quest]
			,q.SortPath AS [quest.sortPath]
			,(
				SELECT cd.ChestDropID AS chestDropId
					,cd.MaterialID AS materialId
					,m.MaterialID AS [material.materialId]
					,m.Material AS [material.material]
					,cat.Category AS [material.category]
					,m.SortPath AS [material.sortPath]
					,cd.Quantity AS quantity
				FROM cht.ChestDrop AS cd
				INNER JOIN core.Material AS m ON m.MaterialID = cd.MaterialID
				INNER JOIN core.Category AS cat ON cat.CategoryID = m.CategoryID
				WHERE cd.ChestID = c.ChestID
				FOR JSON PATH
				) AS chestDrops
		FROM cht.Chest AS c
		INNER JOIN core.Quest AS q ON q.QuestID = c.QuestID
		WHERE c.ChestGroupID = cg.ChestGroupID
		FOR JSON PATH
		) AS chests
FROM cht.ChestGroup AS cg
INNER JOIN core.Frequency AS f ON f.FrequencyID = cg.FrequencyID
FOR JSON PATH
