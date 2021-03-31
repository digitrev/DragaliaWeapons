CREATE PROCEDURE [dbo].[spFillWyrmprint]
AS
BEGIN
	SET NOCOUNT ON

	INSERT AccountWyrmprint (
		AccountID
		,WyrmprintID
		)
	SELECT a.AccountID
		,w.WyrmprintID
	FROM core.Wyrmprint AS w
	CROSS JOIN Account AS a
	
	EXCEPT
	
	SELECT AccountID
		,WyrmprintID
	FROM AccountWyrmprint
END
