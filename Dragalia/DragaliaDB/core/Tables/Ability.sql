CREATE TABLE [core].[Ability] (
	[AbilityID] INT NOT NULL
	,[Ability] NVARCHAR(100) NOT NULL
	,[GenericName] NVARCHAR(50) NOT NULL
	,[AbilityGroupID] INT NOT NULL
	,[Active] BIT NOT NULL CONSTRAINT [DF_Ability_Active] DEFAULT(1)
	,CONSTRAINT [PK_Ability] PRIMARY KEY ([AbilityID])
	,CONSTRAINT [FK_Ability_AbilityGroup] FOREIGN KEY ([AbilityGroupID]) REFERENCES [core].[AbilityGroup]([AbilityGroupID]) ON DELETE CASCADE
	)
