CREATE PROCEDURE [dbo].[spFillDragon]
AS
BEGIN
	SET NOCOUNT ON

	INSERT AccountDragon (
		AccountID
		,DragonID
		)
	SELECT a.AccountID
		,d.DragonID
	FROM core.Dragon AS d
	CROSS JOIN Account AS a
	
	EXCEPT
	
	SELECT AccountID
		,DragonID
	FROM AccountDragon
END
