﻿CREATE PROCEDURE [core].[spWeaponLimitJson]
AS
SELECT pvt.WeaponID AS weaponId
	,wl.WeaponLevel AS [level]
	,ISNULL(pvt.Unbind, 0) AS unbind
	,ISNULL(pvt.Refinement, 0) AS refinement
	,ISNULL(pvt.Slots, 0) AS slots
	,ISNULL(pvt.Dominion, 0) AS dominion
	,ISNULL(pvt.[Weapon Bonus], 0) AS bonus
FROM core.Weapon AS w
INNER JOIN (
	SELECT wu.WeaponID
		,ut.UpgradeType
		,wu.Step
	FROM core.WeaponUpgrade AS wu
	INNER JOIN core.UpgradeType AS ut ON ut.UpgradeTypeID = wu.UpgradeTypeID
	) AS src
PIVOT(MAX(Step) FOR UpgradeType IN (
			[Unbind]
			,[Refinement]
			,[Slots]
			,[Dominion]
			,[Weapon Bonus]
			)) AS pvt ON pvt.WeaponID = w.WeaponID
INNER JOIN (
	SELECT Rarity
		,MAX(WeaponLevel) AS WeaponLevel
	FROM core.WeaponLevel
	GROUP BY Rarity
	) AS wl ON wl.Rarity = w.Rarity
FOR JSON PATH