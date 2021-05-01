CREATE PROCEDURE [den].[spInitializeDen]
AS
BEGIN
	SET NOCOUNT ON

	TRUNCATE TABLE den.TreeCosts

	DECLARE @Json NVARCHAR(MAX) = 
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

	SET @Json = N'[{"Facility":"Arctos Monument","BronzeMat":"Motivational Log","MaxLevel":35},{"Facility":"Circus Tent","BronzeMat":"Tent Canvas","MaxLevel":35},{"Facility":"Cleansing Fount","BronzeMat":"Sacred Stone","MaxLevel":30},{"Facility":"Dragoñata","BronzeMat":"Papier-mâché","MaxLevel":35},{"Facility":"Festival Stage","BronzeMat":"Ornate Lantern","MaxLevel":30},{"Facility":"Library Obscura","BronzeMat":"Arcane Tome","MaxLevel":35},{"Facility":"Opera House","BronzeMat":"Libretto","MaxLevel":30},{"Facility":"Seabed Stage","BronzeMat":"Glam Shell","MaxLevel":35},{"Facility":"Statue of Ilia","BronzeMat":"Holy Ore","MaxLevel":30},{"Facility":"Sweet Retreat","BronzeMat":"Snack-o''-Lantern","MaxLevel":35},{"Facility":"The Hungerdome","BronzeMat":"Chef''s Special","MaxLevel":35},{"Facility":"Wind Shrine","BronzeMat":"Windwhistle Grass","MaxLevel":35},{"Facility":"Yuletree","BronzeMat":"Astral Ornament","MaxLevel":35}]'

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

	TRUNCATE TABLE [den].[MaterialMetadata]

	SET @Json = 
		N'[{"Material":"Rupies","Category":"Currency","SortPath":"/1/1/"},{"Material":"Mana","Category":"Currency","SortPath":"/1/2/"},{"Material":"Eldwater","Category":"Currency","SortPath":"/1/3/"},{"Material":"Bronze Crystal","Category":"Adventurer Upgrade Items","SortPath":"/2/1/"},{"Material":"Silver Crystal","Category":"Adventurer Upgrade Items","SortPath":"/2/2/"},{"Material":"Gold Crystal","Category":"Adventurer Upgrade Items","SortPath":"/2/3/"},{"Material":"Fortifying Crystal","Category":"Adventurer Upgrade Items","SortPath":"/3/1/"},{"Material":"Amplifying Crystal","Category":"Adventurer Upgrade Items","SortPath":"/3/2/"},{"Material":"Dragonfruit","Category":"Dragon Upgrade Items","SortPath":"/4/1/"},{"Material":"Ripe Dragonfruit","Category":"Dragon Upgrade Items","SortPath":"/4/2/"},{"Material":"Succulent Dragonfruit","Category":"Dragon Upgrade Items","SortPath":"/4/3/"},{"Material":"Fortifying Dragonscale","Category":"Dragon Upgrade Items","SortPath":"/5/1/"},{"Material":"Amplifying Dragonscale","Category":"Dragon Upgrade Items","SortPath":"/5/2/"},{"Material":"Bronze Whetstone","Category":"Weapon Upgrade Items","SortPath":"/6/1/"},{"Material":"Silver Whetstone","Category":"Weapon Upgrade Items","SortPath":"/6/2/"},{"Material":"Gold Whetstone","Category":"Weapon Upgrade Items","SortPath":"/6/3/"},{"Material":"Holy Water","Category":"Wyrmprint Upgrade Items","SortPath":"/7/1/"},{"Material":"Blessed Water","Category":"Wyrmprint Upgrade Items","SortPath":"/7/2/"},{"Material":"Consecrated Water","Category":"Wyrmprint Upgrade Items","SortPath":"/7/3/"},{"Material":"Fortifying Gemstone","Category":"Wyrmprint Upgrade Items","SortPath":"/8/1/"},{"Material":"Amplifying Gemstone","Category":"Wyrmprint Upgrade Items","SortPath":"/8/2/"},{"Material":"Flame Orb","Category":"Orbs","SortPath":"/9/1/1/"},{"Material":"Blaze Orb","Category":"Orbs","SortPath":"/9/1/2/"},{"Material":"Inferno Orb","Category":"Orbs","SortPath":"/9/1/3/"},{"Material":"Incandescence Orb","Category":"Orbs","SortPath":"/9/1/4/"},{"Material":"Water Orb","Category":"Orbs","SortPath":"/9/2/1/"},{"Material":"Stream Orb","Category":"Orbs","SortPath":"/9/2/2/"},{"Material":"Deluge Orb","Category":"Orbs","SortPath":"/9/2/3/"},{"Material":"Tsunami Orb","Category":"Orbs","SortPath":"/9/2/4/"},{"Material":"Wind Orb","Category":"Orbs","SortPath":"/9/3/1/"},{"Material":"Storm Orb","Category":"Orbs","SortPath":"/9/3/2/"},{"Material":"Maelstrom Orb","Category":"Orbs","SortPath":"/9/3/3/"},{"Material":"Tempest Orb","Category":"Orbs","SortPath":"/9/3/4/"},{"Material":"Light Orb","Category":"Orbs","SortPath":"/9/4/1/"},{"Material":"Radiance Orb","Category":"Orbs","SortPath":"/9/4/2/"},{"Material":"Refulgence Orb","Category":"Orbs","SortPath":"/9/4/3/"},{"Material":"Resplendence Orb","Category":"Orbs","SortPath":"/9/4/4/"},{"Material":"Shadow Orb","Category":"Orbs","SortPath":"/9/5/1/"},{"Material":"Nightfall Orb","Category":"Orbs","SortPath":"/9/5/2/"},{"Material":"Nether Orb","Category":"Orbs","SortPath":"/9/5/3/"},{"Material":"Abaddon Orb","Category":"Orbs","SortPath":"/9/5/4/"},{"Material":"Rainbow Orb","Category":"Orbs","SortPath":"/9/6/"},{"Material":"Flamewyrm''s Scale","Category":"Scales","SortPath":"/10/1/1/"},{"Material":"Flamewyrm''s Scaldscale","Category":"Scales","SortPath":"/10/1/2/"},{"Material":"Waterwyrm''s Scale","Category":"Scales","SortPath":"/10/2/1/"},{"Material":"Waterwyrm''s Glistscale","Category":"Scales","SortPath":"/10/2/2/"},{"Material":"Windwyrm''s Scale","Category":"Scales","SortPath":"/10/3/1/"},{"Material":"Windwyrm''s Squallscale","Category":"Scales","SortPath":"/10/3/1/"},{"Material":"Lightwyrm''s Scale","Category":"Scales","SortPath":"/10/4/1/"},{"Material":"Lightwyrm''s Glowscale","Category":"Scales","SortPath":"/10/4/2/"},{"Material":"Shadowwyrm''s Scale","Category":"Scales","SortPath":"/10/5/1/"},{"Material":"Shadowwyrm''s Darkscale","Category":"Scales","SortPath":"/10/5/2/"},{"Material":"Knight''s Testament","Category":"Testaments","SortPath":"/11/1/"},{"Material":"Champion''s Testament","Category":"Testaments","SortPath":"/11/2/"},{"Material":"Moonlight Stone","Category":"Stones","SortPath":"/12/1/"},{"Material":"Sunlight Stone","Category":"Stones","SortPath":"/12/2/"},{"Material":"Steel Brick","Category":"Ingots","SortPath":"/13/1/"},{"Material":"Damascus Ingot","Category":"Ingots","SortPath":"/13/2/"},{"Material":"Adamantite Ingot","Category":"Ingots","SortPath":"/13/3/"},{"Material":"Silver Key","Category":"Keys","SortPath":"/14/1/"},{"Material":"Golden Key","Category":"Keys","SortPath":"/14/2/"},{"Material":"Flamewyrm''s Sphere","Category":"Dragon Spheres","SortPath":"/15/1/1/"},{"Material":"Flamewyrm''s Greatsphere","Category":"Dragon Spheres","SortPath":"/15/1/2/"},{"Material":"Waterwyrm''s Sphere","Category":"Dragon Spheres","SortPath":"/15/2/1/"},{"Material":"Waterwyrm''s Greatsphere","Category":"Dragon Spheres","SortPath":"/15/2/2/"},{"Material":"Windwyrm''s Sphere","Category":"Dragon Spheres","SortPath":"/15/3/1/"},{"Material":"Windwyrm''s Greatsphere","Category":"Dragon Spheres","SortPath":"/15/3/2/"},{"Material":"Lightwyrm''s Sphere","Category":"Dragon Spheres","SortPath":"/15/4/1/"},{"Material":"Lightwyrm''s Greatsphere","Category":"Dragon Spheres","SortPath":"/15/4/2/"},{"Material":"Shadowwyrm''s Sphere","Category":"Dragon Spheres","SortPath":"/15/5/1/"},{"Material":"Shadowwyrm''s Greatsphere","Category":"Dragon Spheres","SortPath":"/15/5/2/"},{"Material":"High Flamewyrm''s Tail","Category":"High Dragon Materials","SortPath":"/16/1/1/"},{"Material":"High Flamewyrm''s Horn","Category":"High Dragon Materials","SortPath":"/16/1/2/"},{"Material":"High Waterwyrm''s Tail","Category":"High Dragon Materials","SortPath":"/16/2/1/"},{"Material":"High Waterwyrm''s Horn","Category":"High Dragon Materials","SortPath":"/16/2/2/"},{"Material":"High Windwyrm''s Tail","Category":"High Dragon Materials","SortPath":"/16/3/1/"},{"Material":"High Windwyrm''s Horn","Category":"High Dragon Materials","SortPath":"/16/3/2/"},{"Material":"High Lightwyrm''s Tail","Category":"High Dragon Materials","SortPath":"/16/4/1/"},{"Material":"High Lightwyrm''s Horn","Category":"High Dragon Materials","SortPath":"/16/4/2/"},{"Material":"High Shadowwyrm''s Tail","Category":"High Dragon Materials","SortPath":"/16/5/1/"},{"Material":"High Shadowwyrm''s Horn","Category":"High Dragon Materials","SortPath":"/16/5/2/"},{"Material":"Dyrenell Aes","Category":"Dyrenell Coins","SortPath":"/17/1/"},{"Material":"Dyrenell Argenteus","Category":"Dyrenell Coins","SortPath":"/17/2/"},{"Material":"Dyrenell Aureus","Category":"Dyrenell Coins","SortPath":"/17/3/"},{"Material":"Vermilion Insignia","Category":"Insignia","SortPath":"/18/1/1/"},{"Material":"Royal Vermilion Insignia","Category":"Insignia","SortPath":"/18/1/2/"},{"Material":"Azure Insignia","Category":"Insignia","SortPath":"/18/2/1/"},{"Material":"Royal Azure Insignia","Category":"Insignia","SortPath":"/18/2/2/"},{"Material":"Jade Insignia","Category":"Insignia","SortPath":"/18/3/1/"},{"Material":"Royal Jade Insignia","Category":"Insignia","SortPath":"/18/3/2/"},{"Material":"Amber Insignia","Category":"Insignia","SortPath":"/18/4/1/"},{"Material":"Royal Amber Insignia","Category":"Insignia","SortPath":"/18/4/2/"},{"Material":"Violet Insignia","Category":"Insignia","SortPath":"/18/5/1/"},{"Material":"Royal Violet Insignia","Category":"Insignia","SortPath":"/18/5/2/"},{"Material":"Soaring Ones'' Mask Fragment","Category":"Agito Fragments","SortPath":"/19/1/1/"},{"Material":"Liberated One''s Mask Fragment","Category":"Agito Fragments","SortPath":"/19/1/2/"},{"Material":"Rebellious One''s Cruelty","Category":"Agito Fragments","SortPath":"/19/1/3/"},{"Material":"Eliminating One''s Mask Fragment","Category":"Agito Fragments","SortPath":"/19/2/1/"},{"Material":"Despairing One''s Mask Fragment","Category":"Agito Fragments","SortPath":"/19/2/2/"},{"Material":"Rebellious One''s Desperation","Category":"Agito Fragments","SortPath":"/19/2/3/"},{"Material":"Rebellious Bird''s Tide","Category":"Agito Fragments","SortPath":"/19/2/4/"},{"Material":"Destitute One''s Mask Fragment","Category":"Agito Fragments","SortPath":"/19/3/1/"},{"Material":"Plagued One''s Mask Fragment","Category":"Agito Fragments","SortPath":"/19/3/2/"},{"Material":"Rebellious One''s Insanity","Category":"Agito Fragments","SortPath":"/19/3/3/"},{"Material":"Rebellious Wolf''s Gale","Category":"Agito Fragments","SortPath":"/19/3/4/"},{"Material":"Almighty One''s Mask Fragment","Category":"Agito Fragments","SortPath":"/19/4/1/"},{"Material":"Uprooting One''s Mask Fragment","Category":"Agito Fragments","SortPath":"/19/4/2/"},{"Material":"Rebellious One''s Arrogance","Category":"Agito Fragments","SortPath":"/19/4/3/"},{"Material":"Rebellious Ox''s Lightning","Category":"Agito Fragments","SortPath":"/19/4/4/"},{"Material":"Remaining One''s Mask Fragment","Category":"Agito Fragments","SortPath":"/19/5/1/"},{"Material":"Vengeful One''s Mask Fragment","Category":"Agito Fragments","SortPath":"/19/5/2/"},{"Material":"Rebellious One''s Loyalty","Category":"Agito Fragments","SortPath":"/19/5/3/"},{"Material":"Talonstone","Category":"Other Items","SortPath":"/20/1/"},{"Material":"Looking Glass","Category":"Other Items","SortPath":"/20/2/"},{"Material":"Damascus Crystal","Category":"Treasure Trade Fragments","SortPath":"/21/1/"},{"Material":"Sunlight Ore","Category":"Treasure Trade Fragments","SortPath":"/21/2/"},{"Material":"Golden Fragment","Category":"Treasure Trade Fragments","SortPath":"/21/3/"},{"Material":"Twinkling Grains","Category":"Treasure Trade Fragments","SortPath":"/21/4/"},{"Material":"Void Leaf","Category":"Universal Void Drops","SortPath":"/22/1/"},{"Material":"Void Seed","Category":"Universal Void Drops","SortPath":"/22/2/"},{"Material":"Squishums","Category":"Squishums and Other Jokes","SortPath":"/23/1/"},{"Material":"Imitation Squish","Category":"Squishums and Other Jokes","SortPath":"/23/2/"},{"Material":"Half-Eaten Bread","Category":"Squishums and Other Jokes","SortPath":"/23/3/"},{"Material":"Flame Tome","Category":"Tomes","SortPath":"/24/1/"},{"Material":"Water Tome","Category":"Tomes","SortPath":"/24/2/"},{"Material":"Wind Tome","Category":"Tomes","SortPath":"/24/3/"},{"Material":"Light Tome","Category":"Tomes","SortPath":"/24/4/"},{"Material":"Shadow Tome","Category":"Tomes","SortPath":"/24/5/"},{"Material":"Astral Shard","Category":"Astral Shards","SortPath":"/25/"},{"Material":"Appearance Ticket","Category":"Alberian Battle Royale","SortPath":"/26/"},{"Material":"Nature''s Blessing","Category":"Nature''s Blessing","SortPath":"/27/"},{"Material":"Cyclone Shard","Category":"Dominion Shards","SortPath":"/27.1/1/1/"},{"Material":"Twilight Shard","Category":"Dominion Shards","SortPath":"/27.1/1/2/"},{"Material":"Cyclone Prism","Category":"Dominion Shards","SortPath":"/27.1/2/1/"},{"Material":"Twilight Prism","Category":"Dominion Shards","SortPath":"/27.1/2/2/"},{"Material":"Iron Ore","Category":"Weapon Upgrade Materials","SortPath":"/28/1/1/"},{"Material":"Granite","Category":"Weapon Upgrade Materials","SortPath":"/28/1/2/"},{"Material":"Meteorite","Category":"Weapon Upgrade Materials","SortPath":"/28/1/3/"},{"Material":"Fiend''s Claw","Category":"Weapon Upgrade Materials","SortPath":"/28/2/1/"},{"Material":"Fiend''s Horn","Category":"Weapon Upgrade Materials","SortPath":"/28/2/2/"},{"Material":"Fiend''s Eye","Category":"Weapon Upgrade Materials","SortPath":"/28/2/3/"},{"Material":"Bat''s Wing","Category":"Weapon Upgrade Materials","SortPath":"/28/3/1/"},{"Material":"Ancient Bird''s Feather","Category":"Weapon Upgrade Materials","SortPath":"/28/3/2/"},{"Material":"Bewitching Wings","Category":"Weapon Upgrade Materials","SortPath":"/28/3/3/"},{"Material":"Light Metal","Category":"Special Weapon Upgrade Materials","SortPath":"/29/1/1/"},{"Material":"Abyss Stone","Category":"Special Weapon Upgrade Materials","SortPath":"/29/1/2/"},{"Material":"Crimson Core","Category":"Special Weapon Upgrade Materials","SortPath":"/29/1/3/"},{"Material":"Twinkling Sand","Category":"Special Weapon Upgrade Materials","SortPath":"/29/2/1/"},{"Material":"Orichalcum","Category":"Special Weapon Upgrade Materials","SortPath":"/29/2/2/"},{"Material":"Sword Tablet","Category":"Tablet","SortPath":"/30/1/"},{"Material":"Blade Tablet","Category":"Tablet","SortPath":"/30/2/"},{"Material":"Dagger Tablet","Category":"Tablet","SortPath":"/30/3/"},{"Material":"Axe Tablet","Category":"Tablet","SortPath":"/30/4/"},{"Material":"Lance Tablet","Category":"Tablet","SortPath":"/30/5/"},{"Material":"Bow Tablet","Category":"Tablet","SortPath":"/30/6/"},{"Material":"Wand Tablet","Category":"Tablet","SortPath":"/30/7/"},{"Material":"Staff Tablet","Category":"Tablet","SortPath":"/30/8/"},{"Material":"Manacaster Tablet","Category":"Tablet","SortPath":"/30/9/"},{"Material":"Snack-o''-Lantern","Category":"Event Facility Upgrade Materials","SortPath":"/31/1/"},{"Material":"Windwhistle Grass","Category":"Event Facility Upgrade Materials","SortPath":"/31/2/"},{"Material":"Astral Ornament","Category":"Event Facility Upgrade Materials","SortPath":"/31/3/"},{"Material":"Tent Canvas","Category":"Event Facility Upgrade Materials","SortPath":"/31/4/"},{"Material":"Arcane Tome","Category":"Event Facility Upgrade Materials","SortPath":"/31/5/"},{"Material":"Papier-mâché","Category":"Event Facility Upgrade Materials","SortPath":"/31/6/"},{"Material":"Motivational Log","Category":"Event Facility Upgrade Materials","SortPath":"/31/7/"},{"Material":"Glam Shell","Category":"Event Facility Upgrade Materials","SortPath":"/31/8/"},{"Material":"Chef''s Special","Category":"Event Facility Upgrade Materials","SortPath":"/31/9/"},{"Material":"Ornate Lantern","Category":"Event Facility Upgrade Materials","SortPath":"/31/10/"},{"Material":"Holy Ore","Category":"Event Facility Upgrade Materials","SortPath":"/31/11/"},{"Material":"Libretto","Category":"Event Facility Upgrade Materials","SortPath":"/31/12/"},{"Material":"Solid Fungus","Category":"Void Materials","SortPath":"/32/1/1/"},{"Material":"Crimson Fungus","Category":"Void Materials","SortPath":"/32/1/2/"},{"Material":"Burning Spore","Category":"Void Materials","SortPath":"/32/1/3/"},{"Material":"Storm Fungus","Category":"Void Materials","SortPath":"/32/1/4/"},{"Material":"Spongy Spore","Category":"Void Materials","SortPath":"/32/1/5/"},{"Material":"Shiny Spore","Category":"Void Materials","SortPath":"/32/1/6/"},{"Material":"Old Cloth","Category":"Void Materials","SortPath":"/32/2/1/"},{"Material":"Floating Red Cloth","Category":"Void Materials","SortPath":"/32/2/2/"},{"Material":"Otherworldly Lantern","Category":"Void Materials","SortPath":"/32/2/3/"},{"Material":"Floating Blue Cloth","Category":"Void Materials","SortPath":"/32/2/4/"},{"Material":"Abyssal Lantern","Category":"Void Materials","SortPath":"/32/2/5/"},{"Material":"Floating Yellow Cloth","Category":"Void Materials","SortPath":"/32/2/6/"},{"Material":"Unearthly Lantern","Category":"Void Materials","SortPath":"/32/2/7/"},{"Material":"Floating Purple Cloth","Category":"Void Materials","SortPath":"/32/2/8/"},{"Material":"Shadowy Lantern","Category":"Void Materials","SortPath":"/32/2/9/"},{"Material":"Goblin Thread","Category":"Void Materials","SortPath":"/32/3/1/"},{"Material":"Aromatic Wood","Category":"Void Materials","SortPath":"/32/3/2/"},{"Material":"Purple Thread","Category":"Void Materials","SortPath":"/32/3/3/"},{"Material":"Acoustic Wood","Category":"Void Materials","SortPath":"/32/3/4/"},{"Material":"Steel Slab","Category":"Void Materials","SortPath":"/32/4/1/"},{"Material":"Golem Core","Category":"Void Materials","SortPath":"/32/4/2/"},{"Material":"Amber Slab","Category":"Void Materials","SortPath":"/32/4/3/"},{"Material":"Light Core","Category":"Void Materials","SortPath":"/32/4/5/"},{"Material":"Obsidian Slab","Category":"Void Materials","SortPath":"/32/4/6/"},{"Material":"Dark Core","Category":"Void Materials","SortPath":"/32/4/7/"},{"Material":"Catoblepas''s Hoof","Category":"Void Materials","SortPath":"/32/5/1/"},{"Material":"Catoblepas''s Heateye","Category":"Void Materials","SortPath":"/32/5/2/"},{"Material":"Catoblepas''s Stormeye","Category":"Void Materials","SortPath":"/32/5/3/"},{"Material":"Catoblepas''s Shadoweye","Category":"Void Materials","SortPath":"/32/5/4/"},{"Material":"Soul Vestiges","Category":"Void Materials","SortPath":"/32/6/1/"},{"Material":"Infernal Soul","Category":"Void Materials","SortPath":"/32/6/2/"},{"Material":"Abyssal Soul","Category":"Void Materials","SortPath":"/32/6/3/"},{"Material":"Eolian Soul","Category":"Void Materials","SortPath":"/32/6/4/"},{"Material":"Raging Fang","Category":"Void Materials","SortPath":"/32/7/1/"},{"Material":"Smoldering Tail","Category":"Void Materials","SortPath":"/32/7/2/"},{"Material":"Greedy Tail","Category":"Void Materials","SortPath":"/32/7/3/"},{"Material":"Proud Tail","Category":"Void Materials","SortPath":"/32/7/4/"},{"Material":"Raging Tail","Category":"Void Materials","SortPath":"/32/7/5/"},{"Material":"Great Feather","Category":"Void Dragon Materials","SortPath":"/33/1/1/"},{"Material":"Zephyr Rune","Category":"Void Dragon Materials","SortPath":"/33/1/2/"},{"Material":"Oceanic Fin","Category":"Void Dragon Materials","SortPath":"/33/2/1/"},{"Material":"Oceanic Crown","Category":"Void Dragon Materials","SortPath":"/33/2/2/"},{"Material":"Necroblossom","Category":"Void Dragon Materials","SortPath":"/33/3/1/"},{"Material":"Abyssal Standard","Category":"Void Dragon Materials","SortPath":"/33/3/2/"},{"Material":"Ruinous Horn","Category":"Void Dragon Materials","SortPath":"/33/4/1/"},{"Material":"Ruinous Wing","Category":"Void Dragon Materials","SortPath":"/33/4/2/"},{"Material":"Blazing Horn","Category":"Void Dragon Materials","SortPath":"/33/5/1/"},{"Material":"Blazing Ember","Category":"Void Dragon Materials","SortPath":"/33/5/2/"},{"Material":"Volcanic Mane","Category":"Void Chimera Materials","SortPath":"/34/1/1/"},{"Material":"Volcanic Claw","Category":"Void Chimera Materials","SortPath":"/34/1/2/"},{"Material":"Volcanic Horn","Category":"Void Chimera Materials","SortPath":"/34/1/3/"},{"Material":"Tidal Mane","Category":"Void Chimera Materials","SortPath":"/34/2/1/"},{"Material":"Tidal Claw","Category":"Void Chimera Materials","SortPath":"/34/2/2/"},{"Material":"Tidal Horn","Category":"Void Chimera Materials","SortPath":"/34/2/3/"},{"Material":"Tempest Mane","Category":"Void Chimera Materials","SortPath":"/34/3/1/"},{"Material":"Tempest Claw","Category":"Void Chimera Materials","SortPath":"/34/3/2/"},{"Material":"Tempest Horn","Category":"Void Chimera Materials","SortPath":"/34/3/3/"},{"Material":"Luminous Mane","Category":"Void Chimera Materials","SortPath":"/34/4/1/"},{"Material":"Luminous Claw","Category":"Void Chimera Materials","SortPath":"/34/4/2/"},{"Material":"Luminous Horn","Category":"Void Chimera Materials","SortPath":"/34/4/3/"},{"Material":"Ebon Mane","Category":"Void Chimera Materials","SortPath":"/34/5/1/"},{"Material":"Ebon Claw","Category":"Void Chimera Materials","SortPath":"/34/5/2/"},{"Material":"Ebon Horn","Category":"Void Chimera Materials","SortPath":"/34/5/3/"},{"Material":"Burning Heart","Category":"Hearts","SortPath":"/35/1/"},{"Material":"Azure Heart","Category":"Hearts","SortPath":"/35/2/"},{"Material":"Verdant Heart","Category":"Hearts","SortPath":"/35/3/"},{"Material":"Coronal Heart","Category":"Hearts","SortPath":"/35/4/"},{"Material":"Ebony Heart","Category":"Hearts","SortPath":"/35/5/"},{"Material":"Longing Heart","Category":"Hearts","SortPath":"/35/6/"},{"Material":"Agni''s Essence","Category":"Draconic Essence","SortPath":"/36/1/1/"},{"Material":"Prometheus''s Essence","Category":"Draconic Essence","SortPath":"/36/1/2/"},{"Material":"Cerberus''s Essence","Category":"Draconic Essence","SortPath":"/36/1/3/"},{"Material":"Konohana Sakuya''s Essence","Category":"Draconic Essence","SortPath":"/36/1/4/"},{"Material":"Arctos''s Essence","Category":"Draconic Essence","SortPath":"/36/1/5/"},{"Material":"Apollo''s Essence","Category":"Draconic Essence","SortPath":"/36/1/6/"},{"Material":"Kagutsuchi''s Essence","Category":"Draconic Essence","SortPath":"/36/1/7/"},{"Material":"Leviathan''s Essence","Category":"Draconic Essence","SortPath":"/36/2/1/"},{"Material":"Poseidon''s Essence","Category":"Draconic Essence","SortPath":"/36/2/2/"},{"Material":"Siren''s Essence","Category":"Draconic Essence","SortPath":"/36/2/3/"},{"Material":"Simurgh''s Essence","Category":"Draconic Essence","SortPath":"/36/2/4/"},{"Material":"Kamuy''s Essence","Category":"Draconic Essence","SortPath":"/36/2/5/"},{"Material":"Nimis''s Essence","Category":"Draconic Essence","SortPath":"/36/2/6/"},{"Material":"Gaibhne & Creidhne''s Essence","Category":"Draconic Essence","SortPath":"/36/2/7/"},{"Material":"Zephyr''s Essence","Category":"Draconic Essence","SortPath":"/36/3/1/"},{"Material":"Garuda''s Essence","Category":"Draconic Essence","SortPath":"/36/3/2/"},{"Material":"Long Long''s Essence","Category":"Draconic Essence","SortPath":"/36/3/3/"},{"Material":"Pazuzu''s Essence","Category":"Draconic Essence","SortPath":"/36/3/4/"},{"Material":"Freyja''s Essence","Category":"Draconic Essence","SortPath":"/36/3/5/"},{"Material":"Vayu''s Essence","Category":"Draconic Essence","SortPath":"/36/3/6/"},{"Material":"Hastur''s Essence","Category":"Draconic Essence","SortPath":"/36/3/7/"},{"Material":"Cupid''s Essence","Category":"Draconic Essence","SortPath":"/36/4/1/"},{"Material":"Jeanne d''Arc''s Essence","Category":"Draconic Essence","SortPath":"/36/4/2/"},{"Material":"Gilgamesh''s Essence","Category":"Draconic Essence","SortPath":"/36/4/3/"},{"Material":"Liger''s Essence","Category":"Draconic Essence","SortPath":"/36/4/4/"},{"Material":"Takemikazuchi''s Essence","Category":"Draconic Essence","SortPath":"/36/4/5/"},{"Material":"Pop-Star Siren''s Essence","Category":"Draconic Essence","SortPath":"/36/4/6/"},{"Material":"Corsaint Phoenix''s Essence","Category":"Draconic Essence","SortPath":"/36/4/7/"},{"Material":"Chthonius''s Essence","Category":"Draconic Essence","SortPath":"/36/5/1/"},{"Material":"Nidhogg''s Essence","Category":"Draconic Essence","SortPath":"/36/5/2/"},{"Material":"Nyarlathotep''s Essence","Category":"Draconic Essence","SortPath":"/36/5/3/"},{"Material":"Shinobi''s Essence","Category":"Draconic Essence","SortPath":"/36/5/4/"},{"Material":"Epimetheus''s Essence","Category":"Draconic Essence","SortPath":"/36/5/5/"},{"Material":"Andromeda''s Essence","Category":"Draconic Essence","SortPath":"/36/5/6/"},{"Material":"Azazel''s Essence","Category":"Draconic Essence","SortPath":"/36/5/7/"},{"Material":"Crown of Light''s Memory","Category":"Wyrmprint Memories","SortPath":"/36.1/1/1/"},{"Material":"Tutelary Successor''s Memory","Category":"Wyrmprint Memories","SortPath":"/36.1/1/2/"},{"Material":"Queen of the Sands'' Memory","Category":"Wyrmprint Memories","SortPath":"/36.1/1/3/"},{"Material":"Otherworld Auspex''s Memory","Category":"Wyrmprint Memories","SortPath":"/36.1/1/4/"},{"Material":"Twilight Queen''s Memory","Category":"Wyrmprint Memories","SortPath":"/36.1/1/5/"},{"Material":"Determined Auspex''s Memory","Category":"Wyrmprint Memories","SortPath":"/36.1/1/6/"},{"Material":"Anointed Lance''s Memory","Category":"Wyrmprint Memories","SortPath":"/36.1/2/1/"},{"Material":"Doting Sister''s Memory","Category":"Wyrmprint Memories","SortPath":"/36.1/2/2/"},{"Material":"Sentient Vegetable''s Memory","Category":"Wyrmprint Memories","SortPath":"/36.1/2/3/"},{"Material":"Twilight Hunter''s Memory","Category":"Wyrmprint Memories","SortPath":"/36.1/2/4/"},{"Material":"Dreaming Vegetable''s Memory","Category":"Wyrmprint Memories","SortPath":"/36.1/2/5/"},{"Material":"Twilight Hawk''s Memory","Category":"Wyrmprint Memories","SortPath":"/36.1/2/6/"},{"Material":"Gala Elisanne''s Conviction","Category":"Spiral Materials","SortPath":"/36.2/0/1/"},{"Material":"Gala Elisanne''s Devotion","Category":"Spiral Materials","SortPath":"/36.2/0/2/"},{"Material":"Gala Ranzal''s Conviction","Category":"Spiral Materials","SortPath":"/36.2/0.1/1/"},{"Material":"Gala Ranzal''s Devotion","Category":"Spiral Materials","SortPath":"/36.2/0.1/2/"},{"Material":"Gala Prince''s Conviction","Category":"Spiral Materials","SortPath":"/36.2/1/1/"},{"Material":"Gala Prince''s Devotion","Category":"Spiral Materials","SortPath":"/36.2/1/2/"},{"Material":"Wyrmsigil Remnant","Category":"Other Materials","SortPath":"/37/1/"},{"Material":"Fafnir Medal","Category":"Other Materials","SortPath":"/37/2/"}]'

	INSERT [den].[MaterialMetadata] (
		[Material]
		,[Category]
		,[SortPath]
		)
	SELECT [Material]
		,[Category]
		,[SortPath]
	FROM OPENJSON(@Json) WITH (
			[Material] NVARCHAR(50)
			,[Category] NVARCHAR(50)
			,[SortPath] NVARCHAR(255)
			)

	TRUNCATE TABLE [den].[FacilityMetadata]

	SET @Json = 
		N'[{"Facility":"Halidom","Category":"Halidom"},{"Facility":"Rupie Mine","Category":"Production"},{"Facility":"Dragontree","Category":"Production"},{"Facility":"Flame Altar","Category":"Altars"},{"Facility":"Water Altar","Category":"Altars"},{"Facility":"Wind Altar","Category":"Altars"},{"Facility":"Light Altar","Category":"Altars"},{"Facility":"Shadow Altar","Category":"Altars"},{"Facility":"Sword Dojo","Category":"Dojos"},{"Facility":"Blade Dojo","Category":"Dojos"},{"Facility":"Dagger Dojo","Category":"Dojos"},{"Facility":"Axe Dojo","Category":"Dojos"},{"Facility":"Lance Dojo","Category":"Dojos"},{"Facility":"Bow Dojo","Category":"Dojos"},{"Facility":"Wand Dojo","Category":"Dojos"},{"Facility":"Staff Dojo","Category":"Dojos"},{"Facility":"Manacaster Dojo","Category":"Dojos"},{"Facility":"Flame Dracolith","Category":"Dracoliths"},{"Facility":"Water Dracolith","Category":"Dracoliths"},{"Facility":"Wind Dracolith","Category":"Dracoliths"},{"Facility":"Light Dracolith","Category":"Dracoliths"},{"Facility":"Shadow Dracolith","Category":"Dracoliths"},{"Facility":"Red Flowers","Category":"Decoration"},{"Facility":"Blue Flowers","Category":"Decoration"},{"Facility":"Conifer Tree","Category":"Decoration"},{"Facility":"Broadleaf Tree","Category":"Decoration"},{"Facility":"Battle Standard","Category":"Decoration"},{"Facility":"Circus Tent","Category":"Event Facility"},{"Facility":"Balloon Wagon","Category":"Decoration"},{"Facility":"Fafnir Statue (Flame)","Category":"Fafnir Statues"},{"Facility":"Fafnir Statue (Water)","Category":"Fafnir Statues"},{"Facility":"Fafnir Statue (Wind)","Category":"Fafnir Statues"},{"Facility":"Fafnir Statue (Light)","Category":"Fafnir Statues"},{"Facility":"Fafnir Statue (Shadow)","Category":"Fafnir Statues"},{"Facility":"Wind Shrine","Category":"Event Facility"},{"Facility":"Wishmill","Category":"Decoration"},{"Facility":"Seabed Stage","Category":"Event Facility"},{"Facility":"Palm Tree","Category":"Decoration"},{"Facility":"Smithy","Category":"Halidom"},{"Facility":"Sweet Retreat","Category":"Event Facility"},{"Facility":"Jack-o''-Lantern","Category":"Decoration"},{"Facility":"Yuletree","Category":"Event Facility"},{"Facility":"Snowdrake","Category":"Decoration"},{"Facility":"Library Obscura","Category":"Event Facility"},{"Facility":"Lectern","Category":"Decoration"},{"Facility":"Dragoñata","Category":"Event Facility"},{"Facility":"Eggy Luca","Category":"Decoration"},{"Facility":"Eggy Sarisse","Category":"Decoration"},{"Facility":"Magma Slime Statue","Category":"Slime Statues"},{"Facility":"Aqua Slime Statue","Category":"Slime Statues"},{"Facility":"Aero Slime Statue","Category":"Slime Statues"},{"Facility":"Twinkling Slime Statue","Category":"Slime Statues"},{"Facility":"Poison Slime Statue","Category":"Slime Statues"},{"Facility":"Arctos Monument","Category":"Event Facility"},{"Facility":"Iron Weather Vane","Category":"Decoration"},{"Facility":"Pumpkin Mariti","Category":"Decoration"},{"Facility":"Metall","Category":"Decoration"},{"Facility":"Flame Tree","Category":"Agito Trees"},{"Facility":"Water Tree","Category":"Agito Trees"},{"Facility":"Wind Tree","Category":"Agito Trees"},{"Facility":"Light Tree","Category":"Agito Trees"},{"Facility":"Shadow Tree","Category":"Agito Trees"},{"Facility":"The Hungerdome","Category":"Event Facility"},{"Facility":"Foodie''s Fork","Category":"Decoration"},{"Facility":"Festival Stage","Category":"Event Facility"},{"Facility":"Hinomotoan Fan","Category":"Decoration"},{"Facility":"Statue of Ilia","Category":"Event Facility"},{"Facility":"Opera House","Category":"Event Facility"},{"Facility":"Double Bass","Category":"Decoration"},{"Facility":"Cleansing Fount","Category":"Event Facility"},{"Facility":"Little Pi Plushie","Category":"Decoration"}]'

	INSERT [den].[FacilityMetadata] (
		[Facility]
		,[Category]
		)
	SELECT [Facility]
		,[Category]
	FROM OPENJSON(@Json) WITH (
			[Facility] NVARCHAR(50)
			,[Category] NVARCHAR(50)
			)

	TRUNCATE TABLE [den].[QuestHierarchy]

	SET @Json = 
		N'[{"Quest":"Quests","ItemLevel":0},{"Quest":"Campaign Quests","ItemLevel":1},{"Quest":"Campaign Quests: Normal","ItemLevel":2},{"Quest":"Chapter 1 Normal","ItemLevel":3},{"Quest":"Chapter 2 Normal","ItemLevel":3},{"Quest":"Chapter 3 Normal","ItemLevel":3},{"Quest":"Chapter 4 Normal","ItemLevel":3},{"Quest":"Chapter 5 Normal","ItemLevel":3},{"Quest":"Chapter 6 Normal","ItemLevel":3},{"Quest":"Chapter 7 Normal","ItemLevel":3},{"Quest":"Chapter 8 Normal","ItemLevel":3},{"Quest":"Chapter 9 Normal","ItemLevel":3},{"Quest":"Chapter 10 Normal","ItemLevel":3},{"Quest":"Chapter 11 Normal","ItemLevel":3},{"Quest":"Chapter 12 Normal","ItemLevel":3},{"Quest":"Chapter 13 Normal","ItemLevel":3},{"Quest":"Chapter 14 Normal","ItemLevel":3},{"Quest":"Chapter 15 Normal","ItemLevel":3},{"Quest":"Chapter 16 Normal","ItemLevel":3},{"Quest":"Chapter 17 Normal","ItemLevel":3},{"Quest":"Chapter 18 Normal","ItemLevel":3},{"Quest":"Chapter 19 Normal","ItemLevel":3},{"Quest":"Campaign Quests: Hard","ItemLevel":2},{"Quest":"Chapter 1 Hard","ItemLevel":3},{"Quest":"Ch. 1 / 1-2 Hard","ItemLevel":4},{"Quest":"Ch. 1 / 2-2 Hard","ItemLevel":4},{"Quest":"Ch. 1 / 4-5 Hard","ItemLevel":4},{"Quest":"Chapter 2 Hard","ItemLevel":3},{"Quest":"Ch. 2 / 1-3 Hard","ItemLevel":4},{"Quest":"Ch. 2 / 3-3 Hard","ItemLevel":4},{"Quest":"Ch. 2 / 4-2 Hard","ItemLevel":4},{"Quest":"Ch. 2 / 5-1 Hard","ItemLevel":4},{"Quest":"Ch. 2 / 6-1 Hard","ItemLevel":4},{"Quest":"Chapter 3 Hard","ItemLevel":3},{"Quest":"Ch. 3 / 1-3 Hard","ItemLevel":4},{"Quest":"Ch. 3 / 2-3 Hard","ItemLevel":4},{"Quest":"Ch. 3 / 3-5 Hard","ItemLevel":4},{"Quest":"Ch. 3 / 4-3 Hard","ItemLevel":4},{"Quest":"Chapter 4 Hard","ItemLevel":3},{"Quest":"Ch. 4 / 1-4 Hard","ItemLevel":4},{"Quest":"Ch. 4 / 3-5 Hard","ItemLevel":4},{"Quest":"Ch. 4 / 4-2 Hard","ItemLevel":4},{"Quest":"Ch. 4 / 5-2 Hard","ItemLevel":4},{"Quest":"Chapter 5 Hard","ItemLevel":3},{"Quest":"Ch. 5 / 1-3 Hard","ItemLevel":4},{"Quest":"Ch. 5 / 2-4 Hard","ItemLevel":4},{"Quest":"Ch. 5 / 3-3 Hard","ItemLevel":4},{"Quest":"Ch. 5 / 4-3 Hard","ItemLevel":4},{"Quest":"Chapter 6 Hard","ItemLevel":3},{"Quest":"Ch. 6 / 1-6 Hard","ItemLevel":4},{"Quest":"Ch. 6 / 3-3 Hard","ItemLevel":4},{"Quest":"Ch. 6 / 4-2 Hard","ItemLevel":4},{"Quest":"Chapter 7 Hard","ItemLevel":3},{"Quest":"Ch. 7 / 1-3 Hard","ItemLevel":4},{"Quest":"Ch. 7 / 2-3 Hard","ItemLevel":4},{"Quest":"Chapter 8 Hard","ItemLevel":3},{"Quest":"Ch. 8 / 1-4 Hard","ItemLevel":4},{"Quest":"Ch. 8 / 2-3 Hard","ItemLevel":4},{"Quest":"Ch. 8 / 3-4 Hard","ItemLevel":4},{"Quest":"Chapter 9 Hard","ItemLevel":3},{"Quest":"Ch. 9 / 1-2 Hard","ItemLevel":4},{"Quest":"Ch. 9 / 2-2 Hard","ItemLevel":4},{"Quest":"Ch. 9 / 3-2 Hard","ItemLevel":4},{"Quest":"Chapter 10 Hard","ItemLevel":3},{"Quest":"Ch. 10 / 1-2 Hard","ItemLevel":4},{"Quest":"Ch. 10 / 2-2 Hard","ItemLevel":4},{"Quest":"Ch. 10 / 3-2 Hard","ItemLevel":4},{"Quest":"Chapter 11 Hard","ItemLevel":3},{"Quest":"Chapter 12 Hard","ItemLevel":3},{"Quest":"Chapter 13 Hard","ItemLevel":3},{"Quest":"Chapter 14 Hard","ItemLevel":3},{"Quest":"Ch. 14 / 1-2 Hard","ItemLevel":4},{"Quest":"Chapter 15 Hard","ItemLevel":3},{"Quest":"Chapter 16 Hard","ItemLevel":3},{"Quest":"Chapter 17 Hard","ItemLevel":3},{"Quest":"Chapter 18 Hard","ItemLevel":3},{"Quest":"Chapter 19 Hard","ItemLevel":3},{"Quest":"Campaign Quests: Very Hard","ItemLevel":2},{"Quest":"Chapter 1 Very Hard","ItemLevel":3},{"Quest":"Ch. 1 / 1-2 Very Hard","ItemLevel":4},{"Quest":"Ch. 1 / 2-2 Very Hard","ItemLevel":4},{"Quest":"Ch. 1 / 4-5 Very Hard","ItemLevel":4},{"Quest":"Chapter 2 Very Hard","ItemLevel":3},{"Quest":"Ch. 2 / 1-3 Very Hard","ItemLevel":4},{"Quest":"Ch. 2 / 3-3 Very Hard","ItemLevel":4},{"Quest":"Ch. 2 / 4-2 Very Hard","ItemLevel":4},{"Quest":"Ch. 2 / 5-1 Very Hard","ItemLevel":4},{"Quest":"Ch. 2 / 6-1 Very Hard","ItemLevel":4},{"Quest":"Chapter 3 Very Hard","ItemLevel":3},{"Quest":"Ch. 3 / 1-3 Very Hard","ItemLevel":4},{"Quest":"Ch. 3 / 2-3 Very Hard","ItemLevel":4},{"Quest":"Ch. 3 / 3-5 Very Hard","ItemLevel":4},{"Quest":"Ch. 3 / 4-3 Very Hard","ItemLevel":4},{"Quest":"Chapter 4 Very Hard","ItemLevel":3},{"Quest":"Ch. 4 / 1-4 Very Hard","ItemLevel":4},{"Quest":"Ch. 4 / 3-5 Very Hard","ItemLevel":4},{"Quest":"Ch. 4 / 4-2 Very Hard","ItemLevel":4},{"Quest":"Ch. 4 / 5-2 Very Hard","ItemLevel":4},{"Quest":"Chapter 5 Very Hard","ItemLevel":3},{"Quest":"Ch. 5 / 1-3 Very Hard","ItemLevel":4},{"Quest":"Ch. 5 / 2-4 Very Hard","ItemLevel":4},{"Quest":"Ch. 5 / 3-3 Very Hard","ItemLevel":4},{"Quest":"Ch. 5 / 4-3 Very Hard","ItemLevel":4},{"Quest":"Chapter 6 Very Hard","ItemLevel":3},{"Quest":"Ch. 6 / 1-6 Very Hard","ItemLevel":4},{"Quest":"Ch. 6 / 3-3 Very Hard","ItemLevel":4},{"Quest":"Ch. 6 / 4-2 Very Hard","ItemLevel":4},{"Quest":"Chapter 7 Very Hard","ItemLevel":3},{"Quest":"Ch. 7 / 1-3 Very Hard","ItemLevel":4},{"Quest":"Ch. 7 / 2-3 Very Hard","ItemLevel":4},{"Quest":"Chapter 8 Very Hard","ItemLevel":3},{"Quest":"Ch. 8 / 1-4 Very Hard","ItemLevel":4},{"Quest":"Ch. 8 / 2-3 Very Hard","ItemLevel":4},{"Quest":"Ch. 8 / 3-4 Very Hard","ItemLevel":4},{"Quest":"Chapter 9 Very Hard","ItemLevel":3},{"Quest":"Ch. 9 / 1-2 Very Hard","ItemLevel":4},{"Quest":"Ch. 9 / 2-2 Very Hard","ItemLevel":4},{"Quest":"Ch. 9 / 3-2 Very Hard","ItemLevel":4},{"Quest":"Chapter 10 Very Hard","ItemLevel":3},{"Quest":"Ch. 10 / 1-2 Very Hard","ItemLevel":4},{"Quest":"Ch. 10 / 2-2 Very Hard","ItemLevel":4},{"Quest":"Ch. 10 / 3-2 Very Hard","ItemLevel":4},{"Quest":"Chapter 11 Very Hard","ItemLevel":3},{"Quest":"Chapter 12 Very Hard","ItemLevel":3},{"Quest":"Chapter 13 Very Hard","ItemLevel":3},{"Quest":"Chapter 14 Very Hard","ItemLevel":3},{"Quest":"Ch. 14 / 1-2 Very Hard","ItemLevel":4},{"Quest":"Chapter 15 Very Hard","ItemLevel":3},{"Quest":"Chapter 16 Very Hard","ItemLevel":3},{"Quest":"Chapter 17 Very Hard","ItemLevel":3},{"Quest":"Chapter 18 Very Hard","ItemLevel":3},{"Quest":"Chapter 19 Very Hard","ItemLevel":3},{"Quest":"Special Events","ItemLevel":1},{"Quest":"Astral Raids","ItemLevel":2},{"Quest":"Trials of the Mighty","ItemLevel":2},{"Quest":"Zephyr''s Trial","ItemLevel":3},{"Quest":"Zephyr''s Trial: Master","ItemLevel":4},{"Quest":"Zephyr''s Trial: Expert","ItemLevel":4},{"Quest":"Zephyr''s Trial: Standard","ItemLevel":4},{"Quest":"Poseidon''s Trial","ItemLevel":3},{"Quest":"Poseidon''s Trial: Master","ItemLevel":4},{"Quest":"Poseidon''s Trial: Expert","ItemLevel":4},{"Quest":"Poseidon''s Trial: Standard","ItemLevel":4},{"Quest":"Thor''s Trial","ItemLevel":3},{"Quest":"Thor''s Trial: Master","ItemLevel":4},{"Quest":"Thor''s Trial: Expert","ItemLevel":4},{"Quest":"Thor''s Trial: Standard","ItemLevel":4},{"Quest":"Void Battles","ItemLevel":2},{"Quest":"Shroom Strikes","ItemLevel":3},{"Quest":"Scalding Shroom Strike","ItemLevel":4},{"Quest":"Gust Shroom Strike","ItemLevel":4},{"Quest":"Wandering Shroom Strike","ItemLevel":4},{"Quest":"Ghost Strikes","ItemLevel":3},{"Quest":"Blazing Ghost Strike","ItemLevel":4},{"Quest":"Cerulean Ghost Strike","ItemLevel":4},{"Quest":"Lambent Ghost Strike","ItemLevel":4},{"Quest":"Violet Ghost Strike","ItemLevel":4},{"Quest":"Hermit Strikes","ItemLevel":3},{"Quest":"Frost Hermit Strike","ItemLevel":4},{"Quest":"Twilight Hermit Strike","ItemLevel":4},{"Quest":"Golem Strikes","ItemLevel":3},{"Quest":"Steel Golem Strike","ItemLevel":4},{"Quest":"Amber Golem Strike","ItemLevel":4},{"Quest":"Obsidian Golem Strike","ItemLevel":4},{"Quest":"Catoblepas Strikes","ItemLevel":3},{"Quest":"Catoblepas Fotia Strike","ItemLevel":4},{"Quest":"Catoblepas Anemos Strike","ItemLevel":4},{"Quest":"Catoblepas Skia Strike","ItemLevel":4},{"Quest":"Phantom Strikes","ItemLevel":3},{"Quest":"Infernal Phantom Strike","ItemLevel":4},{"Quest":"Abyssal Phantom Strike","ItemLevel":4},{"Quest":"Eolian Phantom Strike","ItemLevel":4},{"Quest":"Manticore Strikes","ItemLevel":3},{"Quest":"Smoldering Manticore Strike","ItemLevel":4},{"Quest":"Greedy Manticore Strike","ItemLevel":4},{"Quest":"Proud Manticore Strike","ItemLevel":4},{"Quest":"Raging Manticore Strike","ItemLevel":4},{"Quest":"Void Dragon Strikes","ItemLevel":3},{"Quest":"Void Zephyr Strike","ItemLevel":4},{"Quest":"Void Zephyr Strike: Expert","ItemLevel":5},{"Quest":"Void Zephyr Strike: Standard","ItemLevel":5},{"Quest":"Void Poseidon Strike","ItemLevel":4},{"Quest":"Void Poseidon Strike: Expert","ItemLevel":5},{"Quest":"Void Poseidon Strike: Standard","ItemLevel":5},{"Quest":"Void Jeanne d''Arc Strike","ItemLevel":4},{"Quest":"Void Jeanne d''Arc Strike: Expert","ItemLevel":5},{"Quest":"Void Jeanne d''Arc Strike: Standard","ItemLevel":5},{"Quest":"Void Nidhogg Strike","ItemLevel":4},{"Quest":"Void Nidhogg Strike: Expert","ItemLevel":5},{"Quest":"Void Nidhogg Strike: Standard","ItemLevel":5},{"Quest":"Void Agni Strike","ItemLevel":4},{"Quest":"Void Agni Strike: Expert","ItemLevel":5},{"Quest":"Void Agni Strike: Standard","ItemLevel":5},{"Quest":"Chimera Strikes","ItemLevel":3},{"Quest":"Volcanic Chimera Strike","ItemLevel":4},{"Quest":"Volcanic Chimera Strike: Expert","ItemLevel":5},{"Quest":"Volcanic Chimera Strike: Standard","ItemLevel":5},{"Quest":"Tidal Chimera Strike","ItemLevel":4},{"Quest":"Tidal Chimera Strike: Expert","ItemLevel":5},{"Quest":"Tidal Chimera Strike: Standard","ItemLevel":5},{"Quest":"Tempest Chimera Strike","ItemLevel":4},{"Quest":"Tempest Chimera Strike: Expert","ItemLevel":5},{"Quest":"Tempest Chimera Strike: Standard","ItemLevel":5},{"Quest":"Luminous Chimera Strike","ItemLevel":4},{"Quest":"Luminous Chimera Strike: Expert","ItemLevel":5},{"Quest":"Luminous Chimera Strike: Standard","ItemLevel":5},{"Quest":"Ebon Chimera Strike","ItemLevel":4},{"Quest":"Ebon Chimera Strike: Expert","ItemLevel":5},{"Quest":"Ebon Chimera Strike: Standard","ItemLevel":5},{"Quest":"Recurring Events","ItemLevel":1},{"Quest":"Avenue to Power","ItemLevel":2},{"Quest":"Avenue to Fortune","ItemLevel":2},{"Quest":"Elemental Ruins","ItemLevel":2},{"Quest":"Flamehowl Ruins","ItemLevel":3},{"Quest":"Waterscour Ruins","ItemLevel":3},{"Quest":"Windmaul Ruins","ItemLevel":3},{"Quest":"Lightsunder Ruins","ItemLevel":3},{"Quest":"Shadowsteep Ruins","ItemLevel":3},{"Quest":"Event Compendium","ItemLevel":2},{"Quest":"Facility Events","ItemLevel":3},{"Quest":"Flames of Reflection","ItemLevel":4},{"Quest":"The Miracle of Dragonyule","ItemLevel":4},{"Quest":"A Wish to the Winds","ItemLevel":4},{"Quest":"Dream Big Under the Big Top","ItemLevel":4},{"Quest":"The Hunt for Harmony","ItemLevel":4},{"Quest":"Trick or Treasure","ItemLevel":4},{"Quest":"A Crescendo of Courage","ItemLevel":4},{"Quest":"The Accursed Archives","ItemLevel":4},{"Quest":"Raid Events","ItemLevel":3},{"Quest":"Fractured Futures","ItemLevel":4},{"Quest":"Forgotten Truths","ItemLevel":4},{"Quest":"Challenge Events","ItemLevel":1},{"Quest":"The Mercurial Gauntlet","ItemLevel":2},{"Quest":"Dragon Trials","ItemLevel":2},{"Quest":"Midgardsormr''s Trial","ItemLevel":3},{"Quest":"Mercury''s Trial","ItemLevel":3},{"Quest":"Brunhilda''s Trial","ItemLevel":3},{"Quest":"Jupiter''s Trial","ItemLevel":3},{"Quest":"Zodiark''s Trial","ItemLevel":3},{"Quest":"The Imperial Onslaught","ItemLevel":2},{"Quest":"Battle at Mount Adolla","ItemLevel":3},{"Quest":"Battle at Myriage Lake","ItemLevel":3},{"Quest":"Battle in Rovetelle Forest","ItemLevel":3},{"Quest":"Battle in the Dornith Mountains","ItemLevel":3},{"Quest":"Battle at the Wartarch Ruins","ItemLevel":3},{"Quest":"Advanced Dragon Trials","ItemLevel":2},{"Quest":"High Midgardsormr''s Trial","ItemLevel":3},{"Quest":"High Midgardsormr''s Trial: Master","ItemLevel":4},{"Quest":"High Midgardsormr''s Trial: Expert","ItemLevel":4},{"Quest":"High Midgardsormr''s Trial: Standard","ItemLevel":4},{"Quest":"High Midgardsormr''s Trial: Prelude","ItemLevel":4},{"Quest":"High Mercury''s Trial","ItemLevel":3},{"Quest":"High Mercury''s Trial: Master","ItemLevel":4},{"Quest":"High Mercury''s Trial: Expert","ItemLevel":4},{"Quest":"High Mercury''s Trial: Standard","ItemLevel":4},{"Quest":"High Mercury''s Trial: Prelude","ItemLevel":4},{"Quest":"High Brunhilda''s Trial","ItemLevel":3},{"Quest":"High Brunhilda''s Trial: Master","ItemLevel":4},{"Quest":"High Brunhilda''s Trial: Expert","ItemLevel":4},{"Quest":"High Brunhilda''s Trial: Standard","ItemLevel":4},{"Quest":"High Brunhilda''s Trial: Prelude","ItemLevel":4},{"Quest":"High Jupiter''s Trial","ItemLevel":3},{"Quest":"High Jupiter''s Trial: Master","ItemLevel":4},{"Quest":"High Jupiter''s Trial: Expert","ItemLevel":4},{"Quest":"High Jupiter''s Trial: Standard","ItemLevel":4},{"Quest":"High Jupiter''s Trial: Prelude","ItemLevel":4},{"Quest":"High Zodiark''s Trial","ItemLevel":3},{"Quest":"High Zodiark''s Trial: Master","ItemLevel":4},{"Quest":"High Zodiark''s Trial: Expert","ItemLevel":4},{"Quest":"High Zodiark''s Trial: Standard","ItemLevel":4},{"Quest":"High Zodiark''s Trial: Prelude","ItemLevel":4},{"Quest":"The Agito Uprising","ItemLevel":2},{"Quest":"Volk''s Wrath","ItemLevel":3},{"Quest":"Volk''s Wrath: Master","ItemLevel":4},{"Quest":"Volk''s Wrath: Expert","ItemLevel":4},{"Quest":"Volk''s Wrath: Standard","ItemLevel":4},{"Quest":"Ciella''s Wrath","ItemLevel":3},{"Quest":"Ciella''s Wrath: Master","ItemLevel":4},{"Quest":"Ciella''s Wrath: Expert","ItemLevel":4},{"Quest":"Ciella''s Wrath: Standard","ItemLevel":4},{"Quest":"Ayaha & Otoha''s Wrath","ItemLevel":3},{"Quest":"Ayaha & Otoha''s Wrath: Master","ItemLevel":4},{"Quest":"Ayaha & Otoha''s Wrath: Expert","ItemLevel":4},{"Quest":"Ayaha & Otoha''s Wrath: Standard","ItemLevel":4},{"Quest":"Kai Yan''s Wrath","ItemLevel":3},{"Quest":"Kai Yan''s Wrath: Master","ItemLevel":4},{"Quest":"Kai Yan''s Wrath: Expert","ItemLevel":4},{"Quest":"Kai Yan''s Wrath: Standard","ItemLevel":4},{"Quest":"Tartarus''s Wrath","ItemLevel":3},{"Quest":"Tartarus''s Wrath: Master","ItemLevel":4},{"Quest":"Tartarus''s Wrath: Expert","ItemLevel":4},{"Quest":"Tartarus''s Wrath: Standard","ItemLevel":4},{"Quest":"Rise of the Sinister Dominion","ItemLevel":2},{"Quest":"Lilith''s Encroaching Shadow","ItemLevel":3},{"Quest":"Lilith''s Encroaching Shadow: Master","ItemLevel":4},{"Quest":"Lilith''s Encroaching Shadow: Expert","ItemLevel":4},{"Quest":"Lilith''s Encroaching Shadow: Standard","ItemLevel":4},{"Quest":"Exceptionally Difficult Quests","ItemLevel":1},{"Quest":"The Agito Uprising: Legend Difficulty","ItemLevel":2},{"Quest":"Volk''s Wrath: Legend Difficulty","ItemLevel":3},{"Quest":"Ciella''s Wrath: Legend Difficulty","ItemLevel":3},{"Quest":"Kai Yan''s Wrath: Legend Difficulty","ItemLevel":3},{"Quest":"Forgotten Truths: Morsayati Reckoning","ItemLevel":2},{"Quest":"Morsayati Reckoning","ItemLevel":3}]'

	INSERT [den].[QuestHierarchy] (
		[Quest]
		,[ItemLevel]
		)
	SELECT [Quest]
		,[ItemLevel]
	FROM OPENJSON(@Json) WITH (
			[Quest] NVARCHAR(50)
			,[ItemLevel] INT
			)

	EXEC [den].[spSetQuestHierachy]

	TRUNCATE TABLE [den].[FarmLocation]

	SET @Json = 
		N'[{"Material":"Rupies","Quest":"Avenue to Fortune"},{"Material":"Rupies","Quest":"Advanced Dragon Trials"},{"Material":"Rupies","Quest":"The Agito Uprising"},{"Material":"Rupies","Quest":"Rise of the Sinister Dominion"},{"Material":"Eldwater","Quest":"The Mercurial Gauntlet"},{"Material":"Bronze Crystal","Quest":"Avenue to Power"},{"Material":"Silver Crystal","Quest":"Avenue to Power"},{"Material":"Gold Crystal","Quest":"Avenue to Power"},{"Material":"Fortifying Crystal","Quest":"Astral Raids"},{"Material":"Fortifying Crystal","Quest":"The Agito Uprising"},{"Material":"Fortifying Crystal","Quest":"Advanced Dragon Trials"},{"Material":"Fortifying Crystal","Quest":"Thor''s Trial"},{"Material":"Amplifying Crystal","Quest":"Astral Raids"},{"Material":"Amplifying Crystal","Quest":"The Agito Uprising"},{"Material":"Amplifying Crystal","Quest":"Advanced Dragon Trials"},{"Material":"Amplifying Crystal","Quest":"Thor''s Trial"},{"Material":"Fortifying Dragonscale","Quest":"Morsayati Reckoning"},{"Material":"Fortifying Dragonscale","Quest":"Rise of the Sinister Dominion"},{"Material":"Fortifying Dragonscale","Quest":"Thor''s Trial"},{"Material":"Amplifying Dragonscale","Quest":"Morsayati Reckoning"},{"Material":"Amplifying Dragonscale","Quest":"Rise of the Sinister Dominion"},{"Material":"Amplifying Dragonscale","Quest":"Thor''s Trial"},{"Material":"Bronze Whetstone","Quest":"The Imperial Onslaught"},{"Material":"Silver Whetstone","Quest":"The Imperial Onslaught"},{"Material":"Gold Whetstone","Quest":"The Imperial Onslaught"},{"Material":"Fortifying Gemstone","Quest":"Astral Raids"},{"Material":"Fortifying Gemstone","Quest":"The Agito Uprising"},{"Material":"Fortifying Gemstone","Quest":"Advanced Dragon Trials"},{"Material":"Fortifying Gemstone","Quest":"Thor''s Trial"},{"Material":"Amplifying Gemstone","Quest":"Astral Raids"},{"Material":"Amplifying Gemstone","Quest":"The Agito Uprising"},{"Material":"Amplifying Gemstone","Quest":"Advanced Dragon Trials"},{"Material":"Amplifying Gemstone","Quest":"Thor''s Trial"},{"Material":"Flame Orb","Quest":"Flamehowl Ruins"},{"Material":"Blaze Orb","Quest":"Flamehowl Ruins"},{"Material":"Inferno Orb","Quest":"Flamehowl Ruins"},{"Material":"Incandescence Orb","Quest":"Volcanic Chimera Strike: Expert"},{"Material":"Incandescence Orb","Quest":"Void Agni Strike: Expert"},{"Material":"Water Orb","Quest":"Waterscour Ruins"},{"Material":"Stream Orb","Quest":"Waterscour Ruins"},{"Material":"Deluge Orb","Quest":"Waterscour Ruins"},{"Material":"Tsunami Orb","Quest":"Tidal Chimera Strike: Expert"},{"Material":"Tsunami Orb","Quest":"Void Poseidon Strike: Expert"},{"Material":"Wind Orb","Quest":"Windmaul Ruins"},{"Material":"Storm Orb","Quest":"Windmaul Ruins"},{"Material":"Maelstrom Orb","Quest":"Windmaul Ruins"},{"Material":"Tempest Orb","Quest":"Tempest Chimera Strike: Expert"},{"Material":"Tempest Orb","Quest":"Void Zephyr Strike: Expert"},{"Material":"Light Orb","Quest":"Lightsunder Ruins"},{"Material":"Radiance Orb","Quest":"Lightsunder Ruins"},{"Material":"Refulgence Orb","Quest":"Lightsunder Ruins"},{"Material":"Resplendence Orb","Quest":"Luminous Chimera Strike: Expert"},{"Material":"Resplendence Orb","Quest":"Void Jeanne d''Arc Strike: Expert"},{"Material":"Resplendence Orb","Quest":"Thor''s Trial: Expert"},{"Material":"Resplendence Orb","Quest":"Thor''s Trial: Master"},{"Material":"Shadow Orb","Quest":"Shadowsteep Ruins"},{"Material":"Nightfall Orb","Quest":"Shadowsteep Ruins"},{"Material":"Nether Orb","Quest":"Shadowsteep Ruins"},{"Material":"Abaddon Orb","Quest":"Ebon Chimera Strike: Expert"},{"Material":"Abaddon Orb","Quest":"Void Nidhogg Strike: Expert"},{"Material":"Rainbow Orb","Quest":"Elemental Ruins"},{"Material":"Rainbow Orb","Quest":"Thor''s Trial"},{"Material":"Flamewyrm''s Scale","Quest":"Brunhilda''s Trial"},{"Material":"Flamewyrm''s Scaldscale","Quest":"Brunhilda''s Trial"},{"Material":"Flamewyrm''s Scaldscale","Quest":"High Brunhilda''s Trial: Prelude"},{"Material":"Waterwyrm''s Scale","Quest":"Mercury''s Trial"},{"Material":"Waterwyrm''s Glistscale","Quest":"Mercury''s Trial"},{"Material":"Waterwyrm''s Glistscale","Quest":"High Mercury''s Trial: Prelude"},{"Material":"Windwyrm''s Scale","Quest":"Midgardsormr''s Trial"},{"Material":"Windwyrm''s Squallscale","Quest":"Midgardsormr''s Trial"},{"Material":"Windwyrm''s Squallscale","Quest":"High Midgardsormr''s Trial: Prelude"},{"Material":"Lightwyrm''s Scale","Quest":"Jupiter''s Trial"},{"Material":"Lightwyrm''s Glowscale","Quest":"Jupiter''s Trial"},{"Material":"Lightwyrm''s Glowscale","Quest":"High Jupiter''s Trial: Prelude"},{"Material":"Shadowwyrm''s Scale","Quest":"Zodiark''s Trial"},{"Material":"Shadowwyrm''s Darkscale","Quest":"Zodiark''s Trial"},{"Material":"Shadowwyrm''s Darkscale","Quest":"High Zodiark''s Trial: Prelude"},{"Material":"Flamewyrm''s Sphere","Quest":"Brunhilda''s Trial"},{"Material":"Flamewyrm''s Sphere","Quest":"High Brunhilda''s Trial: Prelude"},{"Material":"Flamewyrm''s Greatsphere","Quest":"High Brunhilda''s Trial"},{"Material":"Waterwyrm''s Sphere","Quest":"Mercury''s Trial"},{"Material":"Waterwyrm''s Sphere","Quest":"High Mercury''s Trial: Prelude"},{"Material":"Waterwyrm''s Greatsphere","Quest":"High Mercury''s Trial"},{"Material":"Windwyrm''s Sphere","Quest":"Midgardsormr''s Trial"},{"Material":"Windwyrm''s Sphere","Quest":"High Midgardsormr''s Trial: Prelude"},{"Material":"Windwyrm''s Greatsphere","Quest":"High Midgardsormr''s Trial"},{"Material":"Lightwyrm''s Sphere","Quest":"Jupiter''s Trial"},{"Material":"Lightwyrm''s Sphere","Quest":"High Jupiter''s Trial: Prelude"},{"Material":"Lightwyrm''s Greatsphere","Quest":"High Jupiter''s Trial"},{"Material":"Shadowwyrm''s Sphere","Quest":"Zodiark''s Trial"},{"Material":"Shadowwyrm''s Sphere","Quest":"High Zodiark''s Trial: Prelude"},{"Material":"Shadowwyrm''s Greatsphere","Quest":"High Zodiark''s Trial"},{"Material":"High Flamewyrm''s Tail","Quest":"High Brunhilda''s Trial: Master"},{"Material":"High Flamewyrm''s Tail","Quest":"High Brunhilda''s Trial: Expert"},{"Material":"High Flamewyrm''s Horn","Quest":"High Brunhilda''s Trial: Master"},{"Material":"High Waterwyrm''s Tail","Quest":"High Mercury''s Trial: Master"},{"Material":"High Waterwyrm''s Tail","Quest":"High Mercury''s Trial: Expert"},{"Material":"High Waterwyrm''s Horn","Quest":"High Mercury''s Trial: Master"},{"Material":"High Windwyrm''s Tail","Quest":"High Midgardsormr''s Trial: Master"},{"Material":"High Windwyrm''s Tail","Quest":"High Midgardsormr''s Trial: Expert"},{"Material":"High Windwyrm''s Horn","Quest":"High Midgardsormr''s Trial: Master"},{"Material":"High Lightwyrm''s Tail","Quest":"High Jupiter''s Trial: Master"},{"Material":"High Lightwyrm''s Horn","Quest":"High Jupiter''s Trial: Master"},{"Material":"High Lightwyrm''s Horn","Quest":"High Jupiter''s Trial: Expert"},{"Material":"High Shadowwyrm''s Tail","Quest":"High Zodiark''s Trial: Master"},{"Material":"High Shadowwyrm''s Horn","Quest":"High Zodiark''s Trial: Master"},{"Material":"High Shadowwyrm''s Horn","Quest":"High Zodiark''s Trial: Expert"},{"Material":"Dyrenell Aes","Quest":"The Imperial Onslaught"},{"Material":"Dyrenell Argenteus","Quest":"The Imperial Onslaught"},{"Material":"Dyrenell Aureus","Quest":"The Imperial Onslaught"},{"Material":"Vermilion Insignia","Quest":"Battle at Mount Adolla"},{"Material":"Royal Vermilion Insignia","Quest":"Battle at Mount Adolla"},{"Material":"Azure Insignia","Quest":"Battle at Myriage Lake"},{"Material":"Royal Azure Insignia","Quest":"Battle at Myriage Lake"},{"Material":"Jade Insignia","Quest":"Battle in Rovetelle Forest"},{"Material":"Royal Jade Insignia","Quest":"Battle in Rovetelle Forest"},{"Material":"Amber Insignia","Quest":"Battle in the Dornith Mountains"},{"Material":"Royal Amber Insignia","Quest":"Battle in the Dornith Mountains"},{"Material":"Violet Insignia","Quest":"Battle at the Wartarch Ruins"},{"Material":"Royal Violet Insignia","Quest":"Battle at the Wartarch Ruins"},{"Material":"Soaring Ones'' Mask Fragment","Quest":"Ayaha & Otoha''s Wrath: Standard"},{"Material":"Soaring Ones'' Mask Fragment","Quest":"Ayaha & Otoha''s Wrath: Expert"},{"Material":"Liberated One''s Mask Fragment","Quest":"Ayaha & Otoha''s Wrath: Expert"},{"Material":"Liberated One''s Mask Fragment","Quest":"Ayaha & Otoha''s Wrath: Master"},{"Material":"Rebellious One''s Cruelty","Quest":"Ayaha & Otoha''s Wrath: Master"},{"Material":"Eliminating One''s Mask Fragment","Quest":"Ciella''s Wrath: Standard"},{"Material":"Eliminating One''s Mask Fragment","Quest":"Ciella''s Wrath: Expert"},{"Material":"Despairing One''s Mask Fragment","Quest":"Ciella''s Wrath: Expert"},{"Material":"Despairing One''s Mask Fragment","Quest":"Ciella''s Wrath: Master"},{"Material":"Rebellious One''s Desperation","Quest":"Ciella''s Wrath: Master"},{"Material":"Destitute One''s Mask Fragment","Quest":"Volk''s Wrath: Standard"},{"Material":"Destitute One''s Mask Fragment","Quest":"Volk''s Wrath: Expert"},{"Material":"Plagued One''s Mask Fragment","Quest":"Volk''s Wrath: Expert"},{"Material":"Plagued One''s Mask Fragment","Quest":"Volk''s Wrath: Master"},{"Material":"Rebellious One''s Insanity","Quest":"Volk''s Wrath: Master"},{"Material":"Rebellious Wolf''s Gale","Quest":"Volk''s Wrath: Legend Difficulty"},{"Material":"Almighty One''s Mask Fragment","Quest":"Kai Yan''s Wrath: Standard"},{"Material":"Almighty One''s Mask Fragment","Quest":"Kai Yan''s Wrath: Expert"},{"Material":"Uprooting One''s Mask Fragment","Quest":"Kai Yan''s Wrath: Expert"},{"Material":"Uprooting One''s Mask Fragment","Quest":"Kai Yan''s Wrath: Master"},{"Material":"Rebellious One''s Arrogance","Quest":"Kai Yan''s Wrath: Master"},{"Material":"Rebellious Ox''s Lightning","Quest":"Kai Yan''s Wrath: Legend Difficulty"},{"Material":"Remaining One''s Mask Fragment","Quest":"Tartarus''s Wrath: Standard"},{"Material":"Remaining One''s Mask Fragment","Quest":"Tartarus''s Wrath: Expert"},{"Material":"Vengeful One''s Mask Fragment","Quest":"Tartarus''s Wrath: Expert"},{"Material":"Vengeful One''s Mask Fragment","Quest":"Tartarus''s Wrath: Master"},{"Material":"Rebellious One''s Loyalty","Quest":"Tartarus''s Wrath: Master"},{"Material":"Talonstone","Quest":"Advanced Dragon Trials"},{"Material":"Void Leaf","Quest":"Void Battles"},{"Material":"Void Seed","Quest":"Void Battles"},{"Material":"Squishums","Quest":"Void Dragon Strikes"},{"Material":"Squishums","Quest":"Chimera Strikes"},{"Material":"Astral Shard","Quest":"Astral Raids"},{"Material":"Nature''s Blessing","Quest":"Morsayati Reckoning"},{"Material":"Nature''s Blessing","Quest":"Thor''s Trial"},{"Material":"Twilight Shard","Quest":"Lilith''s Encroaching Shadow: Expert"},{"Material":"Twilight Shard","Quest":"Lilith''s Encroaching Shadow: Standard"},{"Material":"Twilight Prism","Quest":"Lilith''s Encroaching Shadow: Expert"},{"Material":"Iron Ore","Quest":"Windmaul Ruins"},{"Material":"Iron Ore","Quest":"Battle at Mount Adolla"},{"Material":"Iron Ore","Quest":"Battle in the Dornith Mountains"},{"Material":"Granite","Quest":"Windmaul Ruins"},{"Material":"Granite","Quest":"Battle at Mount Adolla"},{"Material":"Granite","Quest":"Battle in the Dornith Mountains"},{"Material":"Meteorite","Quest":"Windmaul Ruins"},{"Material":"Meteorite","Quest":"Battle at Mount Adolla"},{"Material":"Meteorite","Quest":"Battle in the Dornith Mountains"},{"Material":"Fiend''s Claw","Quest":"Flamehowl Ruins"},{"Material":"Fiend''s Claw","Quest":"Lightsunder Ruins"},{"Material":"Fiend''s Claw","Quest":"Battle at Myriage Lake"},{"Material":"Fiend''s Claw","Quest":"Battle at the Wartarch Ruins"},{"Material":"Fiend''s Horn","Quest":"Flamehowl Ruins"},{"Material":"Fiend''s Horn","Quest":"Lightsunder Ruins"},{"Material":"Fiend''s Horn","Quest":"Battle at Myriage Lake"},{"Material":"Fiend''s Horn","Quest":"Battle at the Wartarch Ruins"},{"Material":"Fiend''s Eye","Quest":"Flamehowl Ruins"},{"Material":"Fiend''s Eye","Quest":"Lightsunder Ruins"},{"Material":"Fiend''s Eye","Quest":"Battle at Myriage Lake"},{"Material":"Fiend''s Eye","Quest":"Battle at the Wartarch Ruins"},{"Material":"Bat''s Wing","Quest":"Waterscour Ruins"},{"Material":"Bat''s Wing","Quest":"Shadowsteep Ruins"},{"Material":"Bat''s Wing","Quest":"Battle in Rovetelle Forest"},{"Material":"Ancient Bird''s Feather","Quest":"Waterscour Ruins"},{"Material":"Ancient Bird''s Feather","Quest":"Shadowsteep Ruins"},{"Material":"Ancient Bird''s Feather","Quest":"Battle in Rovetelle Forest"},{"Material":"Bewitching Wings","Quest":"Waterscour Ruins"},{"Material":"Bewitching Wings","Quest":"Shadowsteep Ruins"},{"Material":"Bewitching Wings","Quest":"Battle in Rovetelle Forest"},{"Material":"Light Metal","Quest":"Dragon Trials"},{"Material":"Abyss Stone","Quest":"Dragon Trials"},{"Material":"Crimson Core","Quest":"Dragon Trials"},{"Material":"Twinkling Sand","Quest":"The Mercurial Gauntlet"},{"Material":"Orichalcum","Quest":"High Midgardsormr''s Trial: Expert"},{"Material":"Orichalcum","Quest":"High Mercury''s Trial: Expert"},{"Material":"Orichalcum","Quest":"High Brunhilda''s Trial: Expert"},{"Material":"Orichalcum","Quest":"High Jupiter''s Trial: Expert"},{"Material":"Orichalcum","Quest":"High Zodiark''s Trial: Expert"},{"Material":"Orichalcum","Quest":"Thor''s Trial: Master"},{"Material":"Sword Tablet","Quest":"Battle in Rovetelle Forest"},{"Material":"Sword Tablet","Quest":"Battle in the Dornith Mountains"},{"Material":"Blade Tablet","Quest":"Battle at Mount Adolla"},{"Material":"Blade Tablet","Quest":"Battle in the Dornith Mountains"},{"Material":"Dagger Tablet","Quest":"Battle in Rovetelle Forest"},{"Material":"Dagger Tablet","Quest":"Battle in the Dornith Mountains"},{"Material":"Axe Tablet","Quest":"Battle at Myriage Lake"},{"Material":"Axe Tablet","Quest":"Battle in the Dornith Mountains"},{"Material":"Lance Tablet","Quest":"Battle at Mount Adolla"},{"Material":"Lance Tablet","Quest":"Battle at the Wartarch Ruins"},{"Material":"Bow Tablet","Quest":"Battle at Myriage Lake"},{"Material":"Bow Tablet","Quest":"Battle at the Wartarch Ruins"},{"Material":"Wand Tablet","Quest":"Battle at Mount Adolla"},{"Material":"Wand Tablet","Quest":"Battle at the Wartarch Ruins"},{"Material":"Staff Tablet","Quest":"Battle at Myriage Lake"},{"Material":"Staff Tablet","Quest":"Battle in Rovetelle Forest"},{"Material":"Staff Tablet","Quest":"Battle at the Wartarch Ruins"},{"Material":"Manacaster Tablet","Quest":"Battle in the Dornith Mountains"},{"Material":"Manacaster Tablet","Quest":"Battle at the Wartarch Ruins"},{"Material":"Snack-o''-Lantern","Quest":"Trick or Treasure"},{"Material":"Windwhistle Grass","Quest":"A Wish to the Winds"},{"Material":"Astral Ornament","Quest":"The Miracle of Dragonyule"},{"Material":"Tent Canvas","Quest":"Dream Big Under the Big Top"},{"Material":"Arcane Tome","Quest":"The Accursed Archives"},{"Material":"Papier-mâché","Quest":"The Hunt for Harmony"},{"Material":"Motivational Log","Quest":"Flames of Reflection"},{"Material":"Glam Shell","Quest":"A Crescendo of Courage"},{"Material":"Chef''s Special","Quest":"A Dash of Disaster"},{"Material":"Ornate Lantern","Quest":"Rhythmic Resolutions"},{"Material":"Holy Ore","Quest":"Agents of the Goddess"},{"Material":"Libretto","Quest":"The Phantom’s Ransom"},{"Material":"Solid Fungus","Quest":"Shroom Strikes"},{"Material":"Crimson Fungus","Quest":"Scalding Shroom Strike"},{"Material":"Burning Spore","Quest":"Scalding Shroom Strike"},{"Material":"Storm Fungus","Quest":"Gust Shroom Strike"},{"Material":"Spongy Spore","Quest":"Gust Shroom Strike"},{"Material":"Shiny Spore","Quest":"Wandering Shroom Strike"},{"Material":"Old Cloth","Quest":"Ghost Strikes"},{"Material":"Floating Red Cloth","Quest":"Blazing Ghost Strike"},{"Material":"Otherworldly Lantern","Quest":"Blazing Ghost Strike"},{"Material":"Floating Blue Cloth","Quest":"Cerulean Ghost Strike"},{"Material":"Abyssal Lantern","Quest":"Cerulean Ghost Strike"},{"Material":"Floating Yellow Cloth","Quest":"Lambent Ghost Strike"},{"Material":"Unearthly Lantern","Quest":"Lambent Ghost Strike"},{"Material":"Floating Purple Cloth","Quest":"Violet Ghost Strike"},{"Material":"Shadowy Lantern","Quest":"Violet Ghost Strike"},{"Material":"Goblin Thread","Quest":"Hermit Strikes"},{"Material":"Aromatic Wood","Quest":"Frost Hermit Strike"},{"Material":"Purple Thread","Quest":"Twilight Hermit Strike"},{"Material":"Acoustic Wood","Quest":"Twilight Hermit Strike"},{"Material":"Steel Slab","Quest":"Golem Strikes"},{"Material":"Golem Core","Quest":"Steel Golem Strike"},{"Material":"Amber Slab","Quest":"Amber Golem Strike"},{"Material":"Light Core","Quest":"Amber Golem Strike"},{"Material":"Obsidian Slab","Quest":"Obsidian Golem Strike"},{"Material":"Dark Core","Quest":"Obsidian Golem Strike"},{"Material":"Catoblepas''s Hoof","Quest":"Catoblepas Strikes"},{"Material":"Catoblepas''s Heateye","Quest":"Catoblepas Fotia Strike"},{"Material":"Catoblepas''s Stormeye","Quest":"Catoblepas Anemos Strike"},{"Material":"Catoblepas''s Shadoweye","Quest":"Catoblepas Skia Strike"},{"Material":"Soul Vestiges","Quest":"Phantom Strikes"},{"Material":"Infernal Soul","Quest":"Infernal Phantom Strike"},{"Material":"Abyssal Soul","Quest":"Abyssal Phantom Strike"},{"Material":"Eolian Soul","Quest":"Eolian Phantom Strike"},{"Material":"Raging Fang","Quest":"Manticore Strikes"},{"Material":"Smoldering Tail","Quest":"Smoldering Manticore Strike"},{"Material":"Greedy Tail","Quest":"Greedy Manticore Strike"},{"Material":"Proud Tail","Quest":"Proud Manticore Strike"},{"Material":"Raging Tail","Quest":"Raging Manticore Strike"},{"Material":"Great Feather","Quest":"Void Zephyr Strike"},{"Material":"Zephyr Rune","Quest":"Void Zephyr Strike"},{"Material":"Oceanic Fin","Quest":"Void Poseidon Strike"},{"Material":"Oceanic Crown","Quest":"Void Poseidon Strike"},{"Material":"Necroblossom","Quest":"Void Jeanne d''Arc Strike"},{"Material":"Abyssal Standard","Quest":"Void Jeanne d''Arc Strike"},{"Material":"Ruinous Horn","Quest":"Void Nidhogg Strike"},{"Material":"Ruinous Wing","Quest":"Void Nidhogg Strike"},{"Material":"Blazing Horn","Quest":"Void Agni Strike"},{"Material":"Blazing Ember","Quest":"Void Agni Strike"},{"Material":"Volcanic Mane","Quest":"Volcanic Chimera Strike"},{"Material":"Volcanic Claw","Quest":"Volcanic Chimera Strike"},{"Material":"Volcanic Horn","Quest":"Volcanic Chimera Strike: Expert"},{"Material":"Tidal Mane","Quest":"Tidal Chimera Strike"},{"Material":"Tidal Claw","Quest":"Tidal Chimera Strike"},{"Material":"Tidal Horn","Quest":"Tidal Chimera Strike: Expert"},{"Material":"Tempest Mane","Quest":"Tempest Chimera Strike"},{"Material":"Tempest Claw","Quest":"Tempest Chimera Strike"},{"Material":"Tempest Horn","Quest":"Tempest Chimera Strike: Expert"},{"Material":"Luminous Mane","Quest":"Luminous Chimera Strike"},{"Material":"Luminous Claw","Quest":"Luminous Chimera Strike"},{"Material":"Luminous Horn","Quest":"Luminous Chimera Strike: Expert"},{"Material":"Ebon Mane","Quest":"Ebon Chimera Strike"},{"Material":"Ebon Claw","Quest":"Ebon Chimera Strike"},{"Material":"Ebon Horn","Quest":"Ebon Chimera Strike: Expert"},{"Material":"Burning Heart","Quest":"Void Agni Strike"},{"Material":"Azure Heart","Quest":"Void Poseidon Strike"},{"Material":"Verdant Heart","Quest":"Void Zephyr Strike"},{"Material":"Coronal Heart","Quest":"Void Jeanne d''Arc Strike"},{"Material":"Ebony Heart","Quest":"Void Nidhogg Strike"},{"Material":"Longing Heart","Quest":"Void Dragon Strikes"},{"Material":"Agni''s Essence","Quest":"Ch. 3 / 1-3 Hard"},{"Material":"Agni''s Essence","Quest":"Ch. 3 / 1-3 Very Hard"},{"Material":"Prometheus''s Essence","Quest":"Ch. 3 / 3-5 Hard"},{"Material":"Prometheus''s Essence","Quest":"Ch. 3 / 3-5 Very Hard"},{"Material":"Cerberus''s Essence","Quest":"Ch. 3 / 2-3 Hard"},{"Material":"Cerberus''s Essence","Quest":"Ch. 3 / 2-3 Very Hard"},{"Material":"Konohana Sakuya''s Essence","Quest":"Ch. 3 / 4-3 Hard"},{"Material":"Konohana Sakuya''s Essence","Quest":"Ch. 3 / 4-3 Very Hard"},{"Material":"Arctos''s Essence","Quest":"Ch. 8 / 1-4 Hard"},{"Material":"Arctos''s Essence","Quest":"Ch. 8 / 1-4 Very Hard"},{"Material":"Apollo''s Essence","Quest":"Ch. 8 / 2-3 Hard"},{"Material":"Apollo''s Essence","Quest":"Ch. 8 / 2-3 Very Hard"},{"Material":"Leviathan''s Essence","Quest":"Ch. 2 / 3-3 Hard"},{"Material":"Leviathan''s Essence","Quest":"Ch. 2 / 3-3 Very Hard"},{"Material":"Poseidon''s Essence","Quest":"Ch. 2 / 1-3 Hard"},{"Material":"Poseidon''s Essence","Quest":"Ch. 2 / 1-3 Very Hard"},{"Material":"Siren''s Essence","Quest":"Ch. 2 / 4-2 Hard"},{"Material":"Siren''s Essence","Quest":"Ch. 2 / 4-2 Very Hard"},{"Material":"Simurgh''s Essence","Quest":"Ch. 2 / 5-1 Hard"},{"Material":"Simurgh''s Essence","Quest":"Ch. 2 / 5-1 Very Hard"},{"Material":"Kamuy''s Essence","Quest":"Ch. 2 / 6-1 Hard"},{"Material":"Kamuy''s Essence","Quest":"Ch. 2 / 6-1 Very Hard"},{"Material":"Nimis''s Essence","Quest":"Ch. 7 / 1-3 Hard"},{"Material":"Nimis''s Essence","Quest":"Ch. 7 / 1-3 Very Hard"},{"Material":"Zephyr''s Essence","Quest":"Ch. 1 / 1-2 Hard"},{"Material":"Zephyr''s Essence","Quest":"Ch. 1 / 1-2 Very Hard"},{"Material":"Garuda''s Essence","Quest":"Ch. 1 / 2-2 Hard"},{"Material":"Garuda''s Essence","Quest":"Ch. 1 / 2-2 Very Hard"},{"Material":"Long Long''s Essence","Quest":"Ch. 1 / 4-5 Hard"},{"Material":"Long Long''s Essence","Quest":"Ch. 1 / 4-5 Very Hard"},{"Material":"Pazuzu''s Essence","Quest":"Ch. 6 / 1-6 Hard"},{"Material":"Pazuzu''s Essence","Quest":"Ch. 6 / 1-6 Very Hard"},{"Material":"Freyja''s Essence","Quest":"Ch. 6 / 3-3 Hard"},{"Material":"Freyja''s Essence","Quest":"Ch. 6 / 3-3 Very Hard"},{"Material":"Vayu''s Essence","Quest":"Ch. 6 / 4-2 Hard"},{"Material":"Vayu''s Essence","Quest":"Ch. 6 / 4-2 Very Hard"},{"Material":"Cupid''s Essence","Quest":"Ch. 4 / 4-2 Hard"},{"Material":"Cupid''s Essence","Quest":"Ch. 4 / 4-2 Very Hard"},{"Material":"Jeanne d''Arc''s Essence","Quest":"Ch. 4 / 1-4 Hard"},{"Material":"Jeanne d''Arc''s Essence","Quest":"Ch. 4 / 1-4 Very Hard"},{"Material":"Gilgamesh''s Essence","Quest":"Ch. 4 / 3-5 Hard"},{"Material":"Gilgamesh''s Essence","Quest":"Ch. 4 / 3-5 Very Hard"},{"Material":"Liger''s Essence","Quest":"Ch. 4 / 5-2 Hard"},{"Material":"Liger''s Essence","Quest":"Ch. 4 / 5-2 Very Hard"},{"Material":"Takemikazuchi''s Essence","Quest":"Ch. 9 / 1-2 Hard"},{"Material":"Takemikazuchi''s Essence","Quest":"Ch. 9 / 1-2 Very Hard"},{"Material":"Pop-Star Siren''s Essence","Quest":"Ch. 9 / 2-2 Hard"},{"Material":"Pop-Star Siren''s Essence","Quest":"Ch. 9 / 2-2 Very Hard"},{"Material":"Chthonius''s Essence","Quest":"Ch. 5 / 4-3 Hard"},{"Material":"Chthonius''s Essence","Quest":"Ch. 5 / 4-3 Very Hard"},{"Material":"Nidhogg''s Essence","Quest":"Ch. 5 / 1-3 Hard"},{"Material":"Nidhogg''s Essence","Quest":"Ch. 5 / 1-3 Very Hard"},{"Material":"Nyarlathotep''s Essence","Quest":"Ch. 5 / 2-4 Hard"},{"Material":"Nyarlathotep''s Essence","Quest":"Ch. 5 / 2-4 Very Hard"},{"Material":"Shinobi''s Essence","Quest":"Ch. 5 / 3-3 Hard"},{"Material":"Shinobi''s Essence","Quest":"Ch. 5 / 3-3 Very Hard"},{"Material":"Epimetheus''s Essence","Quest":"Ch. 10 / 1-2 Hard"},{"Material":"Epimetheus''s Essence","Quest":"Ch. 10 / 1-2 Very Hard"},{"Material":"Andromeda''s Essence","Quest":"Ch. 10 / 2-2 Hard"},{"Material":"Andromeda''s Essence","Quest":"Ch. 10 / 2-2 Very Hard"},{"Material":"Crown of Light''s Memory","Quest":"Lilith''s Encroaching Shadow: Standard"},{"Material":"Tutelary Successor''s Memory","Quest":"Lilith''s Encroaching Shadow: Standard"},{"Material":"Queen of the Sands'' Memory","Quest":"Lilith''s Encroaching Shadow"},{"Material":"Otherworld Auspex''s Memory","Quest":"Lilith''s Encroaching Shadow"},{"Material":"Twilight Queen''s Memory","Quest":"Lilith''s Encroaching Shadow: Expert"},{"Material":"Twilight Queen''s Memory","Quest":"Lilith''s Encroaching Shadow: Master"},{"Material":"Determined Auspex''s Memory","Quest":"Lilith''s Encroaching Shadow: Expert"},{"Material":"Determined Auspex''s Memory","Quest":"Lilith''s Encroaching Shadow: Master"},{"Material":"Rebellious Bird''s Tide","Quest":"Ciella''s Wrath: Legend Difficulty"},{"Material":"Gala Prince''s Conviction","Quest":"Thor''s Trial"},{"Material":"Gala Prince''s Devotion","Quest":"Thor''s Trial: Expert"},{"Material":"Gala Prince''s Devotion","Quest":"Thor''s Trial: Master"},{"Material":"Gala Elisanne''s Conviction","Quest":"Poseidon''s Trial"},{"Material":"Gala Elisanne''s Devotion","Quest":"Poseidon''s Trial: Expert"},{"Material":"Gala Elisanne''s Devotion","Quest":"Poseidon''s Trial: Master"},{"Material":"Rainbow Orb","Quest":"Poseidon''s Trial"},{"Material":"Resplendence Orb","Quest":"Poseidon''s Trial: Master"},{"Material":"Resplendence Orb","Quest":"Poseidon''s Trial: Expert"},{"Material":"Fortifying Crystal","Quest":"Poseidon''s Trial"},{"Material":"Amplifying Crystal","Quest":"Poseidon''s Trial"},{"Material":"Fortifying Dragonscale","Quest":"Poseidon''s Trial"},{"Material":"Amplifying Dragonscale","Quest":"Poseidon''s Trial"},{"Material":"Fortifying Gemstone","Quest":"Poseidon''s Trial"},{"Material":"Amplifying Gemstone","Quest":"Poseidon''s Trial"},{"Material":"Nature''s Blessing","Quest":"Poseidon''s Trial"},{"Material":"Orichalcum","Quest":"Poseidon''s Trial: Master"},{"Quest":"Zephyr''s Trial","Material":"Rainbow Orb"},{"Quest":"Zephyr''s Trial: Master","Material":"Resplendence Orb"},{"Quest":"Zephyr''s Trial: Expert","Material":"Resplendence Orb"},{"Quest":"Zephyr''s Trial","Material":"Fortifying Crystal"},{"Quest":"Zephyr''s Trial","Material":"Amplifying Crystal"},{"Quest":"Zephyr''s Trial","Material":"Fortifying Dragonscale"},{"Quest":"Zephyr''s Trial","Material":"Amplifying Dragonscale"},{"Quest":"Zephyr''s Trial","Material":"Fortifying Gemstone"},{"Quest":"Zephyr''s Trial","Material":"Amplifying Gemstone"},{"Quest":"Zephyr''s Trial","Material":"Nature''s Blessing"},{"Quest":"Zephyr''s Trial: Master","Material":"Orichalcum"},{"Quest":"Zephyr''s Trial","Material":"Gala Ranzal''s Conviction"},{"Quest":"Zephyr''s Trial: Master","Material":"Gala Ranzal''s Devotion"},{"Quest":"Zephyr''s Trial: Expert","Material":"Gala Ranzal''s Devotion"},{"Material":"Kagutsuchi''s Essence","Quest":"Ch. 8 / 3-4 Hard"},{"Material":"Kagutsuchi''s Essence","Quest":"Ch. 8 / 3-4 Very Hard"},{"Material":"Gaibhne & Creidhne''s Essence","Quest":"Ch. 7 / 2-3 Hard"},{"Material":"Gaibhne & Creidhne''s Essence","Quest":"Ch. 7 / 2-3 Very Hard"},{"Material":"Hastur''s Essence","Quest":"Ch. 14 / 1-2 Hard"},{"Material":"Hastur''s Essence","Quest":"Ch. 14 / 1-2 Very Hard"},{"Material":"Corsaint Phoenix''s Essence","Quest":"Ch. 9 / 3-2 Hard"},{"Material":"Corsaint Phoenix''s Essence","Quest":"Ch. 9 / 3-2 Very Hard"},{"Material":"Azazel''s Essence","Quest":"Ch. 10 / 3-2 Hard"},{"Material":"Azazel''s Essence","Quest":"Ch. 10 / 3-2 Very Hard"}]'

	INSERT [den].[FarmLocation] (
		[Material]
		,[Quest]
		)
	SELECT [Material]
		,[Quest]
	FROM OPENJSON(@Json) WITH (
			[Material] NVARCHAR(50)
			,[Quest] NVARCHAR(50)
			)

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

	TRUNCATE TABLE [den].[CategoryMetadata]

	SET @Json = N'[{"Category":"Halidom","SortPath":"/1/"},{"Category":"Production","SortPath":"/2/"},{"Category":"Altars","SortPath":"/3/"},{"Category":"Dojos","SortPath":"/4/"},{"Category":"Dracoliths","SortPath":"/8/"},{"Category":"Fafnir Statues","SortPath":"/9/"},{"Category":"Slime Statues","SortPath":"/5/"},{"Category":"Agito Trees","SortPath":"/6/"},{"Category":"Event Facility","SortPath":"/7/"},{"Category":"Decoration","SortPath":"/10/"}]'

	INSERT [den].[CategoryMetadata] (
		[Category]
		,[SortPath]
		)
	SELECT [Category]
		,[SortPath]
	FROM OPENJSON(@Json) WITH (
			[Category] NVARCHAR(50)
			,[SortPath] NVARCHAR(255)
			)
END
