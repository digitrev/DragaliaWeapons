CREATE PROCEDURE [core].[spQuestJson]
AS
SELECT QuestID AS questId
	,Quest AS quest
	,SortPath AS sortPath
FROM core.Quest
ORDER BY SortPath
FOR JSON PATH
