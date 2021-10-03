CREATE PROCEDURE [core].[spWeaponSeriesJson]
AS
SELECT WeaponSeriesID AS weaponSeriesId
	,WeaponSeries AS weaponSeries
FROM core.WeaponSeries
ORDER BY SortOrder
FOR JSON PATH
