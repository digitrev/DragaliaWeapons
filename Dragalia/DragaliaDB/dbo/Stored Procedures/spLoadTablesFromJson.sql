CREATE PROCEDURE [dbo].[spLoadTablesFromJson]
AS
BEGIN
	SET NOCOUNT ON

	DROP TABLE IF EXISTS #WeaponDenormalized

	SELECT w.*
	INTO #WeaponDenormalized
	FROM jsn.Weapon AS rj
	CROSS APPLY OPENJSON(rj.JsonText) WITH (cargoquery NVARCHAR(MAX) AS JSON) AS cq
	CROSS APPLY OPENJSON(cq.cargoquery) WITH (
			WeaponID int '$.title.Id'
			,ParentWeaponID int '$.title.MainWeaponId'
			,WeaponName NVARCHAR(50) '$.title.WeaponName'
			,WeaponType NVARCHAR(10) '$.title.Type'
			,Rarity smallint '$.title.Rarity'
			,Element NVARCHAR(10) '$.title.ElementalType'
			,WeaponSource NVARCHAR(20) '$.title.Availability'
			,Ability1 int '$.title.Abilities11'
			,Ability2 int '$.title.Abilities21'
			,AssembleCoin NVARCHAR(50) '$.title.AssembleCoin'
			,Material1 NVARCHAR(50) '$.title.CraftMaterial1'
			,MaterialQuantity1 NVARCHAR(50) '$.title.CraftMaterialQuantity1'
			,Material2 NVARCHAR(50) '$.title.CraftMaterial2'
			,MaterialQuantity2 NVARCHAR(50) '$.title.CraftMaterialQuantity2'
			,Material3 NVARCHAR(50) '$.title.CraftMaterial3'
			,MaterialQuantity3 NVARCHAR(50) '$.title.CraftMaterialQuantity3'
			,Material4 NVARCHAR(50) '$.title.CraftMaterial4'
			,MaterialQuantity4 NVARCHAR(50) '$.title.CraftMaterialQuantity4'
			,Material5 NVARCHAR(50) '$.title.CraftMaterial5'
			,MaterialQuantity5 NVARCHAR(50) '$.title.CraftMaterialQuantity5'
			) AS w


	INSERT Ability(AbilityID, GenericName, AbilityName)
	SELECT DISTINCT a.AbilityID, a.GenericName, a.AbilityName
	FROM jsn.Ability AS rj
	CROSS APPLY OPENJSON(rj.JsonText) WITH (cargoquery NVARCHAR(MAX) AS JSON) AS cq
	CROSS APPLY OPENJSON(cq.cargoquery) WITH (
			AbilityID int '$.title.Id'
			,GenericName NVARCHAR(50) '$.title.GenericName'
			,AbilityName NVARCHAR(50) '$.title.Name'
			) AS a
	LEFT JOIN Ability as a2
		on a2.AbilityID = a.AbilityID
	WHERE a.AbilityName is not null
		AND a2.AbilityID IS NULL

	UPDATE Ability 
	SET AbilityName = REPLACE(AbilityName, '&amp;', '&')
		,GenericName = REPLACE(GenericName, '&amp;', '&')

	MERGE Element AS trg
	USING (
		SELECT DISTINCT Element
		FROM #WeaponDenormalized
		) AS src
		ON src.Element = trg.Element
	WHEN NOT MATCHED BY SOURCE
		THEN
			DELETE
	WHEN NOT MATCHED
		THEN
			INSERT (Element)
			VALUES (src.Element);

	MERGE Item AS trg
	USING (
		SELECT Material1
		FROM #WeaponDenormalized
		WHERE Material1 NOT IN (
				''
				,'0'
				)
	
		UNION
	
		SELECT Material2
		FROM #WeaponDenormalized
		WHERE Material2 NOT IN (
				''
				,'0'
				)
	
		UNION
	
		SELECT Material3
		FROM #WeaponDenormalized
		WHERE Material3 NOT IN (
				''
				,'0'
				)
	
		UNION
	
		SELECT Material4
		FROM #WeaponDenormalized
		WHERE Material4 NOT IN (
				''
				,'0'
				)
	
		UNION
	
		SELECT Material5
		FROM #WeaponDenormalized
		WHERE Material5 NOT IN (
				''
				,'0'
				)
	
		UNION
	
		SELECT 'Rupies'
		) AS src(Item)
		ON src.Item = trg.ItemName
	WHEN NOT MATCHED BY SOURCE
		THEN
			DELETE
	WHEN NOT MATCHED
		THEN
			INSERT (ItemName)
			VALUES (src.Item);

	MERGE WeaponType AS trg
	USING (
		SELECT DISTINCT WeaponType
		FROM #WeaponDenormalized
		) AS src
		ON src.WeaponType = trg.WeaponType
	WHEN NOT MATCHED BY SOURCE
		THEN
			DELETE
	WHEN NOT MATCHED
		THEN
			INSERT (WeaponType)
			VALUES (src.WeaponType);

	MERGE WeaponSource AS trg
	USING (
		SELECT DISTINCT WeaponSource
		FROM #WeaponDenormalized
		) AS src
		ON src.WeaponSource = trg.WeaponSource
	WHEN NOT MATCHED BY SOURCE
		THEN
			DELETE
	WHEN NOT MATCHED
		THEN
			INSERT (WeaponSource)
			VALUES (src.WeaponSource);

	MERGE Weapon AS trg
	USING (
		SELECT wd.WeaponID
			,NULLIF(wd.ParentWeaponID, 0) AS ParentWeaponID
			,wd.WeaponName
			,wt.WeaponTypeID
			,wd.Rarity
			,e.ElementID
			,ws.WeaponSourceID
		FROM #WeaponDenormalized AS wd
		INNER JOIN WeaponType AS wt ON wt.WeaponType = wd.WeaponType
		INNER JOIN Element AS e ON e.Element = wd.Element
		INNER JOIN WeaponSource AS ws ON ws.WeaponSource = wd.WeaponSource
		) AS src
		ON src.WeaponID = trg.WeaponID
	WHEN MATCHED
		THEN
			UPDATE
			SET ParentWeaponID = src.ParentWeaponID
				,WeaponName = src.WeaponName
				,WeaponTypeID = src.WeaponTypeID
				,Rarity = src.Rarity
				,ElementID = src.ElementID
				,WeaponSourceID = src.WeaponSourceID
	WHEN NOT MATCHED BY SOURCE
		THEN
			DELETE
	WHEN NOT MATCHED
		THEN
			INSERT (
				WeaponID
				,ParentWeaponID
				,WeaponName
				,WeaponTypeID
				,Rarity
				,ElementID
				,WeaponSourceID
				)
			VALUES (
				src.WeaponID
				,src.ParentWeaponID
				,src.WeaponName
				,src.WeaponTypeID
				,src.Rarity
				,src.ElementID
				,src.WeaponSourceID
				);

	MERGE WeaponAbility AS trg
	USING (
		SELECT WeaponID
			,Ability1
		FROM #WeaponDenormalized
		WHERE Ability1 <> 0
	
		UNION
	
		SELECT WeaponID
			,Ability2
		FROM #WeaponDenormalized
		WHERE Ability2 <> 0
		) AS src(WeaponID, AbilityID)
		ON src.WeaponID = trg.WeaponID
			AND src.AbilityID = trg.AbilityID
	WHEN NOT MATCHED BY SOURCE
		THEN
			DELETE
	WHEN NOT MATCHED
		THEN
			INSERT (
				WeaponID
				,AbilityID
				)
			VALUES (
				src.WeaponID
				,src.AbilityID
				);

	MERGE WeaponCrafting AS trg
	USING (
		SELECT wd.WeaponID
			,i.ItemID
			,wd.AssembleCoin
		FROM #WeaponDenormalized AS wd
		CROSS JOIN Item AS i
		WHERE i.ItemName = 'Rupies'
	
		UNION
	
		SELECT wd.WeaponID
			,i.ItemID
			,wd.MaterialQuantity1
		FROM #WeaponDenormalized AS wd
		INNER JOIN Item AS i ON i.ItemName = wd.Material1
	
		UNION
	
		SELECT wd.WeaponID
			,i.ItemID
			,wd.MaterialQuantity2
		FROM #WeaponDenormalized AS wd
		INNER JOIN Item AS i ON i.ItemName = wd.Material2
	
		UNION
	
		SELECT wd.WeaponID
			,i.ItemID
			,wd.MaterialQuantity3
		FROM #WeaponDenormalized AS wd
		INNER JOIN Item AS i ON i.ItemName = wd.Material3
	
		UNION
	
		SELECT wd.WeaponID
			,i.ItemID
			,wd.MaterialQuantity4
		FROM #WeaponDenormalized AS wd
		INNER JOIN Item AS i ON i.ItemName = wd.Material4
	
		UNION
	
		SELECT wd.WeaponID
			,i.ItemID
			,wd.MaterialQuantity5
		FROM #WeaponDenormalized AS wd
		INNER JOIN Item AS i ON i.ItemName = wd.Material5
		) AS src(WeaponID, ItemID, ItemQuantity)
		ON src.WeaponID = trg.WeaponID
			AND src.ItemID = trg.ItemID
	WHEN MATCHED
		THEN
			UPDATE
			SET Quantity = src.ItemQuantity
	WHEN NOT MATCHED BY SOURCE
		THEN
			DELETE
	WHEN NOT MATCHED
		THEN
			INSERT (
				WeaponID
				,ItemID
				,Quantity
				)
			VALUES (
				src.WeaponID
				,src.ItemID
				,src.ItemQuantity
				);
END