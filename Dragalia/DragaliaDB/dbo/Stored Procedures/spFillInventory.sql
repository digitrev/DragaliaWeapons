CREATE PROCEDURE [dbo].[spFillInventory]
AS
BEGIN
	SET NOCOUNT ON

	INSERT AccountInventory (
		AccountID
		,MaterialID
		)
	SELECT a.AccountID
		,m.MaterialID
	FROM core.Material AS m
	CROSS APPLY Account AS a
	WHERE m.Active = 1
		AND a.Active = 1
	
	EXCEPT
	
	SELECT AccountID
		,MaterialID
	FROM AccountInventory
END
