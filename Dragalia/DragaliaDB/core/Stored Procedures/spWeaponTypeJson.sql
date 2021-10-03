CREATE PROCEDURE [core].[spWeaponTypeJson]
AS
SELECT WeaponTypeID AS weaponTypeId
	,WeaponType AS weaponType
FROM core.WeaponType
ORDER BY WeaponTypeID
FOR JSON PATH
