
-- =============================================
-- Author:		Trevor Burn
-- Create date: 2020/05/03
-- Description:	
-- =============================================
CREATE   FUNCTION fnGetWeaponCraftingCounts (
	@WeaponID INT
	)
RETURNS @WeaponCraftingCounts TABLE (
	WeaponID INT
	,ItemID INT
	,Quantity INT
	)
AS
BEGIN
	DECLARE @ParentWeaponID INT = @WeaponID
	DECLARE @Factor INT = 1
	DECLARE @results TABLE (
		WeaponID INT
		,ItemID INT
		,Quantity INT
		)

	WHILE @ParentWeaponID IS NOT NULL
	BEGIN
		INSERT @results (
			WeaponID
			,ItemID
			,Quantity
			)
		SELECT @WeaponID
			,wc.ItemID
			,wc.Quantity * @Factor
		FROM Weapon AS w
		INNER JOIN WeaponCrafting AS wc ON wc.WeaponID = w.WeaponID
		WHERE w.WeaponID = @ParentWeaponID

		SET @ParentWeaponID = (
				SELECT ParentWeaponID
				FROM Weapon
				WHERE WeaponID = @ParentWeaponID
				)
		SET @Factor = 5 * @Factor
	END

	INSERT @WeaponCraftingCounts (
		WeaponID
		,ItemID
		,Quantity
		)
	SELECT WeaponID
		,ItemID
		,SUM(Quantity) AS Quantity
	FROM @results
	GROUP BY WeaponID
		,ItemID

	RETURN
END