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
		N'[{"Category":"Adventurer Upgrade Items","Material":"Bronze Crystal","SortPath":"/2/1/"},{"Category":"Adventurer Upgrade Items","Material":"Silver Crystal","SortPath":"/2/2/"},{"Category":"Adventurer Upgrade Items","Material":"Gold Crystal","SortPath":"/2/3/"},{"Category":"Dragon Upgrade Items","Material":"Dragonfruit","SortPath":"/4/1/"},{"Category":"Dragon Upgrade Items","Material":"Ripe Dragonfruit","SortPath":"/4/2/"},{"Category":"Dragon Upgrade Items","Material":"Succulent Dragonfruit","SortPath":"/4/3/"},{"Category":"Weapon Upgrade Items","Material":"Bronze Whetstone","SortPath":"/6/1/"},{"Category":"Weapon Upgrade Items","Material":"Silver Whetstone","SortPath":"/6/2/"},{"Category":"Weapon Upgrade Items","Material":"Gold Whetstone","SortPath":"/6/3/"},{"Category":"Orbs","Material":"Rainbow Orb","SortPath":"/9/6/"},{"Category":"Orbs","Material":"Flame Orb","SortPath":"/9/1/1/"},{"Category":"Orbs","Material":"Blaze Orb","SortPath":"/9/1/2/"},{"Category":"Orbs","Material":"Inferno Orb","SortPath":"/9/1/3/"},{"Category":"Orbs","Material":"Incandescence Orb","SortPath":"/9/1/4/"},{"Category":"Orbs","Material":"Water Orb","SortPath":"/9/2/1/"},{"Category":"Orbs","Material":"Stream Orb","SortPath":"/9/2/2/"},{"Category":"Orbs","Material":"Deluge Orb","SortPath":"/9/2/3/"},{"Category":"Orbs","Material":"Tsunami Orb","SortPath":"/9/2/4/"},{"Category":"Orbs","Material":"Wind Orb","SortPath":"/9/3/1/"},{"Category":"Orbs","Material":"Storm Orb","SortPath":"/9/3/2/"},{"Category":"Orbs","Material":"Maelstrom Orb","SortPath":"/9/3/3/"},{"Category":"Orbs","Material":"Tempest Orb","SortPath":"/9/3/4/"},{"Category":"Orbs","Material":"Light Orb","SortPath":"/9/4/1/"},{"Category":"Orbs","Material":"Radiance Orb","SortPath":"/9/4/2/"},{"Category":"Orbs","Material":"Refulgence Orb","SortPath":"/9/4/3/"},{"Category":"Orbs","Material":"Resplendence Orb","SortPath":"/9/4/4/"},{"Category":"Orbs","Material":"Shadow Orb","SortPath":"/9/5/1/"},{"Category":"Orbs","Material":"Nightfall Orb","SortPath":"/9/5/2/"},{"Category":"Orbs","Material":"Nether Orb","SortPath":"/9/5/3/"},{"Category":"Orbs","Material":"Abaddon Orb","SortPath":"/9/5/4/"},{"Category":"Scales","Material":"Flamewyrm''s Scale","SortPath":"/10/1/1/"},{"Category":"Scales","Material":"Flamewyrm''s Scaldscale","SortPath":"/10/1/2/"},{"Category":"Scales","Material":"Waterwyrm''s Scale","SortPath":"/10/2/1/"},{"Category":"Scales","Material":"Waterwyrm''s Glistscale","SortPath":"/10/2/2/"},{"Category":"Scales","Material":"Windwyrm''s Scale","SortPath":"/10/3/1/"},{"Category":"Scales","Material":"Windwyrm''s Squallscale","SortPath":"/10/3/1/"},{"Category":"Scales","Material":"Lightwyrm''s Scale","SortPath":"/10/4/1/"},{"Category":"Scales","Material":"Lightwyrm''s Glowscale","SortPath":"/10/4/2/"},{"Category":"Scales","Material":"Shadowwyrm''s Scale","SortPath":"/10/5/1/"},{"Category":"Scales","Material":"Shadowwyrm''s Darkscale","SortPath":"/10/5/2/"},{"Category":"Testaments","Material":"Knight''s Testament","SortPath":"/11/1/"},{"Category":"Testaments","Material":"Champion''s Testament","SortPath":"/11/2/"},{"Category":"Stones","Material":"Moonlight Stone","SortPath":"/12/1/"},{"Category":"Stones","Material":"Sunlight Stone","SortPath":"/12/2/"},{"Category":"Ingots","Material":"Steel Brick","SortPath":"/13/1/"},{"Category":"Ingots","Material":"Damascus Ingot","SortPath":"/13/2/"},{"Category":"Ingots","Material":"Adamantite Ingot","SortPath":"/13/3/"},{"Category":"Wyrmprint Upgrade Items","Material":"Holy Water","SortPath":"/7/1/"},{"Category":"Wyrmprint Upgrade Items","Material":"Blessed Water","SortPath":"/7/2/"},{"Category":"Wyrmprint Upgrade Items","Material":"Consecrated Water","SortPath":"/7/3/"},{"Category":"Keys","Material":"Silver Key","SortPath":"/14/1/"},{"Category":"Keys","Material":"Golden Key","SortPath":"/14/2/"},{"Category":"Adventurer Upgrade Items","Material":"Fortifying Crystal","SortPath":"/3/1/"},{"Category":"Adventurer Upgrade Items","Material":"Amplifying Crystal","SortPath":"/3/2/"},{"Category":"Dragon Upgrade Items","Material":"Fortifying Dragonscale","SortPath":"/5/1/"},{"Category":"Dragon Upgrade Items","Material":"Amplifying Dragonscale","SortPath":"/5/2/"},{"Category":"Wyrmprint Upgrade Items","Material":"Fortifying Gemstone","SortPath":"/8/1/"},{"Category":"Wyrmprint Upgrade Items","Material":"Amplifying Gemstone","SortPath":"/8/2/"},{"Category":"Other Materials","Material":"Wyrmsigil Remnant","SortPath":"/37/1/"},{"Category":"Dragon Spheres","Material":"Flamewyrm''s Sphere","SortPath":"/15/1/1/"},{"Category":"Dragon Spheres","Material":"Flamewyrm''s Greatsphere","SortPath":"/15/1/2/"},{"Category":"Dragon Spheres","Material":"Waterwyrm''s Sphere","SortPath":"/15/2/1/"},{"Category":"Dragon Spheres","Material":"Waterwyrm''s Greatsphere","SortPath":"/15/2/2/"},{"Category":"Dragon Spheres","Material":"Windwyrm''s Sphere","SortPath":"/15/3/1/"},{"Category":"Dragon Spheres","Material":"Windwyrm''s Greatsphere","SortPath":"/15/3/2/"},{"Category":"Dragon Spheres","Material":"Lightwyrm''s Sphere","SortPath":"/15/4/1/"},{"Category":"Dragon Spheres","Material":"Lightwyrm''s Greatsphere","SortPath":"/15/4/2/"},{"Category":"Dragon Spheres","Material":"Shadowwyrm''s Sphere","SortPath":"/15/5/1/"},{"Category":"Dragon Spheres","Material":"Shadowwyrm''s Greatsphere","SortPath":"/15/5/2/"},{"Category":"Other Items","Material":"Talonstone","SortPath":"/20/1/"},{"Category":"Treasure Trade Fragments","Material":"Damascus Crystal","SortPath":"/21/1/"},{"Category":"Other Items","Material":"Looking Glass","SortPath":"/20/2/"},{"Category":"Dyrenell Coins","Material":"Dyrenell Aes","SortPath":"/17/1/"},{"Category":"Dyrenell Coins","Material":"Dyrenell Argenteus","SortPath":"/17/2/"},{"Category":"Dyrenell Coins","Material":"Dyrenell Aureus","SortPath":"/17/3/"},{"Category":"Insignia","Material":"Vermilion Insignia","SortPath":"/18/1/1/"},{"Category":"Insignia","Material":"Royal Vermilion Insignia","SortPath":"/18/1/2/"},{"Category":"Insignia","Material":"Azure Insignia","SortPath":"/18/2/1/"},{"Category":"Insignia","Material":"Royal Azure Insignia","SortPath":"/18/2/2/"},{"Category":"Insignia","Material":"Jade Insignia","SortPath":"/18/3/1/"},{"Category":"Insignia","Material":"Royal Jade Insignia","SortPath":"/18/3/2/"},{"Category":"Insignia","Material":"Amber Insignia","SortPath":"/18/4/1/"},{"Category":"Insignia","Material":"Royal Amber Insignia","SortPath":"/18/4/2/"},{"Category":"Insignia","Material":"Violet Insignia","SortPath":"/18/5/1/"},{"Category":"Insignia","Material":"Royal Violet Insignia","SortPath":"/18/5/2/"},{"Category":"Treasure Trade Fragments","Material":"Sunlight Ore","SortPath":"/21/2/"},{"Category":"Treasure Trade Fragments","Material":"Golden Fragment","SortPath":"/21/3/"},{"Category":"Universal Void Drops","Material":"Void Leaf","SortPath":"/22/1/"},{"Category":"Universal Void Drops","Material":"Void Seed","SortPath":"/22/2/"},{"Category":"Squishums and Other Jokes","Material":"Squishums","SortPath":"/23/1/"},{"Category":"Squishums and Other Jokes","Material":"Imitation Squish","SortPath":"/23/2/"},{"Category":"Treasure Trade Fragments","Material":"Twinkling Grains","SortPath":"/21/4/"},{"Category":"Astral Shards","Material":"Astral Shard","SortPath":"/25/"},{"Category":"Agito Fragments","Material":"Soaring Ones'' Mask Fragment","SortPath":"/19/1/1/"},{"Category":"Agito Fragments","Material":"Liberated One''s Mask Fragment","SortPath":"/19/1/2/"},{"Category":"Agito Fragments","Material":"Rebellious One''s Cruelty","SortPath":"/19/1/3/"},{"Category":"Agito Fragments","Material":"Eliminating One''s Mask Fragment","SortPath":"/19/2/1/"},{"Category":"Agito Fragments","Material":"Despairing One''s Mask Fragment","SortPath":"/19/2/2/"},{"Category":"Agito Fragments","Material":"Rebellious One''s Desperation","SortPath":"/19/2/3/"},{"Category":"Agito Fragments","Material":"Rebellious Bird''s Tide","SortPath":"/19/2/4/"},{"Category":"Agito Fragments","Material":"Destitute One''s Mask Fragment","SortPath":"/19/3/1/"},{"Category":"Agito Fragments","Material":"Plagued One''s Mask Fragment","SortPath":"/19/3/2/"},{"Category":"Agito Fragments","Material":"Rebellious One''s Insanity","SortPath":"/19/3/3/"},{"Category":"Agito Fragments","Material":"Rebellious Wolf''s Gale","SortPath":"/19/3/4/"},{"Category":"Agito Fragments","Material":"Almighty One''s Mask Fragment","SortPath":"/19/4/1/"},{"Category":"Agito Fragments","Material":"Uprooting One''s Mask Fragment","SortPath":"/19/4/2/"},{"Category":"Agito Fragments","Material":"Rebellious One''s Arrogance","SortPath":"/19/4/3/"},{"Category":"Agito Fragments","Material":"Rebellious Ox''s Lightning","SortPath":"/19/4/4/"},{"Category":"Agito Fragments","Material":"Remaining One''s Mask Fragment","SortPath":"/19/5/1/"},{"Category":"Agito Fragments","Material":"Vengeful One''s Mask Fragment","SortPath":"/19/5/2/"},{"Category":"Agito Fragments","Material":"Rebellious One''s Loyalty","SortPath":"/19/5/3/"},{"Category":"Squishums and Other Jokes","Material":"Half-Eaten Bread","SortPath":"/23/3/"},{"Category":"Tomes","Material":"Flame Tome","SortPath":"/24/1/"},{"Category":"Tomes","Material":"Water Tome","SortPath":"/24/2/"},{"Category":"Tomes","Material":"Wind Tome","SortPath":"/24/3/"},{"Category":"Tomes","Material":"Light Tome","SortPath":"/24/4/"},{"Category":"Tomes","Material":"Shadow Tome","SortPath":"/24/5/"},{"Category":"Alberian Battle Royale","Material":"Appearance Ticket","SortPath":"/26/"},{"Category":"Nature''s Blessing","Material":"Nature''s Blessing","SortPath":"/27/"},{"Category":"Dominion Shards","Material":"Twilight Shard","SortPath":"/27.1/1/"},{"Category":"Dominion Shards","Material":"Twilight Prism","SortPath":"/27.1/2/"},{"Category":"Weapon Upgrade Materials","Material":"Iron Ore","SortPath":"/28/1/1/"},{"Category":"Weapon Upgrade Materials","Material":"Granite","SortPath":"/28/1/2/"},{"Category":"Weapon Upgrade Materials","Material":"Meteorite","SortPath":"/28/1/3/"},{"Category":"Weapon Upgrade Materials","Material":"Fiend''s Claw","SortPath":"/28/2/1/"},{"Category":"Weapon Upgrade Materials","Material":"Fiend''s Horn","SortPath":"/28/2/2/"},{"Category":"Weapon Upgrade Materials","Material":"Fiend''s Eye","SortPath":"/28/2/3/"},{"Category":"Weapon Upgrade Materials","Material":"Bat''s Wing","SortPath":"/28/3/1/"},{"Category":"Weapon Upgrade Materials","Material":"Ancient Bird''s Feather","SortPath":"/28/3/2/"},{"Category":"Weapon Upgrade Materials","Material":"Bewitching Wings","SortPath":"/28/3/3/"},{"Category":"Special Weapon Upgrade Materials","Material":"Light Metal","SortPath":"/29/1/1/"},{"Category":"Special Weapon Upgrade Materials","Material":"Abyss Stone","SortPath":"/29/1/2/"},{"Category":"Special Weapon Upgrade Materials","Material":"Crimson Core","SortPath":"/29/1/3/"},{"Category":"Special Weapon Upgrade Materials","Material":"Twinkling Sand","SortPath":"/29/2/1/"},{"Category":"Special Weapon Upgrade Materials","Material":"Orichalcum","SortPath":"/29/2/2/"},{"Category":"Tablet","Material":"Sword Tablet","SortPath":"/30/1/"},{"Category":"Tablet","Material":"Blade Tablet","SortPath":"/30/2/"},{"Category":"Tablet","Material":"Dagger Tablet","SortPath":"/30/3/"},{"Category":"Tablet","Material":"Axe Tablet","SortPath":"/30/4/"},{"Category":"Tablet","Material":"Lance Tablet","SortPath":"/30/5/"},{"Category":"Tablet","Material":"Bow Tablet","SortPath":"/30/6/"},{"Category":"Tablet","Material":"Wand Tablet","SortPath":"/30/7/"},{"Category":"Tablet","Material":"Staff Tablet","SortPath":"/30/8/"},{"Category":"Tablet","Material":"Manacaster Tablet","SortPath":"/30/9/"},{"Category":"High Dragon Materials","Material":"High Flamewyrm''s Tail","SortPath":"/16/1/1/"},{"Category":"High Dragon Materials","Material":"High Waterwyrm''s Tail","SortPath":"/16/2/1/"},{"Category":"High Dragon Materials","Material":"High Windwyrm''s Tail","SortPath":"/16/3/1/"},{"Category":"High Dragon Materials","Material":"High Lightwyrm''s Tail","SortPath":"/16/4/1/"},{"Category":"High Dragon Materials","Material":"High Shadowwyrm''s Tail","SortPath":"/16/5/1/"},{"Category":"High Dragon Materials","Material":"High Flamewyrm''s Horn","SortPath":"/16/1/2/"},{"Category":"High Dragon Materials","Material":"High Waterwyrm''s Horn","SortPath":"/16/2/2/"},{"Category":"High Dragon Materials","Material":"High Windwyrm''s Horn","SortPath":"/16/3/2/"},{"Category":"High Dragon Materials","Material":"High Lightwyrm''s Horn","SortPath":"/16/4/2/"},{"Category":"High Dragon Materials","Material":"High Shadowwyrm''s Horn","SortPath":"/16/5/2/"},{"Category":"Hearts","Material":"Burning Heart","SortPath":"/35/1/"},{"Category":"Hearts","Material":"Azure Heart","SortPath":"/35/2/"},{"Category":"Hearts","Material":"Verdant Heart","SortPath":"/35/3/"},{"Category":"Hearts","Material":"Coronal Heart","SortPath":"/35/4/"},{"Category":"Hearts","Material":"Ebony Heart","SortPath":"/35/5/"},{"Category":"Hearts","Material":"Longing Heart","SortPath":"/35/6/"},{"Category":"Event Facility Upgrade Materials","Material":"Snack-o''-Lantern","SortPath":"/31/1/"},{"Category":"Event Facility Upgrade Materials","Material":"Windwhistle Grass","SortPath":"/31/2/"},{"Category":"Event Facility Upgrade Materials","Material":"Astral Ornament","SortPath":"/31/3/"},{"Category":"Event Facility Upgrade Materials","Material":"Tent Canvas","SortPath":"/31/4/"},{"Category":"Event Facility Upgrade Materials","Material":"Arcane Tome","SortPath":"/31/5/"},{"Category":"Event Facility Upgrade Materials","Material":"Papier-mâché","SortPath":"/31/6/"},{"Category":"Event Facility Upgrade Materials","Material":"Motivational Log","SortPath":"/31/7/"},{"Category":"Event Facility Upgrade Materials","Material":"Glam Shell","SortPath":"/31/8/"},{"Category":"Event Facility Upgrade Materials","Material":"Chef''s Special","SortPath":"/31/9/"},{"Category":"Event Facility Upgrade Materials","Material":"Ornate Lantern","SortPath":"/31/10/"},{"Category":"Event Facility Upgrade Materials","Material":"Holy Ore","SortPath":"/31/11/"},{"Category":"Event Facility Upgrade Materials","Material":"Libretto","SortPath":"/31/12/"},{"Category":"Void Materials","Material":"Solid Fungus","SortPath":"/32/1/1/"},{"Category":"Void Materials","Material":"Shiny Spore","SortPath":"/32/1/6/"},{"Category":"Void Materials","Material":"Goblin Thread","SortPath":"/32/3/1/"},{"Category":"Void Materials","Material":"Aromatic Wood","SortPath":"/32/3/2/"},{"Category":"Void Materials","Material":"Steel Slab","SortPath":"/32/4/1/"},{"Category":"Void Materials","Material":"Golem Core","SortPath":"/32/4/2/"},{"Category":"Void Dragon Materials","Material":"Great Feather","SortPath":"/33/1/1/"},{"Category":"Void Dragon Materials","Material":"Zephyr Rune","SortPath":"/33/1/2/"},{"Category":"Void Materials","Material":"Raging Fang","SortPath":"/32/7/1/"},{"Category":"Void Materials","Material":"Raging Tail","SortPath":"/32/7/5/"},{"Category":"Void Materials","Material":"Old Cloth","SortPath":"/32/2/1/"},{"Category":"Void Materials","Material":"Floating Red Cloth","SortPath":"/32/2/2/"},{"Category":"Void Materials","Material":"Otherworldly Lantern","SortPath":"/32/2/3/"},{"Category":"Void Materials","Material":"Obsidian Slab","SortPath":"/32/4/6/"},{"Category":"Void Materials","Material":"Dark Core","SortPath":"/32/4/7/"},{"Category":"Void Dragon Materials","Material":"Blazing Horn","SortPath":"/33/5/1/"},{"Category":"Void Dragon Materials","Material":"Blazing Ember","SortPath":"/33/5/2/"},{"Category":"Void Materials","Material":"Storm Fungus","SortPath":"/32/1/4/"},{"Category":"Void Materials","Material":"Spongy Spore","SortPath":"/32/1/5/"},{"Category":"Void Materials","Material":"Floating Purple Cloth","SortPath":"/32/2/8/"},{"Category":"Void Materials","Material":"Shadowy Lantern","SortPath":"/32/2/9/"},{"Category":"Void Materials","Material":"Amber Slab","SortPath":"/32/4/3/"},{"Category":"Void Materials","Material":"Light Core","SortPath":"/32/4/5/"},{"Category":"Void Dragon Materials","Material":"Oceanic Fin","SortPath":"/33/2/1/"},{"Category":"Void Dragon Materials","Material":"Oceanic Crown","SortPath":"/33/2/2/"},{"Category":"Void Dragon Materials","Material":"Necroblossom","SortPath":"/33/3/1/"},{"Category":"Void Dragon Materials","Material":"Abyssal Standard","SortPath":"/33/3/2/"},{"Category":"Void Materials","Material":"Greedy Tail","SortPath":"/32/7/3/"},{"Category":"Void Materials","Material":"Crimson Fungus","SortPath":"/32/1/2/"},{"Category":"Void Materials","Material":"Burning Spore","SortPath":"/32/1/3/"},{"Category":"Void Materials","Material":"Purple Thread","SortPath":"/32/3/3/"},{"Category":"Void Materials","Material":"Acoustic Wood","SortPath":"/32/3/4/"},{"Category":"Void Materials","Material":"Catoblepas''s Hoof","SortPath":"/32/5/1/"},{"Category":"Void Materials","Material":"Catoblepas''s Stormeye","SortPath":"/32/5/3/"},{"Category":"Void Dragon Materials","Material":"Ruinous Horn","SortPath":"/33/4/1/"},{"Category":"Void Dragon Materials","Material":"Ruinous Wing","SortPath":"/33/4/2/"},{"Category":"Void Materials","Material":"Floating Yellow Cloth","SortPath":"/32/2/6/"},{"Category":"Void Materials","Material":"Unearthly Lantern","SortPath":"/32/2/7/"},{"Category":"Void Materials","Material":"Soul Vestiges","SortPath":"/32/6/1/"},{"Category":"Void Materials","Material":"Eolian Soul","SortPath":"/32/6/4/"},{"Category":"Void Materials","Material":"Smoldering Tail","SortPath":"/32/7/2/"},{"Category":"Void Chimera Materials","Material":"Volcanic Mane","SortPath":"/34/1/1/"},{"Category":"Void Chimera Materials","Material":"Volcanic Claw","SortPath":"/34/1/2/"},{"Category":"Void Chimera Materials","Material":"Volcanic Horn","SortPath":"/34/1/3/"},{"Category":"Void Materials","Material":"Proud Tail","SortPath":"/32/7/4/"},{"Category":"Void Chimera Materials","Material":"Ebon Mane","SortPath":"/34/5/1/"},{"Category":"Void Chimera Materials","Material":"Ebon Claw","SortPath":"/34/5/2/"},{"Category":"Void Chimera Materials","Material":"Ebon Horn","SortPath":"/34/5/3/"},{"Category":"Void Materials","Material":"Floating Blue Cloth","SortPath":"/32/2/4/"},{"Category":"Void Materials","Material":"Abyssal Lantern","SortPath":"/32/2/5/"},{"Category":"Void Materials","Material":"Catoblepas''s Heateye","SortPath":"/32/5/2/"},{"Category":"Void Materials","Material":"Infernal Soul","SortPath":"/32/6/2/"},{"Category":"Void Chimera Materials","Material":"Tempest Mane","SortPath":"/34/3/1/"},{"Category":"Void Chimera Materials","Material":"Tempest Claw","SortPath":"/34/3/2/"},{"Category":"Void Chimera Materials","Material":"Tempest Horn","SortPath":"/34/3/3/"},{"Category":"Void Materials","Material":"Catoblepas''s Shadoweye","SortPath":"/32/5/4/"},{"Category":"Void Materials","Material":"Abyssal Soul","SortPath":"/32/6/3/"},{"Category":"Void Chimera Materials","Material":"Tidal Mane","SortPath":"/34/2/1/"},{"Category":"Void Chimera Materials","Material":"Tidal Claw","SortPath":"/34/2/2/"},{"Category":"Void Chimera Materials","Material":"Tidal Horn","SortPath":"/34/2/3/"},{"Category":"Void Chimera Materials","Material":"Luminous Mane","SortPath":"/34/4/1/"},{"Category":"Void Chimera Materials","Material":"Luminous Claw","SortPath":"/34/4/2/"},{"Category":"Void Chimera Materials","Material":"Luminous Horn","SortPath":"/34/4/3/"},{"Category":"Draconic Essence","Material":"Agni''s Essence","SortPath":"/36/1/1/"},{"Category":"Draconic Essence","Material":"Prometheus''s Essence","SortPath":"/36/1/2/"},{"Category":"Draconic Essence","Material":"Cerberus''s Essence","SortPath":"/36/1/3/"},{"Category":"Draconic Essence","Material":"Konohana Sakuya''s Essence","SortPath":"/36/1/4/"},{"Category":"Draconic Essence","Material":"Arctos''s Essence","SortPath":"/36/1/5/"},{"Category":"Draconic Essence","Material":"Apollo''s Essence","SortPath":"/36/1/6/"},{"Category":"Draconic Essence","Material":"Leviathan''s Essence","SortPath":"/36/2/1/"},{"Category":"Draconic Essence","Material":"Poseidon''s Essence","SortPath":"/36/2/2/"},{"Category":"Draconic Essence","Material":"Siren''s Essence","SortPath":"/36/2/3/"},{"Category":"Draconic Essence","Material":"Simurgh''s Essence","SortPath":"/36/2/4/"},{"Category":"Draconic Essence","Material":"Kamuy''s Essence","SortPath":"/36/2/5/"},{"Category":"Draconic Essence","Material":"Nimis''s Essence","SortPath":"/36/2/6/"},{"Category":"Draconic Essence","Material":"Zephyr''s Essence","SortPath":"/36/3/1/"},{"Category":"Draconic Essence","Material":"Garuda''s Essence","SortPath":"/36/3/2/"},{"Category":"Draconic Essence","Material":"Long Long''s Essence","SortPath":"/36/3/3/"},{"Category":"Draconic Essence","Material":"Pazuzu''s Essence","SortPath":"/36/3/4/"},{"Category":"Draconic Essence","Material":"Freyja''s Essence","SortPath":"/36/3/5/"},{"Category":"Draconic Essence","Material":"Vayu''s Essence","SortPath":"/36/3/6/"},{"Category":"Draconic Essence","Material":"Cupid''s Essence","SortPath":"/36/4/1/"},{"Category":"Draconic Essence","Material":"Jeanne d''Arc''s Essence","SortPath":"/36/4/2/"},{"Category":"Draconic Essence","Material":"Gilgamesh''s Essence","SortPath":"/36/4/3/"},{"Category":"Draconic Essence","Material":"Liger''s Essence","SortPath":"/36/4/4/"},{"Category":"Draconic Essence","Material":"Takemikazuchi''s Essence","SortPath":"/36/4/5/"},{"Category":"Draconic Essence","Material":"Pop-Star Siren''s Essence","SortPath":"/36/4/6/"},{"Category":"Draconic Essence","Material":"Chthonius''s Essence","SortPath":"/36/5/1/"},{"Category":"Draconic Essence","Material":"Nidhogg''s Essence","SortPath":"/36/5/2/"},{"Category":"Draconic Essence","Material":"Nyarlathotep''s Essence","SortPath":"/36/5/3/"},{"Category":"Draconic Essence","Material":"Shinobi''s Essence","SortPath":"/36/5/4/"},{"Category":"Draconic Essence","Material":"Epimetheus''s Essence","SortPath":"/36/5/5/"},{"Category":"Draconic Essence","Material":"Andromeda''s Essence","SortPath":"/36/5/6/"},{"Category":"Wyrmprint Memories","Material":"Crown of Light''s Memory","SortPath":"/36.1/1/"},{"Category":"Wyrmprint Memories","Material":"Tutelary Successor''s Memory","SortPath":"/36.1/2/"},{"Category":"Wyrmprint Memories","Material":"Queen of the Sands'' Memory","SortPath":"/36.1/3/"},{"Category":"Wyrmprint Memories","Material":"Otherworld Auspex''s Memory","SortPath":"/36.1/4/"},{"Category":"Wyrmprint Memories","Material":"Twilight Queen''s Memory","SortPath":"/36.1/5/"},{"Category":"Wyrmprint Memories","Material":"Determined Auspex''s Memory","SortPath":"/36.1/6/"},{"Category":"Currency","Material":"Eldwater","SortPath":"/1/3/"},{"Category":"Other Materials","Material":"Fafnir Medal","SortPath":"/37/2/"},{"Category":"Currency","Material":"Mana","SortPath":"/1/2/"},{"Category":"Currency","Material":"Rupies","SortPath":"/1/1/"},{"Category":"Spiral Materials","Material":"Gala Prince''s Conviction","SortPath":"/36.2/1/1/"},{"Category":"Spiral Materials","Material":"Gala Prince''s Devotion","SortPath":"/36.2/1/2/"},{"Category":"Spiral Materials","Material":"Gala Elisanne''s Conviction","SortPath":"/36.2/0/1/"},{"Category":"Spiral Materials","Material":"Gala Elisanne''s Devotion","SortPath":"/36.2/0/2/"},{"Category":"Spiral Materials","Material":"Gala Ranzal''s Conviction","SortPath":"/36.2/0.1/1/"},{"Category":"Spiral Materials","Material":"Gala Ranzal''s Devotion","SortPath":"/36.2/0.1/2/"}]'

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
		N'[{"Quest":"Quests","ItemLevel":0},{"Quest":"Campaign Quests","ItemLevel":1},{"Quest":"Campaign Quests: Normal","ItemLevel":2},{"Quest":"Chapter 1 Normal","ItemLevel":3},{"Quest":"Chapter 2 Normal","ItemLevel":3},{"Quest":"Chapter 3 Normal","ItemLevel":3},{"Quest":"Chapter 4 Normal","ItemLevel":3},{"Quest":"Chapter 5 Normal","ItemLevel":3},{"Quest":"Chapter 6 Normal","ItemLevel":3},{"Quest":"Chapter 7 Normal","ItemLevel":3},{"Quest":"Chapter 8 Normal","ItemLevel":3},{"Quest":"Chapter 9 Normal","ItemLevel":3},{"Quest":"Chapter 10 Normal","ItemLevel":3},{"Quest":"Chapter 11 Normal","ItemLevel":3},{"Quest":"Chapter 12 Normal","ItemLevel":3},{"Quest":"Chapter 13 Normal","ItemLevel":3},{"Quest":"Chapter 14 Normal","ItemLevel":3},{"Quest":"Chapter 15 Normal","ItemLevel":3},{"Quest":"Chapter 16 Normal","ItemLevel":3},{"Quest":"Chapter 17 Normal","ItemLevel":3},{"Quest":"Chapter 18 Normal","ItemLevel":3},{"Quest":"Campaign Quests: Hard","ItemLevel":2},{"Quest":"Chapter 1 Hard","ItemLevel":3},{"Quest":"Ch. 1 / 1-2 Hard","ItemLevel":4},{"Quest":"Ch. 1 / 2-2 Hard","ItemLevel":4},{"Quest":"Ch. 1 / 4-5 Hard","ItemLevel":4},{"Quest":"Chapter 2 Hard","ItemLevel":3},{"Quest":"Ch. 2 / 1-3 Hard","ItemLevel":4},{"Quest":"Ch. 2 / 3-3 Hard","ItemLevel":4},{"Quest":"Ch. 2 / 4-2 Hard","ItemLevel":4},{"Quest":"Ch. 2 / 5-1 Hard","ItemLevel":4},{"Quest":"Ch. 2 / 6-1 Hard","ItemLevel":4},{"Quest":"Chapter 3 Hard","ItemLevel":3},{"Quest":"Ch. 3 / 1-3 Hard","ItemLevel":4},{"Quest":"Ch. 3 / 2-3 Hard","ItemLevel":4},{"Quest":"Ch. 3 / 3-5 Hard","ItemLevel":4},{"Quest":"Ch. 3 / 4-3 Hard","ItemLevel":4},{"Quest":"Chapter 4 Hard","ItemLevel":3},{"Quest":"Ch. 4 / 1-4 Hard","ItemLevel":4},{"Quest":"Ch. 4 / 3-5 Hard","ItemLevel":4},{"Quest":"Ch. 4 / 4-2 Hard","ItemLevel":4},{"Quest":"Ch. 4 / 5-2 Hard","ItemLevel":4},{"Quest":"Chapter 5 Hard","ItemLevel":3},{"Quest":"Ch. 5 / 1-3 Hard","ItemLevel":4},{"Quest":"Ch. 5 / 2-4 Hard","ItemLevel":4},{"Quest":"Ch. 5 / 3-3 Hard","ItemLevel":4},{"Quest":"Ch. 5 / 4-3 Hard","ItemLevel":4},{"Quest":"Chapter 6 Hard","ItemLevel":3},{"Quest":"Ch. 6 / 1-6 Hard","ItemLevel":4},{"Quest":"Ch. 6 / 3-3 Hard","ItemLevel":4},{"Quest":"Ch. 6 / 4-2 Hard","ItemLevel":4},{"Quest":"Chapter 7 Hard","ItemLevel":3},{"Quest":"Ch. 7 / 1-3 Hard","ItemLevel":4},{"Quest":"Chapter 8 Hard","ItemLevel":3},{"Quest":"Ch. 8 / 1-4 Hard","ItemLevel":4},{"Quest":"Ch. 8 / 2-3 Hard","ItemLevel":4},{"Quest":"Chapter 9 Hard","ItemLevel":3},{"Quest":"Ch. 9 / 1-2 Hard","ItemLevel":4},{"Quest":"Ch. 9 / 2-2 Hard","ItemLevel":4},{"Quest":"Chapter 10 Hard","ItemLevel":3},{"Quest":"Ch. 10 / 1-2 Hard","ItemLevel":4},{"Quest":"Ch. 10 / 2-2 Hard","ItemLevel":4},{"Quest":"Chapter 11 Hard","ItemLevel":3},{"Quest":"Chapter 12 Hard","ItemLevel":4},{"Quest":"Chapter 13 Hard","ItemLevel":4},{"Quest":"Chapter 14 Hard","ItemLevel":4},{"Quest":"Chapter 15 Hard","ItemLevel":4},{"Quest":"Chapter 16 Hard","ItemLevel":4},{"Quest":"Chapter 17 Hard","ItemLevel":4},{"Quest":"Chapter 18 Hard","ItemLevel":4},{"Quest":"Campaign Quests: Very Hard","ItemLevel":2},{"Quest":"Chapter 1 Very Hard","ItemLevel":3},{"Quest":"Ch. 1 / 1-2 Very Hard","ItemLevel":4},{"Quest":"Ch. 1 / 2-2 Very Hard","ItemLevel":4},{"Quest":"Ch. 1 / 4-5 Very Hard","ItemLevel":4},{"Quest":"Chapter 2 Very Hard","ItemLevel":3},{"Quest":"Ch. 2 / 1-3 Very Hard","ItemLevel":4},{"Quest":"Ch. 2 / 3-3 Very Hard","ItemLevel":4},{"Quest":"Ch. 2 / 4-2 Very Hard","ItemLevel":4},{"Quest":"Ch. 2 / 5-1 Very Hard","ItemLevel":4},{"Quest":"Ch. 2 / 6-1 Very Hard","ItemLevel":4},{"Quest":"Chapter 3 Very Hard","ItemLevel":3},{"Quest":"Ch. 3 / 1-3 Very Hard","ItemLevel":4},{"Quest":"Ch. 3 / 2-3 Very Hard","ItemLevel":4},{"Quest":"Ch. 3 / 3-5 Very Hard","ItemLevel":4},{"Quest":"Ch. 3 / 4-3 Very Hard","ItemLevel":4},{"Quest":"Chapter 4 Very Hard","ItemLevel":3},{"Quest":"Ch. 4 / 1-4 Very Hard","ItemLevel":4},{"Quest":"Ch. 4 / 3-5 Very Hard","ItemLevel":4},{"Quest":"Ch. 4 / 4-2 Very Hard","ItemLevel":4},{"Quest":"Ch. 4 / 5-2 Very Hard","ItemLevel":4},{"Quest":"Chapter 5 Very Hard","ItemLevel":3},{"Quest":"Ch. 5 / 1-3 Very Hard","ItemLevel":4},{"Quest":"Ch. 5 / 2-4 Very Hard","ItemLevel":4},{"Quest":"Ch. 5 / 3-3 Very Hard","ItemLevel":4},{"Quest":"Ch. 5 / 4-3 Very Hard","ItemLevel":4},{"Quest":"Chapter 6 Very Hard","ItemLevel":3},{"Quest":"Ch. 6 / 1-6 Very Hard","ItemLevel":4},{"Quest":"Ch. 6 / 3-3 Very Hard","ItemLevel":4},{"Quest":"Ch. 6 / 4-2 Very Hard","ItemLevel":4},{"Quest":"Chapter 7 Very Hard","ItemLevel":3},{"Quest":"Ch. 7 / 1-3 Very Hard","ItemLevel":4},{"Quest":"Chapter 8 Very Hard","ItemLevel":3},{"Quest":"Ch. 8 / 1-4 Very Hard","ItemLevel":4},{"Quest":"Ch. 8 / 2-3 Very Hard","ItemLevel":4},{"Quest":"Chapter 9 Very Hard","ItemLevel":3},{"Quest":"Ch. 9 / 1-2 Very Hard","ItemLevel":4},{"Quest":"Ch. 9 / 2-2 Very Hard","ItemLevel":4},{"Quest":"Chapter 10 Very Hard","ItemLevel":3},{"Quest":"Ch. 10 / 1-2 Very Hard","ItemLevel":4},{"Quest":"Ch. 10 / 2-2 Very Hard","ItemLevel":4},{"Quest":"Chapter 11 Very Hard","ItemLevel":3},{"Quest":"Chapter 12 Very Hard","ItemLevel":4},{"Quest":"Chapter 13 Very Hard","ItemLevel":4},{"Quest":"Chapter 14 Very Hard","ItemLevel":4},{"Quest":"Chapter 15 Very Hard","ItemLevel":4},{"Quest":"Chapter 16 Very Hard","ItemLevel":4},{"Quest":"Chapter 17 Very Hard","ItemLevel":4},{"Quest":"Chapter 18 Very Hard","ItemLevel":4},{"Quest":"Special Events","ItemLevel":1},{"Quest":"Astral Raids","ItemLevel":2},{"Quest":"Trials of the Mighty","ItemLevel":2},{"Quest":"Zephyr''s Trial","ItemLevel":3},{"Quest":"Zephyr''s Trial: Master","ItemLevel":4},{"Quest":"Zephyr''s Trial: Expert","ItemLevel":4},{"Quest":"Zephyr''s Trial: Standard","ItemLevel":4},{"Quest":"Poseidon''s Trial","ItemLevel":3},{"Quest":"Poseidon''s Trial: Master","ItemLevel":4},{"Quest":"Poseidon''s Trial: Expert","ItemLevel":4},{"Quest":"Poseidon''s Trial: Standard","ItemLevel":4},{"Quest":"Thor''s Trial","ItemLevel":3},{"Quest":"Thor''s Trial: Master","ItemLevel":4},{"Quest":"Thor''s Trial: Expert","ItemLevel":4},{"Quest":"Thor''s Trial: Standard","ItemLevel":4},{"Quest":"Void Battles","ItemLevel":2},{"Quest":"Shroom Strikes","ItemLevel":3},{"Quest":"Scalding Shroom Strike","ItemLevel":4},{"Quest":"Gust Shroom Strike","ItemLevel":4},{"Quest":"Wandering Shroom Strike","ItemLevel":4},{"Quest":"Ghost Strikes","ItemLevel":3},{"Quest":"Blazing Ghost Strike","ItemLevel":4},{"Quest":"Cerulean Ghost Strike","ItemLevel":4},{"Quest":"Lambent Ghost Strike","ItemLevel":4},{"Quest":"Violet Ghost Strike","ItemLevel":4},{"Quest":"Hermit Strikes","ItemLevel":3},{"Quest":"Frost Hermit Strike","ItemLevel":4},{"Quest":"Twilight Hermit Strike","ItemLevel":4},{"Quest":"Golem Strikes","ItemLevel":3},{"Quest":"Steel Golem Strike","ItemLevel":4},{"Quest":"Amber Golem Strike","ItemLevel":4},{"Quest":"Obsidian Golem Strike","ItemLevel":4},{"Quest":"Catoblepas Strikes","ItemLevel":3},{"Quest":"Catoblepas Fotia Strike","ItemLevel":4},{"Quest":"Catoblepas Anemos Strike","ItemLevel":4},{"Quest":"Catoblepas Skia Strike","ItemLevel":4},{"Quest":"Phantom Strikes","ItemLevel":3},{"Quest":"Infernal Phantom Strike","ItemLevel":4},{"Quest":"Abyssal Phantom Strike","ItemLevel":4},{"Quest":"Eolian Phantom Strike","ItemLevel":4},{"Quest":"Manticore Strikes","ItemLevel":3},{"Quest":"Smoldering Manticore Strike","ItemLevel":4},{"Quest":"Greedy Manticore Strike","ItemLevel":4},{"Quest":"Proud Manticore Strike","ItemLevel":4},{"Quest":"Raging Manticore Strike","ItemLevel":4},{"Quest":"Void Dragon Strikes","ItemLevel":3},{"Quest":"Void Zephyr Strike","ItemLevel":4},{"Quest":"Void Zephyr Strike: Expert","ItemLevel":5},{"Quest":"Void Zephyr Strike: Standard","ItemLevel":5},{"Quest":"Void Poseidon Strike","ItemLevel":4},{"Quest":"Void Poseidon Strike: Expert","ItemLevel":5},{"Quest":"Void Poseidon Strike: Standard","ItemLevel":5},{"Quest":"Void Jeanne d''Arc Strike","ItemLevel":4},{"Quest":"Void Jeanne d''Arc Strike: Expert","ItemLevel":5},{"Quest":"Void Jeanne d''Arc Strike: Standard","ItemLevel":5},{"Quest":"Void Nidhogg Strike","ItemLevel":4},{"Quest":"Void Nidhogg Strike: Expert","ItemLevel":5},{"Quest":"Void Nidhogg Strike: Standard","ItemLevel":5},{"Quest":"Void Agni Strike","ItemLevel":4},{"Quest":"Void Agni Strike: Expert","ItemLevel":5},{"Quest":"Void Agni Strike: Standard","ItemLevel":5},{"Quest":"Chimera Strikes","ItemLevel":3},{"Quest":"Volcanic Chimera Strike","ItemLevel":4},{"Quest":"Volcanic Chimera Strike: Expert","ItemLevel":5},{"Quest":"Volcanic Chimera Strike: Standard","ItemLevel":5},{"Quest":"Tidal Chimera Strike","ItemLevel":4},{"Quest":"Tidal Chimera Strike: Expert","ItemLevel":5},{"Quest":"Tidal Chimera Strike: Standard","ItemLevel":5},{"Quest":"Tempest Chimera Strike","ItemLevel":4},{"Quest":"Tempest Chimera Strike: Expert","ItemLevel":5},{"Quest":"Tempest Chimera Strike: Standard","ItemLevel":5},{"Quest":"Luminous Chimera Strike","ItemLevel":4},{"Quest":"Luminous Chimera Strike: Expert","ItemLevel":5},{"Quest":"Luminous Chimera Strike: Standard","ItemLevel":5},{"Quest":"Ebon Chimera Strike","ItemLevel":4},{"Quest":"Ebon Chimera Strike: Expert","ItemLevel":5},{"Quest":"Ebon Chimera Strike: Standard","ItemLevel":5},{"Quest":"Recurring Events","ItemLevel":1},{"Quest":"Avenue to Power","ItemLevel":2},{"Quest":"Avenue to Fortune","ItemLevel":2},{"Quest":"Elemental Ruins","ItemLevel":2},{"Quest":"Flamehowl Ruins","ItemLevel":3},{"Quest":"Waterscour Ruins","ItemLevel":3},{"Quest":"Windmaul Ruins","ItemLevel":3},{"Quest":"Lightsunder Ruins","ItemLevel":3},{"Quest":"Shadowsteep Ruins","ItemLevel":3},{"Quest":"Event Compendium","ItemLevel":2},{"Quest":"Facility Events","ItemLevel":3},{"Quest":"Flames of Reflection","ItemLevel":4},{"Quest":"The Miracle of Dragonyule","ItemLevel":4},{"Quest":"A Wish to the Winds","ItemLevel":4},{"Quest":"Dream Big Under the Big Top","ItemLevel":4},{"Quest":"The Hunt for Harmony","ItemLevel":4},{"Quest":"Trick or Treasure","ItemLevel":4},{"Quest":"A Crescendo of Courage","ItemLevel":4},{"Quest":"The Accursed Archives","ItemLevel":4},{"Quest":"Raid Events","ItemLevel":3},{"Quest":"Fractured Futures","ItemLevel":4},{"Quest":"Forgotten Truths","ItemLevel":4},{"Quest":"Challenge Events","ItemLevel":1},{"Quest":"The Mercurial Gauntlet","ItemLevel":2},{"Quest":"Dragon Trials","ItemLevel":2},{"Quest":"Midgardsormr''s Trial","ItemLevel":3},{"Quest":"Mercury''s Trial","ItemLevel":3},{"Quest":"Brunhilda''s Trial","ItemLevel":3},{"Quest":"Jupiter''s Trial","ItemLevel":3},{"Quest":"Zodiark''s Trial","ItemLevel":3},{"Quest":"The Imperial Onslaught","ItemLevel":2},{"Quest":"Battle at Mount Adolla","ItemLevel":3},{"Quest":"Battle at Myriage Lake","ItemLevel":3},{"Quest":"Battle in Rovetelle Forest","ItemLevel":3},{"Quest":"Battle in the Dornith Mountains","ItemLevel":3},{"Quest":"Battle at the Wartarch Ruins","ItemLevel":3},{"Quest":"Advanced Dragon Trials","ItemLevel":2},{"Quest":"High Midgardsormr''s Trial","ItemLevel":3},{"Quest":"High Midgardsormr''s Trial: Master","ItemLevel":4},{"Quest":"High Midgardsormr''s Trial: Expert","ItemLevel":4},{"Quest":"High Midgardsormr''s Trial: Standard","ItemLevel":4},{"Quest":"High Midgardsormr''s Trial: Prelude","ItemLevel":4},{"Quest":"High Mercury''s Trial","ItemLevel":3},{"Quest":"High Mercury''s Trial: Master","ItemLevel":4},{"Quest":"High Mercury''s Trial: Expert","ItemLevel":4},{"Quest":"High Mercury''s Trial: Standard","ItemLevel":4},{"Quest":"High Mercury''s Trial: Prelude","ItemLevel":4},{"Quest":"High Brunhilda''s Trial","ItemLevel":3},{"Quest":"High Brunhilda''s Trial: Master","ItemLevel":4},{"Quest":"High Brunhilda''s Trial: Expert","ItemLevel":4},{"Quest":"High Brunhilda''s Trial: Standard","ItemLevel":4},{"Quest":"High Brunhilda''s Trial: Prelude","ItemLevel":4},{"Quest":"High Jupiter''s Trial","ItemLevel":3},{"Quest":"High Jupiter''s Trial: Master","ItemLevel":4},{"Quest":"High Jupiter''s Trial: Expert","ItemLevel":4},{"Quest":"High Jupiter''s Trial: Standard","ItemLevel":4},{"Quest":"High Jupiter''s Trial: Prelude","ItemLevel":4},{"Quest":"High Zodiark''s Trial","ItemLevel":3},{"Quest":"High Zodiark''s Trial: Master","ItemLevel":4},{"Quest":"High Zodiark''s Trial: Expert","ItemLevel":4},{"Quest":"High Zodiark''s Trial: Standard","ItemLevel":4},{"Quest":"High Zodiark''s Trial: Prelude","ItemLevel":4},{"Quest":"The Agito Uprising","ItemLevel":2},{"Quest":"Volk''s Wrath","ItemLevel":3},{"Quest":"Volk''s Wrath: Master","ItemLevel":4},{"Quest":"Volk''s Wrath: Expert","ItemLevel":4},{"Quest":"Volk''s Wrath: Standard","ItemLevel":4},{"Quest":"Ciella''s Wrath","ItemLevel":3},{"Quest":"Ciella''s Wrath: Master","ItemLevel":4},{"Quest":"Ciella''s Wrath: Expert","ItemLevel":4},{"Quest":"Ciella''s Wrath: Standard","ItemLevel":4},{"Quest":"Ayaha & Otoha''s Wrath","ItemLevel":3},{"Quest":"Ayaha & Otoha''s Wrath: Master","ItemLevel":4},{"Quest":"Ayaha & Otoha''s Wrath: Expert","ItemLevel":4},{"Quest":"Ayaha & Otoha''s Wrath: Standard","ItemLevel":4},{"Quest":"Kai Yan''s Wrath","ItemLevel":3},{"Quest":"Kai Yan''s Wrath: Master","ItemLevel":4},{"Quest":"Kai Yan''s Wrath: Expert","ItemLevel":4},{"Quest":"Kai Yan''s Wrath: Standard","ItemLevel":4},{"Quest":"Tartarus''s Wrath","ItemLevel":3},{"Quest":"Tartarus''s Wrath: Master","ItemLevel":4},{"Quest":"Tartarus''s Wrath: Expert","ItemLevel":4},{"Quest":"Tartarus''s Wrath: Standard","ItemLevel":4},{"Quest":"Rise of the Sinister Dominion","ItemLevel":2},{"Quest":"Lilith''s Encroaching Shadow","ItemLevel":3},{"Quest":"Lilith''s Encroaching Shadow: Master","ItemLevel":4},{"Quest":"Lilith''s Encroaching Shadow: Expert","ItemLevel":4},{"Quest":"Lilith''s Encroaching Shadow: Standard","ItemLevel":4},{"Quest":"Exceptionally Difficult Quests","ItemLevel":1},{"Quest":"The Agito Uprising: Legend Difficulty","ItemLevel":2},{"Quest":"Volk''s Wrath: Legend Difficulty","ItemLevel":3},{"Quest":"Ciella''s Wrath: Legend Difficulty","ItemLevel":3},{"Quest":"Kai Yan''s Wrath: Legend Difficulty","ItemLevel":3},{"Quest":"Forgotten Truths: Morsayati Reckoning","ItemLevel":2},{"Quest":"Morsayati Reckoning","ItemLevel":3}]'

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
		N'[{"Material":"Rupies","Quest":"Avenue to Fortune"},{"Material":"Rupies","Quest":"Advanced Dragon Trials"},{"Material":"Rupies","Quest":"The Agito Uprising"},{"Material":"Rupies","Quest":"Rise of the Sinister Dominion"},{"Material":"Eldwater","Quest":"The Mercurial Gauntlet"},{"Material":"Bronze Crystal","Quest":"Avenue to Power"},{"Material":"Silver Crystal","Quest":"Avenue to Power"},{"Material":"Gold Crystal","Quest":"Avenue to Power"},{"Material":"Fortifying Crystal","Quest":"Astral Raids"},{"Material":"Fortifying Crystal","Quest":"The Agito Uprising"},{"Material":"Fortifying Crystal","Quest":"Advanced Dragon Trials"},{"Material":"Fortifying Crystal","Quest":"Thor''s Trial"},{"Material":"Amplifying Crystal","Quest":"Astral Raids"},{"Material":"Amplifying Crystal","Quest":"The Agito Uprising"},{"Material":"Amplifying Crystal","Quest":"Advanced Dragon Trials"},{"Material":"Amplifying Crystal","Quest":"Thor''s Trial"},{"Material":"Fortifying Dragonscale","Quest":"Morsayati Reckoning"},{"Material":"Fortifying Dragonscale","Quest":"Rise of the Sinister Dominion"},{"Material":"Fortifying Dragonscale","Quest":"Thor''s Trial"},{"Material":"Amplifying Dragonscale","Quest":"Morsayati Reckoning"},{"Material":"Amplifying Dragonscale","Quest":"Rise of the Sinister Dominion"},{"Material":"Amplifying Dragonscale","Quest":"Thor''s Trial"},{"Material":"Bronze Whetstone","Quest":"The Imperial Onslaught"},{"Material":"Silver Whetstone","Quest":"The Imperial Onslaught"},{"Material":"Gold Whetstone","Quest":"The Imperial Onslaught"},{"Material":"Fortifying Gemstone","Quest":"Astral Raids"},{"Material":"Fortifying Gemstone","Quest":"The Agito Uprising"},{"Material":"Fortifying Gemstone","Quest":"Advanced Dragon Trials"},{"Material":"Fortifying Gemstone","Quest":"Thor''s Trial"},{"Material":"Amplifying Gemstone","Quest":"Astral Raids"},{"Material":"Amplifying Gemstone","Quest":"The Agito Uprising"},{"Material":"Amplifying Gemstone","Quest":"Advanced Dragon Trials"},{"Material":"Amplifying Gemstone","Quest":"Thor''s Trial"},{"Material":"Flame Orb","Quest":"Flamehowl Ruins"},{"Material":"Blaze Orb","Quest":"Flamehowl Ruins"},{"Material":"Inferno Orb","Quest":"Flamehowl Ruins"},{"Material":"Incandescence Orb","Quest":"Volcanic Chimera Strike: Expert"},{"Material":"Incandescence Orb","Quest":"Void Agni Strike: Expert"},{"Material":"Water Orb","Quest":"Waterscour Ruins"},{"Material":"Stream Orb","Quest":"Waterscour Ruins"},{"Material":"Deluge Orb","Quest":"Waterscour Ruins"},{"Material":"Tsunami Orb","Quest":"Tidal Chimera Strike: Expert"},{"Material":"Tsunami Orb","Quest":"Void Poseidon Strike: Expert"},{"Material":"Wind Orb","Quest":"Windmaul Ruins"},{"Material":"Storm Orb","Quest":"Windmaul Ruins"},{"Material":"Maelstrom Orb","Quest":"Windmaul Ruins"},{"Material":"Tempest Orb","Quest":"Tempest Chimera Strike: Expert"},{"Material":"Tempest Orb","Quest":"Void Zephyr Strike: Expert"},{"Material":"Light Orb","Quest":"Lightsunder Ruins"},{"Material":"Radiance Orb","Quest":"Lightsunder Ruins"},{"Material":"Refulgence Orb","Quest":"Lightsunder Ruins"},{"Material":"Resplendence Orb","Quest":"Luminous Chimera Strike: Expert"},{"Material":"Resplendence Orb","Quest":"Void Jeanne d''Arc Strike: Expert"},{"Material":"Resplendence Orb","Quest":"Thor''s Trial: Expert"},{"Material":"Resplendence Orb","Quest":"Thor''s Trial: Master"},{"Material":"Shadow Orb","Quest":"Shadowsteep Ruins"},{"Material":"Nightfall Orb","Quest":"Shadowsteep Ruins"},{"Material":"Nether Orb","Quest":"Shadowsteep Ruins"},{"Material":"Abaddon Orb","Quest":"Ebon Chimera Strike: Expert"},{"Material":"Abaddon Orb","Quest":"Void Nidhogg Strike: Expert"},{"Material":"Rainbow Orb","Quest":"Elemental Ruins"},{"Material":"Rainbow Orb","Quest":"Thor''s Trial"},{"Material":"Flamewyrm''s Scale","Quest":"Brunhilda''s Trial"},{"Material":"Flamewyrm''s Scaldscale","Quest":"Brunhilda''s Trial"},{"Material":"Flamewyrm''s Scaldscale","Quest":"High Brunhilda''s Trial: Prelude"},{"Material":"Waterwyrm''s Scale","Quest":"Mercury''s Trial"},{"Material":"Waterwyrm''s Glistscale","Quest":"Mercury''s Trial"},{"Material":"Waterwyrm''s Glistscale","Quest":"High Mercury''s Trial: Prelude"},{"Material":"Windwyrm''s Scale","Quest":"Midgardsormr''s Trial"},{"Material":"Windwyrm''s Squallscale","Quest":"Midgardsormr''s Trial"},{"Material":"Windwyrm''s Squallscale","Quest":"High Midgardsormr''s Trial: Prelude"},{"Material":"Lightwyrm''s Scale","Quest":"Jupiter''s Trial"},{"Material":"Lightwyrm''s Glowscale","Quest":"Jupiter''s Trial"},{"Material":"Lightwyrm''s Glowscale","Quest":"High Jupiter''s Trial: Prelude"},{"Material":"Shadowwyrm''s Scale","Quest":"Zodiark''s Trial"},{"Material":"Shadowwyrm''s Darkscale","Quest":"Zodiark''s Trial"},{"Material":"Shadowwyrm''s Darkscale","Quest":"High Zodiark''s Trial: Prelude"},{"Material":"Flamewyrm''s Sphere","Quest":"Brunhilda''s Trial"},{"Material":"Flamewyrm''s Sphere","Quest":"High Brunhilda''s Trial: Prelude"},{"Material":"Flamewyrm''s Greatsphere","Quest":"High Brunhilda''s Trial"},{"Material":"Waterwyrm''s Sphere","Quest":"Mercury''s Trial"},{"Material":"Waterwyrm''s Sphere","Quest":"High Mercury''s Trial: Prelude"},{"Material":"Waterwyrm''s Greatsphere","Quest":"High Mercury''s Trial"},{"Material":"Windwyrm''s Sphere","Quest":"Midgardsormr''s Trial"},{"Material":"Windwyrm''s Sphere","Quest":"High Midgardsormr''s Trial: Prelude"},{"Material":"Windwyrm''s Greatsphere","Quest":"High Midgardsormr''s Trial"},{"Material":"Lightwyrm''s Sphere","Quest":"Jupiter''s Trial"},{"Material":"Lightwyrm''s Sphere","Quest":"High Jupiter''s Trial: Prelude"},{"Material":"Lightwyrm''s Greatsphere","Quest":"High Jupiter''s Trial"},{"Material":"Shadowwyrm''s Sphere","Quest":"Zodiark''s Trial"},{"Material":"Shadowwyrm''s Sphere","Quest":"High Zodiark''s Trial: Prelude"},{"Material":"Shadowwyrm''s Greatsphere","Quest":"High Zodiark''s Trial"},{"Material":"High Flamewyrm''s Tail","Quest":"High Brunhilda''s Trial: Master"},{"Material":"High Flamewyrm''s Tail","Quest":"High Brunhilda''s Trial: Expert"},{"Material":"High Flamewyrm''s Horn","Quest":"High Brunhilda''s Trial: Master"},{"Material":"High Waterwyrm''s Tail","Quest":"High Mercury''s Trial: Master"},{"Material":"High Waterwyrm''s Tail","Quest":"High Mercury''s Trial: Expert"},{"Material":"High Waterwyrm''s Horn","Quest":"High Mercury''s Trial: Master"},{"Material":"High Windwyrm''s Tail","Quest":"High Midgardsormr''s Trial: Master"},{"Material":"High Windwyrm''s Tail","Quest":"High Midgardsormr''s Trial: Expert"},{"Material":"High Windwyrm''s Horn","Quest":"High Midgardsormr''s Trial: Master"},{"Material":"High Lightwyrm''s Tail","Quest":"High Jupiter''s Trial: Master"},{"Material":"High Lightwyrm''s Horn","Quest":"High Jupiter''s Trial: Master"},{"Material":"High Lightwyrm''s Horn","Quest":"High Jupiter''s Trial: Expert"},{"Material":"High Shadowwyrm''s Tail","Quest":"High Zodiark''s Trial: Master"},{"Material":"High Shadowwyrm''s Horn","Quest":"High Zodiark''s Trial: Master"},{"Material":"High Shadowwyrm''s Horn","Quest":"High Zodiark''s Trial: Expert"},{"Material":"Dyrenell Aes","Quest":"The Imperial Onslaught"},{"Material":"Dyrenell Argenteus","Quest":"The Imperial Onslaught"},{"Material":"Dyrenell Aureus","Quest":"The Imperial Onslaught"},{"Material":"Vermilion Insignia","Quest":"Battle at Mount Adolla"},{"Material":"Royal Vermilion Insignia","Quest":"Battle at Mount Adolla"},{"Material":"Azure Insignia","Quest":"Battle at Myriage Lake"},{"Material":"Royal Azure Insignia","Quest":"Battle at Myriage Lake"},{"Material":"Jade Insignia","Quest":"Battle in Rovetelle Forest"},{"Material":"Royal Jade Insignia","Quest":"Battle in Rovetelle Forest"},{"Material":"Amber Insignia","Quest":"Battle in the Dornith Mountains"},{"Material":"Royal Amber Insignia","Quest":"Battle in the Dornith Mountains"},{"Material":"Violet Insignia","Quest":"Battle at the Wartarch Ruins"},{"Material":"Royal Violet Insignia","Quest":"Battle at the Wartarch Ruins"},{"Material":"Soaring Ones'' Mask Fragment","Quest":"Ayaha & Otoha''s Wrath: Standard"},{"Material":"Soaring Ones'' Mask Fragment","Quest":"Ayaha & Otoha''s Wrath: Expert"},{"Material":"Liberated One''s Mask Fragment","Quest":"Ayaha & Otoha''s Wrath: Expert"},{"Material":"Liberated One''s Mask Fragment","Quest":"Ayaha & Otoha''s Wrath: Master"},{"Material":"Rebellious One''s Cruelty","Quest":"Ayaha & Otoha''s Wrath: Master"},{"Material":"Eliminating One''s Mask Fragment","Quest":"Ciella''s Wrath: Standard"},{"Material":"Eliminating One''s Mask Fragment","Quest":"Ciella''s Wrath: Expert"},{"Material":"Despairing One''s Mask Fragment","Quest":"Ciella''s Wrath: Expert"},{"Material":"Despairing One''s Mask Fragment","Quest":"Ciella''s Wrath: Master"},{"Material":"Rebellious One''s Desperation","Quest":"Ciella''s Wrath: Master"},{"Material":"Destitute One''s Mask Fragment","Quest":"Volk''s Wrath: Standard"},{"Material":"Destitute One''s Mask Fragment","Quest":"Volk''s Wrath: Expert"},{"Material":"Plagued One''s Mask Fragment","Quest":"Volk''s Wrath: Expert"},{"Material":"Plagued One''s Mask Fragment","Quest":"Volk''s Wrath: Master"},{"Material":"Rebellious One''s Insanity","Quest":"Volk''s Wrath: Master"},{"Material":"Rebellious Wolf''s Gale","Quest":"Volk''s Wrath: Legend Difficulty"},{"Material":"Almighty One''s Mask Fragment","Quest":"Kai Yan''s Wrath: Standard"},{"Material":"Almighty One''s Mask Fragment","Quest":"Kai Yan''s Wrath: Expert"},{"Material":"Uprooting One''s Mask Fragment","Quest":"Kai Yan''s Wrath: Expert"},{"Material":"Uprooting One''s Mask Fragment","Quest":"Kai Yan''s Wrath: Master"},{"Material":"Rebellious One''s Arrogance","Quest":"Kai Yan''s Wrath: Master"},{"Material":"Rebellious Ox''s Lightning","Quest":"Kai Yan''s Wrath: Legend Difficulty"},{"Material":"Remaining One''s Mask Fragment","Quest":"Tartarus''s Wrath: Standard"},{"Material":"Remaining One''s Mask Fragment","Quest":"Tartarus''s Wrath: Expert"},{"Material":"Vengeful One''s Mask Fragment","Quest":"Tartarus''s Wrath: Expert"},{"Material":"Vengeful One''s Mask Fragment","Quest":"Tartarus''s Wrath: Master"},{"Material":"Rebellious One''s Loyalty","Quest":"Tartarus''s Wrath: Master"},{"Material":"Talonstone","Quest":"Advanced Dragon Trials"},{"Material":"Void Leaf","Quest":"Void Battles"},{"Material":"Void Seed","Quest":"Void Battles"},{"Material":"Squishums","Quest":"Void Dragon Strikes"},{"Material":"Squishums","Quest":"Chimera Strikes"},{"Material":"Astral Shard","Quest":"Astral Raids"},{"Material":"Nature''s Blessing","Quest":"Morsayati Reckoning"},{"Material":"Nature''s Blessing","Quest":"Thor''s Trial"},{"Material":"Twilight Shard","Quest":"Lilith''s Encroaching Shadow: Expert"},{"Material":"Twilight Shard","Quest":"Lilith''s Encroaching Shadow: Standard"},{"Material":"Twilight Prism","Quest":"Lilith''s Encroaching Shadow: Expert"},{"Material":"Iron Ore","Quest":"Windmaul Ruins"},{"Material":"Iron Ore","Quest":"Battle at Mount Adolla"},{"Material":"Iron Ore","Quest":"Battle in the Dornith Mountains"},{"Material":"Granite","Quest":"Windmaul Ruins"},{"Material":"Granite","Quest":"Battle at Mount Adolla"},{"Material":"Granite","Quest":"Battle in the Dornith Mountains"},{"Material":"Meteorite","Quest":"Windmaul Ruins"},{"Material":"Meteorite","Quest":"Battle at Mount Adolla"},{"Material":"Meteorite","Quest":"Battle in the Dornith Mountains"},{"Material":"Fiend''s Claw","Quest":"Flamehowl Ruins"},{"Material":"Fiend''s Claw","Quest":"Lightsunder Ruins"},{"Material":"Fiend''s Claw","Quest":"Battle at Myriage Lake"},{"Material":"Fiend''s Claw","Quest":"Battle at the Wartarch Ruins"},{"Material":"Fiend''s Horn","Quest":"Flamehowl Ruins"},{"Material":"Fiend''s Horn","Quest":"Lightsunder Ruins"},{"Material":"Fiend''s Horn","Quest":"Battle at Myriage Lake"},{"Material":"Fiend''s Horn","Quest":"Battle at the Wartarch Ruins"},{"Material":"Fiend''s Eye","Quest":"Flamehowl Ruins"},{"Material":"Fiend''s Eye","Quest":"Lightsunder Ruins"},{"Material":"Fiend''s Eye","Quest":"Battle at Myriage Lake"},{"Material":"Fiend''s Eye","Quest":"Battle at the Wartarch Ruins"},{"Material":"Bat''s Wing","Quest":"Waterscour Ruins"},{"Material":"Bat''s Wing","Quest":"Shadowsteep Ruins"},{"Material":"Bat''s Wing","Quest":"Battle in Rovetelle Forest"},{"Material":"Ancient Bird''s Feather","Quest":"Waterscour Ruins"},{"Material":"Ancient Bird''s Feather","Quest":"Shadowsteep Ruins"},{"Material":"Ancient Bird''s Feather","Quest":"Battle in Rovetelle Forest"},{"Material":"Bewitching Wings","Quest":"Waterscour Ruins"},{"Material":"Bewitching Wings","Quest":"Shadowsteep Ruins"},{"Material":"Bewitching Wings","Quest":"Battle in Rovetelle Forest"},{"Material":"Light Metal","Quest":"Dragon Trials"},{"Material":"Abyss Stone","Quest":"Dragon Trials"},{"Material":"Crimson Core","Quest":"Dragon Trials"},{"Material":"Twinkling Sand","Quest":"The Mercurial Gauntlet"},{"Material":"Orichalcum","Quest":"High Midgardsormr''s Trial: Expert"},{"Material":"Orichalcum","Quest":"High Mercury''s Trial: Expert"},{"Material":"Orichalcum","Quest":"High Brunhilda''s Trial: Expert"},{"Material":"Orichalcum","Quest":"High Jupiter''s Trial: Expert"},{"Material":"Orichalcum","Quest":"High Zodiark''s Trial: Expert"},{"Material":"Orichalcum","Quest":"Thor''s Trial: Master"},{"Material":"Sword Tablet","Quest":"Battle in Rovetelle Forest"},{"Material":"Sword Tablet","Quest":"Battle in the Dornith Mountains"},{"Material":"Blade Tablet","Quest":"Battle at Mount Adolla"},{"Material":"Blade Tablet","Quest":"Battle in the Dornith Mountains"},{"Material":"Dagger Tablet","Quest":"Battle in Rovetelle Forest"},{"Material":"Dagger Tablet","Quest":"Battle in the Dornith Mountains"},{"Material":"Axe Tablet","Quest":"Battle at Myriage Lake"},{"Material":"Axe Tablet","Quest":"Battle in the Dornith Mountains"},{"Material":"Lance Tablet","Quest":"Battle at Mount Adolla"},{"Material":"Lance Tablet","Quest":"Battle at the Wartarch Ruins"},{"Material":"Bow Tablet","Quest":"Battle at Myriage Lake"},{"Material":"Bow Tablet","Quest":"Battle at the Wartarch Ruins"},{"Material":"Wand Tablet","Quest":"Battle at Mount Adolla"},{"Material":"Wand Tablet","Quest":"Battle at the Wartarch Ruins"},{"Material":"Staff Tablet","Quest":"Battle at Myriage Lake"},{"Material":"Staff Tablet","Quest":"Battle in Rovetelle Forest"},{"Material":"Staff Tablet","Quest":"Battle at the Wartarch Ruins"},{"Material":"Manacaster Tablet","Quest":"Battle in the Dornith Mountains"},{"Material":"Manacaster Tablet","Quest":"Battle at the Wartarch Ruins"},{"Material":"Snack-o''-Lantern","Quest":"Trick or Treasure"},{"Material":"Windwhistle Grass","Quest":"A Wish to the Winds"},{"Material":"Astral Ornament","Quest":"The Miracle of Dragonyule"},{"Material":"Tent Canvas","Quest":"Dream Big Under the Big Top"},{"Material":"Arcane Tome","Quest":"The Accursed Archives"},{"Material":"Papier-mâché","Quest":"The Hunt for Harmony"},{"Material":"Motivational Log","Quest":"Flames of Reflection"},{"Material":"Glam Shell","Quest":"A Crescendo of Courage"},{"Material":"Chef''s Special","Quest":"A Dash of Disaster"},{"Material":"Ornate Lantern","Quest":"Rhythmic Resolutions"},{"Material":"Holy Ore","Quest":"Agents of the Goddess"},{"Material":"Libretto","Quest":"The Phantom’s Ransom"},{"Material":"Solid Fungus","Quest":"Shroom Strikes"},{"Material":"Crimson Fungus","Quest":"Scalding Shroom Strike"},{"Material":"Burning Spore","Quest":"Scalding Shroom Strike"},{"Material":"Storm Fungus","Quest":"Gust Shroom Strike"},{"Material":"Spongy Spore","Quest":"Gust Shroom Strike"},{"Material":"Shiny Spore","Quest":"Wandering Shroom Strike"},{"Material":"Old Cloth","Quest":"Ghost Strikes"},{"Material":"Floating Red Cloth","Quest":"Blazing Ghost Strike"},{"Material":"Otherworldly Lantern","Quest":"Blazing Ghost Strike"},{"Material":"Floating Blue Cloth","Quest":"Cerulean Ghost Strike"},{"Material":"Abyssal Lantern","Quest":"Cerulean Ghost Strike"},{"Material":"Floating Yellow Cloth","Quest":"Lambent Ghost Strike"},{"Material":"Unearthly Lantern","Quest":"Lambent Ghost Strike"},{"Material":"Floating Purple Cloth","Quest":"Violet Ghost Strike"},{"Material":"Shadowy Lantern","Quest":"Violet Ghost Strike"},{"Material":"Goblin Thread","Quest":"Hermit Strikes"},{"Material":"Aromatic Wood","Quest":"Frost Hermit Strike"},{"Material":"Purple Thread","Quest":"Twilight Hermit Strike"},{"Material":"Acoustic Wood","Quest":"Twilight Hermit Strike"},{"Material":"Steel Slab","Quest":"Golem Strikes"},{"Material":"Golem Core","Quest":"Steel Golem Strike"},{"Material":"Amber Slab","Quest":"Amber Golem Strike"},{"Material":"Light Core","Quest":"Amber Golem Strike"},{"Material":"Obsidian Slab","Quest":"Obsidian Golem Strike"},{"Material":"Dark Core","Quest":"Obsidian Golem Strike"},{"Material":"Catoblepas''s Hoof","Quest":"Catoblepas Strikes"},{"Material":"Catoblepas''s Heateye","Quest":"Catoblepas Fotia Strike"},{"Material":"Catoblepas''s Stormeye","Quest":"Catoblepas Anemos Strike"},{"Material":"Catoblepas''s Shadoweye","Quest":"Catoblepas Skia Strike"},{"Material":"Soul Vestiges","Quest":"Phantom Strikes"},{"Material":"Infernal Soul","Quest":"Infernal Phantom Strike"},{"Material":"Abyssal Soul","Quest":"Abyssal Phantom Strike"},{"Material":"Eolian Soul","Quest":"Eolian Phantom Strike"},{"Material":"Raging Fang","Quest":"Manticore Strikes"},{"Material":"Smoldering Tail","Quest":"Smoldering Manticore Strike"},{"Material":"Greedy Tail","Quest":"Greedy Manticore Strike"},{"Material":"Proud Tail","Quest":"Proud Manticore Strike"},{"Material":"Raging Tail","Quest":"Raging Manticore Strike"},{"Material":"Great Feather","Quest":"Void Zephyr Strike"},{"Material":"Zephyr Rune","Quest":"Void Zephyr Strike"},{"Material":"Oceanic Fin","Quest":"Void Poseidon Strike"},{"Material":"Oceanic Crown","Quest":"Void Poseidon Strike"},{"Material":"Necroblossom","Quest":"Void Jeanne d''Arc Strike"},{"Material":"Abyssal Standard","Quest":"Void Jeanne d''Arc Strike"},{"Material":"Ruinous Horn","Quest":"Void Nidhogg Strike"},{"Material":"Ruinous Wing","Quest":"Void Nidhogg Strike"},{"Material":"Blazing Horn","Quest":"Void Agni Strike"},{"Material":"Blazing Ember","Quest":"Void Agni Strike"},{"Material":"Volcanic Mane","Quest":"Volcanic Chimera Strike"},{"Material":"Volcanic Claw","Quest":"Volcanic Chimera Strike"},{"Material":"Volcanic Horn","Quest":"Volcanic Chimera Strike: Expert"},{"Material":"Tidal Mane","Quest":"Tidal Chimera Strike"},{"Material":"Tidal Claw","Quest":"Tidal Chimera Strike"},{"Material":"Tidal Horn","Quest":"Tidal Chimera Strike: Expert"},{"Material":"Tempest Mane","Quest":"Tempest Chimera Strike"},{"Material":"Tempest Claw","Quest":"Tempest Chimera Strike"},{"Material":"Tempest Horn","Quest":"Tempest Chimera Strike: Expert"},{"Material":"Luminous Mane","Quest":"Luminous Chimera Strike"},{"Material":"Luminous Claw","Quest":"Luminous Chimera Strike"},{"Material":"Luminous Horn","Quest":"Luminous Chimera Strike: Expert"},{"Material":"Ebon Mane","Quest":"Ebon Chimera Strike"},{"Material":"Ebon Claw","Quest":"Ebon Chimera Strike"},{"Material":"Ebon Horn","Quest":"Ebon Chimera Strike: Expert"},{"Material":"Burning Heart","Quest":"Void Agni Strike"},{"Material":"Azure Heart","Quest":"Void Poseidon Strike"},{"Material":"Verdant Heart","Quest":"Void Zephyr Strike"},{"Material":"Coronal Heart","Quest":"Void Jeanne d''Arc Strike"},{"Material":"Ebony Heart","Quest":"Void Nidhogg Strike"},{"Material":"Longing Heart","Quest":"Void Dragon Strikes"},{"Material":"Agni''s Essence","Quest":"Ch. 3 / 1-3 Hard"},{"Material":"Agni''s Essence","Quest":"Ch. 3 / 1-3 Very Hard"},{"Material":"Prometheus''s Essence","Quest":"Ch. 3 / 3-5 Hard"},{"Material":"Prometheus''s Essence","Quest":"Ch. 3 / 3-5 Very Hard"},{"Material":"Cerberus''s Essence","Quest":"Ch. 3 / 2-3 Hard"},{"Material":"Cerberus''s Essence","Quest":"Ch. 3 / 2-3 Very Hard"},{"Material":"Konohana Sakuya''s Essence","Quest":"Ch. 3 / 4-3 Hard"},{"Material":"Konohana Sakuya''s Essence","Quest":"Ch. 3 / 4-3 Very Hard"},{"Material":"Arctos''s Essence","Quest":"Ch. 8 / 1-4 Hard"},{"Material":"Arctos''s Essence","Quest":"Ch. 8 / 1-4 Very Hard"},{"Material":"Apollo''s Essence","Quest":"Ch. 8 / 2-3 Hard"},{"Material":"Apollo''s Essence","Quest":"Ch. 8 / 2-3 Very Hard"},{"Material":"Leviathan''s Essence","Quest":"Ch. 2 / 3-3 Hard"},{"Material":"Leviathan''s Essence","Quest":"Ch. 2 / 3-3 Very Hard"},{"Material":"Poseidon''s Essence","Quest":"Ch. 2 / 1-3 Hard"},{"Material":"Poseidon''s Essence","Quest":"Ch. 2 / 1-3 Very Hard"},{"Material":"Siren''s Essence","Quest":"Ch. 2 / 4-2 Hard"},{"Material":"Siren''s Essence","Quest":"Ch. 2 / 4-2 Very Hard"},{"Material":"Simurgh''s Essence","Quest":"Ch. 2 / 5-1 Hard"},{"Material":"Simurgh''s Essence","Quest":"Ch. 2 / 5-1 Very Hard"},{"Material":"Kamuy''s Essence","Quest":"Ch. 2 / 6-1 Hard"},{"Material":"Kamuy''s Essence","Quest":"Ch. 2 / 6-1 Very Hard"},{"Material":"Nimis''s Essence","Quest":"Ch. 7 / 1-3 Hard"},{"Material":"Nimis''s Essence","Quest":"Ch. 7 / 1-3 Very Hard"},{"Material":"Zephyr''s Essence","Quest":"Ch. 1 / 1-2 Hard"},{"Material":"Zephyr''s Essence","Quest":"Ch. 1 / 1-2 Very Hard"},{"Material":"Garuda''s Essence","Quest":"Ch. 1 / 2-2 Hard"},{"Material":"Garuda''s Essence","Quest":"Ch. 1 / 2-2 Very Hard"},{"Material":"Long Long''s Essence","Quest":"Ch. 1 / 4-5 Hard"},{"Material":"Long Long''s Essence","Quest":"Ch. 1 / 4-5 Very Hard"},{"Material":"Pazuzu''s Essence","Quest":"Ch. 6 / 1-6 Hard"},{"Material":"Pazuzu''s Essence","Quest":"Ch. 6 / 1-6 Very Hard"},{"Material":"Freyja''s Essence","Quest":"Ch. 6 / 3-3 Hard"},{"Material":"Freyja''s Essence","Quest":"Ch. 6 / 3-3 Very Hard"},{"Material":"Vayu''s Essence","Quest":"Ch. 6 / 4-2 Hard"},{"Material":"Vayu''s Essence","Quest":"Ch. 6 / 4-2 Very Hard"},{"Material":"Cupid''s Essence","Quest":"Ch. 4 / 4-2 Hard"},{"Material":"Cupid''s Essence","Quest":"Ch. 4 / 4-2 Very Hard"},{"Material":"Jeanne d''Arc''s Essence","Quest":"Ch. 4 / 1-4 Hard"},{"Material":"Jeanne d''Arc''s Essence","Quest":"Ch. 4 / 1-4 Very Hard"},{"Material":"Gilgamesh''s Essence","Quest":"Ch. 4 / 3-5 Hard"},{"Material":"Gilgamesh''s Essence","Quest":"Ch. 4 / 3-5 Very Hard"},{"Material":"Liger''s Essence","Quest":"Ch. 4 / 5-2 Hard"},{"Material":"Liger''s Essence","Quest":"Ch. 4 / 5-2 Very Hard"},{"Material":"Takemikazuchi''s Essence","Quest":"Ch. 9 / 1-2 Hard"},{"Material":"Takemikazuchi''s Essence","Quest":"Ch. 9 / 1-2 Very Hard"},{"Material":"Pop-Star Siren''s Essence","Quest":"Ch. 9 / 2-2 Hard"},{"Material":"Pop-Star Siren''s Essence","Quest":"Ch. 9 / 2-2 Very Hard"},{"Material":"Chthonius''s Essence","Quest":"Ch. 5 / 4-3 Hard"},{"Material":"Chthonius''s Essence","Quest":"Ch. 5 / 4-3 Very Hard"},{"Material":"Nidhogg''s Essence","Quest":"Ch. 5 / 1-3 Hard"},{"Material":"Nidhogg''s Essence","Quest":"Ch. 5 / 1-3 Very Hard"},{"Material":"Nyarlathotep''s Essence","Quest":"Ch. 5 / 2-4 Hard"},{"Material":"Nyarlathotep''s Essence","Quest":"Ch. 5 / 2-4 Very Hard"},{"Material":"Shinobi''s Essence","Quest":"Ch. 5 / 3-3 Hard"},{"Material":"Shinobi''s Essence","Quest":"Ch. 5 / 3-3 Very Hard"},{"Material":"Epimetheus''s Essence","Quest":"Ch. 10 / 1-2 Hard"},{"Material":"Epimetheus''s Essence","Quest":"Ch. 10 / 1-2 Very Hard"},{"Material":"Andromeda''s Essence","Quest":"Ch. 10 / 2-2 Hard"},{"Material":"Andromeda''s Essence","Quest":"Ch. 10 / 2-2 Very Hard"},{"Material":"Crown of Light''s Memory","Quest":"Lilith''s Encroaching Shadow: Standard"},{"Material":"Tutelary Successor''s Memory","Quest":"Lilith''s Encroaching Shadow: Standard"},{"Material":"Queen of the Sands'' Memory","Quest":"Lilith''s Encroaching Shadow"},{"Material":"Otherworld Auspex''s Memory","Quest":"Lilith''s Encroaching Shadow"},{"Material":"Twilight Queen''s Memory","Quest":"Lilith''s Encroaching Shadow: Expert"},{"Material":"Twilight Queen''s Memory","Quest":"Lilith''s Encroaching Shadow: Master"},{"Material":"Determined Auspex''s Memory","Quest":"Lilith''s Encroaching Shadow: Expert"},{"Material":"Determined Auspex''s Memory","Quest":"Lilith''s Encroaching Shadow: Master"},{"Material":"Rebellious Bird''s Tide","Quest":"Ciella''s Wrath: Legend Difficulty"},{"Material":"Gala Prince''s Conviction","Quest":"Thor''s Trial"},{"Material":"Gala Prince''s Devotion","Quest":"Thor''s Trial: Expert"},{"Material":"Gala Prince''s Devotion","Quest":"Thor''s Trial: Master"},{"Material":"Gala Elisanne''s Conviction","Quest":"Poseidon''s Trial"},{"Material":"Gala Elisanne''s Devotion","Quest":"Poseidon''s Trial: Expert"},{"Material":"Gala Elisanne''s Devotion","Quest":"Poseidon''s Trial: Master"},{"Material":"Rainbow Orb","Quest":"Poseidon''s Trial"},{"Material":"Resplendence Orb","Quest":"Poseidon''s Trial: Master"},{"Material":"Resplendence Orb","Quest":"Poseidon''s Trial: Expert"},{"Material":"Fortifying Crystal","Quest":"Poseidon''s Trial"},{"Material":"Amplifying Crystal","Quest":"Poseidon''s Trial"},{"Material":"Fortifying Dragonscale","Quest":"Poseidon''s Trial"},{"Material":"Amplifying Dragonscale","Quest":"Poseidon''s Trial"},{"Material":"Fortifying Gemstone","Quest":"Poseidon''s Trial"},{"Material":"Amplifying Gemstone","Quest":"Poseidon''s Trial"},{"Material":"Nature''s Blessing","Quest":"Poseidon''s Trial"},{"Material":"Orichalcum","Quest":"Poseidon''s Trial: Master"},{"Quest":"Zephyr''s Trial","Material":"Rainbow Orb"},{"Quest":"Zephyr''s Trial: Master","Material":"Resplendence Orb"},{"Quest":"Zephyr''s Trial: Expert","Material":"Resplendence Orb"},{"Quest":"Zephyr''s Trial","Material":"Fortifying Crystal"},{"Quest":"Zephyr''s Trial","Material":"Amplifying Crystal"},{"Quest":"Zephyr''s Trial","Material":"Fortifying Dragonscale"},{"Quest":"Zephyr''s Trial","Material":"Amplifying Dragonscale"},{"Quest":"Zephyr''s Trial","Material":"Fortifying Gemstone"},{"Quest":"Zephyr''s Trial","Material":"Amplifying Gemstone"},{"Quest":"Zephyr''s Trial","Material":"Nature''s Blessing"},{"Quest":"Zephyr''s Trial: Master","Material":"Orichalcum"},{"Quest":"Zephyr''s Trial","Material":"Gala Ranzal''s Conviction"},{"Quest":"Zephyr''s Trial: Master","Material":"Gala Ranzal''s Devotion"},{"Quest":"Zephyr''s Trial: Expert","Material":"Gala Ranzal''s Devotion"}]'

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
