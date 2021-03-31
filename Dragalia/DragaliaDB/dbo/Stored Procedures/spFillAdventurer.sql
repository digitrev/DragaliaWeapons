CREATE PROCEDURE [dbo].[spFillAdventurer]
AS
BEGIN
	SET NOCOUNT ON

	INSERT AccountAdventurer (
		AccountID
		,AdventurerID
		)
	SELECT a.AccountID
		,ad.AdventurerID
	FROM core.Adventurer AS ad
	CROSS JOIN Account AS a
	
	EXCEPT
	
	SELECT AccountID
		,AdventurerID
	FROM AccountAdventurer
END
