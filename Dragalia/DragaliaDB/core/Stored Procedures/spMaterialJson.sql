CREATE PROCEDURE [core].[spMaterialJson]
AS
SELECT m.MaterialID AS materialId
	,m.Material AS material
	,c.Category AS category
	,m.SortPath AS sortPath
FROM core.Material AS m
INNER JOIN core.Category AS c ON c.CategoryID = m.CategoryID
WHERE c.Category <> 'Unused'
ORDER BY m.SortPath
FOR JSON PATH
