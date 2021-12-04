CREATE PROCEDURE [fac].[spFacilityUpgradeJson]
AS
SELECT [FacilityID]
	,[MaterialID]
	,[FacilityLevel]
	,[Quantity]
	,[Active]
FROM [fac].[FacilityUpgrade]
FOR JSON PATH
