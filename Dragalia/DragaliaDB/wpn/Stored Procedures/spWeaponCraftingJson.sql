CREATE PROCEDURE [wpn].[spWeaponCraftingJson]
AS
SELECT [WeaponID]
	,[MaterialID]
	,[Quantity]
FROM [wpn].[WeaponCrafting]
FOR JSON PATH
