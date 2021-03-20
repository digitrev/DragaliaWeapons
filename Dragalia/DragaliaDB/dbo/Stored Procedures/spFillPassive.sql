CREATE PROCEDURE [dbo].[spFillPassive]
AS
BEGIN
	SET NOCOUNT ON

	INSERT AccountPassive (
		AccountID
		,PassiveID
		)
	SELECT a.AccountID
		,p.PassiveID
	FROM core.Passive AS p
	CROSS JOIN Account AS a
	
	EXCEPT
	
	SELECT AccountID
		,PassiveID
	FROM AccountPassive
END
