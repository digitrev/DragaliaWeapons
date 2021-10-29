CREATE PROCEDURE [wpn].[spWeaponLevelJson]
AS
SELECT [Rarity]
	,[WeaponLevel]
	,[MaterialID]
	,[Quantity]
FROM [wpn].[WeaponLevel]
FOR JSON PATH
