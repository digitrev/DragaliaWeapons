CREATE FUNCTION [util].[InlineMax] (
	@m INT
	,@n INT
	)
RETURNS INT
AS
BEGIN
	RETURN (
			SELECT MAX(v.Val)
			FROM (
				VALUES (@m)
					,(@n)
				) AS v(val)
			)
END
