USE [master]
GO
/****** Object:  Database [CompanyBookSystem]    Script Date: 12/26/2012 14:33:45 ******/
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
/****** Object:  Table [dbo].[Users]    Script Date: 12/26/2012 14:33:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [uniqueidentifier] NOT NULL,
	[LoginName] [nvarchar](20) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
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
INSERT [dbo].[Users] ([Id], [LoginName], [Password], [RealName], [Tel], [Email], [Describe], [State]) VALUES (N'1ff7ac63-c974-4d9f-b790-5c3e6e516bc1', N'admin', N'jZae727K08KaOmKSgOaGzww/XVqGr/PKEgIMkjrcbJI=', N'陈明', N'62751111', N'chenming@tianfusoftwarepark.com', NULL, 1)
/****** Object:  Table [dbo].[ObjectStyle]    Script Date: 12/26/2012 14:33:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ObjectStyle](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](20) NOT NULL,
	[BackgroundColor] [varchar](10) NOT NULL,
	[TextColor] [varchar](10) NOT NULL,
	[BorderColor] [varchar](10) NOT NULL,
	[Describe] [nvarchar](200) NULL,
	[State] [int] NOT NULL,
 CONSTRAINT [PK_RecordStyle] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ObjectStyle', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'样式名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ObjectStyle', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'背景色
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ObjectStyle', @level2type=N'COLUMN',@level2name=N'BackgroundColor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'文字颜色' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ObjectStyle', @level2type=N'COLUMN',@level2name=N'TextColor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'边框色
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ObjectStyle', @level2type=N'COLUMN',@level2name=N'BorderColor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ObjectStyle', @level2type=N'COLUMN',@level2name=N'Describe'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'数据状态' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ObjectStyle', @level2type=N'COLUMN',@level2name=N'State'
GO
INSERT [dbo].[ObjectStyle] ([Id], [Name], [BackgroundColor], [TextColor], [BorderColor], [Describe], [State]) VALUES (N'6371dfbc-99db-49de-9b0b-1bdeaaea8814', N'红色', N'#AE5A5A', N'#000000', N'#854545', N'红色背景，黑色文字', 1)
INSERT [dbo].[ObjectStyle] ([Id], [Name], [BackgroundColor], [TextColor], [BorderColor], [Describe], [State]) VALUES (N'28e8585c-0219-4491-a5d4-2a33d6ffcb5c', N'淡蓝色', N'#4193D9', N'#FFFFFF', N'#4193D9', N'淡蓝色的背景，黑黄色文字', 1)
INSERT [dbo].[ObjectStyle] ([Id], [Name], [BackgroundColor], [TextColor], [BorderColor], [Describe], [State]) VALUES (N'2bb3559a-b7a6-4307-80fc-837ad8e76638', N'黄色', N'#cca833', N'#000000', N'#a07c04', N'黄色背景，黑色文字', 1)
INSERT [dbo].[ObjectStyle] ([Id], [Name], [BackgroundColor], [TextColor], [BorderColor], [Describe], [State]) VALUES (N'7dddb501-3d6d-41f8-a4aa-c6fc424cc85e', N'绿色', N'#358043', N'#023456', N'#358043', N'绿色背景，深蓝色文字', 1)
/****** Object:  Table [dbo].[Departments]    Script Date: 12/26/2012 14:33:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Departments](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](20) NOT NULL,
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
INSERT [dbo].[Departments] ([Id], [Name], [Minister], [Describe], [State]) VALUES (N'00000000-0000-0000-0000-000000000000', N'个人预订', N'', N'个人使用', 1)
INSERT [dbo].[Departments] ([Id], [Name], [Minister], [Describe], [State]) VALUES (N'f721c414-6792-412a-b8bf-680bd7ee0e6c', N'RDS', N'孙部', NULL, 1)
INSERT [dbo].[Departments] ([Id], [Name], [Minister], [Describe], [State]) VALUES (N'd887c1cc-8632-433b-8009-e59d1c09da9c', N'ITS', N'王部', NULL, 1)
/****** Object:  Table [dbo].[BookObjectType]    Script Date: 12/26/2012 14:33:45 ******/
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
INSERT [dbo].[BookObjectType] ([Id], [Name], [Describe], [State]) VALUES (N'8eba5d61-2df2-4147-bfd5-30ebec5682c9', N'会议室', N'开会的地方', 1)
/****** Object:  Table [dbo].[BookObject]    Script Date: 12/26/2012 14:33:45 ******/
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
	[ObjectStyleId] [uniqueidentifier] NULL,
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
INSERT [dbo].[BookObject] ([Id], [Name], [BookObjectTypeId], [Location], [Describe], [State], [ObjectStyleId]) VALUES (N'19f34e91-865f-4a12-8a7d-020cae4ac64b', N'巴黎会议室', N'8eba5d61-2df2-4147-bfd5-30ebec5682c9', N'C8三楼', N'设备：投影仪', 1, N'2bb3559a-b7a6-4307-80fc-837ad8e76638')
INSERT [dbo].[BookObject] ([Id], [Name], [BookObjectTypeId], [Location], [Describe], [State], [ObjectStyleId]) VALUES (N'bf084e4b-e73d-4975-a991-66df0ab1092b', N'北京会议室', N'8eba5d61-2df2-4147-bfd5-30ebec5682c9', N'C8二楼', N'最大的会议室
设备：投影仪', 1, N'6371dfbc-99db-49de-9b0b-1bdeaaea8814')
INSERT [dbo].[BookObject] ([Id], [Name], [BookObjectTypeId], [Location], [Describe], [State], [ObjectStyleId]) VALUES (N'892cb4cb-dc31-46ec-8188-a28e2c99e409', N'东京会议室', N'8eba5d61-2df2-4147-bfd5-30ebec5682c9', N'C8三楼', N'设备：投影仪', 1, N'7dddb501-3d6d-41f8-a4aa-c6fc424cc85e')
INSERT [dbo].[BookObject] ([Id], [Name], [BookObjectTypeId], [Location], [Describe], [State], [ObjectStyleId]) VALUES (N'1ff9014e-f80d-4c5a-ae91-efeea8b61ceb', N'纽约会议室', N'8eba5d61-2df2-4147-bfd5-30ebec5682c9', N'C8二楼', N'设备：投影仪', 1, N'28e8585c-0219-4491-a5d4-2a33d6ffcb5c')
/****** Object:  Table [dbo].[BookRecords]    Script Date: 12/26/2012 14:33:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BookRecords](
	[Id] [uniqueidentifier] NOT NULL,
	[RelevanceId] [uniqueidentifier] NULL,
	[BookObjectId] [uniqueidentifier] NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NOT NULL,
	[StartTime] [datetime] NOT NULL,
	[EndTime] [datetime] NOT NULL,
	[Describe] [nvarchar](200) NULL,
	[DepartmentId] [uniqueidentifier] NOT NULL,
	[Tel] [nvarchar](20) NOT NULL,
	[State] [int] NOT NULL,
	[Creator] [nvarchar](20) NOT NULL,
	[OperateComputerIP] [varchar](40) NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[Modifier] [nvarchar](20) NULL,
	[DateModified] [datetime] NULL,
 CONSTRAINT [PK_BookRecords] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BookRecords', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'关联Id，记录通过该Id关联' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BookRecords', @level2type=N'COLUMN',@level2name=N'RelevanceId'
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
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BookRecords', @level2type=N'COLUMN',@level2name=N'Describe'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'部门Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BookRecords', @level2type=N'COLUMN',@level2name=N'DepartmentId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'联系电话' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BookRecords', @level2type=N'COLUMN',@level2name=N'Tel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BookRecords', @level2type=N'COLUMN',@level2name=N'Creator'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人的电脑IP' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BookRecords', @level2type=N'COLUMN',@level2name=N'OperateComputerIP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BookRecords', @level2type=N'COLUMN',@level2name=N'DateCreated'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BookRecords', @level2type=N'COLUMN',@level2name=N'Modifier'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BookRecords', @level2type=N'COLUMN',@level2name=N'DateModified'
GO
/****** Object:  ForeignKey [FK_BookObject_BookObjectType]    Script Date: 12/26/2012 14:33:45 ******/
ALTER TABLE [dbo].[BookObject]  WITH CHECK ADD  CONSTRAINT [FK_BookObject_BookObjectType] FOREIGN KEY([BookObjectTypeId])
REFERENCES [dbo].[BookObjectType] ([Id])
GO
ALTER TABLE [dbo].[BookObject] CHECK CONSTRAINT [FK_BookObject_BookObjectType]
GO
/****** Object:  ForeignKey [FK_BookObject_ObjectStyle]    Script Date: 12/26/2012 14:33:45 ******/
ALTER TABLE [dbo].[BookObject]  WITH CHECK ADD  CONSTRAINT [FK_BookObject_ObjectStyle] FOREIGN KEY([ObjectStyleId])
REFERENCES [dbo].[ObjectStyle] ([Id])
GO
ALTER TABLE [dbo].[BookObject] CHECK CONSTRAINT [FK_BookObject_ObjectStyle]
GO
/****** Object:  ForeignKey [FK_BookRecords_BookObject]    Script Date: 12/26/2012 14:33:45 ******/
ALTER TABLE [dbo].[BookRecords]  WITH CHECK ADD  CONSTRAINT [FK_BookRecords_BookObject] FOREIGN KEY([BookObjectId])
REFERENCES [dbo].[BookObject] ([Id])
GO
ALTER TABLE [dbo].[BookRecords] CHECK CONSTRAINT [FK_BookRecords_BookObject]
GO
/****** Object:  ForeignKey [FK_BookRecords_Departments]    Script Date: 12/26/2012 14:33:45 ******/
ALTER TABLE [dbo].[BookRecords]  WITH CHECK ADD  CONSTRAINT [FK_BookRecords_Departments] FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[Departments] ([Id])
GO
ALTER TABLE [dbo].[BookRecords] CHECK CONSTRAINT [FK_BookRecords_Departments]
GO
