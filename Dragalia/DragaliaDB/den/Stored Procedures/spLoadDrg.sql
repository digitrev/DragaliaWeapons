CREATE PROCEDURE [den].[spLoadDrg]
AS
BEGIN
	SET NOCOUNT ON

	MERGE [drg].DragonUnbind AS trg
	USING (
		SELECT d.DragonID
			,m.MaterialID
			,dc.Greatsphere AS Quantity
		FROM den.DragonAdvancedMats AS dm
		INNER JOIN [drg].Dragon AS d ON d.Dragon = dm.Dragon
		INNER JOIN core.Material AS m ON m.Material = dm.GreatsphereMat
		CROSS JOIN den.DragonAdvancedCosts AS dc
		WHERE dc.Greatsphere > 0
		
		UNION
		
		SELECT d.DragonID
			,m.MaterialID
			,dc.Sphere
		FROM den.DragonAdvancedMats AS dm
		INNER JOIN [drg].Dragon AS d ON d.Dragon = dm.Dragon
		INNER JOIN core.Material AS m ON m.Material = dm.SphereMat
		CROSS JOIN den.DragonAdvancedCosts AS dc
		WHERE dc.Sphere > 0
		
		UNION
		
		SELECT d.DragonID
			,m.MaterialID
			,dc.Sphere
		FROM den.DragonTrialMats AS dm
		INNER JOIN [drg].Dragon AS d ON d.Dragon = dm.Dragon
		INNER JOIN core.Material AS m ON m.Material = dm.SphereMat
		CROSS JOIN den.DragonTrialCosts AS dc
		WHERE dc.Sphere > 0
		
		UNION
		
		SELECT d.DragonID
			,m.MaterialID
			,dc.Scale
		FROM den.DragonTrialMats AS dm
		INNER JOIN [drg].Dragon AS d ON d.Dragon = dm.Dragon
		INNER JOIN core.Material AS m ON m.Material = dm.ScaleMat
		CROSS JOIN den.DragonTrialCosts AS dc
		WHERE dc.Scale > 0
		
		UNION
		
		SELECT d.DragonID
			,m.MaterialID
			,dm.Seed
		FROM den.DragonVoidCosts AS dm
		INNER JOIN [drg].Dragon AS d ON d.Dragon = dm.Dragon
		CROSS JOIN core.Material AS m
		WHERE dm.Seed > 0
			AND m.Material = 'Void Seed'
		) AS src
		ON src.DragonID = trg.DragonID
			AND src.MaterialId = trg.MaterialID
	WHEN MATCHED
		THEN
			UPDATE
			SET Quantity = src.Quantity
	WHEN NOT MATCHED
		THEN
			INSERT (
				DragonID
				,MaterialID
				,Quantity
				)
			VALUES (
				src.DragonID
				,src.MaterialID
				,src.Quantity
				);
END
