﻿CREATE PROCEDURE [core].[spFacilityJson]
AS
SELECT f.FacilityID AS facilityId
	,f.Facility AS facility
	,f.Limit AS limit
	,c.Category AS category
FROM core.Facility AS f
INNER JOIN core.Category AS c ON c.CategoryID = f.CategoryID
ORDER BY c.SortPath
	,f.FacilityID
