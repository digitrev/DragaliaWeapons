CREATE PROCEDURE [dbo].[spLoadTablesFromJson]
AS
BEGIN
	SET NOCOUNT ON

	MERGE Material AS trg
	USING (
		SELECT m.MaterialID
			,m.MaterialName
		FROM jsn.Material AS mj
		CROSS APPLY OPENJSON(mj.JsonText) WITH (cargoquery NVARCHAR(MAX) AS JSON) AS cq
		CROSS APPLY OPENJSON(cq.cargoquery) WITH (
				MaterialID NVARCHAR(50) '$.title.Id'
				,MaterialName NVARCHAR(50) '$.title.Name'
				) AS m
		) AS src
		ON src.MaterialID = trg.MaterialID
	WHEN MATCHED
		THEN
			UPDATE
			SET MaterialName = src.MaterialName
	WHEN NOT MATCHED BY SOURCE
		THEN
			DELETE
	WHEN NOT MATCHED
		THEN
			INSERT (
				MaterialID
				,MaterialName
				)
			VALUES (
				src.MaterialID
				,src.MaterialName
				);
END
