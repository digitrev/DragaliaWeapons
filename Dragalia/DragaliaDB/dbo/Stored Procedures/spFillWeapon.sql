CREATE PROCEDURE [dbo].[spFillWeapon]
AS
BEGIN
	SET NOCOUNT ON

	INSERT AccountWeapon (
		AccountID
		,WeaponID
		)
	SELECT a.AccountID
		,w.WeaponID
	FROM core.Weapon AS w
	CROSS JOIN Account AS a
	
	EXCEPT
	
	SELECT AccountID
		,WeaponID
	FROM AccountWeapon
END
