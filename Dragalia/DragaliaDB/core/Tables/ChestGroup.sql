﻿CREATE TABLE [core].[ChestGroup] (
	[ChestGroupID] INT NOT NULL IDENTITY
	,[ChestGroup] NVARCHAR(50) NOT NULL
	,[FrequencyID] INT NOT NULL
	,CONSTRAINT [PK_ChestGroup] PRIMARY KEY ([ChestGroupID])
	,CONSTRAINT [FK_ChestGroup_Frequency] FOREIGN KEY ([FrequencyID]) REFERENCES [core].[Frequency]([FrequencyID])
	)
