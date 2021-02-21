CREATE TABLE [core].[AbilityGroup] (
	[AbilityGroupID] INT NOT NULL
	,[AbilityGroup] NVARCHAR(50) NOT NULL
	,[Active] BIT NOT NULL CONSTRAINT [DF_AbilityGroup_Active] DEFAULT(1)
	,CONSTRAINT [PK_AbilityGroup] PRIMARY KEY ([AbilityGroupID])
	)
