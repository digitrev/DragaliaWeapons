CREATE PROCEDURE [den].[spLoadCore]
AS
BEGIN
	SET NOCOUNT ON

	MERGE core.Category AS trg
	USING (
		SELECT Category
		FROM den.MaterialMetadata
		
		UNION
		
		SELECT Category
		FROM den.FacilityMetadata
		) AS src
		ON src.Category = trg.Category
	WHEN NOT MATCHED BY SOURCE
		THEN
			DELETE
	WHEN NOT MATCHED
		THEN
			INSERT (Category)
			VALUES (src.Category);

	UPDATE c
	SET SortPath = cm.SortPath
	FROM core.Category AS c
	INNER JOIN den.CategoryMetadata AS cm ON cm.Category = c.Category

	UPDATE core.Material
	SET SortPath = HIERARCHYID::GetRoot()

	UPDATE m
	SET SortPath = mm.SortPath
		,CategoryID = c.CategoryID
	FROM core.Material AS m
	INNER JOIN den.MaterialMetadata AS mm ON mm.Material = m.Material
	INNER JOIN core.Category AS c ON c.Category = mm.Category

	MERGE core.Quest AS trg
	USING den.QuestHierarchy AS src
		ON src.Quest = trg.Quest
	WHEN MATCHED
		THEN
			UPDATE
			SET SortPath = src.SortPath
	WHEN NOT MATCHED BY SOURCE
		THEN
			DELETE
	WHEN NOT MATCHED
		THEN
			INSERT (
				Quest
				,SortPath
				)
			VALUES (
				src.Quest
				,src.SortPath
				);

	TRUNCATE TABLE core.MaterialQuest

	INSERT core.MaterialQuest (
		MaterialID
		,QuestID
		)
	SELECT m.MaterialID
		,q.QuestID
	FROM den.FarmLocation AS fl
	INNER JOIN core.Material AS m ON m.Material = fl.Material
	INNER JOIN core.Quest AS q ON q.Quest = fl.Quest

	EXEC [den].spLoadDrg

	EXEC [den].spLoadFac
END
