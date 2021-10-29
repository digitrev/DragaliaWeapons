﻿CREATE PROCEDURE [den].[spInitializeDenCht]
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @Json NVARCHAR(MAX)

	TRUNCATE TABLE [den].[Chests]

	SET @Json = 
		'[{"Frequency":"Daily","ChestGroups":[{"ChestGroup":"Elemental Ruins","Quantity":1,"Chests":[{"Quest":"Flamehowl Ruins","Drops":[{"Material":"Inferno Orb"},{"Material":"Blaze Orb"},{"Material":"Flame Orb"}]},{"Quest":"Waterscour Ruins","Drops":[{"Material":"Deluge Orb"},{"Material":"Stream Orb"},{"Material":"Water Orb"}]},{"Quest":"Windmaul Ruins","Drops":[{"Material":"Wind Orb"},{"Material":"Storm Orb"},{"Material":"Maelstrom Orb"}]},{"Quest":"Lightsunder Ruins","Drops":[{"Material":"Light Orb"},{"Material":"Radiance Orb"},{"Material":"Refulgence Orb"}]},{"Quest":"Shadowsteep Ruins","Drops":[{"Material":"Shadow Orb"},{"Material":"Nightfall Orb"},{"Material":"Nether Orb"}]}]},{"ChestGroup":"Dragon Trials","Quantity":1,"Chests":[{"Quest":"Midgardsormr''s Trial","Drops":[{"Material":"Windwyrm''s Squallscale"},{"Material":"Windwyrm''s Scale"}]},{"Quest":"Mercury''s Trial","Drops":[{"Material":"Waterwyrm''s Glistscale"},{"Material":"Waterwyrm''s Scale"}]},{"Quest":"Brunhilda''s Trial","Drops":[{"Material":"Flamewyrm''s Scaldscale"},{"Material":"Flamewyrm''s Scale"}]},{"Quest":"Jupiter''s Trial","Drops":[{"Material":"Lightwyrm''s Glowscale"},{"Material":"Lightwyrm''s Scale"}]},{"Quest":"Zodiark''s Trial","Drops":[{"Material":"Shadowwyrm''s Darkscale"},{"Material":"Shadowwyrm''s Scale"}]}]},{"ChestGroup":"The Imperial Onslaught","Quantity":1,"Chests":[{"Quest":"Battle at Mount Adolla","Drops":[{"Material":"Vermilion Insignia"},{"Material":"Royal Vermilion Insignia"}]},{"Quest":"Battle at Myriage Lake","Drops":[{"Material":"Azure Insignia"},{"Material":"Royal Azure Insignia"}]},{"Quest":"Battle in Rovetelle Forest","Drops":[{"Material":"Jade Insignia"},{"Material":"Royal Jade Insignia"}]},{"Quest":"Battle in the Dornith Mountains","Drops":[{"Material":"Amber Insignia"},{"Material":"Royal Amber Insignia"}]},{"Quest":"Battle at the Wartarch Ruins","Drops":[{"Material":"Violet Insignia"},{"Material":"Royal Violet Insignia"}]}]}]},{"Frequency":"Weekly","ChestGroups":[{"ChestGroup":"Advanced Dragon Trials","Quantity":5,"Chests":[{"Quest":"High Midgardsormr''s Trial: Master","Drops":[{"Material":"Windwyrm''s Greatsphere"},{"Material":"High Windwyrm''s Horn"}]},{"Quest":"High Midgardsormr''s Trial: Expert","Drops":[{"Material":"Windwyrm''s Greatsphere"},{"Material":"High Windwyrm''s Horn"},{"Material":"High Windwyrm''s Tail"}]},{"Quest":"High Midgardsormr''s Trial: Standard","Drops":[{"Material":"Windwyrm''s Greatsphere"}]},{"Quest":"High Mercury''s Trial: Master","Drops":[{"Material":"Waterwyrm''s Greatsphere"},{"Material":"High Waterwyrm''s Horn"}]},{"Quest":"High Mercury''s Trial: Expert","Drops":[{"Material":"Waterwyrm''s Greatsphere"},{"Material":"High Waterwyrm''s Horn"},{"Material":"High Waterwyrm''s Tail"}]},{"Quest":"High Mercury''s Trial: Standard","Drops":[{"Material":"Waterwyrm''s Greatsphere"}]},{"Quest":"High Brunhilda''s Trial: Master","Drops":[{"Material":"Flamewyrm''s Greatsphere"},{"Material":"High Flamewyrm''s Horn"}]},{"Quest":"High Brunhilda''s Trial: Expert","Drops":[{"Material":"Flamewyrm''s Greatsphere"},{"Material":"High Flamewyrm''s Horn"},{"Material":"High Flamewyrm''s Tail"}]},{"Quest":"High Brunhilda''s Trial: Standard","Drops":[{"Material":"Flamewyrm''s Greatsphere"}]},{"Quest":"High Jupiter''s Trial: Master","Drops":[{"Material":"Lightwyrm''s Greatsphere"},{"Material":"High Lightwyrm''s Horn"}]},{"Quest":"High Jupiter''s Trial: Expert","Drops":[{"Material":"Lightwyrm''s Greatsphere"},{"Material":"High Lightwyrm''s Horn"},{"Material":"High Lightwyrm''s Tail"}]},{"Quest":"High Jupiter''s Trial: Standard","Drops":[{"Material":"Lightwyrm''s Greatsphere"}]},{"Quest":"High Zodiark''s Trial: Master","Drops":[{"Material":"Shadowwyrm''s Greatsphere"},{"Material":"High Shadowwyrm''s Horn"}]},{"Quest":"High Zodiark''s Trial: Expert","Drops":[{"Material":"Shadowwyrm''s Greatsphere"},{"Material":"High Shadowwyrm''s Horn"},{"Material":"High Shadowwyrm''s Tail"}]},{"Quest":"High Zodiark''s Trial: Standard","Drops":[{"Material":"Shadowwyrm''s Greatsphere"}]}]},{"ChestGroup":"The Agito Uprising","Quantity":5,"Chests":[{"Quest":"Volk''s Wrath: Master","Drops":[{"Material":"Rebellious One''s Insanity"}]},{"Quest":"Volk''s Wrath: Expert","Drops":[{"Material":"Rebellious One''s Insanity"},{"Material":"Plagued One''s Mask Fragment"},{"Material":"Destitute One''s Mask Fragment"}]},{"Quest":"Volk''s Wrath: Standard","Drops":[{"Material":"Plagued One''s Mask Fragment"},{"Material":"Destitute One''s Mask Fragment"}]},{"Quest":"Ciella''s Wrath: Master","Drops":[{"Material":"Rebellious One''s Desperation"}]},{"Quest":"Ciella''s Wrath: Expert","Drops":[{"Material":"Rebellious One''s Desperation"},{"Material":"Despairing One''s Mask Fragment"},{"Material":"Eliminating One''s Mask Fragment"}]},{"Quest":"Ciella''s Wrath: Standard","Drops":[{"Material":"Despairing One''s Mask Fragment"},{"Material":"Eliminating One''s Mask Fragment"}]},{"Quest":"Ayaha & Otoha''s Wrath: Master","Drops":[{"Material":"Rebellious One''s Cruelty"}]},{"Quest":"Ayaha & Otoha''s Wrath: Expert","Drops":[{"Material":"Rebellious One''s Cruelty"},{"Material":"Liberated One''s Mask Fragment"},{"Material":"Soaring Ones'' Mask Fragment"}]},{"Quest":"Ayaha & Otoha''s Wrath: Standard","Drops":[{"Material":"Liberated One''s Mask Fragment"},{"Material":"Soaring Ones'' Mask Fragment"}]},{"Quest":"Kai Yan''s Wrath: Master","Drops":[{"Material":"Rebellious One''s Arrogance"}]},{"Quest":"Kai Yan''s Wrath: Expert","Drops":[{"Material":"Rebellious One''s Arrogance"},{"Material":"Uprooting One''s Mask Fragment"},{"Material":"Almighty One''s Mask Fragment"}]},{"Quest":"Kai Yan''s Wrath: Standard","Drops":[{"Material":"Uprooting One''s Mask Fragment"},{"Material":"Almighty One''s Mask Fragment"}]},{"Quest":"Tartarus''s Wrath: Master","Drops":[{"Material":"Rebellious One''s Loyalty"}]},{"Quest":"Tartarus''s Wrath: Expert","Drops":[{"Material":"Rebellious One''s Loyalty"},{"Material":"Vengeful One''s Mask Fragment"},{"Material":"Remaining One''s Mask Fragment"}]},{"Quest":"Tartarus''s Wrath: Standard","Drops":[{"Material":"Vengeful One''s Mask Fragment"},{"Material":"Remaining One''s Mask Fragment"}]}]},{"ChestGroup":"Rise of the Sinister Dominion","Quantity":3,"Chests":[{"Quest":"Lilith''s Encroaching Shadow: Master","Drops":[{"Material":"Twilight Prism"}]},{"Quest":"Lilith''s Encroaching Shadow: Expert","Drops":[{"Material":"Twilight Prism"},{"Material":"Twilight Shard"}]},{"Quest":"Lilith''s Encroaching Shadow: Standard","Drops":[{"Material":"Twilight Prism"},{"Material":"Twilight Shard"}]},{"Quest":"Jaldabaoth''s Piercing Gale: Expert","Drops":[{"Material":"Cyclone Prism"},{"Material":"Cyclone Shard"}]},{"Quest":"Jaldabaoth''s Piercing Gale: Standard","Drops":[{"Material":"Cyclone Prism"},{"Material":"Cyclone Shard"}]},{"Quest":"Jaldabaoth''s Piercing Gale: Master","Drops":[{"Material":"Cyclone Prism"}]},{"Quest":"Iblis''s Surging Cascade: Master","Drops":[{"Material":"Whirlpool Prism"}]},{"Quest":"Iblis''s Surging Cascade: Expert","Drops":[{"Material":"Whirlpool Prism"},{"Material":"Whirlpool Shard"}]},{"Quest":"Iblis''s Surging Cascade: Standard","Drops":[{"Material":"Whirlpool Prism"},{"Material":"Whirlpool Shard"}]},{"Quest":"Asura''s Blinding Light: Master","Drops":[{"Material":"Blinding Prism"}]},{"Quest":"Asura''s Blinding Light: Expert","Drops":[{"Material":"Blinding Prism"},{"Material":"Blinding Shard"}]},{"Quest":"Asura''s Blinding Light: Standard","Drops":[{"Material":"Blinding Prism"},{"Material":"Blinding Shard"}]},{"Quest":"Surtr''s Devouring Flame: Expert","Drops":[{"Material":"Firestorm Prism"},{"Material":"Firestorm Shard"}]},{"Quest":"Surtr''s Devouring Flame: Master","Drops":[{"Material":"Firestorm Prism"}]},{"Quest":"Surtr''s Devouring Flame: Standard","Drops":[{"Material":"Firestorm Prism"},{"Material":"Firestorm Shard"}]}]},{"ChestGroup":"The Agito Uprising: Legend Difficulty","Quantity":1,"Chests":[{"Quest":"Volk''s Wrath: Legend Difficulty","Drops":[{"Material":"Rebellious Wolf''s Gale"}]},{"Quest":"Kai Yan''s Wrath: Legend Difficulty","Drops":[{"Material":"Rebellious Ox''s Lightning"}]},{"Quest":"Ciella''s Wrath: Legend Difficulty","Drops":[{"Material":"Rebellious Bird''s Tide"}]},{"Quest":"Ayaha & Otoha''s Wrath: Legend Difficulty","Drops":[{"Material":"Rebellious Butterflies'' Searing Fire"}]},{"Quest":"Tartarus''s Wrath: Legend Difficulty","Drops":[{"Material":"Rebellious Lion''s Twilight"}]}]}]}]'

	INSERT [den].[Chests] (
		Frequency
		,ChestGroup
		,Quantity
		,Quest
		,Material
		)
	SELECT f.Frequency
		,cg.ChestGroup
		,cg.Quantity
		,c.Quest
		,d.Material
	FROM OPENJSON(@Json) WITH (
			Frequency NVARCHAR(50)
			,ChestGroups NVARCHAR(MAX) AS JSON
			) AS f
	CROSS APPLY OPENJSON(f.ChestGroups) WITH (
			ChestGroup NVARCHAR(50)
			,Quantity INT
			,Chests NVARCHAR(MAX) AS JSON
			) AS cg
	CROSS APPLY OPENJSON(cg.Chests) WITH (
			Quest NVARCHAR(50)
			,Drops NVARCHAR(MAX) AS JSON
			) AS c
	CROSS APPLY OPENJSON(c.Drops) WITH (Material NVARCHAR(50)) AS d
END
