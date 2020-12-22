CREATE FUNCTION [dbo].[fnPlayerInventory] (@AccountID INT)
RETURNS TABLE
AS
RETURN (
		SELECT m.MaterialID
			,ISNULL(i.Quantity, 0) AS Owned
			,ISNULL(ic.Quantity, 0) AS Costs
			,util.InlineMax(ISNULL(ic.Quantity, 0) - ISNULL(i.Quantity, 0), 0) AS Needed
		FROM core.Material AS m
		LEFT JOIN [AccountInventory] AS i ON i.MaterialID = m.MaterialID
			AND i.AccountID = @AccountID
		LEFT JOIN dbo.fnInventoryCosts(@AccountID) AS ic ON ic.MaterialID = m.MaterialID
		)
