CREATE TABLE [core].[Affinity] (
	[AffinityID] INT NOT NULL
	,[Affinity] NVARCHAR(50) NOT NULL
	,[Active] BIT NOT NULL CONSTRAINT [DF_Affinity_Active] DEFAULT(1)
	,CONSTRAINT [PK_Affinity] PRIMARY KEY ([AffinityID])
	)
