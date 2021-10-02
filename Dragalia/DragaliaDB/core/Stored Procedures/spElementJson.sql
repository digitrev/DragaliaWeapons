CREATE PROCEDURE [core].[spElementJson]
AS
SELECT ElementID AS elementId
	,Element AS element
FROM core.Element
ORDER BY SortOrder
FOR JSON PATH
