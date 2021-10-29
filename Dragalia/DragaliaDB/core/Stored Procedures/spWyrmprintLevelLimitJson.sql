CREATE PROCEDURE [core].[spWyrmprintLevelLimitJson]
AS
SELECT WyrmprintRarity AS rarity
	,MAX(MaxWyrmprintLevel) AS [level]
FROM [wpt].WyrmprintLevelLimit
GROUP BY WyrmprintRarity
FOR JSON PATH
