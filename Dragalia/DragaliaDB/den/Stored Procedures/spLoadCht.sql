CREATE PROCEDURE den.spLoadCht
AS
BEGIN
	SET NOCOUNT ON

	MERGE core.Frequency AS trg
	USING (
		SELECT DISTINCT Frequency
		FROM den.Chests
		) AS src
		ON src.Frequency = trg.Frequency
	WHEN NOT MATCHED
		THEN
			INSERT (Frequency)
			VALUES (src.Frequency)
	WHEN NOT MATCHED BY SOURCE
		THEN
			DELETE;

	MERGE cht.ChestGroup AS trg
	USING (
		SELECT DISTINCT c.ChestGroup
			,f.FrequencyID
			,c.Quantity
		FROM den.Chests AS c
		INNER JOIN core.Frequency AS f ON f.Frequency = c.Frequency
		) AS src
		ON src.ChestGroup = trg.ChestGroup
	WHEN MATCHED
		THEN
			UPDATE
			SET FrequencyID = src.FrequencyID
				,Quantity = src.Quantity
	WHEN NOT MATCHED
		THEN
			INSERT (
				ChestGroup
				,FrequencyID
				,Quantity
				)
			VALUES (
				src.ChestGroup
				,src.FrequencyID
				,src.Quantity
				)
	WHEN NOT MATCHED BY SOURCE
		THEN
			DELETE;

	MERGE cht.Chest AS trg
	USING (
		SELECT DISTINCT cg.ChestGroupID
			,q.QuestID
		FROM den.Chests AS c
		INNER JOIN cht.ChestGroup AS cg ON cg.ChestGroup = c.ChestGroup
		INNER JOIN core.Quest AS q ON q.Quest = c.Quest
		) AS src
		ON src.ChestGroupID = trg.ChestGroupID
			AND src.QuestID = trg.QuestID
	WHEN NOT MATCHED
		THEN
			INSERT (
				ChestGroupID
				,QuestID
				)
			VALUES (
				src.ChestGroupID
				,src.QuestID
				)
	WHEN NOT MATCHED BY SOURCE
		THEN
			DELETE;

	MERGE cht.ChestDrop AS trg
	USING (
		SELECT DISTINCT c.ChestID
			,m.MaterialID
		FROM den.Chests AS dc
		INNER JOIN cht.ChestGroup AS cg ON cg.ChestGroup = dc.ChestGroup
		INNER JOIN core.Quest AS q ON q.Quest = dc.Quest
		INNER JOIN cht.Chest AS c ON c.ChestGroupID = cg.ChestGroupID
			AND c.QuestID = q.QuestID
		INNER JOIN core.Material AS m ON m.Material = dc.Material
		) AS src
		ON src.ChestID = trg.ChestID
			AND src.MaterialID = trg.MaterialID
	WHEN NOT MATCHED
		THEN
			INSERT (
				ChestID
				,MaterialID
				)
			VALUES (
				src.ChestID
				,src.MaterialID
				)
	WHEN NOT MATCHED BY SOURCE
		THEN
			DELETE;
END
