USE [Splitter]
GO

DECLARE @MigrationNumber varchar
DECLARE @Application nvarchar(max)
DECLARE @TargetVersionMajor int
DECLARE @TargetVersionMinor int
DECLARE @TargetVersionBuild int

SET @MigrationNumber = '1'
SET @Application = 'Budget'
SET @TargetVersionMajor = 0
SET @TargetVersionMinor = 0
SET @TargetVersionBuild = 1

PRINT 'Migrating ' + @Application + ' to version ' + CAST(@TargetVersionMajor AS nvarchar) + '.' + CAST(@TargetVersionMinor AS nvarchar) + '.' + CAST(@TargetVersionBuild AS nvarchar) + ': Checking version'

-- Create DatabaseVersion table if not exists
IF NOT EXISTS(SELECT 1 FROM sys.Objects WHERE Object_id = OBJECT_ID(N'dbo.DatabaseVersion') AND Type = N'U')
BEGIN
	PRINT 'Creating table [DatabaseVersion]'

	CREATE TABLE [dbo].[DatabaseVersion](
		[Id] [uniqueidentifier] NOT NULL DEFAULT NEWSEQUENTIALID(),
		[Application] [nvarchar](max) NOT NULL,
		[VersionMajor] [int] NOT NULL,
		[VersionMinor] [int] NOT NULL,
		[VersionBuild] [int] NOT NULL
	CONSTRAINT [PK_DatabaseVersion] PRIMARY KEY CLUSTERED ([Id] ASC)
		WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY])
		ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END

PRINT 'Checking database version'
IF EXISTS(SELECT [Application] FROM [dbo].[DatabaseVersion] WHERE [Application] = @Application)
BEGIN
	DECLARE @Major int, @Minor int, @Build int
	SELECT @Major = [VersionMajor], @Minor = [VersionMinor], @Build = [VersionBuild]
	FROM [dbo].[DatabaseVersion]
	WHERE [Application] = @Application
	
	PRINT 'Application ' + @Application + ' already exists in version: ' + CAST(@Major AS nvarchar) + '.' + CAST(@Minor AS nvarchar) + '.' + CAST(@Build AS nvarchar)
	
	RETURN
END

PRINT 'Migrating ' + @Application + ' to version ' + CAST(@TargetVersionMajor AS nvarchar) + '.' + CAST(@TargetVersionMinor AS nvarchar) + '.' + CAST(@TargetVersionBuild AS nvarchar) + ': Applying migration'

INSERT INTO [dbo].[DatabaseVersion] ([Application], [VersionMajor], [VersionMinor], [VersionBuild])
VALUES (@Application, 0, 0, 1)

PRINT 'Migrating ' + @Application + ' to version ' + CAST(@TargetVersionMajor AS nvarchar) + '.' + CAST(@TargetVersionMinor AS nvarchar) + '.' + CAST(@TargetVersionBuild AS nvarchar) + ': Successfully finished'

GO