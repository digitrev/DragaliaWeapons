CREATE PROCEDURE [jsn].[spLoadCore]
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

	IF OBJECT_ID('tempdb..#WeaponLimit') IS NOT NULL
		DROP TABLE #WeaponLimit

	--Ability group
	MERGE core.AbilityGroup AS trg
	USING (
		SELECT ag.AbilityGroupID
			,REPLACE(ag.AbilityGroup, '&amp;', '&') AS AbilityGroup
		FROM jsn.TableJson AS agj
		CROSS APPLY OPENJSON(agj.JsonText) WITH (cargoquery NVARCHAR(MAX) AS JSON) AS cq
		CROSS APPLY OPENJSON(cq.cargoquery) WITH (
				AbilityGroupID INT '$.title.Id'
				,AbilityGroup NVARCHAR(255) '$.title.GroupName'
				) AS ag
		WHERE agj.TableName = 'AbilityGroup'
		) AS src
		ON src.AbilityGroupID = trg.AbilityGroupID
	WHEN MATCHED
		THEN
			UPDATE
			SET AbilityGroup = src.AbilityGroup
	WHEN NOT MATCHED BY SOURCE
		THEN
			DELETE
	WHEN NOT MATCHED
		THEN
			INSERT (
				AbilityGroupID
				,AbilityGroup
				)
			VALUES (
				src.AbilityGroupID
				,src.AbilityGroup
				);

	--Ability data
	MERGE core.Ability AS trg
	USING (
		SELECT a.AbilityID
			,REPLACE(a.Ability, '&amp;', '&') AS Ability
			,REPLACE(a.GenericName, '&amp;', '&') AS GenericName
			,a.AbilityGroupID
		FROM jsn.TableJson AS aj
		CROSS APPLY OPENJSON(aj.JsonText) WITH (cargoquery NVARCHAR(MAX) AS JSON) AS cq
		CROSS APPLY OPENJSON(cq.cargoquery) WITH (
				AbilityID INT '$.title.Id'
				,Ability NVARCHAR(255) '$.title.Name'
				,GenericName NVARCHAR(255) '$.title.GenericName'
				,AbilityGroupID INT '$.title.AbilityGroup'
				) AS a
		WHERE aj.TableName = 'Ability'
		) AS src
		ON src.AbilityID = trg.AbilityID
	WHEN MATCHED
		THEN
			UPDATE
			SET Ability = src.Ability
				,GenericName = src.GenericName
				,AbilityGroupID = src.AbilityGroupID
	WHEN NOT MATCHED BY SOURCE
		THEN
			DELETE
	WHEN NOT MATCHED
		THEN
			INSERT (
				AbilityID
				,Ability
				,GenericName
				,AbilityGroupID
				)
			VALUES (
				src.AbilityID
				,src.Ability
				,src.GenericName
				,src.AbilityGroupID
				);

	--Affinity data
	MERGE core.[Affinity] AS trg
	USING (
		SELECT a.AffinityID
			,REPLACE(a.[Affinity], '&amp;', '&') AS [Affinity]
		FROM jsn.TableJson AS aj
		CROSS APPLY OPENJSON(aj.JsonText) WITH (cargoquery NVARCHAR(MAX) AS JSON) AS cq
		CROSS APPLY OPENJSON(cq.cargoquery) WITH (
				AffinityID INT '$.title.Id'
				,[Affinity] NVARCHAR(255) '$.title.Name'
				) AS a
		WHERE aj.TableName = 'Affinity'
		) AS src
		ON src.AffinityID = trg.AffinityID
	WHEN MATCHED
		THEN
			UPDATE
			SET [Affinity] = src.[Affinity]
	WHEN NOT MATCHED BY SOURCE
		THEN
			DELETE
	WHEN NOT MATCHED
		THEN
			INSERT (
				AffinityID
				,[Affinity]
				)
			VALUES (
				src.AffinityID
				,src.[Affinity]
				);

	--Material data
	MERGE core.Material AS trg
	USING (
		SELECT m.MaterialID
			,m.MaterialName
		FROM jsn.TableJson AS mj
		CROSS APPLY OPENJSON(mj.JsonText) WITH (cargoquery NVARCHAR(MAX) AS JSON) AS cq
		CROSS APPLY OPENJSON(cq.cargoquery) WITH (
				MaterialID NVARCHAR(50) '$.title.Id'
				,MaterialName NVARCHAR(50) '$.title.Name'
				) AS m
		WHERE mj.TableName = 'Material'
		
		UNION
		
		--Hard coded because Gamepedia doesn't track rupie as a separate material
		SELECT 'Rupie'
			,'Rupies'
		) AS src
		ON src.MaterialID = trg.MaterialID
	WHEN MATCHED
		THEN
			UPDATE
			SET [Material] = src.MaterialName
	WHEN NOT MATCHED BY SOURCE
		THEN
			DELETE
	WHEN NOT MATCHED
		THEN
			INSERT (
				MaterialID
				,[Material]
				)
			VALUES (
				src.MaterialID
				,src.MaterialName
				);

	--Weapon data
	SELECT DISTINCT w.WeaponID
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
	FROM jsn.TableJson AS wj
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
	WHERE wj.TableName = 'Weapon'

	--Basic tables
	MERGE core.Element AS trg
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
	UPDATE core.Element
	SET SortOrder = - SortOrder
	WHERE Element = 'None'

	MERGE core.WeaponSeries AS trg
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
	INNER JOIN core.WeaponSeries AS ws ON ws.WeaponSeries = src.WeaponSeries

	MERGE core.WeaponType AS trg
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
	MERGE core.Weapon AS trg
	USING (
		SELECT DISTINCT WeaponID
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
			SET [Weapon] = src.WeaponName
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
				,[Weapon]
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
	TRUNCATE TABLE core.WeaponCrafting

	INSERT core.WeaponCrafting (
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
	INNER JOIN core.Material AS m ON m.[Material] = wc.Material

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
	FROM jsn.TableJson AS wuj
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
	WHERE wuj.TableName = 'WeaponUpgrade'

	MERGE core.UpgradeType AS trg
	USING (
		SELECT DISTINCT UpgradeTypeID
			,UpgradeType
		FROM #WeaponUpgrade
		) AS src
		ON src.UpgradeTypeID = trg.UpgradeType
	WHEN MATCHED
		THEN
			UPDATE
			SET [UpgradeType] = src.UpgradeType
	WHEN NOT MATCHED BY SOURCE
		THEN
			DELETE
	WHEN NOT MATCHED
		THEN
			INSERT (
				[UpgradeTypeID]
				,[UpgradeType]
				)
			VALUES (
				src.UpgradeTypeID
				,src.UpgradeType
				);

	TRUNCATE TABLE core.WeaponUpgrade

	INSERT core.WeaponUpgrade (
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
	INNER JOIN core.Material AS m ON m.MaterialID = wu.MaterialID

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
	FROM jsn.TableJson AS pj
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
	WHERE pj.TableName = 'Passive'

	--Unknown abilities (should be deprecated in the future)
	INSERT core.Ability (
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
	INNER JOIN core.Element AS e ON e.ElementID = p.ElementID
	LEFT JOIN core.Ability AS a ON a.AbilityID = p.AbilityID
	WHERE a.AbilityID IS NULL

	MERGE core.Passive AS trg
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
	TRUNCATE TABLE core.PassiveCrafting

	INSERT core.PassiveCrafting (
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
	INNER JOIN core.Material AS m ON m.MaterialID = pc.MaterialID

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
	FROM jsn.TableJson AS wlj
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
	WHERE wlj.TableName = 'WeaponLevel'

	TRUNCATE TABLE core.WeaponLevel

	INSERT core.WeaponLevel (
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
	INNER JOIN core.Material AS m ON m.MaterialID = l.MaterialID

	--Facilities
	MERGE core.Facility AS trg
	USING (
		SELECT f.FacilityID
			,f.FacilityName
			,f.FacilityCount
		FROM jsn.TableJson AS fj
		CROSS APPLY OPENJSON(fj.JsonText) WITH (cargoquery NVARCHAR(max) AS json) AS cq
		CROSS APPLY OPENJSON(cq.cargoquery) WITH (
				FacilityID INT '$.title.Id'
				,FacilityName NVARCHAR(50) '$.title.Name'
				,FacilityCount INT '$.title.Available'
				) AS f
		WHERE fj.TableName = 'Facility'
		) AS src
		ON src.FacilityID = trg.FacilityID
	WHEN MATCHED
		THEN
			UPDATE
			SET [Facility] = src.FacilityName
				,[Limit] = src.FacilityCount
	WHEN NOT MATCHED BY SOURCE
		THEN
			DELETE
	WHEN NOT MATCHED
		THEN
			INSERT (
				FacilityID
				,[Facility]
				,[Limit]
				)
			VALUES (
				src.FacilityID
				,src.FacilityName
				,src.FacilityCount
				);

	--WeaponLimit
	SELECT wl.WeaponRarity
		,wl.UnbindLimit0
		,wl.UnbindLimit1
		,wl.UnbindLimit2
		,wl.LevelLimit0
		,wl.LevelLimit1
		,wl.LevelLimit2
		,wl.LevelLimit3
		,wl.LevelLimit4
		,wl.LevelLimit5
		,wl.LevelLimit6
		,wl.LevelLimit7
		,wl.LevelLimit8
		,wl.LevelLimit9
	INTO #WeaponLimit
	FROM jsn.TableJson AS wlj
	CROSS APPLY OPENJSON(wlj.JsonText) WITH (cargoquery NVARCHAR(MAX) AS JSON) AS cq
	CROSS APPLY OPENJSON(cq.cargoquery) WITH (
			WeaponRarity INT '$.title.Id'
			,UnbindLimit0 INT '$.title.MaxLimitBreakCountByLimitOver0'
			,UnbindLimit1 INT '$.title.MaxLimitBreakCountByLimitOver1'
			,UnbindLimit2 INT '$.title.MaxLimitBreakCountByLimitOver2'
			,LevelLimit0 INT '$.title.MaxLimitLevelByLimitBreak0'
			,LevelLimit1 INT '$.title.MaxLimitLevelByLimitBreak1'
			,LevelLimit2 INT '$.title.MaxLimitLevelByLimitBreak2'
			,LevelLimit3 INT '$.title.MaxLimitLevelByLimitBreak3'
			,LevelLimit4 INT '$.title.MaxLimitLevelByLimitBreak4'
			,LevelLimit5 INT '$.title.MaxLimitLevelByLimitBreak5'
			,LevelLimit6 INT '$.title.MaxLimitLevelByLimitBreak6'
			,LevelLimit7 INT '$.title.MaxLimitLevelByLimitBreak7'
			,LevelLimit8 INT '$.title.MaxLimitLevelByLimitBreak8'
			,LevelLimit9 INT '$.title.MaxLimitLevelByLimitBreak9'
			) AS wl
	WHERE wlj.TableName = 'WeaponLimit'

	--WeaponUnbindLimit
	MERGE core.WeaponUnbindLimit AS trg
	USING (
		SELECT upvt.WeaponRarity
			,upvt.MaxUnbindLevel
			,REPLACE(upvt.RefinementLevel, 'UnbindLimit', '') AS RefinementLevel
		FROM #WeaponLimit AS src
		UNPIVOT(MaxUnbindLevel FOR RefinementLevel IN (
					UnbindLimit0
					,UnbindLimit1
					,UnbindLimit2
					)) AS upvt
		WHERE upvt.MaxUnbindLevel > 0
		) AS src
		ON src.WeaponRarity = trg.WeaponRarity
			AND src.RefinementLevel = trg.RefinementLevel
	WHEN MATCHED
		THEN
			UPDATE
			SET MaxUnbindLevel = src.MaxUnbindLevel
	WHEN NOT MATCHED BY SOURCE
		THEN
			DELETE
	WHEN NOT MATCHED
		THEN
			INSERT (
				WeaponRarity
				,RefinementLevel
				,MaxUnbindLevel
				)
			VALUES (
				src.WeaponRarity
				,src.RefinementLevel
				,src.MaxUnbindLevel
				);

	--WeaponLevelLimit
	MERGE core.WeaponLevelLimit AS trg
	USING (
		SELECT upvt.WeaponRarity
			,upvt.MaxWeaponLevel
			,REPLACE(upvt.UnbindLevel, 'LevelLimit', '') AS UnbindLevel
		FROM #WeaponLimit AS src
		UNPIVOT(MaxWeaponLevel FOR UnbindLevel IN (
					LevelLimit0
					,LevelLimit1
					,LevelLimit2
					,LevelLimit3
					,LevelLimit4
					,LevelLimit5
					,LevelLimit6
					,LevelLimit7
					,LevelLimit8
					,LevelLimit9
					)) AS upvt
		WHERE upvt.MaxWeaponLevel > 0
		) AS src
		ON src.WeaponRarity = trg.WeaponRarity
			AND src.UnbindLevel = trg.UnbindLevel
	WHEN MATCHED
		THEN
			UPDATE
			SET MaxWeaponLevel = src.MaxWeaponLevel
	WHEN NOT MATCHED BY SOURCE
		THEN
			DELETE
	WHEN NOT MATCHED
		THEN
			INSERT (
				WeaponRarity
				,UnbindLevel
				,MaxWeaponLevel
				)
			VALUES (
				src.WeaponRarity
				,src.UnbindLevel
				,src.MaxWeaponLevel
				);
END
