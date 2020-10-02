CREATE PROCEDURE [core].[spLoadTablesFromDen]
AS
BEGIN
	--Tree table
	MERGE core.FacilityUpgrade AS trg
	USING (
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
		) AS src
		ON src.FacilityID = trg.FacilityID
			AND src.MaterialID = trg.MaterialID
			AND src.FacilityLevel = trg.FacilityLevel
	WHEN MATCHED
		THEN
			UPDATE
			SET Quantity = src.Quantity
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
