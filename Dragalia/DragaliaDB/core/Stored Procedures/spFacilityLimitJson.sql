CREATE PROCEDURE [core].[spFacilityLimitJson]
AS
SELECT FacilityID AS facilityID
	,MAX(FacilityLevel) AS maxLevel
FROM core.FacilityUpgrade
GROUP BY FacilityID
FOR JSON PATH
