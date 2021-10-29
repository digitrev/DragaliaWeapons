CREATE PROCEDURE [jsn].[spLoadCore]
AS
BEGIN
	SET NOCOUNT ON

	IF OBJECT_ID('tempdb..#Passive') IS NOT NULL
		DROP TABLE #Passive

	IF OBJECT_ID('tempdb..#Weapon') IS NOT NULL
		DROP TABLE #Weapon

	IF OBJECT_ID('tempdb..#WeaponUpgrade') IS NOT NULL
		DROP TABLE #WeaponUpgrade

	IF OBJECT_ID('tempdb..#WeaponLevel') IS NOT NULL
		DROP TABLE #WeaponLevel

	IF OBJECT_ID('tempdb..#WeaponLimit') IS NOT NULL
		DROP TABLE #WeaponLimit

	IF OBJECT_ID('tempdb..#Wyrmprint') IS NOT NULL
		DROP TABLE #Wyrmprint

	IF OBJECT_ID('tempdb..#WyrmprintUpgrade') IS NOT NULL
		DROP TABLE #WyrmprintUpgrade

	IF OBJECT_ID('tempdb..#WyrmprintLevel') IS NOT NULL
		DROP TABLE #WyrmprintLevel

	IF OBJECT_ID('tempdb..#WyrmprintLimit') IS NOT NULL
		DROP TABLE #WyrmprintLimit

	IF OBJECT_ID('tempdb..#AdventurerMC') IS NOT NULL
		DROP TABLE #AdventurerMC

	IF OBJECT_ID('tempdb..#MCNodes') IS NOT NULL
		DROP TABLE #MCNodes

	IF OBJECT_ID('tempdb..#ManaPieceRaw') IS NOT NULL
		DROP TABLE #ManaPieceRaw

	IF OBJECT_ID('tempdb..#ManaPieceMaterial') IS NOT NULL
		DROP TABLE #ManaPieceMaterial

	IF OBJECT_ID('tempdb..#ManaPieceEldwater') IS NOT NULL
		DROP TABLE #ManaPieceEldwater

	IF OBJECT_ID('tempdb..#MCUnbind') IS NOT NULL
		DROP TABLE #MCUnbind

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
				,Active = 1
	WHEN NOT MATCHED BY SOURCE
		THEN
			UPDATE
			SET Active = 0
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
				,Active = 1
	WHEN NOT MATCHED BY SOURCE
		THEN
			UPDATE
			SET Active = 0
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
				,Active = 1
	WHEN NOT MATCHED BY SOURCE
		THEN
			UPDATE
			SET Active = 0
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
			,REPLACE(m.MaterialName, '&amp;', '&') AS MaterialName
		FROM jsn.TableJson AS mj
		CROSS APPLY OPENJSON(mj.JsonText) WITH (cargoquery NVARCHAR(MAX) AS JSON) AS cq
		CROSS APPLY OPENJSON(cq.cargoquery) WITH (
				MaterialID NVARCHAR(50) '$.title.Id'
				,MaterialName NVARCHAR(50) '$.title.Name'
				) AS m
		WHERE mj.TableName = 'Material'
		
		UNION
		
		--Hard coded because Gamepedia doesn't track rupies as a separate material
		SELECT 'Rupie'
			,'Rupies'
		
		UNION
		
		--Hard coded because Gamepedia doesn't track eldwater as a separate material
		SELECT 'Eldwater'
			,'Eldwater'
		
		UNION
		
		--Hard coded because Gamepedia doesn't track mana as a separate material
		SELECT 'Mana'
			,'Mana'
		) AS src
		ON src.MaterialID = trg.MaterialID
	WHEN MATCHED
		THEN
			UPDATE
			SET [Material] = src.MaterialName
				,Active = 1
	WHEN NOT MATCHED BY SOURCE
		THEN
			UPDATE
			SET Active = 0
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
				,Active = 1
	WHEN NOT MATCHED BY SOURCE
		THEN
			UPDATE
			SET Active = 0
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

	MERGE [wpn].WeaponSeries AS trg
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
				,Active = 1
	WHEN NOT MATCHED BY SOURCE
		THEN
			UPDATE
			SET Active = 0
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
	INNER JOIN [wpn].WeaponSeries AS ws ON ws.WeaponSeries = src.WeaponSeries

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
				,Active = 1
	WHEN NOT MATCHED BY SOURCE
		THEN
			UPDATE
			SET Active = 0
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
	MERGE [wpn].Weapon AS trg
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
				,Active = 1
	WHEN NOT MATCHED BY SOURCE
		THEN
			UPDATE
			SET Active = 0
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
	TRUNCATE TABLE [wpn].WeaponCrafting

	INSERT [wpn].WeaponCrafting (
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
	WHERE wc.MaterialQuantity > 0

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
		ON src.UpgradeTypeID = trg.UpgradeTypeID
	WHEN MATCHED
		THEN
			UPDATE
			SET [UpgradeType] = src.UpgradeType
				,Active = 1
	WHEN NOT MATCHED BY SOURCE
		THEN
			UPDATE
			SET Active = 0
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

	TRUNCATE TABLE [wpn].WeaponUpgrade

	INSERT [wpn].WeaponUpgrade (
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
	WHERE wu.Quantity > 0

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

	MERGE [wpn].Passive AS trg
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
				,Active = 1
	WHEN NOT MATCHED BY SOURCE
		THEN
			UPDATE
			SET Active = 0
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
	TRUNCATE TABLE [wpn].PassiveCrafting

	INSERT [wpn].PassiveCrafting (
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
	WHERE pc.Quantity > 0

	--Weapon leveling
	SELECT wl.Rarity
		,wl.WeaponLevel
		,wl.BuildupMaterialId1
		,wl.BuildupMaterialQuantity1
		,wl.BuildupMaterialId2
		,wl.BuildupMaterialQuantity2
		,wl.BuildupMaterialId3
		,wl.BuildupMaterialQuantity3
	INTO #WeaponLevel
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

	TRUNCATE TABLE [wpn].WeaponLevel

	INSERT [wpn].WeaponLevel (
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
		FROM #WeaponLevel
		
		UNION ALL
		
		SELECT Rarity
			,WeaponLevel
			,BuildupMaterialId2
			,BuildupMaterialQuantity2
		FROM #WeaponLevel
		
		UNION ALL
		
		SELECT Rarity
			,WeaponLevel
			,BuildupMaterialId3
			,BuildupMaterialQuantity3
		FROM #WeaponLevel
		) AS l
	INNER JOIN core.Material AS m ON m.MaterialID = l.MaterialID
	WHERE l.Quantity > 0

	--Facilities
	MERGE [fac].Facility AS trg
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
				,Active = 1
	WHEN NOT MATCHED BY SOURCE
		THEN
			UPDATE
			SET Active = 0
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
	TRUNCATE TABLE [wpn].WeaponUnbindLimit

	INSERT [wpn].WeaponUnbindLimit (
		WeaponRarity
		,RefinementLevel
		,MaxUnbindLevel
		)
	SELECT upvt.WeaponRarity
		,REPLACE(upvt.RefinementLevel, 'UnbindLimit', '') AS RefinementLevel
		,upvt.MaxUnbindLevel
	FROM #WeaponLimit AS src
	UNPIVOT(MaxUnbindLevel FOR RefinementLevel IN (
				UnbindLimit0
				,UnbindLimit1
				,UnbindLimit2
				)) AS upvt
	WHERE upvt.MaxUnbindLevel > 0

	--WeaponLevelLimit
	TRUNCATE TABLE [wpn].WeaponLevelLimit

	INSERT [wpn].WeaponLevelLimit (
		WeaponRarity
		,UnbindLevel
		,MaxWeaponLevel
		)
	SELECT upvt.WeaponRarity
		,REPLACE(upvt.UnbindLevel, 'LevelLimit', '') AS UnbindLevel
		,upvt.MaxWeaponLevel
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

	--Wyrmprint
	SELECT w.WyrmprintID
		,REPLACE(w.Wyrmprint, '&quot;', '"') AS Wyrmprint
		,w.Rarity
		,w.RarityGroup
		,w.AbilityID11
		,w.AbilityID12
		,w.AbilityID13
		,w.AbilityID21
		,w.AbilityID22
		,w.AbilityID23
		,w.AffinityID
		,w.GroupID
		,w.UniqueMaterialID
	INTO #Wyrmprint
	FROM jsn.TableJson AS wj
	CROSS APPLY OPENJSON(wj.JsonText) WITH (cargoquery NVARCHAR(max) AS json) AS cq
	CROSS APPLY OPENJSON(cq.cargoquery) WITH (
			WyrmprintID INT '$.title.Id'
			,Wyrmprint NVARCHAR(50) '$.title.Name'
			,Rarity INT '$.title.Rarity'
			,RarityGroup INT '$.title.RarityGroup'
			,AbilityID11 INT '$.title.Abilities11'
			,AbilityID12 INT '$.title.Abilities12'
			,AbilityID13 INT '$.title.Abilities13'
			,AbilityID21 INT '$.title.Abilities21'
			,AbilityID22 INT '$.title.Abilities22'
			,AbilityID23 INT '$.title.Abilities23'
			,AffinityID INT '$.title.UnionAbilityGroupId'
			,GroupID INT '$.title.AbilityCrestBuildupGroupId'
			,UniqueMaterialID NVARCHAR(50) '$.title.UniqueBuildupMaterialId'
			) AS w
	WHERE wj.TableName = 'Wyrmprint'

	MERGE [wpt].Wyrmprint AS trg
	USING (
		SELECT DISTINCT WyrmprintID
			,REPLACE(Wyrmprint, '&amp;', '&') AS Wyrmprint
			,Rarity
			,RarityGroup
			,NULLIF(AffinityID, 0) AS AffinityID
		FROM #Wyrmprint
		) AS src
		ON src.WyrmprintID = trg.WyrmprintID
	WHEN MATCHED
		THEN
			UPDATE
			SET Wyrmprint = src.Wyrmprint
				,Rarity = src.Rarity
				,RarityGroup = src.RarityGroup
				,AffinityID = src.AffinityID
				,Active = 1
	WHEN NOT MATCHED BY SOURCE
		THEN
			UPDATE
			SET Active = 0
	WHEN NOT MATCHED
		THEN
			INSERT (
				WyrmprintID
				,Wyrmprint
				,Rarity
				,RarityGroup
				,AffinityID
				)
			VALUES (
				src.WyrmprintID
				,src.Wyrmprint
				,src.Rarity
				,src.RarityGroup
				,src.AffinityID
				);

	--WyrmprintAbility
	TRUNCATE TABLE [wpt].WyrmprintAbility

	INSERT [wpt].WyrmprintAbility (
		WyrmprintID
		,AbilityID
		,AbilitySlot
		,AbilityLevel
		)
	SELECT wa.WyrmprintID
		,wa.AbilityID
		,wa.AbilitySlot
		,wa.AbilityLevel
	FROM (
		SELECT WyrmprintID
			,AbilityID11 AS AbilityID
			,1 AS AbilitySlot
			,1 AS AbilityLevel
		FROM #Wyrmprint
		
		UNION ALL
		
		SELECT WyrmprintID
			,AbilityID12
			,1
			,2
		FROM #Wyrmprint
		
		UNION ALL
		
		SELECT WyrmprintID
			,AbilityID13
			,1
			,3
		FROM #Wyrmprint
		
		UNION ALL
		
		SELECT WyrmprintID
			,AbilityID21
			,2
			,1
		FROM #Wyrmprint
		
		UNION ALL
		
		SELECT WyrmprintID
			,AbilityID22
			,2
			,2
		FROM #Wyrmprint
		
		UNION ALL
		
		SELECT WyrmprintID
			,AbilityID23
			,2
			,3
		FROM #Wyrmprint
		) AS wa
	INNER JOIN core.Ability AS a ON a.AbilityID = wa.AbilityID

	--WyrmprintUpgrade
	SELECT w.WyrmprintID
		,wu.UpgradeTypeID
		,wu.Step
		,wu.Eldwater
		,wu.MaterialID1
		,wu.Quantity1
		,wu.MaterialID2
		,wu.Quantity2
		,wu.MaterialID3
		,wu.Quantity3
		,w.UniqueMaterialID
		,wu.UniqueQuantity
	INTO #WyrmprintUpgrade
	FROM jsn.TableJson AS wuj
	CROSS APPLY OPENJSON(wuj.JsonText) WITH (cargoquery NVARCHAR(MAX) AS JSON) AS cq
	CROSS APPLY OPENJSON(cq.cargoquery) WITH (
			Id INT '$.title.Id'
			,GroupID INT '$.title.AbilityCrestBuildupGroupId'
			,UpgradeTypeID INT '$.title.BuildupPieceTypeId'
			,Step INT '$.title.Step'
			,Eldwater INT '$.title.BuildupDewPoint'
			,MaterialID1 NVARCHAR(50) '$.title.BuildupMaterialId1'
			,Quantity1 INT '$.title.BuildupMaterialQuantity1'
			,MaterialID2 NVARCHAR(50) '$.title.BuildupMaterialId2'
			,Quantity2 INT '$.title.BuildupMaterialQuantity2'
			,MaterialID3 NVARCHAR(50) '$.title.BuildupMaterialId3'
			,Quantity3 INT '$.title.BuildupMaterialQuantity3'
			,UniqueQuantity INT '$.title.UniqueBuildupMaterialCount'
			) AS wu
	INNER JOIN #Wyrmprint AS w ON w.GroupID = wu.GroupID
	WHERE wuj.TableName = 'WyrmprintUpgrade'

	TRUNCATE TABLE [wpt].WyrmprintUpgrade

	INSERT [wpt].WyrmprintUpgrade (
		WyrmprintID
		,UpgradeTypeID
		,Step
		,MaterialID
		,Quantity
		)
	SELECT wu.WyrmprintID
		,wu.UpgradeTypeID
		,wu.Step
		,wu.MaterialID
		,wu.Quantity
	FROM (
		SELECT WyrmprintID
			,UpgradeTypeID
			,Step
			,MaterialID1 AS MaterialID
			,Quantity1 AS Quantity
		FROM #WyrmprintUpgrade
		
		UNION
		
		SELECT WyrmprintID
			,UpgradeTypeID
			,Step
			,MaterialID2
			,Quantity2
		FROM #WyrmprintUpgrade
		
		UNION
		
		SELECT WyrmprintID
			,UpgradeTypeID
			,Step
			,MaterialID3
			,Quantity3
		FROM #WyrmprintUpgrade
		
		UNION
		
		SELECT WyrmprintID
			,UpgradeTypeID
			,Step
			,UniqueMaterialID
			,UniqueQuantity
		FROM #WyrmprintUpgrade
		
		UNION
		
		SELECT WyrmprintID
			,UpgradeTypeID
			,Step
			,'Eldwater'
			,Eldwater
		FROM #WyrmprintUpgrade
		) AS wu
	INNER JOIN core.Material AS m ON m.MaterialID = wu.MaterialID
	WHERE wu.Quantity > 0

	--WyrmprintLevel
	SELECT w.WyrmprintID
		,wl.WyrmprintLevel
		,wl.MaterialID1
		,wl.Quantity1
		,wl.MaterialID2
		,wl.Quantity2
		,wl.MaterialID3
		,wl.Quantity3
		,w.UniqueMaterialID
		,wl.UniqueQuantity
	INTO #WyrmprintLevel
	FROM jsn.TableJson AS wlj
	CROSS APPLY OPENJSON(wlj.JsonText) WITH (cargoquery NVARCHAR(MAX) AS JSON) AS cq
	CROSS APPLY OPENJSON(cq.cargoquery) WITH (
			Rarity INT '$.title.RarityGroup'
			,WyrmprintLevel INT '$.title.Level'
			,MaterialID1 NVARCHAR(50) '$.title.BuildupMaterialId1'
			,Quantity1 INT '$.title.BuildupMaterialQuantity1'
			,MaterialID2 NVARCHAR(50) '$.title.BuildupMaterialId2'
			,Quantity2 INT '$.title.BuildupMaterialQuantity2'
			,MaterialID3 NVARCHAR(50) '$.title.BuildupMaterialId3'
			,Quantity3 INT '$.title.BuildupMaterialQuantity3'
			,UniqueQuantity NVARCHAR(50) '$.title.UniqueBuildupMaterialCount'
			) AS wl
	INNER JOIN #Wyrmprint AS w ON w.RarityGroup = wl.Rarity
	WHERE wlj.TableName = 'WyrmprintLevel'

	TRUNCATE TABLE [wpt].WyrmprintLevel

	INSERT [wpt].WyrmprintLevel (
		WyrmprintID
		,WyrmprintLevel
		,MaterialID
		,Quantity
		)
	SELECT wl.WyrmprintID
		,wl.WyrmprintLevel
		,wl.MaterialID
		,wl.Quantity
	FROM (
		SELECT WyrmprintID
			,WyrmprintLevel
			,MaterialID1 AS MaterialID
			,Quantity1 AS Quantity
		FROM #WyrmprintLevel
		
		UNION
		
		SELECT WyrmprintID
			,WyrmprintLevel
			,MaterialID2
			,Quantity2
		FROM #WyrmprintLevel
		
		UNION
		
		SELECT WyrmprintID
			,WyrmprintLevel
			,MaterialID3
			,Quantity3
		FROM #WyrmprintLevel
		
		UNION
		
		SELECT WyrmprintID
			,WyrmprintLevel
			,UniqueMaterialID
			,UniqueQuantity
		FROM #WyrmprintLevel
		) AS wl
	INNER JOIN core.Material AS m ON m.MaterialID = wl.MaterialID
	WHERE wl.Quantity > 0

	--WyrmprintLevelLimit
	SELECT wl.WyrmprintRarity
		,wl.LevelLimit0
		,wl.LevelLimit1
		,wl.LevelLimit2
		,wl.LevelLimit3
		,wl.LevelLimit4
	INTO #WyrmprintLimit
	FROM jsn.TableJson AS wlj
	CROSS APPLY OPENJSON(wlj.JsonText) WITH (cargoquery NVARCHAR(MAX) AS JSON) AS cq
	CROSS APPLY OPENJSON(cq.cargoquery) WITH (
			WyrmprintRarity INT '$.title.Id'
			,LevelLimit0 INT '$.title.MaxLimitLevelByLimitBreak0'
			,LevelLimit1 INT '$.title.MaxLimitLevelByLimitBreak1'
			,LevelLimit2 INT '$.title.MaxLimitLevelByLimitBreak2'
			,LevelLimit3 INT '$.title.MaxLimitLevelByLimitBreak3'
			,LevelLimit4 INT '$.title.MaxLimitLevelByLimitBreak4'
			) AS wl
	WHERE wlj.TableName = 'WyrmprintLimit'

	TRUNCATE TABLE [wpt].WyrmprintLevelLimit

	INSERT [wpt].WyrmprintLevelLimit (
		WyrmprintRarity
		,UnbindLevel
		,MaxWyrmprintLevel
		)
	SELECT upvt.WyrmprintRarity
		,REPLACE(upvt.UnbindLevel, 'LevelLimit', '') AS UnbindLevel
		,upvt.MaxWyrmprintLevel
	FROM #WyrmprintLimit AS src
	UNPIVOT(MaxWyrmprintLevel FOR UnbindLevel IN (
				LevelLimit0
				,LevelLimit1
				,LevelLimit2
				,LevelLimit3
				,LevelLimit4
				)) AS upvt
	WHERE upvt.MaxWyrmprintLevel > 0

	--Adventurer data
	MERGE [adv].Adventurer AS trg
	USING (
		SELECT a.AdventurerID
			,a.VariationID
			,a.Adventurer
			,a.Rarity
			,a.ElementID
			,a.WeaponTypeID
			,CASE a.MaxLimitBreakCount
				WHEN 4
					THEN 50
				WHEN 5
					THEN 70
				ELSE 0
				END AS MCLimit
		FROM jsn.TableJson AS aj
		CROSS APPLY OPENJSON(aj.JsonText) WITH (cargoquery NVARCHAR(MAX) AS JSON) AS cq
		CROSS APPLY OPENJSON(cq.cargoquery) WITH (
				AdventurerID INT '$.title.IdLong'
				,VariationID INT '$.title.VariationId'
				,Adventurer NVARCHAR(50) '$.title.FullName'
				,Rarity INT '$.title.Rarity'
				,ElementID INT '$.title.ElementalTypeId'
				,WeaponTypeID INT '$.title.WeaponTypeId'
				,MaxLimitBreakCount INT '$.title.MaxLimitBreakCount'
				) AS a
		WHERE aj.TableName = 'Adventurer'
		) AS src
		ON src.AdventurerID = trg.AdventurerID
	WHEN MATCHED
		THEN
			UPDATE
			SET Adventurer = src.Adventurer
				,Rarity = src.Rarity
				,ElementID = src.ElementID
				,WeaponTypeID = src.WeaponTypeID
				,MCLimit = src.MCLimit
				,Active = 1
	WHEN NOT MATCHED BY SOURCE
		THEN
			UPDATE
			SET Active = 0
	WHEN NOT MATCHED
		THEN
			INSERT (
				AdventurerID
				,Adventurer
				,Rarity
				,ElementID
				,WeaponTypeID
				,MCLimit
				,Active
				)
			VALUES (
				src.AdventurerID
				,src.Adventurer
				,src.Rarity
				,src.ElementID
				,src.WeaponTypeID
				,src.MCLimit
				,1
				);

	--Mana circles (lots of it)
	SELECT a.AdventurerID
		,CAST(REPLACE(a.ManaCircleName, 'MC_', '') AS INT) AS MCID
		,a.UnbindID
		,a.PieceMaterialElementId
		,a.UniqueGrowMaterialId1
		,a.UniqueGrowMaterialId2
	INTO #AdventurerMC
	FROM jsn.TableJson AS aj
	CROSS APPLY OPENJSON(aj.JsonText) WITH (cargoquery NVARCHAR(MAX) AS JSON) AS cq
	CROSS APPLY OPENJSON(cq.cargoquery) WITH (
			AdventurerID INT '$.title.IdLong'
			,ManaCircleName NVARCHAR(50) '$.title.ManaCircleName'
			,UnbindID NVARCHAR(50) '$.title.CharaLimitBreakId'
			,PieceMaterialElementId INT '$.title.PieceMaterialElementId'
			,UniqueGrowMaterialId1 NVARCHAR(50) '$.title.UniqueGrowMaterialId1'
			,UniqueGrowMaterialId2 NVARCHAR(50) '$.title.UniqueGrowMaterialId2'
			) AS a
	WHERE aj.TableName = 'Adventurer'

	SELECT MCID
		,ManaNode
		,ManaPieceType
		,ManaCost
		,UniqueGrowMaterialCount1
		,UniqueGrowMaterialCount2
		,Stage = ROW_NUMBER() OVER (
			PARTITION BY MCID
			,ManaPieceType ORDER BY ManaNode
			)
	INTO #MCNodes
	FROM (
		SELECT CAST(REPLACE(m.ManaCircleName, 'MC_', '') AS INT) AS MCID
			,m.ManaNode
			,m.ManaPieceType
			,m.ManaCost
			,m.UniqueGrowMaterialCount1
			,m.UniqueGrowMaterialCount2
		FROM jsn.TableJson AS mj
		CROSS APPLY OPENJSON(mj.JsonText) WITH (cargoquery NVARCHAR(MAX) AS JSON) AS cq
		CROSS APPLY OPENJSON(cq.cargoquery) WITH (
				ManaCircleName NVARCHAR(50) '$.title.MC'
				,ManaNode INT '$.title.Id'
				,ManaPieceType INT '$.title.ManaPieceType'
				,ManaCost INT '$.title.NecessaryManaPoint'
				,UniqueGrowMaterialCount1 INT '$.title.UniqueGrowMaterialCount1'
				,UniqueGrowMaterialCount2 INT '$.title.UniqueGrowMaterialCount2'
				) AS m
		WHERE mj.TableName = 'MCNodes'
		) AS d

	SELECT m.PieceMaterialElementId
		,m.Step
		,m.ManaPieceType
		,m.MaterialId1
		,m.MaterialId2
		,m.MaterialId3
		,m.MaterialQuantity1
		,m.MaterialQuantity2
		,m.MaterialQuantity3
		,m.DewPoint
	INTO #ManaPieceRaw
	FROM jsn.TableJson AS mj
	CROSS APPLY OPENJSON(mj.JsonText) WITH (cargoquery NVARCHAR(MAX) AS JSON) AS cq
	CROSS APPLY OPENJSON(cq.cargoquery) WITH (
			PieceMaterialElementId INT '$.title.ElementId'
			,Step INT '$.title.Step'
			,ManaPieceType INT '$.title.ManaPieceType'
			,MaterialId1 NVARCHAR(50) '$.title.MaterialId1'
			,MaterialId2 NVARCHAR(50) '$.title.MaterialId2'
			,MaterialId3 NVARCHAR(50) '$.title.MaterialId3'
			,MaterialQuantity1 INT '$.title.MaterialQuantity1'
			,MaterialQuantity2 INT '$.title.MaterialQuantity2'
			,MaterialQuantity3 INT '$.title.MaterialQuantity3'
			,DewPoint INT '$.title.DewPoint'
			) AS m
	WHERE mj.TableName = 'ManaPieceMaterial'

	SELECT PieceMaterialElementId
		,ManaPieceType
		,MaterialId1 AS MaterialID
		,MaterialQuantity1 AS Quantity
		,Step AS Stage
	INTO #ManaPieceMaterial
	FROM #ManaPieceRaw
	WHERE MaterialId1 <> '0'
	
	UNION ALL
	
	SELECT PieceMaterialElementId
		,ManaPieceType
		,MaterialId2
		,MaterialQuantity2
		,Step
	FROM #ManaPieceRaw
	WHERE MaterialId2 <> '0'
	
	UNION ALL
	
	SELECT PieceMaterialElementId
		,ManaPieceType
		,MaterialId3
		,MaterialQuantity3
		,Step
	FROM #ManaPieceRaw
	WHERE MaterialId3 <> '0'

	SELECT PieceMaterialElementId
		,ManaPieceType
		,Step AS Stage
		,DewPoint AS Eldwater
	INTO #ManaPieceEldwater
	FROM #ManaPieceRaw AS mpr
	WHERE DewPoint <> 0

	TRUNCATE TABLE [adv].ManaCircle

	INSERT [adv].ManaCircle (
		AdventurerID
		,ManaNode
		,MaterialID
		,Quantity
		)
	--basic mana cost
	SELECT a.AdventurerID
		,mc.ManaNode
		,'Mana'
		,mc.ManaCost
	FROM [adv].Adventurer AS a
	INNER JOIN #AdventurerMC AS amc ON amc.AdventurerID = a.AdventurerID
	INNER JOIN #MCNodes AS mc ON mc.MCID = amc.MCID
	WHERE mc.ManaCost > 0
	
	UNION ALL
	
	--devotions 
	SELECT a.AdventurerID
		,mc.ManaNode
		,amc.UniqueGrowMaterialId1
		,mc.UniqueGrowMaterialCount1
	FROM [adv].Adventurer AS a
	INNER JOIN #AdventurerMC AS amc ON amc.AdventurerID = a.AdventurerID
	INNER JOIN #MCNodes AS mc ON mc.MCID = amc.MCID
	WHERE mc.UniqueGrowMaterialCount1 > 0
	
	UNION ALL
	
	-- convictions 
	SELECT a.AdventurerID
		,mc.ManaNode
		,amc.UniqueGrowMaterialId2
		,mc.UniqueGrowMaterialCount2
	FROM [adv].Adventurer AS a
	INNER JOIN #AdventurerMC AS amc ON amc.AdventurerID = a.AdventurerID
	INNER JOIN #MCNodes AS mc ON mc.MCID = amc.MCID
	WHERE mc.UniqueGrowMaterialCount2 > 0
	
	UNION ALL
	
	--eldwater cost
	SELECT a.AdventurerID
		,mc.ManaNode
		,'Eldwater'
		,mpe.Eldwater
	FROM [adv].Adventurer AS a
	INNER JOIN #AdventurerMC AS amc ON amc.AdventurerID = a.AdventurerID
	INNER JOIN #MCNodes AS mc ON mc.MCID = amc.MCID
	INNER JOIN #ManaPieceEldwater AS mpe ON mpe.PieceMaterialElementId = amc.PieceMaterialElementId
		AND mpe.ManaPieceType = mc.ManaPieceType
		AND mpe.Stage = mc.Stage
	WHERE mpe.Eldwater > 0
	
	UNION ALL
	
	--other costs
	SELECT a.AdventurerID
		,mc.ManaNode
		,mpm.MaterialID
		,mpm.Quantity
	FROM [adv].Adventurer AS a
	INNER JOIN core.Element AS e ON e.ElementID = a.ElementID
	INNER JOIN #AdventurerMC AS amc ON amc.AdventurerID = a.AdventurerID
	INNER JOIN #MCNodes AS mc ON mc.MCID = amc.MCID
	INNER JOIN #ManaPieceMaterial AS mpm ON mpm.PieceMaterialElementId = amc.PieceMaterialElementId
		AND mpm.ManaPieceType = mc.ManaPieceType
		AND mpm.Stage = mc.Stage
	WHERE mpm.Quantity > 0

	--3 & 4⭐ unbinds
	INSERT [adv].ManaCircle (
		AdventurerID
		,ManaNode
		,MaterialID
		,Quantity
		)
	SELECT a.AdventurerID
		,31
		,'Eldwater'
		,2500
	FROM [adv].Adventurer AS a
	WHERE a.Rarity = 3
	
	UNION ALL
	
	SELECT a.AdventurerID
		,41
		,'Eldwater'
		,25000
	FROM [adv].Adventurer AS a
	WHERE a.Rarity IN (
			3
			,4
			)

	SELECT c.UnbindID
		,c.OrbData1Id1
		,c.OrbData2Id1
		,c.OrbData3Id1
		,c.OrbData4Id1
		,c.OrbData5Id1
		,c.OrbData1Num1
		,c.OrbData2Num1
		,c.OrbData3Num1
		,c.OrbData4Num1
		,c.OrbData5Num1
		,c.OrbData1Id2
		,c.OrbData2Id2
		,c.OrbData3Id2
		,c.OrbData4Id2
		,c.OrbData5Id2
		,c.OrbData1Num2
		,c.OrbData2Num2
		,c.OrbData3Num2
		,c.OrbData4Num2
		,c.OrbData5Num2
		,c.OrbData1Id3
		,c.OrbData2Id3
		,c.OrbData3Id3
		,c.OrbData4Id3
		,c.OrbData5Id3
		,c.OrbData1Num3
		,c.OrbData2Num3
		,c.OrbData3Num3
		,c.OrbData4Num3
		,c.OrbData5Num3
		,c.OrbData1Id4
		,c.OrbData2Id4
		,c.OrbData3Id4
		,c.OrbData4Id4
		,c.OrbData5Id4
		,c.OrbData1Num4
		,c.OrbData2Num4
		,c.OrbData3Num4
		,c.OrbData4Num4
		,c.OrbData5Num4
		,c.OrbData1Id5
		,c.OrbData2Id5
		,c.OrbData3Id5
		,c.OrbData4Id5
		,c.OrbData5Id5
		,c.OrbData1Num5
		,c.OrbData2Num5
		,c.OrbData3Num5
		,c.OrbData4Num5
		,c.OrbData5Num5
	INTO #MCUnbind
	FROM jsn.TableJson AS cj
	CROSS APPLY OPENJSON(cj.JsonText) WITH (cargoquery NVARCHAR(MAX) AS JSON) AS cq
	CROSS APPLY OPENJSON(cq.cargoquery) WITH (
			UnbindID INT '$.title.Id'
			,OrbData1Id1 NVARCHAR(50) '$.title.OrbData1Id1'
			,OrbData2Id1 NVARCHAR(50) '$.title.OrbData2Id1'
			,OrbData3Id1 NVARCHAR(50) '$.title.OrbData3Id1'
			,OrbData4Id1 NVARCHAR(50) '$.title.OrbData4Id1'
			,OrbData5Id1 NVARCHAR(50) '$.title.OrbData5Id1'
			,OrbData1Num1 INT '$.title.OrbData1Num1'
			,OrbData2Num1 INT '$.title.OrbData2Num1'
			,OrbData3Num1 INT '$.title.OrbData3Num1'
			,OrbData4Num1 INT '$.title.OrbData4Num1'
			,OrbData5Num1 INT '$.title.OrbData5Num1'
			,OrbData1Id2 NVARCHAR(50) '$.title.OrbData1Id2'
			,OrbData2Id2 NVARCHAR(50) '$.title.OrbData2Id2'
			,OrbData3Id2 NVARCHAR(50) '$.title.OrbData3Id2'
			,OrbData4Id2 NVARCHAR(50) '$.title.OrbData4Id2'
			,OrbData5Id2 NVARCHAR(50) '$.title.OrbData5Id2'
			,OrbData1Num2 INT '$.title.OrbData1Num2'
			,OrbData2Num2 INT '$.title.OrbData2Num2'
			,OrbData3Num2 INT '$.title.OrbData3Num2'
			,OrbData4Num2 INT '$.title.OrbData4Num2'
			,OrbData5Num2 INT '$.title.OrbData5Num2'
			,OrbData1Id3 NVARCHAR(50) '$.title.OrbData1Id3'
			,OrbData2Id3 NVARCHAR(50) '$.title.OrbData2Id3'
			,OrbData3Id3 NVARCHAR(50) '$.title.OrbData3Id3'
			,OrbData4Id3 NVARCHAR(50) '$.title.OrbData4Id3'
			,OrbData5Id3 NVARCHAR(50) '$.title.OrbData5Id3'
			,OrbData1Num3 INT '$.title.OrbData1Num3'
			,OrbData2Num3 INT '$.title.OrbData2Num3'
			,OrbData3Num3 INT '$.title.OrbData3Num3'
			,OrbData4Num3 INT '$.title.OrbData4Num3'
			,OrbData5Num3 INT '$.title.OrbData5Num3'
			,OrbData1Id4 NVARCHAR(50) '$.title.OrbData1Id4'
			,OrbData2Id4 NVARCHAR(50) '$.title.OrbData2Id4'
			,OrbData3Id4 NVARCHAR(50) '$.title.OrbData3Id4'
			,OrbData4Id4 NVARCHAR(50) '$.title.OrbData4Id4'
			,OrbData5Id4 NVARCHAR(50) '$.title.OrbData5Id4'
			,OrbData1Num4 INT '$.title.OrbData1Num4'
			,OrbData2Num4 INT '$.title.OrbData2Num4'
			,OrbData3Num4 INT '$.title.OrbData3Num4'
			,OrbData4Num4 INT '$.title.OrbData4Num4'
			,OrbData5Num4 INT '$.title.OrbData5Num4'
			,OrbData1Id5 NVARCHAR(50) '$.title.OrbData1Id5'
			,OrbData2Id5 NVARCHAR(50) '$.title.OrbData2Id5'
			,OrbData3Id5 NVARCHAR(50) '$.title.OrbData3Id5'
			,OrbData4Id5 NVARCHAR(50) '$.title.OrbData4Id5'
			,OrbData5Id5 NVARCHAR(50) '$.title.OrbData5Id5'
			,OrbData1Num5 INT '$.title.OrbData1Num5'
			,OrbData2Num5 INT '$.title.OrbData2Num5'
			,OrbData3Num5 INT '$.title.OrbData3Num5'
			,OrbData4Num5 INT '$.title.OrbData4Num5'
			,OrbData5Num5 INT '$.title.OrbData5Num5'
			) AS c
	WHERE cj.TableName = 'CharaLimitBreak';

	WITH cte
	AS (
		SELECT UnbindID
			,11 AS ManaNode
			,OrbData1Id1 AS MaterialID
			,OrbData1Num1 AS Quantity
		FROM #MCUnbind
		WHERE OrbData1Num1 <> 0
		
		UNION ALL
		
		SELECT UnbindID
			,11
			,OrbData2Id1
			,OrbData2Num1
		FROM #MCUnbind
		WHERE OrbData2Num1 <> 0
		
		UNION ALL
		
		SELECT UnbindID
			,11
			,OrbData3Id1
			,OrbData3Num1
		FROM #MCUnbind
		WHERE OrbData3Num1 <> 0
		
		UNION ALL
		
		SELECT UnbindID
			,11
			,OrbData4Id1
			,OrbData4Num1
		FROM #MCUnbind
		WHERE OrbData4Num1 <> 0
		
		UNION ALL
		
		SELECT UnbindID
			,11
			,OrbData5Id1
			,OrbData5Num1
		FROM #MCUnbind
		WHERE OrbData5Num1 <> 0
		
		UNION ALL
		
		SELECT UnbindID
			,21
			,OrbData1Id2
			,OrbData1Num2
		FROM #MCUnbind
		WHERE OrbData1Num2 <> 0
		
		UNION ALL
		
		SELECT UnbindID
			,21
			,OrbData2Id2
			,OrbData2Num2
		FROM #MCUnbind
		WHERE OrbData2Num2 <> 0
		
		UNION ALL
		
		SELECT UnbindID
			,21
			,OrbData3Id2
			,OrbData3Num2
		FROM #MCUnbind
		WHERE OrbData3Num2 <> 0
		
		UNION ALL
		
		SELECT UnbindID
			,21
			,OrbData4Id2
			,OrbData4Num2
		FROM #MCUnbind
		WHERE OrbData4Num2 <> 0
		
		UNION ALL
		
		SELECT UnbindID
			,21
			,OrbData5Id2
			,OrbData5Num2
		FROM #MCUnbind
		WHERE OrbData5Num2 <> 0
		
		UNION ALL
		
		SELECT UnbindID
			,31
			,OrbData1Id3
			,OrbData1Num3
		FROM #MCUnbind
		WHERE OrbData1Num3 <> 0
		
		UNION ALL
		
		SELECT UnbindID
			,31
			,OrbData2Id3
			,OrbData2Num3
		FROM #MCUnbind
		WHERE OrbData2Num3 <> 0
		
		UNION ALL
		
		SELECT UnbindID
			,31
			,OrbData3Id3
			,OrbData3Num3
		FROM #MCUnbind
		WHERE OrbData3Num3 <> 0
		
		UNION ALL
		
		SELECT UnbindID
			,31
			,OrbData4Id3
			,OrbData4Num3
		FROM #MCUnbind
		WHERE OrbData4Num3 <> 0
		
		UNION ALL
		
		SELECT UnbindID
			,31
			,OrbData5Id3
			,OrbData5Num3
		FROM #MCUnbind
		WHERE OrbData5Num3 <> 0
		
		UNION ALL
		
		SELECT UnbindID
			,41
			,OrbData1Id4
			,OrbData1Num4
		FROM #MCUnbind
		WHERE OrbData1Num4 <> 0
		
		UNION ALL
		
		SELECT UnbindID
			,41
			,OrbData2Id4
			,OrbData2Num4
		FROM #MCUnbind
		WHERE OrbData2Num4 <> 0
		
		UNION ALL
		
		SELECT UnbindID
			,41
			,OrbData3Id4
			,OrbData3Num4
		FROM #MCUnbind
		WHERE OrbData3Num4 <> 0
		
		UNION ALL
		
		SELECT UnbindID
			,41
			,OrbData4Id4
			,OrbData4Num4
		FROM #MCUnbind
		WHERE OrbData4Num4 <> 0
		
		UNION ALL
		
		SELECT UnbindID
			,41
			,OrbData5Id4
			,OrbData5Num4
		FROM #MCUnbind
		WHERE OrbData5Num4 <> 0
		
		UNION ALL
		
		SELECT UnbindID
			,51
			,OrbData1Id5
			,OrbData1Num5
		FROM #MCUnbind
		WHERE OrbData1Num5 <> 0
		
		UNION ALL
		
		SELECT UnbindID
			,51
			,OrbData2Id5
			,OrbData2Num5
		FROM #MCUnbind
		WHERE OrbData2Num5 <> 0
		
		UNION ALL
		
		SELECT UnbindID
			,51
			,OrbData3Id5
			,OrbData3Num5
		FROM #MCUnbind
		WHERE OrbData3Num5 <> 0
		
		UNION ALL
		
		SELECT UnbindID
			,51
			,OrbData4Id5
			,OrbData4Num5
		FROM #MCUnbind
		WHERE OrbData4Num5 <> 0
		
		UNION ALL
		
		SELECT UnbindID
			,51
			,OrbData5Id5
			,OrbData5Num5
		FROM #MCUnbind
		WHERE OrbData5Num5 <> 0
		)
	MERGE [adv].ManaCircle AS trg
	USING (
		SELECT ub.AdventurerID
			,cte.ManaNode
			,cte.MaterialID
			,cte.Quantity
		FROM cte
		INNER JOIN #AdventurerMC AS ub ON ub.UnbindID = cte.UnbindID
		) AS src
		ON src.AdventurerID = trg.AdventurerID
			AND src.ManaNode = trg.ManaNode
			AND src.MaterialID = trg.MaterialID
	WHEN MATCHED
		THEN
			UPDATE
			SET Quantity = src.Quantity + trg.Quantity
	WHEN NOT MATCHED
		THEN
			INSERT (
				AdventurerID
				,ManaNode
				,MaterialID
				,Quantity
				)
			VALUES (
				src.AdventurerID
				,src.ManaNode
				,src.MaterialID
				,src.Quantity
				);

	DELETE mc
	FROM [adv].Adventurer AS a
	INNER JOIN [adv].ManaCircle AS mc ON mc.AdventurerID = a.AdventurerID
	WHERE mc.ManaNode > a.MCLimit

	--Dragons
	MERGE [drg].Dragon AS trg
	USING (
		SELECT d.DragonID
			,REPLACE(d.Dragon, '&amp;', '&') AS Dragon
			,d.ElementID
			,d.Rarity
		FROM jsn.TableJson AS dj
		CROSS APPLY OPENJSON(dj.JsonText) WITH (cargoquery NVARCHAR(MAX) AS JSON) AS cq
		CROSS APPLY OPENJSON(cq.cargoquery) WITH (
				DragonID INT '$.title.Id'
				,Dragon NVARCHAR(50) '$.title.FullName'
				,Rarity INT '$.title.Rarity'
				,ElementID INT '$.title.ElementalTypeId'
				) AS d
		WHERE dj.TableName = 'Dragon'
		) AS src
		ON src.DragonID = trg.DragonID
	WHEN MATCHED
		THEN
			UPDATE
			SET Dragon = src.Dragon
				,Rarity = src.Rarity
				,ElementID = src.ElementID
				,Active = 1
	WHEN NOT MATCHED BY SOURCE
		THEN
			UPDATE
			SET Active = 0
	WHEN NOT MATCHED
		THEN
			INSERT (
				DragonID
				,Dragon
				,Rarity
				,ElementID
				)
			VALUES (
				src.DragonID
				,src.Dragon
				,src.Rarity
				,src.ElementID
				);

	TRUNCATE TABLE [drg].[DragonUnbind]

	INSERT [drg].[DragonUnbind] (
		DragonID
		,MaterialID
		)
	SELECT d.DragonID
		,m.MaterialID
	FROM [drg].Dragon AS d
	INNER JOIN core.Material AS m ON m.Material = CONCAT (
			d.Dragon
			,'''s Essence'
			)
END
