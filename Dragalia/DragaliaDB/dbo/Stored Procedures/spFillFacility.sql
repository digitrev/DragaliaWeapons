CREATE PROCEDURE [dbo].[spFillFacility]
AS
BEGIN
	SET NOCOUNT ON

	INSERT AccountFacility (
		AccountID
		,FacilityID
		,CopyNumber
		)
	SELECT a.AccountID
		,f.FacilityID
		,t.N
	FROM core.Facility AS f
	INNER JOIN util.Tally AS t ON t.N <= f.Limit
	CROSS JOIN Account AS a
	
	EXCEPT
	
	SELECT AccountID
		,FacilityID
		,CopyNumber
	FROM AccountFacility
END
