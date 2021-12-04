CREATE PROCEDURE [wpn].[spWeaponUpgradeJson]
AS
SELECT wu.[WeaponID]
	,ut.[UpgradeType]
	,wu.[Step]
	,wu.[MaterialID]
	,wu.[Quantity]
FROM [wpn].[WeaponUpgrade] AS wu
INNER JOIN [core].[UpgradeType] AS ut ON ut.[UpgradeTypeID] = wu.[UpgradeTypeID]
FOR JSON PATH
