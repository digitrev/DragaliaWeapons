CREATE PROCEDURE [wpt].[spWyrmprintLevelJson]
AS
SELECT [WyrmprintID]
	,[WyrmprintLevel]
	,[MaterialID]
	,[Quantity]
FROM [wpt].[WyrmprintLevel]
FOR JSON PATH
