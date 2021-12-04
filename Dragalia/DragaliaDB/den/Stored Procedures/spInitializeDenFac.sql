﻿CREATE PROCEDURE [den].[spInitializeDenFac]
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @Json NVARCHAR(MAX)

	TRUNCATE TABLE den.TreeCosts

	SET @Json = 
		N'[{"Level":1,"Silver":20},{"Level":2,"Rupie":10000,"Silver":10},{"Level":3,"Rupie":20000,"Silver":10},{"Level":4,"Rupie":30000,"Silver":20},{"Level":5,"Rupie":40000,"Silver":20},{"Level":6,"Rupie":50000,"Silver":30},{"Level":7,"Rupie":60000,"Silver":30},{"Level":8,"Rupie":70000,"Silver":30},{"Level":9,"Rupie":80000,"Silver":30},{"Level":10,"Rupie":90000,"Silver":30},{"Level":11,"Rupie":100000,"Silver":35,"Gold":5},{"Level":12,"Rupie":110000,"Silver":35,"Gold":5},{"Level":13,"Rupie":120000,"Silver":35,"Gold":5},{"Level":14,"Rupie":130000,"Silver":35,"Gold":5},{"Level":15,"Rupie":140000,"Silver":35,"Gold":5},{"Level":16,"Rupie":160000,"Silver":40,"Gold":10},{"Level":17,"Rupie":180000,"Silver":40,"Gold":10},{"Level":18,"Rupie":200000,"Silver":40,"Gold":10},{"Level":19,"Rupie":220000,"Silver":40,"Gold":10},{"Level":20,"Rupie":240000,"Silver":40,"Gold":10},{"Level":21,"Rupie":260000,"Silver":40,"Gold":10},{"Level":22,"Rupie":280000,"Silver":40,"Gold":10},{"Level":23,"Rupie":300000,"Silver":40,"Gold":10},{"Level":24,"Rupie":320000,"Silver":40,"Gold":10},{"Level":25,"Rupie":340000,"Silver":40,"Gold":10},{"Level":26,"Rupie":360000,"Silver":45,"Gold":15},{"Level":27,"Rupie":380000,"Silver":45,"Gold":15},{"Level":28,"Rupie":400000,"Silver":45,"Gold":15},{"Level":29,"Rupie":420000,"Silver":45,"Gold":15},{"Level":30,"Rupie":440000,"Silver":45,"Gold":15}]'

	INSERT den.TreeCosts (
		[Level]
		,[Rupie]
		,[Silver]
		,[Gold]
		)
	SELECT [Level]
		,[Rupie]
		,[Silver]
		,[Gold]
	FROM OPENJSON(@Json) WITH (
			[Level] INT
			,[Rupie] INT
			,[Silver] INT
			,[Gold] INT
			)

	TRUNCATE TABLE den.TreeMats

	SET @Json = N'[{"Facility":"Flame Tree","SilverMat":"Destitute One''s Mask Fragment","GoldMat":"Plagued One''s Mask Fragment"},{"Facility":"Shadow Tree","SilverMat":"Almighty One''s Mask Fragment","GoldMat":"Uprooting One''s Mask Fragment"},{"Facility":"Wind Tree","SilverMat":"Eliminating One''s Mask Fragment","GoldMat":"Despairing One''s Mask Fragment"},{"Facility":"Water Tree","SilverMat":"Soaring Ones'' Mask Fragment","GoldMat":"Liberated One''s Mask Fragment"},{"Facility":"Light Tree","SilverMat":"Remaining One''s Mask Fragment","GoldMat":"Vengeful One''s Mask Fragment"}]'

	INSERT den.TreeMats (
		[Facility]
		,[SilverMat]
		,[GoldMat]
		)
	SELECT [Facility]
		,[SilverMat]
		,[GoldMat]
	FROM OPENJSON(@Json) WITH (
			[Facility] NVARCHAR(50)
			,[SilverMat] NVARCHAR(50)
			,[GoldMat] NVARCHAR(50)
			)

	TRUNCATE TABLE den.MineCosts

	SET @Json = 
		N'[{"Level":1,"Rupie":50},{"Level":2,"Rupie":100},{"Level":3,"Rupie":150},{"Level":4,"Rupie":200},{"Level":5,"Rupie":250},{"Level":6,"Rupie":300,"T1":1},{"Level":7,"Rupie":350,"T1":1},{"Level":8,"Rupie":400,"T1":1},{"Level":9,"Rupie":500,"T1":2},{"Level":10,"Rupie":600,"T1":2},{"Level":11,"Rupie":700,"T1":3},{"Level":12,"Rupie":800,"T1":3},{"Level":13,"Rupie":900,"T1":3},{"Level":14,"Rupie":1000,"T1":5},{"Level":15,"Rupie":1100,"T1":5},{"Level":16,"Rupie":1200,"T1":8,"T2":1},{"Level":17,"Rupie":1400,"T1":8,"T2":1},{"Level":18,"Rupie":1600,"T1":8,"T2":1},{"Level":19,"Rupie":1800,"T1":10,"T2":1},{"Level":20,"Rupie":2000,"T1":10,"T2":1},{"Level":21,"Rupie":2200,"T1":15,"T2":2},{"Level":22,"Rupie":2400,"T1":15,"T2":2},{"Level":23,"Rupie":2600,"T1":15,"T2":2},{"Level":24,"Rupie":2800,"T1":20,"T2":2},{"Level":25,"Rupie":3000,"T1":20,"T2":2},{"Level":26,"Rupie":3200,"T1":30,"T2":3,"T3":1},{"Level":27,"Rupie":3400,"T1":30,"T2":3,"T3":1},{"Level":28,"Rupie":3600,"T1":30,"T2":3,"T3":1},{"Level":29,"Rupie":3800,"T1":40,"T2":3,"T3":1},{"Level":30,"Rupie":4000,"T1":40,"T2":3,"T3":1},{"Level":31,"Rupie":4200,"T1":50,"T2":5,"T3":2,"T4":1},{"Level":32,"Rupie":4400,"T1":55,"T2":10,"T3":4,"T4":2},{"Level":33,"Rupie":4600,"T1":65,"T2":15,"T3":6,"T4":3},{"Level":34,"Rupie":4800,"T1":80,"T2":20,"T3":9,"T4":5},{"Level":35,"Rupie":5000,"T1":100,"T2":30,"T3":12,"T4":7},{"Level":36,"Rupie":5200,"T1":130,"T2":40,"T3":15,"T4":9},{"Level":37,"Rupie":5400,"T1":160,"T2":50,"T3":20,"T4":12},{"Level":38,"Rupie":5600,"T1":200,"T2":65,"T3":25,"T4":15},{"Level":39,"Rupie":5800,"T1":260,"T2":80,"T3":30,"T4":18},{"Level":40,"Rupie":6000,"T1":400,"T2":100,"T3":40,"T4":25},{"Level":41,"Rupie":6200,"T1":540,"T2":120,"T3":50,"T4":32},{"Level":42,"Rupie":6400,"T1":680,"T2":140,"T3":60,"T4":39},{"Level":43,"Rupie":6600,"T1":820,"T2":160,"T3":70,"T4":46},{"Level":44,"Rupie":6800,"T1":960,"T2":180,"T3":80,"T4":53},{"Level":45,"Rupie":7000,"T1":1100,"T2":200,"T3":90,"T4":60}]'

	INSERT den.MineCosts (
		[Level]
		,[Rupie]
		,[T1]
		,[T2]
		,[T3]
		,[T4]
		)
	SELECT [Level]
		,[Rupie]
		,[T1]
		,[T2]
		,[T3]
		,[T4]
	FROM OPENJSON(@Json) WITH (
			[Level] INT
			,[Rupie] INT
			,[T1] INT
			,[T2] INT
			,[T3] INT
			,[T4] INT
			)

	TRUNCATE TABLE den.DojoCosts

	SET @Json = 
		N'[{"Level":1},{"Level":2,"Rupie":3000,"Aes":10},{"Level":3,"Rupie":3500,"Aes":10},{"Level":4,"Rupie":4000,"Aes":10},{"Level":5,"Rupie":4500,"Aes":10},{"Level":6,"Rupie":5000,"Aes":20},{"Level":7,"Rupie":6000,"Aes":20},{"Level":8,"Rupie":7000,"Aes":20},{"Level":9,"Rupie":8000,"Aes":20},{"Level":10,"Rupie":9000,"Aes":20},{"Level":11,"Rupie":10000,"Aes":30,"Argenteus":5,"Silver":10},{"Level":12,"Rupie":12000,"Aes":30,"Argenteus":5,"Silver":10},{"Level":13,"Rupie":14000,"Aes":30,"Argenteus":5,"Silver":10},{"Level":14,"Rupie":16000,"Aes":30,"Argenteus":10,"Silver":20},{"Level":15,"Rupie":18000,"Aes":30,"Argenteus":10,"Silver":20},{"Level":16,"Rupie":20000,"Aes":50,"Argenteus":20,"Silver":40},{"Level":17,"Rupie":25000,"Aes":50,"Argenteus":20,"Silver":40},{"Level":18,"Rupie":30000,"Aes":50,"Argenteus":20,"Silver":40},{"Level":19,"Rupie":35000,"Aes":70,"Argenteus":30,"Silver":60},{"Level":20,"Rupie":40000,"Aes":70,"Argenteus":30,"Silver":60},{"Level":21,"Rupie":50000,"Aes":100,"Argenteus":40,"Aureus":20,"Silver":80},{"Level":22,"Rupie":60000,"Aes":100,"Argenteus":40,"Aureus":30,"Silver":80},{"Level":23,"Rupie":70000,"Aes":100,"Argenteus":40,"Aureus":40,"Silver":80},{"Level":24,"Rupie":80000,"Aes":150,"Argenteus":50,"Aureus":50,"Silver":100},{"Level":25,"Rupie":90000,"Aes":150,"Argenteus":50,"Aureus":60,"Silver":100},{"Level":26,"Rupie":100000,"Aes":200,"Argenteus":60,"Aureus":70,"Silver":120,"Gold":20},{"Level":27,"Rupie":110000,"Aes":200,"Argenteus":60,"Aureus":80,"Silver":120,"Gold":30},{"Level":28,"Rupie":120000,"Aes":200,"Argenteus":60,"Aureus":90,"Silver":120,"Gold":40},{"Level":29,"Rupie":130000,"Aes":300,"Argenteus":80,"Aureus":100,"Silver":160,"Gold":50},{"Level":30,"Rupie":140000,"Aes":300,"Argenteus":80,"Aureus":110,"Silver":160,"Gold":60},{"Level":31,"Rupie":160000,"Aes":300,"Argenteus":100,"Aureus":120,"Silver":200,"Gold":80},{"Level":32,"Rupie":180000,"Aes":400,"Argenteus":100,"Aureus":130,"Silver":200,"Gold":80},{"Level":33,"Rupie":200000,"Aes":400,"Argenteus":100,"Aureus":140,"Silver":200,"Gold":80},{"Level":34,"Rupie":220000,"Aes":500,"Argenteus":120,"Aureus":150,"Silver":240,"Gold":100},{"Level":35,"Rupie":240000,"Aes":500,"Argenteus":120,"Aureus":160,"Silver":240,"Gold":100},{"Level":36,"Rupie":400000,"Argenteus":150,"Aureus":175,"Silver":260,"Gold":100,"Blessing":2},{"Level":37,"Rupie":500000,"Argenteus":175,"Aureus":200,"Silver":280,"Gold":120,"Blessing":2},{"Level":38,"Rupie":620000,"Argenteus":200,"Aureus":225,"Silver":300,"Gold":140,"Blessing":3},{"Level":39,"Rupie":760000,"Argenteus":225,"Aureus":250,"Silver":320,"Gold":160,"Blessing":3},{"Level":40,"Rupie":920000,"Argenteus":250,"Aureus":275,"Silver":340,"Gold":180,"Blessing":4}]'

	INSERT den.DojoCosts (
		[Level]
		,[Rupie]
		,[Aes]
		,[Argenteus]
		,[Aureus]
		,[Silver]
		,[Gold]
		,[Blessing]
		)
	SELECT [Level]
		,[Rupie]
		,[Aes]
		,[Argentus]
		,[Aureus]
		,[Silver]
		,[Gold]
		,[Blessing]
	FROM OPENJSON(@Json) WITH (
			[Level] INT
			,[Rupie] INT
			,[Aes] INT
			,[Argentus] INT
			,[Aureus] INT
			,[Silver] INT
			,[Gold] INT
			,[Blessing] INT
			)

	TRUNCATE TABLE den.DojoMats

	SET @Json = N'[{"Facility":"Axe Dojo","SilverMat":"Jade Insignia","GoldMat":"Royal Jade Insignia"},{"Facility":"Blade Dojo","SilverMat":"Azure Insignia","GoldMat":"Royal Azure Insignia"},{"Facility":"Bow Dojo","SilverMat":"Vermilion Insignia","GoldMat":"Royal Vermilion Insignia"},{"Facility":"Dagger Dojo","SilverMat":"Violet Insignia","GoldMat":"Royal Violet Insignia"},{"Facility":"Lance Dojo","SilverMat":"Azure Insignia","GoldMat":"Royal Azure Insignia"},{"Facility":"Manacaster Dojo","SilverMat":"Violet Insignia","GoldMat":"Royal Violet Insignia"},{"Facility":"Staff Dojo","SilverMat":"Amber Insignia","GoldMat":"Royal Amber Insignia"},{"Facility":"Sword Dojo","SilverMat":"Vermilion Insignia","GoldMat":"Royal Vermilion Insignia"},{"Facility":"Wand Dojo","SilverMat":"Jade Insignia","GoldMat":"Royal Jade Insignia"}]'

	INSERT den.DojoMats (
		[Facility]
		,[SilverMat]
		,[GoldMat]
		)
	SELECT [Facility]
		,[SilverMat]
		,[GoldMat]
	FROM OPENJSON(@Json) WITH (
			[Facility] NVARCHAR(50)
			,[SilverMat] NVARCHAR(50)
			,[GoldMat] NVARCHAR(50)
			)

	TRUNCATE TABLE den.AltarCosts

	SET @Json = 
		N'[{"Level":1,"Rupie":200},{"Level":2,"Rupie":400},{"Level":3,"Rupie":600},{"Level":4,"Rupie":800,"T1":1},{"Level":5,"Rupie":1000,"T1":3},{"Level":6,"Rupie":1200,"T1":5},{"Level":7,"Rupie":1500,"T1":5},{"Level":8,"Rupie":2000,"T1":5},{"Level":9,"Rupie":2500,"T1":7},{"Level":10,"Rupie":3000,"T1":7},{"Level":11,"Rupie":4000,"T1":10,"T2":1},{"Level":12,"Rupie":5000,"T1":10,"T2":1},{"Level":13,"Rupie":6000,"T1":10,"T2":1},{"Level":14,"Rupie":7000,"T1":15,"T2":2},{"Level":15,"Rupie":8000,"T1":15,"T2":2},{"Level":16,"Rupie":10000,"T1":20,"T2":3},{"Level":17,"Rupie":12000,"T1":20,"T2":3},{"Level":18,"Rupie":14000,"T1":20,"T2":3},{"Level":19,"Rupie":16000,"T1":30,"T2":4},{"Level":20,"Rupie":18000,"T1":30,"T2":4},{"Level":21,"Rupie":20000,"T1":50,"T2":6,"T3":1},{"Level":22,"Rupie":22000,"T1":50,"T2":6,"T3":1},{"Level":23,"Rupie":24000,"T1":50,"T2":6,"T3":1},{"Level":24,"Rupie":26000,"T1":70,"T2":8,"T3":1},{"Level":25,"Rupie":28000,"T1":70,"T2":8,"T3":1},{"Level":26,"Rupie":30000,"T1":100,"T2":10,"T3":2},{"Level":27,"Rupie":32000,"T1":100,"T2":10,"T3":2},{"Level":28,"Rupie":34000,"T1":100,"T2":10,"T3":2},{"Level":29,"Rupie":36000,"T1":150,"T2":12,"T3":3},{"Level":30,"Rupie":38000,"T1":150,"T2":12,"T3":3},{"Level":31,"Rupie":42000,"T1":200,"T2":15,"T3":5},{"Level":32,"Rupie":46000,"T1":200,"T2":15,"T3":5},{"Level":33,"Rupie":50000,"T1":200,"T2":15,"T3":5},{"Level":34,"Rupie":54000,"T1":250,"T2":18,"T3":7},{"Level":35,"Rupie":58000,"T1":250,"T2":18,"T3":7},{"Level":36,"Rupie":100000,"T1":300,"T2":36,"T3":15,"T4":2,"Rainbow":6},{"Level":37,"Rupie":140000,"T1":350,"T2":72,"T3":30,"T4":4,"Rainbow":12},{"Level":38,"Rupie":190000,"T1":400,"T2":108,"T3":45,"T4":6,"Rainbow":18},{"Level":39,"Rupie":250000,"T1":450,"T2":144,"T3":60,"T4":8,"Rainbow":24},{"Level":40,"Rupie":320000,"T1":500,"T2":180,"T3":75,"T4":10,"Rainbow":30},{"Level":41,"Rupie":400000,"T2":300,"T3":125,"T4":14,"Rainbow":45,"Blessing":2},{"Level":42,"Rupie":500000,"T2":350,"T3":150,"T4":18,"Rainbow":55,"Blessing":2},{"Level":43,"Rupie":620000,"T2":400,"T3":175,"T4":22,"Rainbow":65,"Blessing":3},{"Level":44,"Rupie":760000,"T2":450,"T3":200,"T4":26,"Rainbow":75,"Blessing":3},{"Level":45,"Rupie":920000,"T2":500,"T3":225,"T4":30,"Rainbow":85,"Blessing":4}]'

	INSERT den.AltarCosts (
		[Level]
		,[Rupie]
		,[T1]
		,[T2]
		,[T3]
		,[T4]
		,[Rainbow]
		,[Blessing]
		)
	SELECT [Level]
		,[Rupie]
		,[T1]
		,[T2]
		,[T3]
		,[T4]
		,[Rainbow]
		,[Blessing]
	FROM OPENJSON(@Json) WITH (
			[Level] INT
			,[Rupie] INT
			,[T1] INT
			,[T2] INT
			,[T3] INT
			,[T4] INT
			,[Rainbow] INT
			,[Blessing] INT
			)

	TRUNCATE TABLE den.AltarMats

	SET @Json = N'[{"Facility":"Flame Altar","T1Mat":"Flame Orb","T2Mat":"Blaze Orb","T3Mat":"Inferno Orb","T4Mat":"Incandescence Orb"},{"Facility":"Light Altar","T1Mat":"Light Orb","T2Mat":"Radiance Orb","T3Mat":"Refulgence Orb","T4Mat":"Resplendence Orb"},{"Facility":"Shadow Altar","T1Mat":"Shadow Orb","T2Mat":"Nightfall Orb","T3Mat":"Nether Orb","T4Mat":"Abaddon Orb"},{"Facility":"Water Altar","T1Mat":"Water Orb","T2Mat":"Stream Orb","T3Mat":"Deluge Orb","T4Mat":"Tsunami Orb"},{"Facility":"Wind Altar","T1Mat":"Wind Orb","T2Mat":"Storm Orb","T3Mat":"Maelstrom Orb","T4Mat":"Tempest Orb"}]'

	INSERT den.AltarMats (
		[Facility]
		,[T1Mat]
		,[T2Mat]
		,[T3Mat]
		,[T4Mat]
		)
	SELECT [Facility]
		,[T1Mat]
		,[T2Mat]
		,[T3Mat]
		,[T4Mat]
	FROM OPENJSON(@Json) WITH (
			[Facility] NVARCHAR(50)
			,[T1Mat] NVARCHAR(50)
			,[T2Mat] NVARCHAR(50)
			,[T3Mat] NVARCHAR(50)
			,[T4Mat] NVARCHAR(50)
			)

	TRUNCATE TABLE den.DracolithCosts

	SET @Json = 
		N'[{"Level":1},{"Level":2,"Rupie":3000},{"Level":3,"Rupie":4000},{"Level":4,"Rupie":5000,"Sphere":5,"Scale":3,"Talonstone":1},{"Level":5,"Rupie":6000,"Sphere":10,"Scale":4,"Talonstone":1},{"Level":6,"Rupie":7000,"Sphere":15,"Scale":5,"Talonstone":1},{"Level":7,"Rupie":8000,"Sphere":20,"Scale":6,"Talonstone":3},{"Level":8,"Rupie":10000,"Sphere":25,"Scale":7,"Talonstone":3},{"Level":9,"Rupie":12000,"Sphere":30,"Scale":8,"Talonstone":3},{"Level":10,"Rupie":14000,"Sphere":35,"Scale":10,"Talonstone":3},{"Level":11,"Rupie":16000,"Sphere":40,"Scale":15,"Talonstone":5},{"Level":12,"Rupie":18000,"Sphere":50,"Scale":20,"Talonstone":5},{"Level":13,"Rupie":20000,"Sphere":60,"Scale":25,"Talonstone":5},{"Level":14,"Rupie":22000,"Sphere":90,"Scale":30,"Talonstone":8},{"Level":15,"Rupie":24000,"Sphere":120,"Scale":40,"Talonstone":8},{"Level":16,"Rupie":26000,"Sphere":150,"Scale":60,"Talonstone":8},{"Level":17,"Rupie":28000,"Sphere":200,"Scale":80,"Talonstone":10},{"Level":18,"Rupie":30000,"Sphere":250,"Scale":100,"Talonstone":10},{"Level":19,"Rupie":32000,"Sphere":300,"Scale":120,"Talonstone":10},{"Level":20,"Rupie":34000,"Sphere":350,"Scale":140,"Talonstone":10},{"Level":21,"Rupie":50000,"Greatsphere":10,"GoldScale":27,"Talonstone":14},{"Level":22,"Rupie":74000,"Greatsphere":14,"GoldScale":31,"Talonstone":19},{"Level":23,"Rupie":110000,"Greatsphere":20,"GoldScale":34,"Talonstone":26},{"Level":24,"Rupie":160000,"Greatsphere":29,"GoldScale":37,"Talonstone":35},{"Level":25,"Rupie":240000,"Greatsphere":41,"GoldScale":40,"Talonstone":48},{"Level":26,"Rupie":360000,"Greatsphere":60,"GoldScale":45,"Talonstone":66},{"Level":27,"Rupie":520000,"Greatsphere":86,"GoldScale":50,"Talonstone":91},{"Level":28,"Rupie":789999,"Greatsphere":122,"GoldScale":60,"Talonstone":124},{"Level":29,"Rupie":1150000,"Greatsphere":174,"GoldScale":66,"Talonstone":170},{"Level":30,"Rupie":1700000,"Greatsphere":250,"GoldScale":72,"Talonstone":233}]'

	INSERT den.DracolithCosts (
		[Level]
		,[Rupie]
		,[Sphere]
		,[Greatsphere]
		,[Scale]
		,[GoldScale]
		,[Talonstone]
		)
	SELECT [Level]
		,[Rupie]
		,[Sphere]
		,[Greatsphere]
		,[Scale]
		,[GoldScale]
		,[Talonstone]
	FROM OPENJSON(@Json) WITH (
			[Level] INT
			,[Rupie] INT
			,[Sphere] INT
			,[Greatsphere] INT
			,[Scale] INT
			,[GoldScale] INT
			,[Talonstone] INT
			)

	TRUNCATE TABLE den.DracolithMats

	SET @Json = N'[{"Facility":"Flame Dracolith","SphereMat":"Flamewyrm''s Sphere","GreatsphereMat":"Flamewyrm''s Greatsphere","ScaleMat":"Flamewyrm''s Scale","GoldScaleMat":"Flamewyrm''s Scaldscale"},{"Facility":"Light Dracolith","SphereMat":"Lightwyrm''s Sphere","GreatsphereMat":"Lightwyrm''s Greatsphere","ScaleMat":"Lightwyrm''s Scale","GoldScaleMat":"Lightwyrm''s Glowscale"},{"Facility":"Shadow Dracolith","SphereMat":"Shadowwyrm''s Sphere","GreatsphereMat":"Shadowwyrm''s Greatsphere","ScaleMat":"Shadowwyrm''s Scale","GoldScaleMat":"Shadowwyrm''s Darkscale"},{"Facility":"Water Dracolith","SphereMat":"Waterwyrm''s Sphere","GreatsphereMat":"Waterwyrm''s Greatsphere","ScaleMat":"Waterwyrm''s Scale","GoldScaleMat":"Waterwyrm''s Glistscale"},{"Facility":"Wind Dracolith","SphereMat":"Windwyrm''s Sphere","GreatsphereMat":"Windwyrm''s Greatsphere","ScaleMat":"Windwyrm''s Scale","GoldScaleMat":"Windwyrm''s Squallscale"}]'

	INSERT den.DracolithMats (
		[Facility]
		,[SphereMat]
		,[GreatsphereMat]
		,[ScaleMat]
		,[GoldScaleMat]
		)
	SELECT [Facility]
		,[SphereMat]
		,[GreatsphereMat]
		,[ScaleMat]
		,[GoldScaleMat]
	FROM OPENJSON(@Json) WITH (
			[Facility] NVARCHAR(50)
			,[SphereMat] NVARCHAR(50)
			,[GreatsphereMat] NVARCHAR(50)
			,[ScaleMat] NVARCHAR(50)
			,[GoldScaleMat] NVARCHAR(50)
			)

	TRUNCATE TABLE den.FafnirCosts

	SET @Json = 
		N'[{"Level":1,"Greatsphere":30,"Talonstone":10},{"Level":2,"Rupie":10000,"Greatsphere":3},{"Level":3,"Rupie":20000,"Greatsphere":3},{"Level":4,"Rupie":30000,"Greatsphere":5},{"Level":5,"Rupie":40000,"Greatsphere":5},{"Level":6,"Rupie":50000,"Greatsphere":7,"GoldScale":5,"Talonstone":10},{"Level":7,"Rupie":60000,"Greatsphere":7,"GoldScale":5,"Talonstone":10},{"Level":8,"Rupie":70000,"Greatsphere":7,"GoldScale":5,"Talonstone":10},{"Level":9,"Rupie":80000,"Greatsphere":10,"GoldScale":5,"Talonstone":10},{"Level":10,"Rupie":90000,"Greatsphere":10,"GoldScale":5,"Talonstone":10},{"Level":11,"Rupie":100000,"Greatsphere":12,"GoldScale":10,"Talonstone":20},{"Level":12,"Rupie":110000,"Greatsphere":12,"GoldScale":10,"Talonstone":20},{"Level":13,"Rupie":120000,"Greatsphere":15,"GoldScale":10,"Talonstone":20},{"Level":14,"Rupie":130000,"Greatsphere":15,"GoldScale":10,"Talonstone":20},{"Level":15,"Rupie":140000,"Greatsphere":15,"GoldScale":10,"Talonstone":20},{"Level":16,"Rupie":160000,"Greatsphere":20,"GoldScale":20,"Talonstone":30},{"Level":17,"Rupie":180000,"Greatsphere":20,"GoldScale":20,"Talonstone":30},{"Level":18,"Rupie":200000,"Greatsphere":20,"GoldScale":20,"Talonstone":30},{"Level":19,"Rupie":220000,"Greatsphere":30,"GoldScale":20,"Talonstone":30},{"Level":20,"Rupie":240000,"Greatsphere":30,"GoldScale":20,"Talonstone":30},{"Level":21,"Rupie":260000,"Greatsphere":40,"GoldScale":30,"Talonstone":40},{"Level":22,"Rupie":280000,"Greatsphere":40,"GoldScale":30,"Talonstone":40},{"Level":23,"Rupie":300000,"Greatsphere":40,"GoldScale":30,"Talonstone":40},{"Level":24,"Rupie":320000,"Greatsphere":50,"GoldScale":30,"Talonstone":40},{"Level":25,"Rupie":340000,"Greatsphere":50,"GoldScale":30,"Talonstone":40},{"Level":26,"Rupie":360000,"Greatsphere":60,"GoldScale":50,"Talonstone":60},{"Level":27,"Rupie":380000,"Greatsphere":60,"GoldScale":50,"Talonstone":60},{"Level":28,"Rupie":400000,"Greatsphere":60,"GoldScale":50,"Talonstone":60},{"Level":29,"Rupie":420000,"Greatsphere":70,"GoldScale":50,"Talonstone":60},{"Level":30,"Rupie":440000,"Greatsphere":70,"GoldScale":50,"Talonstone":60}]'

	INSERT den.FafnirCosts (
		[Level]
		,[Rupie]
		,[Greatsphere]
		,[GoldScale]
		,[Talonstone]
		)
	SELECT [Level]
		,[Rupie]
		,[Greatsphere]
		,[GoldScale]
		,[Talonstone]
	FROM OPENJSON(@Json) WITH (
			[Level] INT
			,[Rupie] INT
			,[Greatsphere] INT
			,[GoldScale] INT
			,[Talonstone] INT
			)

	TRUNCATE TABLE den.FafnirMats

	SET @Json = N'[{"Facility":"Fafnir Statue (Flame)","GreatsphereMat":"Flamewyrm''s Greatsphere","GoldScaleMat":"Flamewyrm''s Scaldscale"},{"Facility":"Fafnir Statue (Light)","GreatsphereMat":"Lightwyrm''s Greatsphere","GoldScaleMat":"Lightwyrm''s Glowscale"},{"Facility":"Fafnir Statue (Shadow)","GreatsphereMat":"Shadowwyrm''s Greatsphere","GoldScaleMat":"Shadowwyrm''s Darkscale"},{"Facility":"Fafnir Statue (Water)","GreatsphereMat":"Waterwyrm''s Greatsphere","GoldScaleMat":"Waterwyrm''s Glistscale"},{"Facility":"Fafnir Statue (Wind)","GreatsphereMat":"Windwyrm''s Greatsphere","GoldScaleMat":"Windwyrm''s Squallscale"}]'

	INSERT den.FafnirMats (
		[Facility]
		,[GreatsphereMat]
		,[GoldScaleMat]
		)
	SELECT [Facility]
		,[GreatsphereMat]
		,[GoldScaleMat]
	FROM OPENJSON(@Json) WITH (
			[Facility] NVARCHAR(50)
			,[GreatsphereMat] NVARCHAR(50)
			,[GoldScaleMat] NVARCHAR(50)
			)

	TRUNCATE TABLE den.StatueCosts

	SET @Json = N'[{"Level":1,"Seed":1},{"Level":2,"Rupie":5000,"Bronze":10},{"Level":3,"Rupie":10000,"Bronze":15,"Void1":2},{"Level":4,"Rupie":15000,"Bronze":20},{"Level":5,"Rupie":20000,"Bronze":25,"Void1":5},{"Level":6,"Rupie":25000,"Bronze":30,"Silver":5},{"Level":7,"Rupie":30000,"Bronze":35,"Silver":10,"Void2":2},{"Level":8,"Rupie":35000,"Bronze":40,"Silver":15},{"Level":9,"Rupie":40000,"Bronze":45,"Silver":20,"Void2":5},{"Level":10,"Rupie":50000,"Bronze":50,"Silver":25},{"Level":11,"Rupie":60000,"Bronze":55,"Silver":30,"Gold":5,"Void3":2},{"Level":12,"Rupie":70000,"Bronze":60,"Silver":35,"Gold":10},{"Level":13,"Rupie":80000,"Bronze":65,"Silver":40,"Gold":15,"Void3":5},{"Level":14,"Rupie":90000,"Bronze":70,"Silver":45,"Gold":20},{"Level":15,"Rupie":100000,"Bronze":75,"Silver":50,"Gold":30,"Void3":8}]'

	INSERT den.StatueCosts (
		[Level]
		,[Rupie]
		,[Bronze]
		,[Void1]
		,[Silver]
		,[Void2]
		,[Gold]
		,[Void3]
		,[Seed]
		)
	SELECT [Level]
		,[Rupie]
		,[Bronze]
		,[Void1]
		,[Silver]
		,[Void2]
		,[Gold]
		,[Void3]
		,[Seed]
	FROM OPENJSON(@Json) WITH (
			[Level] INT
			,[Rupie] INT
			,[Bronze] INT
			,[Void1] INT
			,[Silver] INT
			,[Void2] INT
			,[Gold] INT
			,[Void3] INT
			,[Seed] INT
			)

	TRUNCATE TABLE den.StatueMats

	SET @Json = N'[{"Facility":"Aero Slime Statue","BronzeMat":"Fiend''s Claw","Void1Mat":"Solid Fungus","SilverMat":"Fiend''s Horn","Void2Mat":"Goblin Thread","GoldMat":"Fiend''s Eye","Void3Mat":"Oceanic Fin"},{"Facility":"Aqua Slime Statue","BronzeMat":"Iron Ore","Void1Mat":"Old Cloth","SilverMat":"Granite","Void2Mat":"Goblin Thread","GoldMat":"Meteorite","Void3Mat":"Blazing Horn"},{"Facility":"Magma Slime Statue","BronzeMat":"Bat''s Wing","Void1Mat":"Solid Fungus","SilverMat":"Ancient Bird''s Feather","Void2Mat":"Steel Slab","GoldMat":"Bewitching Wings","Void3Mat":"Great Feather"},{"Facility":"Poison Slime Statue","BronzeMat":"Iron Ore","Void1Mat":"Old Cloth","SilverMat":"Granite","Void2Mat":"Solid Fungus","GoldMat":"Meteorite","Void3Mat":"Necroblossom"},{"Facility":"Twinkling Slime Statue","BronzeMat":"Iron Ore","Void1Mat":"Solid Fungus","SilverMat":"Granite","Void2Mat":"Goblin Thread","GoldMat":"Meteorite","Void3Mat":"Ruinous Horn"}]'

	INSERT den.StatueMats (
		[Facility]
		,[BronzeMat]
		,[Void1Mat]
		,[SilverMat]
		,[Void2Mat]
		,[GoldMat]
		,[Void3Mat]
		)
	SELECT [Facility]
		,[BronzeMat]
		,[Void1Mat]
		,[SilverMat]
		,[Void2Mat]
		,[GoldMat]
		,[Void3Mat]
	FROM OPENJSON(@Json) WITH (
			[Facility] NVARCHAR(50)
			,[BronzeMat] NVARCHAR(50)
			,[Void1Mat] NVARCHAR(50)
			,[SilverMat] NVARCHAR(50)
			,[Void2Mat] NVARCHAR(50)
			,[GoldMat] NVARCHAR(50)
			,[Void3Mat] NVARCHAR(50)
			)

	TRUNCATE TABLE [den].[HalidomSmithy]

	SET @Json = 
		N'[{"Facility":"Halidom","Level":2,"Material":"Rupies","Quantity":5000},{"Facility":"Halidom","Level":3,"Material":"Rupies","Quantity":20000},{"Facility":"Halidom","Level":3,"Material":"Wind Orb","Quantity":10},{"Facility":"Halidom","Level":3,"Material":"Storm Orb","Quantity":1},{"Facility":"Halidom","Level":3,"Material":"Talonstone","Quantity":3},{"Facility":"Halidom","Level":4,"Material":"Rupies","Quantity":50000},{"Facility":"Halidom","Level":4,"Material":"Water Orb","Quantity":20},{"Facility":"Halidom","Level":4,"Material":"Stream Orb","Quantity":3},{"Facility":"Halidom","Level":4,"Material":"Deluge Orb","Quantity":1},{"Facility":"Halidom","Level":4,"Material":"Talonstone","Quantity":5},{"Facility":"Halidom","Level":5,"Material":"Rupies","Quantity":100000},{"Facility":"Halidom","Level":5,"Material":"Flame Orb","Quantity":50},{"Facility":"Halidom","Level":5,"Material":"Blaze Orb","Quantity":7},{"Facility":"Halidom","Level":5,"Material":"Inferno Orb","Quantity":2},{"Facility":"Halidom","Level":5,"Material":"Talonstone","Quantity":10},{"Facility":"Halidom","Level":6,"Material":"Rupies","Quantity":150000},{"Facility":"Halidom","Level":6,"Material":"Light Orb","Quantity":100},{"Facility":"Halidom","Level":6,"Material":"Radiance Orb","Quantity":15},{"Facility":"Halidom","Level":6,"Material":"Refulgence Orb","Quantity":3},{"Facility":"Halidom","Level":6,"Material":"Talonstone","Quantity":15},{"Facility":"Halidom","Level":7,"Material":"Rupies","Quantity":200000},{"Facility":"Halidom","Level":7,"Material":"Shadow Orb","Quantity":150},{"Facility":"Halidom","Level":7,"Material":"Nightfall Orb","Quantity":20},{"Facility":"Halidom","Level":7,"Material":"Nether Orb","Quantity":4},{"Facility":"Halidom","Level":7,"Material":"Talonstone","Quantity":20},{"Facility":"Halidom","Level":8,"Material":"Rupies","Quantity":250000},{"Facility":"Halidom","Level":8,"Material":"Wind Orb","Quantity":200},{"Facility":"Halidom","Level":8,"Material":"Storm Orb","Quantity":25},{"Facility":"Halidom","Level":8,"Material":"Maelstrom Orb","Quantity":6},{"Facility":"Halidom","Level":8,"Material":"Talonstone","Quantity":25},{"Facility":"Halidom","Level":9,"Material":"Rupies","Quantity":300000},{"Facility":"Halidom","Level":9,"Material":"Water Orb","Quantity":300},{"Facility":"Halidom","Level":9,"Material":"Stream Orb","Quantity":40},{"Facility":"Halidom","Level":9,"Material":"Deluge Orb","Quantity":9},{"Facility":"Halidom","Level":9,"Material":"Talonstone","Quantity":30},{"Facility":"Halidom","Level":10,"Material":"Rupies","Quantity":350000},{"Facility":"Halidom","Level":10,"Material":"Flame Orb","Quantity":400},{"Facility":"Halidom","Level":10,"Material":"Blaze Orb","Quantity":80},{"Facility":"Halidom","Level":10,"Material":"Inferno Orb","Quantity":20},{"Facility":"Halidom","Level":10,"Material":"Rainbow Orb","Quantity":40},{"Facility":"Halidom","Level":10,"Material":"Talonstone","Quantity":500},{"Facility":"Smithy","Level":2,"Material":"Rupies","Quantity":1000},{"Facility":"Smithy","Level":3,"Material":"Rupies","Quantity":5000},{"Facility":"Smithy","Level":3,"Material":"Light Metal","Quantity":3},{"Facility":"Smithy","Level":4,"Material":"Rupies","Quantity":20000},{"Facility":"Smithy","Level":4,"Material":"Iron Ore","Quantity":10},{"Facility":"Smithy","Level":4,"Material":"Fiend''s Claw","Quantity":10},{"Facility":"Smithy","Level":4,"Material":"Bat''s Wing","Quantity":10},{"Facility":"Smithy","Level":5,"Material":"Rupies","Quantity":40000},{"Facility":"Smithy","Level":5,"Material":"Iron Ore","Quantity":15},{"Facility":"Smithy","Level":5,"Material":"Fiend''s Claw","Quantity":15},{"Facility":"Smithy","Level":5,"Material":"Bat''s Wing","Quantity":15},{"Facility":"Smithy","Level":5,"Material":"Light Metal","Quantity":15},{"Facility":"Smithy","Level":6,"Material":"Rupies","Quantity":60000},{"Facility":"Smithy","Level":6,"Material":"Granite","Quantity":10},{"Facility":"Smithy","Level":6,"Material":"Fiend''s Horn","Quantity":10},{"Facility":"Smithy","Level":6,"Material":"Ancient Bird''s Feather","Quantity":10},{"Facility":"Smithy","Level":7,"Material":"Rupies","Quantity":80000},{"Facility":"Smithy","Level":7,"Material":"Granite","Quantity":15},{"Facility":"Smithy","Level":7,"Material":"Fiend''s Horn","Quantity":15},{"Facility":"Smithy","Level":7,"Material":"Ancient Bird''s Feather","Quantity":15},{"Facility":"Smithy","Level":7,"Material":"Abyss Stone","Quantity":15},{"Facility":"Smithy","Level":8,"Material":"Rupies","Quantity":100000},{"Facility":"Smithy","Level":8,"Material":"Meteorite","Quantity":10},{"Facility":"Smithy","Level":8,"Material":"Fiend''s Eye","Quantity":10},{"Facility":"Smithy","Level":8,"Material":"Bewitching Wings","Quantity":10},{"Facility":"Smithy","Level":9,"Material":"Rupies","Quantity":120000},{"Facility":"Smithy","Level":9,"Material":"Meteorite","Quantity":15},{"Facility":"Smithy","Level":9,"Material":"Fiend''s Eye","Quantity":15},{"Facility":"Smithy","Level":9,"Material":"Bewitching Wings","Quantity":15},{"Facility":"Smithy","Level":9,"Material":"Crimson Core","Quantity":15},{"Facility":"Dragontree","Level":2,"Material":"Rupies","Quantity":100},{"Facility":"Dragontree","Level":3,"Material":"Rupies","Quantity":300},{"Facility":"Dragontree","Level":4,"Material":"Rupies","Quantity":500},{"Facility":"Dragontree","Level":5,"Material":"Rupies","Quantity":1000},{"Facility":"Dragontree","Level":6,"Material":"Rupies","Quantity":2000},{"Facility":"Dragontree","Level":7,"Material":"Rupies","Quantity":3000},{"Facility":"Dragontree","Level":8,"Material":"Rupies","Quantity":5000},{"Facility":"Dragontree","Level":9,"Material":"Rupies","Quantity":7000},{"Facility":"Dragontree","Level":10,"Material":"Rupies","Quantity":9000},{"Facility":"Dragontree","Level":11,"Material":"Rupies","Quantity":12000},{"Facility":"Dragontree","Level":12,"Material":"Rupies","Quantity":15000},{"Facility":"Dragontree","Level":13,"Material":"Rupies","Quantity":18000},{"Facility":"Dragontree","Level":14,"Material":"Rupies","Quantity":21000},{"Facility":"Dragontree","Level":15,"Material":"Rupies","Quantity":24000},{"Facility":"Dragontree","Level":16,"Material":"Rupies","Quantity":27000},{"Facility":"Dragontree","Level":17,"Material":"Rupies","Quantity":30000},{"Facility":"Dragontree","Level":18,"Material":"Rupies","Quantity":35000},{"Facility":"Dragontree","Level":19,"Material":"Rupies","Quantity":40000},{"Facility":"Dragontree","Level":20,"Material":"Rupies","Quantity":50000},{"Facility":"Dragontree","Level":21,"Material":"Rupies","Quantity":60000},{"Facility":"Dragontree","Level":22,"Material":"Rupies","Quantity":80000},{"Facility":"Dragontree","Level":23,"Material":"Rupies","Quantity":100000},{"Facility":"Dragontree","Level":24,"Material":"Rupies","Quantity":120000},{"Facility":"Dragontree","Level":25,"Material":"Rupies","Quantity":140000},{"Facility":"Dragontree","Level":26,"Material":"Rupies","Quantity":160000},{"Facility":"Dragontree","Level":27,"Material":"Rupies","Quantity":180000},{"Facility":"Dragontree","Level":4,"Material":"Talonstone","Quantity":1},{"Facility":"Dragontree","Level":5,"Material":"Talonstone","Quantity":1},{"Facility":"Dragontree","Level":6,"Material":"Talonstone","Quantity":2},{"Facility":"Dragontree","Level":7,"Material":"Talonstone","Quantity":2},{"Facility":"Dragontree","Level":8,"Material":"Talonstone","Quantity":3},{"Facility":"Dragontree","Level":9,"Material":"Talonstone","Quantity":3},{"Facility":"Dragontree","Level":10,"Material":"Talonstone","Quantity":4},{"Facility":"Dragontree","Level":11,"Material":"Talonstone","Quantity":5},{"Facility":"Dragontree","Level":12,"Material":"Talonstone","Quantity":6},{"Facility":"Dragontree","Level":13,"Material":"Talonstone","Quantity":8},{"Facility":"Dragontree","Level":14,"Material":"Talonstone","Quantity":9},{"Facility":"Dragontree","Level":15,"Material":"Talonstone","Quantity":10},{"Facility":"Dragontree","Level":16,"Material":"Talonstone","Quantity":12},{"Facility":"Dragontree","Level":17,"Material":"Talonstone","Quantity":13},{"Facility":"Dragontree","Level":18,"Material":"Talonstone","Quantity":14},{"Facility":"Dragontree","Level":19,"Material":"Talonstone","Quantity":16},{"Facility":"Dragontree","Level":20,"Material":"Talonstone","Quantity":17},{"Facility":"Dragontree","Level":21,"Material":"Talonstone","Quantity":18},{"Facility":"Dragontree","Level":22,"Material":"Talonstone","Quantity":20},{"Facility":"Dragontree","Level":23,"Material":"Talonstone","Quantity":21},{"Facility":"Dragontree","Level":24,"Material":"Talonstone","Quantity":22},{"Facility":"Dragontree","Level":25,"Material":"Talonstone","Quantity":24},{"Facility":"Dragontree","Level":26,"Material":"Talonstone","Quantity":25},{"Facility":"Dragontree","Level":27,"Material":"Talonstone","Quantity":26}]'

	INSERT [den].[HalidomSmithy] (
		[Facility]
		,[Level]
		,[Material]
		,[Quantity]
		)
	SELECT [Facility]
		,[Level]
		,[Material]
		,[Quantity]
	FROM OPENJSON(@Json) WITH (
			[Facility] NVARCHAR(50)
			,[Level] INT
			,[Material] NVARCHAR(50)
			,[Quantity] INT
			)

	TRUNCATE TABLE [den].[EventCosts]

	SET @Json = 
		N'[{"Level":1,"Rupie":0,"Bronze":0},{"Level":2,"Rupie":100,"Bronze":3},{"Level":3,"Rupie":200,"Bronze":5},{"Level":4,"Rupie":300,"Bronze":7},{"Level":5,"Rupie":400,"Bronze":10},{"Level":6,"Rupie":500,"Bronze":12},{"Level":7,"Rupie":600,"Bronze":15},{"Level":8,"Rupie":700,"Bronze":18},{"Level":9,"Rupie":800,"Bronze":21},{"Level":10,"Rupie":1000,"Bronze":25},{"Level":11,"Rupie":1200,"Bronze":30},{"Level":12,"Rupie":1400,"Bronze":50},{"Level":13,"Rupie":1600,"Bronze":70},{"Level":14,"Rupie":1800,"Bronze":90},{"Level":15,"Rupie":2000,"Bronze":120},{"Level":16,"Rupie":2200,"Bronze":150},{"Level":17,"Rupie":2400,"Bronze":180},{"Level":18,"Rupie":2600,"Bronze":210},{"Level":19,"Rupie":2800,"Bronze":250},{"Level":20,"Rupie":3000,"Bronze":300},{"Level":21,"Rupie":3200,"Bronze":350},{"Level":22,"Rupie":3400,"Bronze":400},{"Level":23,"Rupie":3600,"Bronze":450},{"Level":24,"Rupie":3800,"Bronze":500},{"Level":25,"Rupie":4000,"Bronze":550},{"Level":26,"Rupie":4200,"Bronze":600},{"Level":27,"Rupie":4400,"Bronze":700},{"Level":28,"Rupie":4600,"Bronze":800},{"Level":29,"Rupie":4800,"Bronze":900},{"Level":30,"Rupie":5000,"Bronze":1000},{"Level":31,"Rupie":5200,"Bronze":1100},{"Level":32,"Rupie":5400,"Bronze":1200},{"Level":33,"Rupie":5600,"Bronze":1300},{"Level":34,"Rupie":5800,"Bronze":1400},{"Level":35,"Rupie":6000,"Bronze":1500}]'

	INSERT [den].[EventCosts] (
		[Level]
		,[Rupie]
		,[Bronze]
		)
	SELECT [Level]
		,[Rupie]
		,[Bronze]
	FROM OPENJSON(@Json) WITH (
			[Level] INT
			,[Rupie] INT
			,[Bronze] INT
			)

	TRUNCATE TABLE [den].[EventMats]

	SET @Json = 
		N'[{"BronzeMat":"Motivational Log","Facility":"Arctos Monument","MaxLevel":35},{"BronzeMat":"Tent Canvas","Facility":"Circus Tent","MaxLevel":35},{"BronzeMat":"Sacred Stone","Facility":"Cleansing Fount","MaxLevel":35},{"BronzeMat":"Papier-mâché","Facility":"Dragoñata","MaxLevel":35},{"BronzeMat":"Ornate Lantern","Facility":"Festival Stage","MaxLevel":35},{"BronzeMat":"Arcane Tome","Facility":"Library Obscura","MaxLevel":35},{"BronzeMat":"Libretto","Facility":"Opera House","MaxLevel":35},{"BronzeMat":"Glam Shell","Facility":"Seabed Stage","MaxLevel":35},{"BronzeMat":"Holy Ore","Facility":"Statue of Ilia","MaxLevel":35},{"BronzeMat":"Snack-o''-Lantern","Facility":"Sweet Retreat","MaxLevel":35},{"BronzeMat":"Chef''s Special","Facility":"The Hungerdome","MaxLevel":35},{"BronzeMat":"Windwhistle Grass","Facility":"Wind Shrine","MaxLevel":35},{"BronzeMat":"Astral Ornament","Facility":"Yuletree","MaxLevel":35},{"BronzeMat":"Tidal Tears","Facility":"Abyssal Bell","MaxLevel":30},{"BronzeMat":"Conductive Bolt","Facility":"Dr. Schmidt''s Lab","MaxLevel":30}]'

	INSERT [den].[EventMats] (
		[Facility]
		,[BronzeMat]
		,[MaxLevel]
		)
	SELECT [Facility]
		,[BronzeMat]
		,[MaxLevel]
	FROM OPENJSON(@Json) WITH (
			[Facility] NVARCHAR(50)
			,[BronzeMat] NVARCHAR(50)
			,[MaxLevel] INT
			)

	TRUNCATE TABLE [den].[FacilityMetadata]

	SET @Json = 
		N'[{"Category":"Halidom","Facilities":[{"Facility":"Halidom"},{"Facility":"Smithy"}]},{"Category":"Production","Facilities":[{"Facility":"Rupie Mine"},{"Facility":"Dragontree"}]},{"Category":"Altars","Facilities":[{"Facility":"Flame Altar"},{"Facility":"Water Altar"},{"Facility":"Wind Altar"},{"Facility":"Light Altar"},{"Facility":"Shadow Altar"}]},{"Category":"Dojos","Facilities":[{"Facility":"Sword Dojo"},{"Facility":"Blade Dojo"},{"Facility":"Dagger Dojo"},{"Facility":"Axe Dojo"},{"Facility":"Lance Dojo"},{"Facility":"Bow Dojo"},{"Facility":"Wand Dojo"},{"Facility":"Staff Dojo"},{"Facility":"Manacaster Dojo"}]},{"Category":"Dracoliths","Facilities":[{"Facility":"Flame Dracolith"},{"Facility":"Water Dracolith"},{"Facility":"Wind Dracolith"},{"Facility":"Light Dracolith"},{"Facility":"Shadow Dracolith"}]},{"Category":"Fafnir Statues","Facilities":[{"Facility":"Fafnir Statue (Flame)"},{"Facility":"Fafnir Statue (Water)"},{"Facility":"Fafnir Statue (Wind)"},{"Facility":"Fafnir Statue (Light)"},{"Facility":"Fafnir Statue (Shadow)"}]},{"Category":"Slime Statues","Facilities":[{"Facility":"Magma Slime Statue"},{"Facility":"Aqua Slime Statue"},{"Facility":"Aero Slime Statue"},{"Facility":"Twinkling Slime Statue"},{"Facility":"Poison Slime Statue"}]},{"Category":"Agito Trees","Facilities":[{"Facility":"Flame Tree"},{"Facility":"Water Tree"},{"Facility":"Wind Tree"},{"Facility":"Light Tree"},{"Facility":"Shadow Tree"}]},{"Category":"Event Facility","Facilities":[{"Facility":"Circus Tent"},{"Facility":"Wind Shrine"},{"Facility":"Seabed Stage"},{"Facility":"Sweet Retreat"},{"Facility":"Yuletree"},{"Facility":"Library Obscura"},{"Facility":"Dragoñata"},{"Facility":"Arctos Monument"},{"Facility":"The Hungerdome"},{"Facility":"Festival Stage"},{"Facility":"Statue of Ilia"},{"Facility":"Opera House"},{"Facility":"Cleansing Fount"},{"Facility":"Abyssal Bell"},{"Facility":"Dr. Schmidt''s Lab"}]},{"Category":"Decoration","Facilities":[{"Facility":"Red Flowers"},{"Facility":"Blue Flowers"},{"Facility":"Conifer Tree"},{"Facility":"Broadleaf Tree"},{"Facility":"Battle Standard"},{"Facility":"Balloon Wagon"},{"Facility":"Wishmill"},{"Facility":"Palm Tree"},{"Facility":"Jack-o''-Lantern"},{"Facility":"Snowdrake"},{"Facility":"Lectern"},{"Facility":"Eggy Luca"},{"Facility":"Eggy Sarisse"},{"Facility":"Iron Weather Vane"},{"Facility":"Pumpkin Mariti"},{"Facility":"Metall"},{"Facility":"Foodie''s Fork"},{"Facility":"Hinomotoan Fan"},{"Facility":"Double Bass"},{"Facility":"Little Pi Plushie"},{"Facility":"Extra Large Tropical Juice"},{"Facility":"Preservation Pod"}]}]'

	INSERT [den].[FacilityMetadata] (
		[Facility]
		,[Category]
		)
	SELECT f.[Facility]
		,c.[Category]
	FROM OPENJSON(@Json) WITH (
			[Category] NVARCHAR(50)
			,[Facilities] NVARCHAR(MAX) AS JSON
			) AS c
	CROSS APPLY OPENJSON(c.[Facilities]) WITH ([Facility] NVARCHAR(50)) AS f
END
