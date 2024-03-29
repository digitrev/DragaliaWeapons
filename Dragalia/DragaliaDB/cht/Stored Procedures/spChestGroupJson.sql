﻿CREATE PROCEDURE [cht].[spChestGroupJson]
AS
SELECT cg.ChestGroupID AS chestGroupId
	,cg.ChestGroup AS chestGroup
	,f.Frequency AS frequency
	,cg.Quantity AS quantity
	,(
		SELECT c.ChestID AS chestId
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
				ORDER BY m.SortPath
				FOR JSON PATH
				) AS chestDrops
		FROM cht.Chest AS c
		INNER JOIN core.Quest AS q ON q.QuestID = c.QuestID
		WHERE c.ChestGroupID = cg.ChestGroupID
		ORDER BY q.SortPath
		FOR JSON PATH
		) AS chests
FROM cht.ChestGroup AS cg
INNER JOIN core.Frequency AS f ON f.FrequencyID = cg.FrequencyID
INNER JOIN core.Quest AS q ON q.Quest = cg.ChestGroup
ORDER BY q.SortPath
FOR JSON PATH
