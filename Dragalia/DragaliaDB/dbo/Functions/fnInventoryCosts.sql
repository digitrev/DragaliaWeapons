CREATE FUNCTION [dbo].[fnInventoryCosts] (@AccountID INT)
RETURNS TABLE
AS
RETURN (
		SELECT i.MaterialID
			,SUM(i.Quantity) AS Quantity
		FROM (
			SELECT wc.MaterialID
				,wc.Quantity
			FROM [AccountWeapon] AS w
			INNER JOIN core.WeaponCrafting AS wc ON wc.WeaponID = w.WeaponID
			WHERE w.AccountID = @AccountID
				AND w.Copies = 0
				AND w.CopiesWanted > w.Copies
			
			UNION ALL
			
			SELECT wu.MaterialID
				,wu.Quantity
			FROM [AccountWeapon] AS w
			INNER JOIN core.WeaponUpgrade AS wu ON wu.WeaponID = w.WeaponID
			INNER JOIN core.[UpgradeType] AS ut ON ut.[UpgradeTypeID] = wu.UpgradeTypeID
			WHERE w.AccountID = @AccountID
				AND ut.[UpgradeType] = 'Copies'
				AND w.Copies < wu.Step
				AND wu.Step <= w.CopiesWanted
			
			UNION ALL
			
			SELECT wu.MaterialID
				,wu.Quantity
			FROM [AccountWeapon] AS w
			INNER JOIN core.WeaponUpgrade AS wu ON wu.WeaponID = w.WeaponID
			INNER JOIN core.[UpgradeType] AS ut ON ut.[UpgradeTypeID] = wu.UpgradeTypeID
			WHERE w.AccountID = @AccountID
				AND ut.[UpgradeType] = 'Unbind'
				AND w.Unbind < wu.Step
				AND wu.Step <= w.UnbindWanted
			
			UNION ALL
			
			SELECT wu.MaterialID
				,wu.Quantity
			FROM [AccountWeapon] AS w
			INNER JOIN core.WeaponUpgrade AS wu ON wu.WeaponID = w.WeaponID
			INNER JOIN core.[UpgradeType] AS ut ON ut.[UpgradeTypeID] = wu.UpgradeTypeID
			WHERE w.AccountID = @AccountID
				AND ut.[UpgradeType] = 'Refinement'
				AND w.Refine < wu.Step
				AND wu.Step <= w.RefineWanted
			
			UNION ALL
			
			SELECT wu.MaterialID
				,wu.Quantity
			FROM [AccountWeapon] AS w
			INNER JOIN core.WeaponUpgrade AS wu ON wu.WeaponID = w.WeaponID
			INNER JOIN core.[UpgradeType] AS ut ON ut.[UpgradeTypeID] = wu.UpgradeTypeID
			WHERE w.AccountID = @AccountID
				AND ut.[UpgradeType] = 'Slots'
				AND w.Slot < wu.Step
				AND wu.Step <= w.SlotWanted
			
			UNION ALL
			
			SELECT wu.MaterialID
				,wu.Quantity
			FROM [AccountWeapon] AS w
			INNER JOIN core.WeaponUpgrade AS wu ON wu.WeaponID = w.WeaponID
			INNER JOIN core.[UpgradeType] AS ut ON ut.[UpgradeTypeID] = wu.UpgradeTypeID
			WHERE w.AccountID = @AccountID
				AND ut.[UpgradeType] = 'Weapon Bonus'
				AND w.Bonus < wu.Step
				AND wu.Step <= w.BonusWanted
			
			UNION ALL
			
			SELECT wl.MaterialID
				,wl.Quantity
			FROM [AccountWeapon] AS w
			INNER JOIN core.Weapon AS cw ON cw.WeaponID = w.WeaponID
			INNER JOIN core.WeaponLevel AS wl ON wl.Rarity = cw.Rarity
			WHERE w.AccountID = @AccountID
				AND w.WeaponLevel < wl.WeaponLevel
				AND wl.WeaponLevel <= w.WeaponLevelWanted
			
			UNION ALL
			
			SELECT fu.MaterialID
				,fu.Quantity
			FROM [AccountFacility] AS f
			INNER JOIN core.FacilityUpgrade AS fu ON fu.FacilityID = f.FacilityID
			WHERE f.AccountID = @AccountID
				AND f.CurrentLevel < fu.FacilityLevel
				AND fu.FacilityLevel <= f.WantedLevel
			
			UNION ALL
			
			SELECT pc.MaterialID
				,pc.Quantity
			FROM [AccountPassive] AS p
			INNER JOIN core.PassiveCrafting AS pc ON pc.PassiveID = p.PassiveID
			WHERE p.AccountID = @AccountID
				AND p.Owned = 0
				AND p.Wanted = 1
			) AS i
		GROUP BY i.MaterialID
		)
