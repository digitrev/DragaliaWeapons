CREATE PROCEDURE [den].[spInitializeDenDrg]
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @Json NVARCHAR(MAX)

	TRUNCATE TABLE [den].[DragonAdvancedCosts]

	SET @JSON = N'[{"Greatsphere":120,"Sphere":100}]'

	INSERT [den].[DragonAdvancedCosts] (
		[Greatsphere]
		,[Sphere]
		)
	SELECT [Greatsphere]
		,[Sphere]
	FROM OPENJSON(@Json) WITH (
			[Greatsphere] INT
			,[Sphere] INT
			)

	TRUNCATE TABLE [den].[DragonAdvancedMats]

	SET @JSON = N'[{"Dragon":"High Brunhilda","GreatsphereMat":"Flamewyrm''s Greatsphere","SphereMat":"Flamewyrm''s Sphere"},{"Dragon":"High Jupiter","GreatsphereMat":"Lightwyrm''s Greatsphere","SphereMat":"Lightwyrm''s Sphere"},{"Dragon":"High Mercury","GreatsphereMat":"Waterwyrm''s Greatsphere","SphereMat":"Waterwyrm''s Sphere"},{"Dragon":"High Midgardsormr","GreatsphereMat":"Windwyrm''s Greatsphere","SphereMat":"Windwyrm''s Sphere"},{"Dragon":"High Zodiark","GreatsphereMat":"Shadowwyrm''s Greatsphere","SphereMat":"Shadowwyrm''s Sphere"}]'

	INSERT [den].[DragonAdvancedMats] (
		[Dragon]
		,[GreatsphereMat]
		,[SphereMat]
		)
	SELECT [Dragon]
		,[GreatsphereMat]
		,[SphereMat]
	FROM OPENJSON(@Json) WITH (
			[Dragon] NVARCHAR(50)
			,[GreatsphereMat] NVARCHAR(50)
			,[SphereMat] NVARCHAR(50)
			)

	TRUNCATE TABLE [den].[DragonTrialCosts]

	SET @JSON = N'[{"Sphere":30,"Scale":5}]'

	INSERT [den].[DragonTrialCosts] (
		[Sphere]
		,[Scale]
		)
	SELECT [Sphere]
		,[Scale]
	FROM OPENJSON(@Json) WITH (
			[Sphere] INT
			,[Scale] INT
			)

	TRUNCATE TABLE [den].[DragonTrialMats]

	SET @JSON = N'[{"Dragon":"Brunhilda","SphereMat":"Flamewyrm''s Sphere","ScaleMat":"Flamewyrm''s Scale"},{"Dragon":"Jupiter","SphereMat":"Lightwyrm''s Sphere","ScaleMat":"Lightwyrm''s Scale"},{"Dragon":"Mercury","SphereMat":"Waterwyrm''s Sphere","ScaleMat":"Waterwyrm''s Scale"},{"Dragon":"Midgardsormr","SphereMat":"Windwyrm''s Sphere","ScaleMat":"Windwyrm''s Scale"},{"Dragon":"Zodiark","SphereMat":"Shadowwyrm''s Sphere","ScaleMat":"Shadowwyrm''s Scale"}]'

	INSERT [den].[DragonTrialMats] (
		[Dragon]
		,[SphereMat]
		,[ScaleMat]
		)
	SELECT [Dragon]
		,[SphereMat]
		,[ScaleMat]
	FROM OPENJSON(@Json) WITH (
			[Dragon] NVARCHAR(50)
			,[SphereMat] NVARCHAR(50)
			,[ScaleMat] NVARCHAR(50)
			)

	TRUNCATE TABLE [den].[DragonVoidCosts]

	SET @JSON = N'[{"Dragon":"Bronze Fafnir","Seed":1},{"Dragon":"Gold Fafnir","Seed":4},{"Dragon":"Silver Fafnir","Seed":2}]'

	INSERT [den].[DragonVoidCosts] (
		[Dragon]
		,[Seed]
		)
	SELECT [Dragon]
		,[Seed]
	FROM OPENJSON(@Json) WITH (
			[Dragon] NVARCHAR(50)
			,[Seed] INT
			)
END
