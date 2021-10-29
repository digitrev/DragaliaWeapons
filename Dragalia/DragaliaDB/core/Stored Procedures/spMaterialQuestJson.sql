CREATE PROCEDURE [core].[spMaterialQuestJson]
AS
SELECT mq.MaterialID AS materialId
	,mq.QuestID AS questId
	,m.MaterialID AS [material.materialId]
	,m.Material AS [material.material]
	,c.Category AS [material.category]
	,m.SortPath AS [material.sortPath]
	,q.QuestID AS [quest.questId]
	,q.Quest AS [quest.quest]
	,q.SortPath AS [quest.sortPath]
FROM core.MaterialQuest AS mq
INNER JOIN core.Material AS m ON m.MaterialID = mq.MaterialID
INNER JOIN core.Category AS c ON c.CategoryID = m.CategoryID
INNER JOIN core.Quest AS q ON q.QuestID = mq.QuestID
ORDER BY q.SortPath
	,m.SortPath
FOR JSON PATH
