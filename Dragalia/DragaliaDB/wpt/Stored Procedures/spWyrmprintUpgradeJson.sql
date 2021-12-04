CREATE PROCEDURE [wpt].[spWyrmprintUpgradeJson]
AS
SELECT wu.[WyrmprintID]
	,ut.[UpgradeType]
	,wu.[Step]
	,wu.[MaterialID]
	,wu.[Quantity]
FROM [wpt].[WyrmprintUpgrade] AS wu
INNER JOIN [core].[UpgradeType] AS ut ON ut.[UpgradeTypeID] = wu.UpgradeTypeID
FOR JSON PATH
