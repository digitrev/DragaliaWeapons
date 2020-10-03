CREATE PROCEDURE [den].[spLoadCore]
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
		
		UNION
		
		--Dojos
		SELECT f.FacilityID
			,m.MaterialID
			,dc.[Level]
			,dc.Silver
		FROM den.DojoMats AS dm
		INNER JOIN core.Facility AS f ON f.Facility = dm.Facility
		INNER JOIN core.Material AS m ON m.Material = dm.SilverMat
		CROSS APPLY den.DojoCosts AS dc
		WHERE dc.Silver > 0
		
		UNION
		
		SELECT f.FacilityID
			,m.MaterialID
			,dc.[Level]
			,dc.Gold
		FROM den.DojoMats AS dm
		INNER JOIN core.Facility AS f ON f.Facility = dm.Facility
		INNER JOIN core.Material AS m ON m.Material = dm.GoldMat
		CROSS APPLY den.DojoCosts AS dc
		WHERE dc.Gold > 0
		
		UNION
		
		SELECT f.FacilityID
			,'Rupie'
			,dc.[Level]
			,dc.Rupie
		FROM den.DojoMats AS dm
		INNER JOIN core.Facility AS f ON f.Facility = dm.Facility
		CROSS APPLY den.DojoCosts AS dc
		WHERE dc.Rupie > 0
		
		UNION
		
		SELECT f.FacilityID
			,m.MaterialID
			,dc.[Level]
			,dc.Aes
		FROM den.DojoMats AS dm
		INNER JOIN core.Facility AS f ON f.Facility = dm.Facility
		CROSS APPLY core.Material AS m
		CROSS APPLY den.DojoCosts AS dc
		WHERE dc.Aes > 0
			AND m.Material = 'Dyrenell Aes'
		
		UNION
		
		SELECT f.FacilityID
			,m.MaterialID
			,dc.[Level]
			,dc.[Argenteus]
		FROM den.DojoMats AS dm
		INNER JOIN core.Facility AS f ON f.Facility = dm.Facility
		CROSS APPLY core.Material AS m
		CROSS APPLY den.DojoCosts AS dc
		WHERE dc.[Argenteus] > 0
			AND m.Material = 'Dyrenell Argenteus'
		
		UNION
		
		SELECT f.FacilityID
			,m.MaterialID
			,dc.[Level]
			,dc.Aureus
		FROM den.DojoMats AS dm
		INNER JOIN core.Facility AS f ON f.Facility = dm.Facility
		CROSS APPLY core.Material AS m
		CROSS APPLY den.DojoCosts AS dc
		WHERE dc.Aureus > 0
			AND m.Material = 'Dyrenell Aureus'
		
		UNION
		
		--Altars
		SELECT f.FacilityID
			,'Rupie'
			,ac.[Level]
			,ac.Rupie
		FROM den.AltarMats AS am
		INNER JOIN core.Facility AS f ON f.Facility = am.Facility
		CROSS APPLY den.AltarCosts AS ac
		WHERE ac.Rupie > 0
		
		UNION
		
		SELECT f.FacilityID
			,m.MaterialID
			,ac.[Level]
			,ac.Rainbow
		FROM den.AltarMats AS am
		INNER JOIN core.Facility AS f ON f.Facility = am.Facility
		CROSS APPLY core.Material AS m
		CROSS APPLY den.AltarCosts AS ac
		WHERE ac.Rainbow > 0
			AND m.Material = 'Rainbow Orb'
		
		UNION
		
		SELECT f.FacilityID
			,m.MaterialID
			,ac.[Level]
			,ac.T1
		FROM den.AltarMats AS am
		INNER JOIN core.Facility AS f ON f.Facility = am.Facility
		INNER JOIN core.Material AS m ON m.Material = am.T1Mat
		CROSS APPLY den.AltarCosts AS ac
		WHERE ac.T1 > 0
		
		UNION
		
		SELECT f.FacilityID
			,m.MaterialID
			,ac.[Level]
			,ac.T2
		FROM den.AltarMats AS am
		INNER JOIN core.Facility AS f ON f.Facility = am.Facility
		INNER JOIN core.Material AS m ON m.Material = am.T2Mat
		CROSS APPLY den.AltarCosts AS ac
		WHERE ac.T2 > 0
		
		UNION
		
		SELECT f.FacilityID
			,m.MaterialID
			,ac.[Level]
			,ac.T3
		FROM den.AltarMats AS am
		INNER JOIN core.Facility AS f ON f.Facility = am.Facility
		INNER JOIN core.Material AS m ON m.Material = am.T3Mat
		CROSS APPLY den.AltarCosts AS ac
		WHERE ac.T3 > 0
		
		UNION
		
		SELECT f.FacilityID
			,m.MaterialID
			,ac.[Level]
			,ac.T4
		FROM den.AltarMats AS am
		INNER JOIN core.Facility AS f ON f.Facility = am.Facility
		INNER JOIN core.Material AS m ON m.Material = am.T4Mat
		CROSS APPLY den.AltarCosts AS ac
		WHERE ac.T4 > 0
		
		UNION
		
		--Dracoliths
		SELECT f.FacilityID
			,'Rupie'
			,dc.[Level]
			,dc.Rupie
		FROM den.DracolithMats AS dm
		INNER JOIN core.Facility AS f ON f.Facility = dm.Facility
		CROSS APPLY den.DracolithCosts AS dc
		WHERE dc.Rupie > 0
		
		UNION
		
		SELECT f.FacilityID
			,m.MaterialID
			,dc.[Level]
			,dc.Talonstone
		FROM den.DracolithMats AS dm
		INNER JOIN core.Facility AS f ON f.Facility = dm.Facility
		CROSS APPLY core.Material AS m
		CROSS APPLY den.DracolithCosts AS dc
		WHERE dc.Talonstone > 0
			AND m.Material = 'Talonstone'
		
		UNION
		
		SELECT f.FacilityID
			,m.MaterialID
			,dc.[Level]
			,dc.GoldScale
		FROM den.DracolithMats AS dm
		INNER JOIN core.Facility AS f ON f.Facility = dm.Facility
		INNER JOIN core.Material AS m ON m.Material = dm.GoldScaleMat
		CROSS APPLY den.DracolithCosts AS dc
		WHERE dc.GoldScale > 0
		
		UNION
		
		SELECT f.FacilityID
			,m.MaterialID
			,dc.[Level]
			,dc.Sphere
		FROM den.DracolithMats AS dm
		INNER JOIN core.Facility AS f ON f.Facility = dm.Facility
		INNER JOIN core.Material AS m ON m.Material = dm.SphereMat
		CROSS APPLY den.DracolithCosts AS dc
		WHERE dc.Sphere > 0
		
		UNION
		
		SELECT f.FacilityID
			,m.MaterialID
			,dc.[Level]
			,dc.Greatsphere
		FROM den.DracolithMats AS dm
		INNER JOIN core.Facility AS f ON f.Facility = dm.Facility
		INNER JOIN core.Material AS m ON m.Material = dm.GreatsphereMat
		CROSS APPLY den.DracolithCosts AS dc
		WHERE dc.Greatsphere > 0
		
		UNION
		
		SELECT f.FacilityID
			,m.MaterialID
			,dc.[Level]
			,dc.Scale
		FROM den.DracolithMats AS dm
		INNER JOIN core.Facility AS f ON f.Facility = dm.Facility
		INNER JOIN core.Material AS m ON m.Material = dm.ScaleMat
		CROSS APPLY den.DracolithCosts AS dc
		WHERE dc.Scale > 0
		
		UNION
		
		--Fafnirs
		SELECT f.FacilityID
			,'Rupie'
			,fc.[Level]
			,fc.Rupie
		FROM den.FafnirMats AS fm
		INNER JOIN core.Facility AS f ON f.Facility = fm.Facility
		CROSS APPLY den.FafnirCosts AS fc
		WHERE fc.Rupie > 0
		
		UNION
		
		SELECT f.FacilityID
			,m.MaterialID
			,fc.[Level]
			,fc.Talonstone
		FROM den.FafnirMats AS fm
		INNER JOIN core.Facility AS f ON f.Facility = fm.Facility
		CROSS APPLY core.Material AS m
		CROSS APPLY den.FafnirCosts AS fc
		WHERE fc.Talonstone > 0
			AND m.Material = 'Talonstone'
		
		UNION
		
		SELECT f.FacilityID
			,m.MaterialID
			,fc.[Level]
			,fc.GoldScale
		FROM den.FafnirMats AS fm
		INNER JOIN core.Facility AS f ON f.Facility = fm.Facility
		INNER JOIN core.Material AS m ON m.Material = fm.GoldScaleMat
		CROSS APPLY den.FafnirCosts AS fc
		WHERE fc.GoldScale > 0
		
		UNION
		
		SELECT f.FacilityID
			,m.MaterialID
			,fc.[Level]
			,fc.Greatsphere
		FROM den.FafnirMats AS fm
		INNER JOIN core.Facility AS f ON f.Facility = fm.Facility
		INNER JOIN core.Material AS m ON m.Material = fm.GreatsphereMat
		CROSS APPLY den.FafnirCosts AS fc
		WHERE fc.Greatsphere > 0
		
		UNION
		
		--Statues
		SELECT f.FacilityID
			,'Rupie'
			,sc.[Level]
			,sc.Rupie
		FROM den.StatueMats AS sm
		INNER JOIN core.Facility AS f ON f.Facility = sm.Facility
		CROSS APPLY den.StatueCosts AS sc
		WHERE sc.Rupie > 0
		
		UNION
		
		SELECT f.FacilityID
			,m.MaterialID
			,sc.[Level]
			,sc.Seed
		FROM den.StatueMats AS sm
		INNER JOIN core.Facility AS f ON f.Facility = sm.Facility
		CROSS APPLY core.Material AS m
		CROSS APPLY den.StatueCosts AS sc
		WHERE sc.Seed > 0
			AND m.Material = 'Void Seed'
		
		UNION
		
		SELECT f.FacilityID
			,m.MaterialID
			,sc.[Level]
			,sc.Bronze
		FROM den.StatueMats AS sm
		INNER JOIN core.Facility AS f ON f.Facility = sm.Facility
		INNER JOIN core.Material AS m ON m.Material = sm.BronzeMat
		CROSS APPLY den.StatueCosts AS sc
		WHERE sc.Bronze > 0
		
		UNION
		
		SELECT f.FacilityID
			,m.MaterialID
			,sc.[Level]
			,sc.Silver
		FROM den.StatueMats AS sm
		INNER JOIN core.Facility AS f ON f.Facility = sm.Facility
		INNER JOIN core.Material AS m ON m.Material = sm.SilverMat
		CROSS APPLY den.StatueCosts AS sc
		WHERE sc.Silver > 0
		
		UNION
		
		SELECT f.FacilityID
			,m.MaterialID
			,sc.[Level]
			,sc.Gold
		FROM den.StatueMats AS sm
		INNER JOIN core.Facility AS f ON f.Facility = sm.Facility
		INNER JOIN core.Material AS m ON m.Material = sm.GoldMat
		CROSS APPLY den.StatueCosts AS sc
		WHERE sc.Gold > 0
		
		UNION
		
		SELECT f.FacilityID
			,m.MaterialID
			,sc.[Level]
			,sc.Void1
		FROM den.StatueMats AS sm
		INNER JOIN core.Facility AS f ON f.Facility = sm.Facility
		INNER JOIN core.Material AS m ON m.Material = sm.Void1Mat
		CROSS APPLY den.StatueCosts AS sc
		WHERE sc.Void1 > 0
		
		UNION
		
		SELECT f.FacilityID
			,m.MaterialID
			,sc.[Level]
			,sc.Void2
		FROM den.StatueMats AS sm
		INNER JOIN core.Facility AS f ON f.Facility = sm.Facility
		INNER JOIN core.Material AS m ON m.Material = sm.Void2Mat
		CROSS APPLY den.StatueCosts AS sc
		WHERE sc.Void2 > 0
		
		UNION
		
		SELECT f.FacilityID
			,m.MaterialID
			,sc.[Level]
			,sc.Void3
		FROM den.StatueMats AS sm
		INNER JOIN core.Facility AS f ON f.Facility = sm.Facility
		INNER JOIN core.Material AS m ON m.Material = sm.Void3Mat
		CROSS APPLY den.StatueCosts AS sc
		WHERE sc.Void3 > 0
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
