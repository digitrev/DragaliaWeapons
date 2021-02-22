CREATE TABLE [dbo].[Account] (
	[AccountID] INT NOT NULL IDENTITY
	,[AccountName] NVARCHAR(255) NOT NULL
	,[AccountEmail] NVARCHAR(255) NOT NULL
	,[AuthID] NVARCHAR(255) NOT NULL
	,[Active] BIT NOT NULL CONSTRAINT [DF_Account_Active] DEFAULT(1)
	,CONSTRAINT [PK_Account] PRIMARY KEY ([AccountID])
	)
GO

CREATE INDEX [IX_Account_AuthID] ON [dbo].[Account] ([AuthID])
