CREATE PROCEDURE [den].[spSetQuestHierachy]
AS
BEGIN
	DECLARE @CurrentLevel INT = 1
	DECLARE @MaxLevel INT = (
			SELECT MAX(ItemLevel)
			FROM den.QuestHierarchy
			)

	UPDATE den.QuestHierarchy
	SET SortPath = NULL

	UPDATE den.QuestHierarchy
	SET SortPath = HIERARCHYID::GetRoot()
	WHERE ItemLevel = 0

	WHILE @CurrentLevel <= @MaxLevel
	BEGIN
		DECLARE @ID INT = (
				SELECT TOP 1 QuestHierachyID
				FROM den.QuestHierarchy
				WHERE ItemLevel = @CurrentLevel
					AND SortPath IS NULL
				)
		DECLARE @ParentHID HIERARCHYID = (
				SELECT TOP 1 SortPath
				FROM den.QuestHierarchy
				WHERE ItemLevel < @CurrentLevel
					AND QuestHierachyID < @ID
				ORDER BY QuestHierachyID DESC
				)
		DECLARE @PreviousHID HIERARCHYID = (
				SELECT TOP 1 SortPath
				FROM den.QuestHierarchy
				WHERE ItemLevel = @CurrentLevel
					AND QuestHierachyID < @ID
				ORDER BY QuestHierachyID DESC
				)
		DECLARE @HID HIERARCHYID

		IF @PreviousHID.IsDescendantOf(@ParentHID) = 1
			SET @HID = @ParentHID.GetDescendant(@PreviousHID, NULL)
		ELSE
			SET @HID = @ParentHID.GetDescendant(NULL, NULL)

		UPDATE den.QuestHierarchy
		SET SortPath = @HID
		WHERE QuestHierachyID = @ID

		IF @ID IS NULL
			SET @CurrentLevel = @CurrentLevel + 1
	END
END
