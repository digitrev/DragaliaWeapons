CREATE TABLE [dbo].[Element] (
    [ElementID] TINYINT       IDENTITY (1, 1) NOT NULL,
    [Element]   NVARCHAR (10) NOT NULL,
    CONSTRAINT [PK_Element] PRIMARY KEY CLUSTERED ([ElementID] ASC)
);

