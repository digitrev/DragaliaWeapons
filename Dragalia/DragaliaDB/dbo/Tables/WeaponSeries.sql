CREATE TABLE [dbo].[WeaponSeries] (
	[WeaponSeriesID] INT NOT NULL
	,[WeaponSeries] NVARCHAR(50) NOT NULL
	,[SortOrder] INT NOT NULL, 
    CONSTRAINT [PK_WeaponSeries] PRIMARY KEY ([WeaponSeriesID])
	)
