CREATE PROCEDURE [core].[spLoadTablesFromDen]
AS
BEGIN
	DECLARE @MineID INT = (
			SELECT FacilityID
			FROM core.Facility
			WHERE Facility = 'Rupie Mine'
			)

	MERGE core.FacilityUpgrade AS trg
	USING (
		--Trees
		SELECT f.FacilityID
			,m.MaterialID
			,tc.[Level] AS FacilityLevel
			,tc.Silver AS Quantity
		FROM den.TreeMats AS tm
		INNER JOIN core.Facility AS f ON f.Facility = tm.Facility
		INNER JOIN core.Material AS m ON m.Material = tm.SilverMat
		CROSS JOIN den.TreeCosts AS tc
		WHERE tc.Silver > 0
		
		UNION
		
		SELECT f.FacilityID
			,m.MaterialID
			,tc.[Level]
			,tc.Gold
		FROM den.TreeMats AS tm
		INNER JOIN core.Facility AS f ON f.Facility = tm.Facility
		INNER JOIN core.Material AS m ON m.Material = tm.GoldMat
		CROSS JOIN den.TreeCosts AS tc
		WHERE tc.Gold > 0
		
		UNION
		
		SELECT f.FacilityID
			,'Rupie'
			,tc.[Level]
			,tc.Rupie
		FROM den.TreeMats AS tm
		INNER JOIN core.Facility AS f ON f.Facility = tm.Facility
		CROSS JOIN den.TreeCosts AS tc
		WHERE tc.Rupie > 0
		
		UNION
		
		--Mines
		SELECT @MineID
			,'Rupie'
			,mc.[Level]
			,mc.Rupie
		FROM den.MineCosts AS mc
		WHERE Rupie > 0
		
		UNION
		
		SELECT @MineID
			,m.MaterialID
			,mc.[Level]
			,mc.T1
		FROM den.MineCosts AS mc
		CROSS APPLY core.Material AS m
		WHERE T1 > 0
			AND m.Material = 'Light Orb'
		
		UNION
		
		SELECT @MineID
			,m.MaterialID
			,mc.[Level]
			,mc.T2
		FROM den.MineCosts AS mc
		CROSS APPLY core.Material AS m
		WHERE T2 > 0
			AND m.Material = 'Radiance Orb'
		
		UNION
		
		SELECT @MineID
			,m.MaterialID
			,mc.[Level]
			,mc.T3
		FROM den.MineCosts AS mc
		CROSS APPLY core.Material AS m
		WHERE T3 > 0
			AND m.Material = 'Refulgence Orb'
		
		UNION
		
		SELECT @MineID
			,m.MaterialID
			,mc.[Level]
			,mc.T4
		FROM den.MineCosts AS mc
		CROSS APPLY core.Material AS m
		WHERE T4 > 0
			AND m.Material = 'Resplendence Orb'
		) AS src
		ON src.FacilityID = trg.FacilityID
			AND src.MaterialID = trg.MaterialID
			AND src.FacilityLevel = trg.FacilityLevel
	WHEN MATCHED
		THEN
			UPDATE
			SET Quantity = src.Quantity
	WHEN NOT MATCHED BY source
		THEN
			DELETE
	WHEN NOT MATCHED
		THEN
			INSERT (
				FacilityID
				,MaterialID
				,FacilityLevel
				,Quantity
				)
			VALUES (
				src.FacilityID
				,src.MaterialID
				,src.FacilityLevel
				,src.Quantity
				);
END
