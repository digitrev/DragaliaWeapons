/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
			   SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
PRINT 'Loading data tables from json tables'

EXECUTE jsn.spLoadCore

PRINT 'Loading data tables from denomralized tables'

EXECUTE den.spInitializeDen

EXECUTE den.spLoadCore

IF NOT EXISTS (
		SELECT *
		FROM util.Tally
		WHERE N = 100000
		)
BEGIN
	PRINT 'Initializing tally table'

	TRUNCATE TABLE util.Tally

	SET IDENTITY_INSERT util.Tally ON

	INSERT util.Tally (N)
	SELECT TOP 100000 ROW_NUMBER() OVER (
			ORDER BY c1.column_id
			)
	FROM sys.all_columns c1
		,sys.all_columns c2

	SET IDENTITY_INSERT util.Tally OFF
END
