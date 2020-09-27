CREATE PROCEDURE [dbo].[spLoadTablesFromJson]
AS
BEGIN
	SET NOCOUNT ON

	IF OBJECT_ID('tempdb..#Level') IS NOT NULL
		DROP TABLE #Level

	IF OBJECT_ID('tempdb..#Passive') IS NOT NULL
		DROP TABLE #Passive

	IF OBJECT_ID('tempdb..#Weapon') IS NOT NULL
		DROP TABLE #Weapon

	IF OBJECT_ID('tempdb..#WeaponUpgrade') IS NOT NULL
		DROP TABLE #WeaponUpgrade

	--Ability data
	MERGE Ability AS trg
	USING (
		SELECT a.AbilityID
			,REPLACE(a.Ability, '&amp;', '&') AS Ability
			,REPLACE(a.GenericName, '&amp;', '&') AS GenericName
		FROM jsn.Ability AS aj
		CROSS APPLY OPENJSON(JsonText) WITH (cargoquery NVARCHAR(MAX) AS JSON) AS cq
		CROSS APPLY OPENJSON(cq.cargoquery) WITH (
				AbilityID INT '$.title.Id'
				,Ability NVARCHAR(255) '$.title.Name'
				,GenericName NVARCHAR(255) '$.title.GenericName'
				) AS a
		) AS src
		ON src.AbilityID = trg.AbilityID
	WHEN MATCHED
		THEN
			UPDATE
			SET Ability = src.Ability
				,GenericName = src.GenericName
	WHEN NOT MATCHED BY SOURCE
		THEN
			DELETE
	WHEN NOT MATCHED
		THEN
			INSERT (
				AbilityID
				,Ability
				,GenericName
				)
			VALUES (
				src.AbilityID
				,src.Ability
				,src.GenericName
				);

	--Material data
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
		
		UNION
		
		--Hard coded because Gamepedia doesn't track rupie as a separate material
		SELECT 'Rupie'
			,'Rupies'
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

	--Weapon data
	SELECT w.WeaponID
		,w.WeaponName
		,w.WeaponSeries
		,w.WeaponSeriesID
		,w.WeaponType
		,w.WeaponTypeID
		,w.Rarity
		,w.Element
		,w.ElementID
		,w.CreateCoin
		,w.CreateEntity1
		,w.CreateEntityQuantity1
		,w.CreateEntity2
		,w.CreateEntityQuantity2
		,w.CreateEntity3
		,w.CreateEntityQuantity3
		,w.CreateEntity4
		,w.CreateEntityQuantity4
		,w.CreateEntity5
		,w.CreateEntityQuantity5
		,w.GroupID
	INTO #Weapon
	FROM jsn.Weapon AS wj
	CROSS APPLY OPENJSON(wj.JsonText) WITH (cargoquery NVARCHAR(max) AS json) AS cq
	CROSS APPLY OPENJSON(cq.cargoquery) WITH (
			WeaponID INT '$.title.Id'
			,WeaponName NVARCHAR(255) '$.title.Name'
			,WeaponSeries NVARCHAR(255) '$.title.WeaponSeries'
			,WeaponSeriesID INT '$.title.WeaponSeriesId'
			,WeaponType NVARCHAR(255) '$.title.WeaponType'
			,WeaponTypeID INT '$.title.WeaponTypeId'
			,Rarity INT '$.title.Rarity'
			,Element NVARCHAR(255) '$.title.ElementalType'
			,ElementID INT '$.title.ElementalTypeId'
			,CreateCoin INT '$.title.CreateCoin'
			,CreateEntity1 NVARCHAR(50) '$.title.CreateEntity1'
			,CreateEntityQuantity1 INT '$.title.CreateEntityQuantity1'
			,CreateEntity2 NVARCHAR(50) '$.title.CreateEntity2'
			,CreateEntityQuantity2 INT '$.title.CreateEntityQuantity2'
			,CreateEntity3 NVARCHAR(50) '$.title.CreateEntity3'
			,CreateEntityQuantity3 INT '$.title.CreateEntityQuantity3'
			,CreateEntity4 NVARCHAR(50) '$.title.CreateEntity4'
			,CreateEntityQuantity4 INT '$.title.CreateEntityQuantity4'
			,CreateEntity5 NVARCHAR(50) '$.title.CreateEntity5'
			,CreateEntityQuantity5 INT '$.title.CreateEntityQuantity5'
			,GroupID INT '$.title.WeaponBodyBuildupGroupId'
			) AS w

	--Basic tables
	MERGE Element AS trg
	USING (
		SELECT DISTINCT ElementID
			,Element
		FROM #Weapon
		) AS src
		ON src.ElementID = trg.ElementID
	WHEN MATCHED
		THEN
			UPDATE
			SET Element = src.Element
				,SortOrder = src.ElementID
	WHEN NOT MATCHED BY SOURCE
		THEN
			DELETE
	WHEN NOT MATCHED
		THEN
			INSERT (
				ElementID
				,Element
				,SortOrder
				)
			VALUES (
				src.ElementID
				,src.Element
				,src.ElementID
				);

	--Just force elements to flip sort order
	UPDATE Element
	SET SortOrder = - SortOrder
	WHERE Element = 'None'

	MERGE WeaponSeries AS trg
	USING (
		SELECT DISTINCT WeaponSeriesID
			,WeaponSeries
		FROM #Weapon
		) AS src
		ON src.WeaponSeriesID = trg.WeaponSeriesID
	WHEN MATCHED
		THEN
			UPDATE
			SET WeaponSeries = src.WeaponSeries
				,SortOrder = src.WeaponSeriesID
	WHEN NOT MATCHED BY SOURCE
		THEN
			DELETE
	WHEN NOT MATCHED
		THEN
			INSERT (
				WeaponSeriesID
				,WeaponSeries
				,SortOrder
				)
			VALUES (
				src.WeaponSeriesID
				,src.WeaponSeries
				,src.WeaponSeriesID
				);

	--Force sort order
	UPDATE ws
	SET SortOrder = src.SortOrder
	FROM (
		VALUES (
			'Core'
			,1
			)
			,(
			'Void'
			,2
			)
			,(
			'High Dragon'
			,4
			)
			,(
			'Agito'
			,5
			)
			,(
			'Chimeratech'
			,3
			)
		) AS src(WeaponSeries, SortOrder)
	INNER JOIN WeaponSeries AS ws ON ws.WeaponSeries = src.WeaponSeries

	MERGE WeaponType AS trg
	USING (
		SELECT DISTINCT WeaponTypeID
			,WeaponType
		FROM #Weapon
		) AS src
		ON src.WeaponTypeID = trg.WeaponTypeID
	WHEN MATCHED
		THEN
			UPDATE
			SET WeaponType = src.WeaponType
	WHEN NOT MATCHED BY SOURCE
		THEN
			DELETE
	WHEN NOT MATCHED
		THEN
			INSERT (
				WeaponTypeID
				,WeaponType
				)
			VALUES (
				src.WeaponTypeID
				,src.WeaponType
				);

	--Weapons
	MERGE Weapon AS trg
	USING (
		SELECT WeaponID
			,WeaponName
			,WeaponSeriesID
			,WeaponTypeID
			,Rarity
			,ElementID
		FROM #Weapon
		) AS src
		ON src.WeaponID = trg.WeaponID
	WHEN MATCHED
		THEN
			UPDATE
			SET WeaponName = src.WeaponName
				,WeaponSeriesID = src.WeaponSeriesID
				,WeaponTypeID = src.WeaponTypeID
				,Rarity = src.Rarity
				,ElementID = src.ElementID
	WHEN NOT MATCHED BY SOURCE
		THEN
			DELETE
	WHEN NOT MATCHED
		THEN
			INSERT (
				WeaponID
				,WeaponName
				,WeaponSeriesID
				,WeaponTypeID
				,Rarity
				,ElementID
				)
			VALUES (
				src.WeaponID
				,src.WeaponName
				,src.WeaponSeriesID
				,src.WeaponTypeID
				,src.Rarity
				,src.ElementID
				);

	--Weapon crafting
	TRUNCATE TABLE WeaponCrafting

	INSERT WeaponCrafting (
		WeaponID
		,MaterialID
		,Quantity
		)
	SELECT wc.WeaponID
		,m.MaterialID
		,wc.MaterialQuantity
	FROM (
		SELECT WeaponID
			,CreateEntity1 AS Material
			,CreateEntityQuantity1 AS MaterialQuantity
		FROM #Weapon
		
		UNION ALL
		
		SELECT WeaponID
			,CreateEntity2
			,CreateEntityQuantity2
		FROM #Weapon
		
		UNION ALL
		
		SELECT WeaponID
			,CreateEntity3
			,CreateEntityQuantity3
		FROM #Weapon
		
		UNION ALL
		
		SELECT WeaponID
			,CreateEntity4
			,CreateEntityQuantity4
		FROM #Weapon
		
		UNION ALL
		
		SELECT WeaponID
			,CreateEntity5
			,CreateEntityQuantity5
		FROM #Weapon
		
		UNION ALL
		
		SELECT WeaponID
			,'Rupies'
			,CreateCoin
		FROM #Weapon
		) AS wc
	INNER JOIN Material AS m ON m.MaterialName = wc.Material

	--Weapon upgrade
	SELECT w.WeaponID
		,wu.UpgradeTypeID
		,wu.UpgradeType
		,wu.Step
		,wu.BuildupCoin
		,wu.BuildupMaterialID1
		,wu.BuildupMaterialQuantity1
		,wu.BuildupMaterialID2
		,wu.BuildupMaterialQuantity2
		,wu.BuildupMaterialID3
		,wu.BuildupMaterialQuantity3
		,wu.BuildupMaterialID4
		,wu.BuildupMaterialQuantity4
		,wu.BuildupMaterialID5
		,wu.BuildupMaterialQuantity5
		,wu.BuildupMaterialID6
		,wu.BuildupMaterialQuantity6
		,wu.BuildupMaterialID7
		,wu.BuildupMaterialQuantity7
		,wu.BuildupMaterialID8
		,wu.BuildupMaterialQuantity8
		,wu.BuildupMaterialID9
		,wu.BuildupMaterialQuantity9
		,wu.BuildupMaterialID10
		,wu.BuildupMaterialQuantity10
	INTO #WeaponUpgrade
	FROM jsn.WeaponUpgrade AS wuj
	CROSS APPLY OPENJSON(JsonText) WITH (cargoquery NVARCHAR(MAX) AS JSON) AS cq
	CROSS APPLY OPENJSON(cq.cargoquery) WITH (
			GroupID NVARCHAR(50) '$.title.WeaponBodyBuildupGroupId'
			,UpgradeTypeID NVARCHAR(50) '$.title.BuildupPieceTypeId'
			,UpgradeType NVARCHAR(50) '$.title.BuildupPieceType'
			,Step NVARCHAR(50) '$.title.Step'
			,BuildupCoin INT '$.title.BuildupCoin'
			,BuildupMaterialID1 NVARCHAR(50) '$.title.BuildupMaterialId1'
			,BuildupMaterialQuantity1 INT '$.title.BuildupMaterialQuantity1'
			,BuildupMaterialID2 NVARCHAR(50) '$.title.BuildupMaterialId2'
			,BuildupMaterialQuantity2 INT '$.title.BuildupMaterialQuantity2'
			,BuildupMaterialID3 NVARCHAR(50) '$.title.BuildupMaterialId3'
			,BuildupMaterialQuantity3 INT '$.title.BuildupMaterialQuantity3'
			,BuildupMaterialID4 NVARCHAR(50) '$.title.BuildupMaterialId4'
			,BuildupMaterialQuantity4 INT '$.title.BuildupMaterialQuantity4'
			,BuildupMaterialID5 NVARCHAR(50) '$.title.BuildupMaterialId5'
			,BuildupMaterialQuantity5 INT '$.title.BuildupMaterialQuantity5'
			,BuildupMaterialID6 NVARCHAR(50) '$.title.BuildupMaterialId6'
			,BuildupMaterialQuantity6 INT '$.title.BuildupMaterialQuantity6'
			,BuildupMaterialID7 NVARCHAR(50) '$.title.BuildupMaterialId7'
			,BuildupMaterialQuantity7 INT '$.title.BuildupMaterialQuantity7'
			,BuildupMaterialID8 NVARCHAR(50) '$.title.BuildupMaterialId8'
			,BuildupMaterialQuantity8 INT '$.title.BuildupMaterialQuantity8'
			,BuildupMaterialID9 NVARCHAR(50) '$.title.BuildupMaterialId9'
			,BuildupMaterialQuantity9 INT '$.title.BuildupMaterialQuantity9'
			,BuildupMaterialID10 NVARCHAR(50) '$.title.BuildupMaterialId10'
			,BuildupMaterialQuantity10 INT '$.title.BuildupMaterialQuantity10'
			) AS wu
	INNER JOIN #Weapon AS w ON w.GroupID = wu.GroupID

	MERGE UpgradeType AS trg
	USING (
		SELECT DISTINCT UpgradeTypeID
			,UpgradeType
		FROM #WeaponUpgrade
		) AS src
		ON src.UpgradeTypeID = trg.UpgradeType
	WHEN MATCHED
		THEN
			UPDATE
			SET UpgradeType = src.UpgradeType
	WHEN NOT MATCHED BY SOURCE
		THEN
			DELETE
	WHEN NOT MATCHED
		THEN
			INSERT (
				UpgradeTypeID
				,UpgradeType
				)
			VALUES (
				src.UpgradeTypeID
				,src.UpgradeType
				);

	TRUNCATE TABLE WeaponUpgrade

	INSERT WeaponUpgrade (
		WeaponID
		,UpgradeTypeID
		,Step
		,MaterialID
		,Quantity
		)
	SELECT wu.WeaponID
		,wu.UpgradeTypeID
		,wu.Step
		,wu.MaterialID
		,wu.Quantity
	FROM (
		SELECT WeaponID
			,UpgradeTypeID
			,Step
			,BuildupMaterialID1 AS MaterialID
			,BuildupMaterialQuantity1 AS Quantity
		FROM #WeaponUpgrade
		
		UNION ALL
		
		SELECT WeaponID
			,UpgradeTypeID
			,Step
			,BuildupMaterialID2
			,BuildupMaterialQuantity2
		FROM #WeaponUpgrade
		
		UNION ALL
		
		SELECT WeaponID
			,UpgradeTypeID
			,Step
			,BuildupMaterialID3
			,BuildupMaterialQuantity3
		FROM #WeaponUpgrade
		
		UNION ALL
		
		SELECT WeaponID
			,UpgradeTypeID
			,Step
			,BuildupMaterialID4
			,BuildupMaterialQuantity4
		FROM #WeaponUpgrade
		
		UNION ALL
		
		SELECT WeaponID
			,UpgradeTypeID
			,Step
			,BuildupMaterialID5
			,BuildupMaterialQuantity5
		FROM #WeaponUpgrade
		
		UNION ALL
		
		SELECT WeaponID
			,UpgradeTypeID
			,Step
			,BuildupMaterialID6
			,BuildupMaterialQuantity6
		FROM #WeaponUpgrade
		
		UNION ALL
		
		SELECT WeaponID
			,UpgradeTypeID
			,Step
			,BuildupMaterialID7
			,BuildupMaterialQuantity7
		FROM #WeaponUpgrade
		
		UNION ALL
		
		SELECT WeaponID
			,UpgradeTypeID
			,Step
			,BuildupMaterialID8
			,BuildupMaterialQuantity8
		FROM #WeaponUpgrade
		
		UNION ALL
		
		SELECT WeaponID
			,UpgradeTypeID
			,Step
			,BuildupMaterialID9
			,BuildupMaterialQuantity9
		FROM #WeaponUpgrade
		
		UNION ALL
		
		SELECT WeaponID
			,UpgradeTypeID
			,Step
			,BuildupMaterialID10
			,BuildupMaterialQuantity10
		FROM #WeaponUpgrade
		
		UNION ALL
		
		SELECT WeaponID
			,UpgradeTypeID
			,Step
			,'Rupie'
			,BuildupCoin
		FROM #WeaponUpgrade
		) AS wu
	INNER JOIN Material AS m ON m.MaterialID = wu.MaterialID

	--Passive data
	SELECT p.PassiveID
		,p.AbilityNumber
		,p.SortId
		,p.WeaponTypeID
		,p.ElementID
		,p.AbilityID
		,p.UnlockCoin
		,p.UnlockMaterialId1
		,p.UnlockMaterialQuantity1
		,p.UnlockMaterialId2
		,p.UnlockMaterialQuantity2
		,p.UnlockMaterialId3
		,p.UnlockMaterialQuantity3
		,p.UnlockMaterialId4
		,p.UnlockMaterialQuantity4
		,p.UnlockMaterialId5
		,p.UnlockMaterialQuantity5
	INTO #Passive
	FROM jsn.Passive AS pj
	CROSS APPLY OPENJSON(pj.JsonText) WITH (cargoquery NVARCHAR(max) AS JSON) AS cq
	CROSS APPLY OPENJSON(cq.cargoquery) WITH (
			PassiveID INT '$.title.Id'
			,AbilityNumber INT '$.title.WeaponPassiveAbilityNo'
			,SortId INT '$.title.SortId'
			,WeaponTypeID INT '$.title.WeaponTypeId'
			,ElementID INT '$.title.ElementalTypeId'
			,AbilityID INT '$.title.AbilityId'
			,UnlockCoin INT '$.title.UnlockCoin'
			,UnlockMaterialId1 NVARCHAR(50) '$.title.UnlockMaterialId1'
			,UnlockMaterialQuantity1 INT '$.title.UnlockMaterialQuantity1'
			,UnlockMaterialId2 NVARCHAR(50) '$.title.UnlockMaterialId2'
			,UnlockMaterialQuantity2 INT '$.title.UnlockMaterialQuantity2'
			,UnlockMaterialId3 NVARCHAR(50) '$.title.UnlockMaterialId3'
			,UnlockMaterialQuantity3 INT '$.title.UnlockMaterialQuantity3'
			,UnlockMaterialId4 NVARCHAR(50) '$.title.UnlockMaterialId4'
			,UnlockMaterialQuantity4 INT '$.title.UnlockMaterialQuantity4'
			,UnlockMaterialId5 NVARCHAR(50) '$.title.UnlockMaterialId5'
			,UnlockMaterialQuantity5 INT '$.title.UnlockMaterialQuantity5'
			) AS p

	--Unknown abilities (should be deprecated in the future)
	INSERT Ability (
		AbilityID
		,Ability
		,GenericName
		)
	SELECT DISTINCT p.AbilityID
		,CONCAT (
			'('
			,e.Element
			,') Unknown Ability #'
			,p.AbilityID
			)
		,CONCAT (
			'Unknown Ability #'
			,p.AbilityID
			)
	FROM #Passive AS p
	INNER JOIN Element AS e ON e.ElementID = p.ElementID
	LEFT JOIN Ability AS a ON a.AbilityID = p.AbilityID
	WHERE a.AbilityID IS NULL

	MERGE Passive AS trg
	USING (
		SELECT PassiveID
			,WeaponTypeID
			,ElementID
			,AbilityID
			,AbilityNumber
			,SortId
		FROM #Passive AS p
		) AS src
		ON src.PassiveID = trg.PassiveID
	WHEN MATCHED
		THEN
			UPDATE
			SET WeaponTypeID = src.WeaponTypeID
				,ElementID = src.ElementID
				,AbilityID = src.AbilityID
				,AbilityNumber = src.AbilityNumber
				,SortOrder = src.SortId
	WHEN NOT MATCHED BY SOURCE
		THEN
			DELETE
	WHEN NOT MATCHED
		THEN
			INSERT (
				PassiveID
				,WeaponTypeID
				,ElementID
				,AbilityID
				,AbilityNumber
				,SortOrder 
				)
			VALUES (
				src.PassiveID
				,src.WeaponTypeID
				,src.ElementID
				,src.AbilityID
				,src.AbilityNumber
				,src.SortId
				);

	--Passive crafting
	TRUNCATE TABLE PassiveCrafting

	INSERT PassiveCrafting (
		PassiveID
		,MaterialID
		,Quantity
		)
	SELECT pc.PassiveID
		,pc.MaterialID
		,pc.Quantity
	FROM (
		SELECT PassiveID
			,'Rupie' AS MaterialID
			,UnlockCoin AS Quantity
		FROM #Passive
		
		UNION ALL
		
		SELECT PassiveID
			,UnlockMaterialId1
			,UnlockMaterialQuantity1
		FROM #Passive
		
		UNION ALL
		
		SELECT PassiveID
			,UnlockMaterialId2
			,UnlockMaterialQuantity2
		FROM #Passive
		
		UNION ALL
		
		SELECT PassiveID
			,UnlockMaterialId3
			,UnlockMaterialQuantity3
		FROM #Passive
		
		UNION ALL
		
		SELECT PassiveID
			,UnlockMaterialId4
			,UnlockMaterialQuantity4
		FROM #Passive
		
		UNION ALL
		
		SELECT PassiveID
			,UnlockMaterialId5
			,UnlockMaterialQuantity5
		FROM #Passive
		) AS pc
	INNER JOIN Material AS m ON m.MaterialID = pc.MaterialID

	--Weapon leveling
	SELECT wl.Rarity
		,wl.WeaponLevel
		,wl.BuildupMaterialId1
		,wl.BuildupMaterialQuantity1
		,wl.BuildupMaterialId2
		,wl.BuildupMaterialQuantity2
		,wl.BuildupMaterialId3
		,wl.BuildupMaterialQuantity3
	INTO #Level
	FROM jsn.WeaponLevel AS wlj
	CROSS APPLY OPENJSON(wlj.JsonText) WITH (cargoquery NVARCHAR(MAX) AS JSON) AS cq
	CROSS APPLY OPENJSON(cq.cargoquery) WITH (
			Rarity INT '$.title.RarityGroup'
			,WeaponLevel INT '$.title.Level'
			,BuildupMaterialId1 NVARCHAR(50) '$.title.BuildupMaterialId1'
			,BuildupMaterialQuantity1 INT '$.title.BuildupMaterialQuantity1'
			,BuildupMaterialId2 NVARCHAR(50) '$.title.BuildupMaterialId2'
			,BuildupMaterialQuantity2 INT '$.title.BuildupMaterialQuantity2'
			,BuildupMaterialId3 NVARCHAR(50) '$.title.BuildupMaterialId3'
			,BuildupMaterialQuantity3 INT '$.title.BuildupMaterialQuantity3'
			) AS wl

	TRUNCATE TABLE WeaponLevel

	INSERT WeaponLevel (
		Rarity
		,WeaponLevel
		,MaterialID
		,Quantity
		)
	SELECT l.Rarity
		,l.WeaponLevel
		,l.MaterialID
		,l.Quantity
	FROM (
		SELECT Rarity
			,WeaponLevel
			,BuildupMaterialId1 AS MaterialID
			,BuildupMaterialQuantity1 AS Quantity
		FROM #Level
		
		UNION ALL
		
		SELECT Rarity
			,WeaponLevel
			,BuildupMaterialId2
			,BuildupMaterialQuantity2
		FROM #Level
		
		UNION ALL
		
		SELECT Rarity
			,WeaponLevel
			,BuildupMaterialId3
			,BuildupMaterialQuantity3
		FROM #Level
		) AS l
	INNER JOIN Material AS m ON m.MaterialID = l.MaterialID
END
