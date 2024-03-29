USE [master]
GO
/****** Object:  Database [CompanyBookSystem]    Script Date: 11/22/2012 09:46:57 ******/
CREATE DATABASE [CompanyBookSystem] ON  PRIMARY 
( NAME = N'CompanyBookSystem', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\CompanyBookSystem.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'CompanyBookSystem_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\CompanyBookSystem_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [CompanyBookSystem] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CompanyBookSystem].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CompanyBookSystem] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [CompanyBookSystem] SET ANSI_NULLS OFF
GO
ALTER DATABASE [CompanyBookSystem] SET ANSI_PADDING OFF
GO
ALTER DATABASE [CompanyBookSystem] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [CompanyBookSystem] SET ARITHABORT OFF
GO
ALTER DATABASE [CompanyBookSystem] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [CompanyBookSystem] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [CompanyBookSystem] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [CompanyBookSystem] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [CompanyBookSystem] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [CompanyBookSystem] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [CompanyBookSystem] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [CompanyBookSystem] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [CompanyBookSystem] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [CompanyBookSystem] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [CompanyBookSystem] SET  DISABLE_BROKER
GO
ALTER DATABASE [CompanyBookSystem] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [CompanyBookSystem] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [CompanyBookSystem] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [CompanyBookSystem] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [CompanyBookSystem] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [CompanyBookSystem] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [CompanyBookSystem] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [CompanyBookSystem] SET  READ_WRITE
GO
ALTER DATABASE [CompanyBookSystem] SET RECOVERY FULL
GO
ALTER DATABASE [CompanyBookSystem] SET  MULTI_USER
GO
ALTER DATABASE [CompanyBookSystem] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [CompanyBookSystem] SET DB_CHAINING OFF
GO
EXEC sys.sp_db_vardecimal_storage_format N'CompanyBookSystem', N'ON'
GO
USE [CompanyBookSystem]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 11/22/2012 09:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [uniqueidentifier] NOT NULL,
	[LoginName] [nvarchar](20) NOT NULL,
	[Password] [nvarchar](20) NOT NULL,
	[RealName] [nvarchar](20) NOT NULL,
	[Tel] [nvarchar](20) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[Describe] [nvarchar](200) NULL,
	[State] [int] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Users', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'登录名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Users', @level2type=N'COLUMN',@level2name=N'LoginName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'真实姓名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Users', @level2type=N'COLUMN',@level2name=N'RealName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'联系电话' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Users', @level2type=N'COLUMN',@level2name=N'Tel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'邮箱' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Users', @level2type=N'COLUMN',@level2name=N'Email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Users', @level2type=N'COLUMN',@level2name=N'Describe'
GO
/****** Object:  Table [dbo].[Departments]    Script Date: 11/22/2012 09:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Departments](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](10) NOT NULL,
	[Minister] [nvarchar](10) NOT NULL,
	[Describe] [nvarchar](200) NULL,
	[State] [int] NOT NULL,
 CONSTRAINT [PK_Departments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Departments', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'部门名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Departments', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'部门主管' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Departments', @level2type=N'COLUMN',@level2name=N'Minister'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'类别描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Departments', @level2type=N'COLUMN',@level2name=N'Describe'
GO
/****** Object:  Table [dbo].[BookObjectType]    Script Date: 11/22/2012 09:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookObjectType](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](20) NOT NULL,
	[Describe] [nvarchar](200) NULL,
	[State] [int] NOT NULL,
 CONSTRAINT [PK_BookObjectType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BookObjectType', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'对象类型名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BookObjectType', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'对象类型描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BookObjectType', @level2type=N'COLUMN',@level2name=N'Describe'
GO
/****** Object:  Table [dbo].[BookObject]    Script Date: 11/22/2012 09:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookObject](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](20) NOT NULL,
	[BookObjectTypeId] [uniqueidentifier] NOT NULL,
	[Location] [nvarchar](50) NOT NULL,
	[Describe] [nvarchar](200) NULL,
	[State] [int] NOT NULL,
 CONSTRAINT [PK_BookObject] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BookObject', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'对象名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BookObject', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'对象类型Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BookObject', @level2type=N'COLUMN',@level2name=N'BookObjectTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'所在位置' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BookObject', @level2type=N'COLUMN',@level2name=N'Location'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BookObject', @level2type=N'COLUMN',@level2name=N'Describe'
GO
/****** Object:  Table [dbo].[BookRecords]    Script Date: 11/22/2012 09:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookRecords](
	[Id] [uniqueidentifier] NOT NULL,
	[BookObjectId] [uniqueidentifier] NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NOT NULL,
	[StartTime] [datetime] NOT NULL,
	[EndTime] [datetime] NOT NULL,
	[WhetherContinuous] [bit] NOT NULL,
	[Describe] [nvarchar](200) NULL,
	[DepartmentId] [uniqueidentifier] NOT NULL,
	[Tel] [nvarchar](20) NOT NULL,
	[State] [int] NOT NULL,
	[Creator] [nvarchar](20) NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[Modifier] [nvarchar](20) NULL,
	[DateModified] [datetime] NULL,
 CONSTRAINT [PK_BookRecords] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BookRecords', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'预约、预订对象表Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BookRecords', @level2type=N'COLUMN',@level2name=N'BookObjectId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'开始日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BookRecords', @level2type=N'COLUMN',@level2name=N'StartDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'结束日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BookRecords', @level2type=N'COLUMN',@level2name=N'EndDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'开始时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BookRecords', @level2type=N'COLUMN',@level2name=N'StartTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'结束时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BookRecords', @level2type=N'COLUMN',@level2name=N'EndTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否连续' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BookRecords', @level2type=N'COLUMN',@level2name=N'WhetherContinuous'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BookRecords', @level2type=N'COLUMN',@level2name=N'Describe'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'部门Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BookRecords', @level2type=N'COLUMN',@level2name=N'DepartmentId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'联系电话' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BookRecords', @level2type=N'COLUMN',@level2name=N'Tel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BookRecords', @level2type=N'COLUMN',@level2name=N'Creator'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BookRecords', @level2type=N'COLUMN',@level2name=N'DateCreated'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BookRecords', @level2type=N'COLUMN',@level2name=N'Modifier'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BookRecords', @level2type=N'COLUMN',@level2name=N'DateModified'
GO
/****** Object:  ForeignKey [FK_BookObject_BookObjectType]    Script Date: 11/22/2012 09:46:59 ******/
ALTER TABLE [dbo].[BookObject]  WITH CHECK ADD  CONSTRAINT [FK_BookObject_BookObjectType] FOREIGN KEY([BookObjectTypeId])
REFERENCES [dbo].[BookObjectType] ([Id])
GO
ALTER TABLE [dbo].[BookObject] CHECK CONSTRAINT [FK_BookObject_BookObjectType]
GO
/****** Object:  ForeignKey [FK_BookRecords_BookObject]    Script Date: 11/22/2012 09:46:59 ******/
ALTER TABLE [dbo].[BookRecords]  WITH CHECK ADD  CONSTRAINT [FK_BookRecords_BookObject] FOREIGN KEY([BookObjectId])
REFERENCES [dbo].[BookObject] ([Id])
GO
ALTER TABLE [dbo].[BookRecords] CHECK CONSTRAINT [FK_BookRecords_BookObject]
GO
/****** Object:  ForeignKey [FK_BookRecords_Departments]    Script Date: 11/22/2012 09:46:59 ******/
ALTER TABLE [dbo].[BookRecords]  WITH CHECK ADD  CONSTRAINT [FK_BookRecords_Departments] FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[Departments] ([Id])
GO
ALTER TABLE [dbo].[BookRecords] CHECK CONSTRAINT [FK_BookRecords_Departments]
GO
