CREATE PROCEDURE [fac].[spFacilityLimitJson]
AS
SELECT FacilityID AS facilityID
	,MAX(FacilityLevel) AS maxLevel
FROM [fac].FacilityUpgrade
GROUP BY FacilityID
FOR JSON PATH
