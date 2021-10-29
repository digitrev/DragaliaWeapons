CREATE TABLE [wpn].[WeaponSeries] (
	[WeaponSeriesID] INT NOT NULL
	,[WeaponSeries] NVARCHAR(50) NOT NULL
	,[SortOrder] INT NOT NULL
	,[Active] BIT NOT NULL CONSTRAINT [DF_WeaponSeries_Active] DEFAULT(1)
	,CONSTRAINT [PK_WeaponSeries] PRIMARY KEY ([WeaponSeriesID])
	)
