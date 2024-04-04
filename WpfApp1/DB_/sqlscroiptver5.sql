USE [master]
GO
/****** Object:  Database [i_kak_message_ver4]    Script Date: 04-Apr-24 6:14:23 PM ******/
CREATE DATABASE [i_kak_message_ver4]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'i_kak_message_ver4', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\i_kak_message_ver4.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'i_kak_message_ver4_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\i_kak_message_ver4_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [i_kak_message_ver4] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [i_kak_message_ver4].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [i_kak_message_ver4] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [i_kak_message_ver4] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [i_kak_message_ver4] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [i_kak_message_ver4] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [i_kak_message_ver4] SET ARITHABORT OFF 
GO
ALTER DATABASE [i_kak_message_ver4] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [i_kak_message_ver4] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [i_kak_message_ver4] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [i_kak_message_ver4] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [i_kak_message_ver4] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [i_kak_message_ver4] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [i_kak_message_ver4] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [i_kak_message_ver4] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [i_kak_message_ver4] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [i_kak_message_ver4] SET  DISABLE_BROKER 
GO
ALTER DATABASE [i_kak_message_ver4] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [i_kak_message_ver4] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [i_kak_message_ver4] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [i_kak_message_ver4] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [i_kak_message_ver4] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [i_kak_message_ver4] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [i_kak_message_ver4] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [i_kak_message_ver4] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [i_kak_message_ver4] SET  MULTI_USER 
GO
ALTER DATABASE [i_kak_message_ver4] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [i_kak_message_ver4] SET DB_CHAINING OFF 
GO
ALTER DATABASE [i_kak_message_ver4] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [i_kak_message_ver4] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [i_kak_message_ver4] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [i_kak_message_ver4] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [i_kak_message_ver4] SET QUERY_STORE = ON
GO
ALTER DATABASE [i_kak_message_ver4] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [i_kak_message_ver4]
GO
/****** Object:  Table [dbo].[Attachments]    Script Date: 04-Apr-24 6:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Attachments](
	[AttachmentID] [int] IDENTITY(1,1) NOT NULL,
	[MessageID] [int] NULL,
	[FileName] [nvarchar](100) NOT NULL,
	[FileData] [varbinary](max) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AttachmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ConversationParticipants]    Script Date: 04-Apr-24 6:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConversationParticipants](
	[ParticipantID] [int] IDENTITY(1,1) NOT NULL,
	[ConversationID] [int] NULL,
	[UserID] [int] NULL,
	[JoinedDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ParticipantID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Conversations]    Script Date: 04-Apr-24 6:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Conversations](
	[ConversationID] [int] IDENTITY(1,1) NOT NULL,
	[ConversationName] [nvarchar](100) NOT NULL,
	[ConversationType] [char](1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ConversationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Messages]    Script Date: 04-Apr-24 6:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Messages](
	[MessageID] [int] IDENTITY(1,1) NOT NULL,
	[SenderID] [int] NULL,
	[ConversationID] [int] NULL,
	[MessageText] [nvarchar](max) NOT NULL,
	[SentDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MessageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NoteCategories]    Script Date: 04-Apr-24 6:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NoteCategories](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NoteCategoryMap]    Script Date: 04-Apr-24 6:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NoteCategoryMap](
	[MapID] [int] IDENTITY(1,1) NOT NULL,
	[NoteID] [int] NULL,
	[CategoryID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MapID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notes]    Script Date: 04-Apr-24 6:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notes](
	[NoteID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NULL,
	[NoteText] [nvarchar](max) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[NoteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notifications]    Script Date: 04-Apr-24 6:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notifications](
	[NotificationID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NULL,
	[NotificationType] [char](1) NOT NULL,
	[NotificationText] [nvarchar](max) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[IsRead] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[NotificationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaskCategories]    Script Date: 04-Apr-24 6:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaskCategories](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaskCategoryMap]    Script Date: 04-Apr-24 6:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaskCategoryMap](
	[MapID] [int] IDENTITY(1,1) NOT NULL,
	[TaskID] [int] NULL,
	[CategoryID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MapID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tasks]    Script Date: 04-Apr-24 6:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tasks](
	[TaskID] [int] IDENTITY(1,1) NOT NULL,
	[AssignedToID] [int] NULL,
	[AssignedByID] [int] NULL,
	[TaskDescription] [nvarchar](max) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[DueDate] [datetime] NULL,
	[Status] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TaskID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 04-Apr-24 6:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](100) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[RegistrationDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Attachments] ON 

INSERT [dbo].[Attachments] ([AttachmentID], [MessageID], [FileName], [FileData]) VALUES (1, 1, N'image1.jpg', 0x89504E470D0A1A0A0000000000000000)
INSERT [dbo].[Attachments] ([AttachmentID], [MessageID], [FileName], [FileData]) VALUES (2, 2, N'document1.pdf', 0x25504446010000000000000000000000)
INSERT [dbo].[Attachments] ([AttachmentID], [MessageID], [FileName], [FileData]) VALUES (3, 5, N'image2.png', 0x89504E470D0A1A0A0000000000000000)
INSERT [dbo].[Attachments] ([AttachmentID], [MessageID], [FileName], [FileData]) VALUES (4, 8, N'presentation1.pptx', 0xD0CF11E0A1B11AE10000000000000000)
INSERT [dbo].[Attachments] ([AttachmentID], [MessageID], [FileName], [FileData]) VALUES (5, 10, N'image3.jpg', 0x89504E470D0A1A0A0000000000000000)
INSERT [dbo].[Attachments] ([AttachmentID], [MessageID], [FileName], [FileData]) VALUES (6, 1, N'image1.jpg', 0x89504E470D0A1A0A0000000000000000)
INSERT [dbo].[Attachments] ([AttachmentID], [MessageID], [FileName], [FileData]) VALUES (7, 2, N'document1.pdf', 0x25504446010000000000000000000000)
INSERT [dbo].[Attachments] ([AttachmentID], [MessageID], [FileName], [FileData]) VALUES (8, 5, N'image2.png', 0x89504E470D0A1A0A0000000000000000)
INSERT [dbo].[Attachments] ([AttachmentID], [MessageID], [FileName], [FileData]) VALUES (9, 8, N'presentation1.pptx', 0xD0CF11E0A1B11AE10000000000000000)
INSERT [dbo].[Attachments] ([AttachmentID], [MessageID], [FileName], [FileData]) VALUES (10, 10, N'image3.jpg', 0x89504E470D0A1A0A0000000000000000)
INSERT [dbo].[Attachments] ([AttachmentID], [MessageID], [FileName], [FileData]) VALUES (11, 1, N'image1.jpg', 0x89504E470D0A1A0A0000000000000000)
INSERT [dbo].[Attachments] ([AttachmentID], [MessageID], [FileName], [FileData]) VALUES (12, 2, N'document1.pdf', 0x25504446010000000000000000000000)
INSERT [dbo].[Attachments] ([AttachmentID], [MessageID], [FileName], [FileData]) VALUES (13, 5, N'image2.png', 0x89504E470D0A1A0A0000000000000000)
INSERT [dbo].[Attachments] ([AttachmentID], [MessageID], [FileName], [FileData]) VALUES (14, 8, N'presentation1.pptx', 0xD0CF11E0A1B11AE10000000000000000)
INSERT [dbo].[Attachments] ([AttachmentID], [MessageID], [FileName], [FileData]) VALUES (15, 10, N'image3.jpg', 0x89504E470D0A1A0A0000000000000000)
SET IDENTITY_INSERT [dbo].[Attachments] OFF
GO
SET IDENTITY_INSERT [dbo].[ConversationParticipants] ON 

INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (1, 1, 1, CAST(N'2024-03-11T12:07:37.603' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (2, 1, 2, CAST(N'2024-03-11T12:07:37.603' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (3, 2, 1, CAST(N'2024-03-11T12:07:37.603' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (4, 2, 2, CAST(N'2024-03-11T12:07:37.603' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (5, 2, 3, CAST(N'2024-03-11T12:07:37.603' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (6, 3, 1, CAST(N'2024-03-11T12:07:37.603' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (7, 3, 3, CAST(N'2024-03-11T12:07:37.603' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (8, 4, 2, CAST(N'2024-03-11T12:07:37.603' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (9, 4, 3, CAST(N'2024-03-11T12:07:37.603' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (10, 4, 4, CAST(N'2024-03-11T12:07:37.603' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (11, 5, 1, CAST(N'2024-03-11T12:07:37.603' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (12, 5, 4, CAST(N'2024-03-11T12:07:37.603' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (13, 6, 2, CAST(N'2024-03-11T12:07:37.603' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (14, 6, 3, CAST(N'2024-03-11T12:07:37.603' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (15, 6, 4, CAST(N'2024-03-11T12:07:37.603' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (16, 6, 5, CAST(N'2024-03-11T12:07:37.603' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (17, 7, 1, CAST(N'2024-03-11T12:07:37.603' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (18, 7, 5, CAST(N'2024-03-11T12:07:37.603' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (19, 8, 3, CAST(N'2024-03-11T12:07:37.603' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (20, 8, 4, CAST(N'2024-03-11T12:07:37.603' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (21, 8, 5, CAST(N'2024-03-11T12:07:37.603' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (22, 8, 6, CAST(N'2024-03-11T12:07:37.603' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (23, 9, 1, CAST(N'2024-03-11T12:07:37.603' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (24, 9, 6, CAST(N'2024-03-11T12:07:37.603' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (25, 10, 4, CAST(N'2024-03-11T12:07:37.603' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (26, 10, 5, CAST(N'2024-03-11T12:07:37.603' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (27, 10, 6, CAST(N'2024-03-11T12:07:37.603' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (28, 10, 7, CAST(N'2024-03-11T12:07:37.603' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (29, 1, 1, CAST(N'2024-03-11T12:07:37.903' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (30, 1, 2, CAST(N'2024-03-11T12:07:37.903' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (31, 2, 1, CAST(N'2024-03-11T12:07:37.903' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (32, 2, 2, CAST(N'2024-03-11T12:07:37.903' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (33, 2, 3, CAST(N'2024-03-11T12:07:37.903' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (34, 3, 1, CAST(N'2024-03-11T12:07:37.903' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (35, 3, 3, CAST(N'2024-03-11T12:07:37.903' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (36, 4, 2, CAST(N'2024-03-11T12:07:37.903' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (37, 4, 3, CAST(N'2024-03-11T12:07:37.903' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (38, 4, 4, CAST(N'2024-03-11T12:07:37.903' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (39, 5, 1, CAST(N'2024-03-11T12:07:37.903' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (40, 5, 4, CAST(N'2024-03-11T12:07:37.903' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (41, 6, 2, CAST(N'2024-03-11T12:07:37.903' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (42, 6, 3, CAST(N'2024-03-11T12:07:37.903' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (43, 6, 4, CAST(N'2024-03-11T12:07:37.903' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (44, 6, 5, CAST(N'2024-03-11T12:07:37.903' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (45, 7, 1, CAST(N'2024-03-11T12:07:37.903' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (46, 7, 5, CAST(N'2024-03-11T12:07:37.903' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (47, 8, 3, CAST(N'2024-03-11T12:07:37.903' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (48, 8, 4, CAST(N'2024-03-11T12:07:37.903' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (49, 8, 5, CAST(N'2024-03-11T12:07:37.903' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (50, 8, 6, CAST(N'2024-03-11T12:07:37.903' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (51, 9, 1, CAST(N'2024-03-11T12:07:37.903' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (52, 9, 6, CAST(N'2024-03-11T12:07:37.903' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (53, 10, 4, CAST(N'2024-03-11T12:07:37.903' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (54, 10, 5, CAST(N'2024-03-11T12:07:37.903' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (55, 10, 6, CAST(N'2024-03-11T12:07:37.903' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (56, 10, 7, CAST(N'2024-03-11T12:07:37.903' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (57, 1, 1, CAST(N'2024-03-11T12:07:39.277' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (58, 1, 2, CAST(N'2024-03-11T12:07:39.277' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (59, 2, 1, CAST(N'2024-03-11T12:07:39.277' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (60, 2, 2, CAST(N'2024-03-11T12:07:39.277' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (61, 2, 3, CAST(N'2024-03-11T12:07:39.277' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (62, 3, 1, CAST(N'2024-03-11T12:07:39.277' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (63, 3, 3, CAST(N'2024-03-11T12:07:39.277' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (64, 4, 2, CAST(N'2024-03-11T12:07:39.277' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (65, 4, 3, CAST(N'2024-03-11T12:07:39.277' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (66, 4, 4, CAST(N'2024-03-11T12:07:39.277' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (67, 5, 1, CAST(N'2024-03-11T12:07:39.277' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (68, 5, 4, CAST(N'2024-03-11T12:07:39.277' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (69, 6, 2, CAST(N'2024-03-11T12:07:39.277' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (70, 6, 3, CAST(N'2024-03-11T12:07:39.277' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (71, 6, 4, CAST(N'2024-03-11T12:07:39.277' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (72, 6, 5, CAST(N'2024-03-11T12:07:39.277' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (73, 7, 1, CAST(N'2024-03-11T12:07:39.277' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (74, 7, 5, CAST(N'2024-03-11T12:07:39.277' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (75, 8, 3, CAST(N'2024-03-11T12:07:39.277' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (76, 8, 4, CAST(N'2024-03-11T12:07:39.277' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (77, 8, 5, CAST(N'2024-03-11T12:07:39.277' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (78, 8, 6, CAST(N'2024-03-11T12:07:39.277' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (79, 9, 1, CAST(N'2024-03-11T12:07:39.277' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (80, 9, 6, CAST(N'2024-03-11T12:07:39.277' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (81, 10, 4, CAST(N'2024-03-11T12:07:39.277' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (82, 10, 5, CAST(N'2024-03-11T12:07:39.277' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (83, 10, 6, CAST(N'2024-03-11T12:07:39.277' AS DateTime))
INSERT [dbo].[ConversationParticipants] ([ParticipantID], [ConversationID], [UserID], [JoinedDate]) VALUES (84, 10, 7, CAST(N'2024-03-11T12:07:39.277' AS DateTime))
SET IDENTITY_INSERT [dbo].[ConversationParticipants] OFF
GO
SET IDENTITY_INSERT [dbo].[Conversations] ON 

INSERT [dbo].[Conversations] ([ConversationID], [ConversationName], [ConversationType]) VALUES (1, N'Conversation 1', N'P')
INSERT [dbo].[Conversations] ([ConversationID], [ConversationName], [ConversationType]) VALUES (2, N'Conversation 2', N'G')
INSERT [dbo].[Conversations] ([ConversationID], [ConversationName], [ConversationType]) VALUES (3, N'Conversation 3', N'P')
INSERT [dbo].[Conversations] ([ConversationID], [ConversationName], [ConversationType]) VALUES (4, N'Conversation 4', N'G')
INSERT [dbo].[Conversations] ([ConversationID], [ConversationName], [ConversationType]) VALUES (5, N'Conversation 5', N'P')
INSERT [dbo].[Conversations] ([ConversationID], [ConversationName], [ConversationType]) VALUES (6, N'Conversation 6', N'G')
INSERT [dbo].[Conversations] ([ConversationID], [ConversationName], [ConversationType]) VALUES (7, N'Conversation 7', N'P')
INSERT [dbo].[Conversations] ([ConversationID], [ConversationName], [ConversationType]) VALUES (8, N'Conversation 8', N'G')
INSERT [dbo].[Conversations] ([ConversationID], [ConversationName], [ConversationType]) VALUES (9, N'Conversation 9', N'P')
INSERT [dbo].[Conversations] ([ConversationID], [ConversationName], [ConversationType]) VALUES (10, N'Conversation 10', N'G')
INSERT [dbo].[Conversations] ([ConversationID], [ConversationName], [ConversationType]) VALUES (11, N'Conversation 1', N'P')
INSERT [dbo].[Conversations] ([ConversationID], [ConversationName], [ConversationType]) VALUES (12, N'Conversation 2', N'G')
INSERT [dbo].[Conversations] ([ConversationID], [ConversationName], [ConversationType]) VALUES (13, N'Conversation 3', N'P')
INSERT [dbo].[Conversations] ([ConversationID], [ConversationName], [ConversationType]) VALUES (14, N'Conversation 4', N'G')
INSERT [dbo].[Conversations] ([ConversationID], [ConversationName], [ConversationType]) VALUES (15, N'Conversation 5', N'P')
INSERT [dbo].[Conversations] ([ConversationID], [ConversationName], [ConversationType]) VALUES (16, N'Conversation 6', N'G')
INSERT [dbo].[Conversations] ([ConversationID], [ConversationName], [ConversationType]) VALUES (17, N'Conversation 7', N'P')
INSERT [dbo].[Conversations] ([ConversationID], [ConversationName], [ConversationType]) VALUES (18, N'Conversation 8', N'G')
INSERT [dbo].[Conversations] ([ConversationID], [ConversationName], [ConversationType]) VALUES (19, N'Conversation 9', N'P')
INSERT [dbo].[Conversations] ([ConversationID], [ConversationName], [ConversationType]) VALUES (20, N'Conversation 10', N'G')
INSERT [dbo].[Conversations] ([ConversationID], [ConversationName], [ConversationType]) VALUES (21, N'Conversation 1', N'P')
INSERT [dbo].[Conversations] ([ConversationID], [ConversationName], [ConversationType]) VALUES (22, N'Conversation 2', N'G')
INSERT [dbo].[Conversations] ([ConversationID], [ConversationName], [ConversationType]) VALUES (23, N'Conversation 3', N'P')
INSERT [dbo].[Conversations] ([ConversationID], [ConversationName], [ConversationType]) VALUES (24, N'Conversation 4', N'G')
INSERT [dbo].[Conversations] ([ConversationID], [ConversationName], [ConversationType]) VALUES (25, N'Conversation 5', N'P')
INSERT [dbo].[Conversations] ([ConversationID], [ConversationName], [ConversationType]) VALUES (26, N'Conversation 6', N'G')
INSERT [dbo].[Conversations] ([ConversationID], [ConversationName], [ConversationType]) VALUES (27, N'Conversation 7', N'P')
INSERT [dbo].[Conversations] ([ConversationID], [ConversationName], [ConversationType]) VALUES (28, N'Conversation 8', N'G')
INSERT [dbo].[Conversations] ([ConversationID], [ConversationName], [ConversationType]) VALUES (29, N'Conversation 9', N'P')
INSERT [dbo].[Conversations] ([ConversationID], [ConversationName], [ConversationType]) VALUES (30, N'Conversation 10', N'G')
SET IDENTITY_INSERT [dbo].[Conversations] OFF
GO
SET IDENTITY_INSERT [dbo].[Messages] ON 

INSERT [dbo].[Messages] ([MessageID], [SenderID], [ConversationID], [MessageText], [SentDate]) VALUES (1, 1, 1, N'Здравствуйте!', CAST(N'2024-03-11T12:07:37.603' AS DateTime))
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ConversationID], [MessageText], [SentDate]) VALUES (2, 2, 1, N'Привет!', CAST(N'2024-03-11T12:07:37.603' AS DateTime))
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ConversationID], [MessageText], [SentDate]) VALUES (3, 1, 1, N'Как дела?', CAST(N'2024-03-11T12:07:37.603' AS DateTime))
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ConversationID], [MessageText], [SentDate]) VALUES (4, 2, 1, N'Я в порядке, спасибо.', CAST(N'2024-03-11T12:07:37.603' AS DateTime))
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ConversationID], [MessageText], [SentDate]) VALUES (5, 1, 2, N'Давайте обсудим проект.', CAST(N'2024-03-11T12:07:37.603' AS DateTime))
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ConversationID], [MessageText], [SentDate]) VALUES (6, 2, 2, N'Конечно, что у вас на уме?', CAST(N'2024-03-11T12:07:37.603' AS DateTime))
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ConversationID], [MessageText], [SentDate]) VALUES (7, 3, 2, N'Я могу помочь с дизайном.', CAST(N'2024-03-11T12:07:37.603' AS DateTime))
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ConversationID], [MessageText], [SentDate]) VALUES (8, 1, 3, N'Мне нужно спланировать свои выходные.', CAST(N'2024-03-11T12:07:37.603' AS DateTime))
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ConversationID], [MessageText], [SentDate]) VALUES (9, 3, 3, N'Какие-нибудь веселые мероприятия планируются?', CAST(N'2024-03-11T12:07:37.603' AS DateTime))
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ConversationID], [MessageText], [SentDate]) VALUES (10, 2, 4, N'Мы должны организовать мероприятие по сплочению коллектива.', CAST(N'2024-03-11T12:07:37.603' AS DateTime))
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ConversationID], [MessageText], [SentDate]) VALUES (11, 3, 4, N'Отличная идея!', CAST(N'2024-03-11T12:07:37.603' AS DateTime))
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ConversationID], [MessageText], [SentDate]) VALUES (12, 4, 4, N'Я рассмотрю несколько вариантов.', CAST(N'2024-03-11T12:07:37.603' AS DateTime))
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ConversationID], [MessageText], [SentDate]) VALUES (13, 1, 1, N'Здравствуйте!', CAST(N'2024-03-11T12:07:37.907' AS DateTime))
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ConversationID], [MessageText], [SentDate]) VALUES (14, 2, 1, N'Привет!', CAST(N'2024-03-11T12:07:37.907' AS DateTime))
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ConversationID], [MessageText], [SentDate]) VALUES (15, 1, 1, N'Как дела?', CAST(N'2024-03-11T12:07:37.907' AS DateTime))
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ConversationID], [MessageText], [SentDate]) VALUES (16, 2, 1, N'Я в порядке, спасибо.', CAST(N'2024-03-11T12:07:37.907' AS DateTime))
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ConversationID], [MessageText], [SentDate]) VALUES (17, 1, 2, N'Давайте обсудим проект.', CAST(N'2024-03-11T12:07:37.907' AS DateTime))
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ConversationID], [MessageText], [SentDate]) VALUES (18, 2, 2, N'Конечно, что у вас на уме?', CAST(N'2024-03-11T12:07:37.907' AS DateTime))
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ConversationID], [MessageText], [SentDate]) VALUES (19, 3, 2, N'Я могу помочь с дизайном.', CAST(N'2024-03-11T12:07:37.907' AS DateTime))
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ConversationID], [MessageText], [SentDate]) VALUES (20, 1, 3, N'Мне нужно спланировать свои выходные.', CAST(N'2024-03-11T12:07:37.907' AS DateTime))
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ConversationID], [MessageText], [SentDate]) VALUES (21, 3, 3, N'Какие-нибудь веселые мероприятия планируются?', CAST(N'2024-03-11T12:07:37.907' AS DateTime))
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ConversationID], [MessageText], [SentDate]) VALUES (22, 2, 4, N'Мы должны организовать мероприятие по сплочению коллектива.', CAST(N'2024-03-11T12:07:37.907' AS DateTime))
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ConversationID], [MessageText], [SentDate]) VALUES (23, 3, 4, N'Отличная идея!', CAST(N'2024-03-11T12:07:37.907' AS DateTime))
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ConversationID], [MessageText], [SentDate]) VALUES (24, 4, 4, N'Я рассмотрю несколько вариантов.', CAST(N'2024-03-11T12:07:37.907' AS DateTime))
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ConversationID], [MessageText], [SentDate]) VALUES (25, 1, 1, N'Здравствуйте!', CAST(N'2024-03-11T12:07:39.280' AS DateTime))
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ConversationID], [MessageText], [SentDate]) VALUES (26, 2, 1, N'Привет!', CAST(N'2024-03-11T12:07:39.280' AS DateTime))
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ConversationID], [MessageText], [SentDate]) VALUES (27, 1, 1, N'Как дела?', CAST(N'2024-03-11T12:07:39.280' AS DateTime))
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ConversationID], [MessageText], [SentDate]) VALUES (28, 2, 1, N'Я в порядке, спасибо.', CAST(N'2024-03-11T12:07:39.280' AS DateTime))
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ConversationID], [MessageText], [SentDate]) VALUES (29, 1, 2, N'Давайте обсудим проект.', CAST(N'2024-03-11T12:07:39.280' AS DateTime))
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ConversationID], [MessageText], [SentDate]) VALUES (30, 2, 2, N'Конечно, что у вас на уме?', CAST(N'2024-03-11T12:07:39.280' AS DateTime))
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ConversationID], [MessageText], [SentDate]) VALUES (31, 3, 2, N'Я могу помочь с дизайном.', CAST(N'2024-03-11T12:07:39.280' AS DateTime))
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ConversationID], [MessageText], [SentDate]) VALUES (32, 1, 3, N'Мне нужно спланировать свои выходные.', CAST(N'2024-03-11T12:07:39.280' AS DateTime))
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ConversationID], [MessageText], [SentDate]) VALUES (33, 3, 3, N'Какие-нибудь веселые мероприятия планируются?', CAST(N'2024-03-11T12:07:39.280' AS DateTime))
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ConversationID], [MessageText], [SentDate]) VALUES (34, 2, 4, N'Мы должны организовать мероприятие по сплочению коллектива.', CAST(N'2024-03-11T12:07:39.280' AS DateTime))
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ConversationID], [MessageText], [SentDate]) VALUES (35, 3, 4, N'Отличная идея!', CAST(N'2024-03-11T12:07:39.280' AS DateTime))
INSERT [dbo].[Messages] ([MessageID], [SenderID], [ConversationID], [MessageText], [SentDate]) VALUES (36, 4, 4, N'Я рассмотрю несколько вариантов.', CAST(N'2024-03-11T12:07:39.280' AS DateTime))
SET IDENTITY_INSERT [dbo].[Messages] OFF
GO
SET IDENTITY_INSERT [dbo].[NoteCategories] ON 

INSERT [dbo].[NoteCategories] ([CategoryID], [CategoryName]) VALUES (5, N'Здоровье')
INSERT [dbo].[NoteCategories] ([CategoryID], [CategoryName]) VALUES (3, N'Исследование')
INSERT [dbo].[NoteCategories] ([CategoryID], [CategoryName]) VALUES (1, N'Личный')
INSERT [dbo].[NoteCategories] ([CategoryID], [CategoryName]) VALUES (9, N'Производительность')
INSERT [dbo].[NoteCategories] ([CategoryID], [CategoryName]) VALUES (4, N'Путешествие')
INSERT [dbo].[NoteCategories] ([CategoryID], [CategoryName]) VALUES (2, N'Работа')
INSERT [dbo].[NoteCategories] ([CategoryID], [CategoryName]) VALUES (10, N'Развлечения')
INSERT [dbo].[NoteCategories] ([CategoryID], [CategoryName]) VALUES (7, N'Семья')
INSERT [dbo].[NoteCategories] ([CategoryID], [CategoryName]) VALUES (8, N'Финансы')
INSERT [dbo].[NoteCategories] ([CategoryID], [CategoryName]) VALUES (6, N'Хобби')
SET IDENTITY_INSERT [dbo].[NoteCategories] OFF
GO
SET IDENTITY_INSERT [dbo].[NoteCategoryMap] ON 

INSERT [dbo].[NoteCategoryMap] ([MapID], [NoteID], [CategoryID]) VALUES (1, 1, 1)
INSERT [dbo].[NoteCategoryMap] ([MapID], [NoteID], [CategoryID]) VALUES (2, 2, 3)
INSERT [dbo].[NoteCategoryMap] ([MapID], [NoteID], [CategoryID]) VALUES (3, 3, 7)
INSERT [dbo].[NoteCategoryMap] ([MapID], [NoteID], [CategoryID]) VALUES (4, 4, 4)
INSERT [dbo].[NoteCategoryMap] ([MapID], [NoteID], [CategoryID]) VALUES (5, 5, 2)
INSERT [dbo].[NoteCategoryMap] ([MapID], [NoteID], [CategoryID]) VALUES (6, 6, 9)
INSERT [dbo].[NoteCategoryMap] ([MapID], [NoteID], [CategoryID]) VALUES (7, 7, 5)
INSERT [dbo].[NoteCategoryMap] ([MapID], [NoteID], [CategoryID]) VALUES (8, 8, 2)
INSERT [dbo].[NoteCategoryMap] ([MapID], [NoteID], [CategoryID]) VALUES (9, 9, 1)
INSERT [dbo].[NoteCategoryMap] ([MapID], [NoteID], [CategoryID]) VALUES (10, 10, 6)
INSERT [dbo].[NoteCategoryMap] ([MapID], [NoteID], [CategoryID]) VALUES (11, 1, 1)
INSERT [dbo].[NoteCategoryMap] ([MapID], [NoteID], [CategoryID]) VALUES (12, 2, 3)
INSERT [dbo].[NoteCategoryMap] ([MapID], [NoteID], [CategoryID]) VALUES (13, 3, 7)
INSERT [dbo].[NoteCategoryMap] ([MapID], [NoteID], [CategoryID]) VALUES (14, 4, 4)
INSERT [dbo].[NoteCategoryMap] ([MapID], [NoteID], [CategoryID]) VALUES (15, 5, 2)
INSERT [dbo].[NoteCategoryMap] ([MapID], [NoteID], [CategoryID]) VALUES (16, 6, 9)
INSERT [dbo].[NoteCategoryMap] ([MapID], [NoteID], [CategoryID]) VALUES (17, 7, 5)
INSERT [dbo].[NoteCategoryMap] ([MapID], [NoteID], [CategoryID]) VALUES (18, 8, 2)
INSERT [dbo].[NoteCategoryMap] ([MapID], [NoteID], [CategoryID]) VALUES (19, 9, 1)
INSERT [dbo].[NoteCategoryMap] ([MapID], [NoteID], [CategoryID]) VALUES (20, 10, 6)
INSERT [dbo].[NoteCategoryMap] ([MapID], [NoteID], [CategoryID]) VALUES (21, 1, 1)
INSERT [dbo].[NoteCategoryMap] ([MapID], [NoteID], [CategoryID]) VALUES (22, 2, 3)
INSERT [dbo].[NoteCategoryMap] ([MapID], [NoteID], [CategoryID]) VALUES (23, 3, 7)
INSERT [dbo].[NoteCategoryMap] ([MapID], [NoteID], [CategoryID]) VALUES (24, 4, 4)
INSERT [dbo].[NoteCategoryMap] ([MapID], [NoteID], [CategoryID]) VALUES (25, 5, 2)
INSERT [dbo].[NoteCategoryMap] ([MapID], [NoteID], [CategoryID]) VALUES (26, 6, 9)
INSERT [dbo].[NoteCategoryMap] ([MapID], [NoteID], [CategoryID]) VALUES (27, 7, 5)
INSERT [dbo].[NoteCategoryMap] ([MapID], [NoteID], [CategoryID]) VALUES (28, 8, 2)
INSERT [dbo].[NoteCategoryMap] ([MapID], [NoteID], [CategoryID]) VALUES (29, 9, 1)
INSERT [dbo].[NoteCategoryMap] ([MapID], [NoteID], [CategoryID]) VALUES (30, 10, 6)
SET IDENTITY_INSERT [dbo].[NoteCategoryMap] OFF
GO
SET IDENTITY_INSERT [dbo].[Notes] ON 

INSERT [dbo].[Notes] ([NoteID], [UserID], [NoteText], [CreatedDate]) VALUES (1, 1, N'Не забудьте купить продукты.', CAST(N'2024-03-11T12:07:37.610' AS DateTime))
INSERT [dbo].[Notes] ([NoteID], [UserID], [NoteText], [CreatedDate]) VALUES (2, 2, N'Готовьтесь к экзамену на следующей неделе.', CAST(N'2024-03-11T12:07:37.610' AS DateTime))
INSERT [dbo].[Notes] ([NoteID], [UserID], [NoteText], [CreatedDate]) VALUES (3, 3, N'Позвоните маме в день ее рождения.', CAST(N'2024-03-11T12:07:37.610' AS DateTime))
INSERT [dbo].[Notes] ([NoteID], [UserID], [NoteText], [CreatedDate]) VALUES (4, 4, N'Запланируйте поездку на выходные.', CAST(N'2024-03-11T12:07:37.610' AS DateTime))
INSERT [dbo].[Notes] ([NoteID], [UserID], [NoteText], [CreatedDate]) VALUES (5, 5, N'Последующие действия с клиентом.', CAST(N'2024-03-11T12:07:37.610' AS DateTime))
INSERT [dbo].[Notes] ([NoteID], [UserID], [NoteText], [CreatedDate]) VALUES (6, 1, N'Прочитайте новую книгу о продуктивности.', CAST(N'2024-03-11T12:07:37.610' AS DateTime))
INSERT [dbo].[Notes] ([NoteID], [UserID], [NoteText], [CreatedDate]) VALUES (7, 2, N'Запланируйте визит к врачу.', CAST(N'2024-03-11T12:07:37.610' AS DateTime))
INSERT [dbo].[Notes] ([NoteID], [UserID], [NoteText], [CreatedDate]) VALUES (8, 3, N'Подготовьтесь к презентации.', CAST(N'2024-03-11T12:07:37.610' AS DateTime))
INSERT [dbo].[Notes] ([NoteID], [UserID], [NoteText], [CreatedDate]) VALUES (9, 4, N'Организуйте домашний офис.', CAST(N'2024-03-11T12:07:37.610' AS DateTime))
INSERT [dbo].[Notes] ([NoteID], [UserID], [NoteText], [CreatedDate]) VALUES (10, 5, N'Изучите новые идеи для хобби.', CAST(N'2024-03-11T12:07:37.610' AS DateTime))
INSERT [dbo].[Notes] ([NoteID], [UserID], [NoteText], [CreatedDate]) VALUES (11, 1, N'Не забудьте купить продукты.', CAST(N'2024-03-11T12:07:37.907' AS DateTime))
INSERT [dbo].[Notes] ([NoteID], [UserID], [NoteText], [CreatedDate]) VALUES (12, 2, N'Готовьтесь к экзамену на следующей неделе.', CAST(N'2024-03-11T12:07:37.907' AS DateTime))
INSERT [dbo].[Notes] ([NoteID], [UserID], [NoteText], [CreatedDate]) VALUES (13, 3, N'Позвоните маме в день ее рождения.', CAST(N'2024-03-11T12:07:37.907' AS DateTime))
INSERT [dbo].[Notes] ([NoteID], [UserID], [NoteText], [CreatedDate]) VALUES (14, 4, N'Запланируйте поездку на выходные.', CAST(N'2024-03-11T12:07:37.907' AS DateTime))
INSERT [dbo].[Notes] ([NoteID], [UserID], [NoteText], [CreatedDate]) VALUES (15, 5, N'Последующие действия с клиентом.', CAST(N'2024-03-11T12:07:37.907' AS DateTime))
INSERT [dbo].[Notes] ([NoteID], [UserID], [NoteText], [CreatedDate]) VALUES (16, 1, N'Прочитайте новую книгу о продуктивности.', CAST(N'2024-03-11T12:07:37.907' AS DateTime))
INSERT [dbo].[Notes] ([NoteID], [UserID], [NoteText], [CreatedDate]) VALUES (17, 2, N'Запланируйте визит к врачу.', CAST(N'2024-03-11T12:07:37.907' AS DateTime))
INSERT [dbo].[Notes] ([NoteID], [UserID], [NoteText], [CreatedDate]) VALUES (18, 3, N'Подготовьтесь к презентации.', CAST(N'2024-03-11T12:07:37.907' AS DateTime))
INSERT [dbo].[Notes] ([NoteID], [UserID], [NoteText], [CreatedDate]) VALUES (19, 4, N'Организуйте домашний офис.', CAST(N'2024-03-11T12:07:37.907' AS DateTime))
INSERT [dbo].[Notes] ([NoteID], [UserID], [NoteText], [CreatedDate]) VALUES (20, 5, N'Изучите новые идеи для хобби.', CAST(N'2024-03-11T12:07:37.907' AS DateTime))
INSERT [dbo].[Notes] ([NoteID], [UserID], [NoteText], [CreatedDate]) VALUES (21, 1, N'Не забудьте купить продукты.', CAST(N'2024-03-11T12:07:39.280' AS DateTime))
INSERT [dbo].[Notes] ([NoteID], [UserID], [NoteText], [CreatedDate]) VALUES (22, 2, N'Готовьтесь к экзамену на следующей неделе.', CAST(N'2024-03-11T12:07:39.280' AS DateTime))
INSERT [dbo].[Notes] ([NoteID], [UserID], [NoteText], [CreatedDate]) VALUES (23, 3, N'Позвоните маме в день ее рождения.', CAST(N'2024-03-11T12:07:39.280' AS DateTime))
INSERT [dbo].[Notes] ([NoteID], [UserID], [NoteText], [CreatedDate]) VALUES (24, 4, N'Запланируйте поездку на выходные.', CAST(N'2024-03-11T12:07:39.280' AS DateTime))
INSERT [dbo].[Notes] ([NoteID], [UserID], [NoteText], [CreatedDate]) VALUES (25, 5, N'Последующие действия с клиентом.', CAST(N'2024-03-11T12:07:39.280' AS DateTime))
INSERT [dbo].[Notes] ([NoteID], [UserID], [NoteText], [CreatedDate]) VALUES (26, 1, N'Прочитайте новую книгу о продуктивности.', CAST(N'2024-03-11T12:07:39.280' AS DateTime))
INSERT [dbo].[Notes] ([NoteID], [UserID], [NoteText], [CreatedDate]) VALUES (27, 2, N'Запланируйте визит к врачу.', CAST(N'2024-03-11T12:07:39.280' AS DateTime))
INSERT [dbo].[Notes] ([NoteID], [UserID], [NoteText], [CreatedDate]) VALUES (28, 3, N'Подготовьтесь к презентации.', CAST(N'2024-03-11T12:07:39.280' AS DateTime))
INSERT [dbo].[Notes] ([NoteID], [UserID], [NoteText], [CreatedDate]) VALUES (29, 4, N'Организуйте домашний офис.', CAST(N'2024-03-11T12:07:39.280' AS DateTime))
INSERT [dbo].[Notes] ([NoteID], [UserID], [NoteText], [CreatedDate]) VALUES (30, 5, N'Изучите новые идеи для хобби.', CAST(N'2024-03-11T12:07:39.280' AS DateTime))
SET IDENTITY_INSERT [dbo].[Notes] OFF
GO
SET IDENTITY_INSERT [dbo].[Notifications] ON 

INSERT [dbo].[Notifications] ([NotificationID], [UserID], [NotificationType], [NotificationText], [CreatedDate], [IsRead]) VALUES (1, 1, N'M', N'У вас есть новое сообщение в Разговор 1', CAST(N'2024-03-11T12:07:37.610' AS DateTime), 0)
INSERT [dbo].[Notifications] ([NotificationID], [UserID], [NotificationType], [NotificationText], [CreatedDate], [IsRead]) VALUES (2, 2, N'T', N'Перед вами поставлена новая задача: Обновить веб-сайт', CAST(N'2024-03-11T12:07:37.610' AS DateTime), 0)
INSERT [dbo].[Notifications] ([NotificationID], [UserID], [NotificationType], [NotificationText], [CreatedDate], [IsRead]) VALUES (3, 3, N'N', N'У вас есть новая заметка: Подготовка к презентации', CAST(N'2024-03-11T12:07:37.610' AS DateTime), 0)
INSERT [dbo].[Notifications] ([NotificationID], [UserID], [NotificationType], [NotificationText], [CreatedDate], [IsRead]) VALUES (4, 4, N'M', N'У вас есть новое сообщение в разделе Разговор 4', CAST(N'2024-03-11T12:07:37.610' AS DateTime), 0)
INSERT [dbo].[Notifications] ([NotificationID], [UserID], [NotificationType], [NotificationText], [CreatedDate], [IsRead]) VALUES (5, 5, N'T', N'Вам назначено новое задание: Внесите улучшения в пользовательский интерфейс', CAST(N'2024-03-11T12:07:37.610' AS DateTime), 0)
INSERT [dbo].[Notifications] ([NotificationID], [UserID], [NotificationType], [NotificationText], [CreatedDate], [IsRead]) VALUES (6, 1, N'N', N'У вас есть новая заметка: прочитайте новую книгу о продуктивности', CAST(N'2024-03-11T12:07:37.610' AS DateTime), 0)
INSERT [dbo].[Notifications] ([NotificationID], [UserID], [NotificationType], [NotificationText], [CreatedDate], [IsRead]) VALUES (7, 2, N'M', N'У вас есть новое сообщение в разделе Разговор 2', CAST(N'2024-03-11T12:07:37.610' AS DateTime), 0)
INSERT [dbo].[Notifications] ([NotificationID], [UserID], [NotificationType], [NotificationText], [CreatedDate], [IsRead]) VALUES (8, 3, N'T', N'Вам поручено новое задание: Создать маркетинговые материалы', CAST(N'2024-03-11T12:07:37.610' AS DateTime), 0)
INSERT [dbo].[Notifications] ([NotificationID], [UserID], [NotificationType], [NotificationText], [CreatedDate], [IsRead]) VALUES (9, 4, N'N', N'У вас есть новая заметка: Организуйте домашний офис', CAST(N'2024-03-11T12:07:37.610' AS DateTime), 0)
INSERT [dbo].[Notifications] ([NotificationID], [UserID], [NotificationType], [NotificationText], [CreatedDate], [IsRead]) VALUES (10, 5, N'M', N'У вас есть новое сообщение в разделе Разговор 6', CAST(N'2024-03-11T12:07:37.610' AS DateTime), 0)
INSERT [dbo].[Notifications] ([NotificationID], [UserID], [NotificationType], [NotificationText], [CreatedDate], [IsRead]) VALUES (11, 1, N'M', N'У вас есть новое сообщение в Разговор 1', CAST(N'2024-03-11T12:07:37.907' AS DateTime), 0)
INSERT [dbo].[Notifications] ([NotificationID], [UserID], [NotificationType], [NotificationText], [CreatedDate], [IsRead]) VALUES (12, 2, N'T', N'Перед вами поставлена новая задача: Обновить веб-сайт', CAST(N'2024-03-11T12:07:37.907' AS DateTime), 0)
INSERT [dbo].[Notifications] ([NotificationID], [UserID], [NotificationType], [NotificationText], [CreatedDate], [IsRead]) VALUES (13, 3, N'N', N'У вас есть новая заметка: Подготовка к презентации', CAST(N'2024-03-11T12:07:37.907' AS DateTime), 0)
INSERT [dbo].[Notifications] ([NotificationID], [UserID], [NotificationType], [NotificationText], [CreatedDate], [IsRead]) VALUES (14, 4, N'M', N'У вас есть новое сообщение в разделе Разговор 4', CAST(N'2024-03-11T12:07:37.907' AS DateTime), 0)
INSERT [dbo].[Notifications] ([NotificationID], [UserID], [NotificationType], [NotificationText], [CreatedDate], [IsRead]) VALUES (15, 5, N'T', N'Вам назначено новое задание: Внесите улучшения в пользовательский интерфейс', CAST(N'2024-03-11T12:07:37.907' AS DateTime), 0)
INSERT [dbo].[Notifications] ([NotificationID], [UserID], [NotificationType], [NotificationText], [CreatedDate], [IsRead]) VALUES (16, 1, N'N', N'У вас есть новая заметка: прочитайте новую книгу о продуктивности', CAST(N'2024-03-11T12:07:37.907' AS DateTime), 0)
INSERT [dbo].[Notifications] ([NotificationID], [UserID], [NotificationType], [NotificationText], [CreatedDate], [IsRead]) VALUES (17, 2, N'M', N'У вас есть новое сообщение в разделе Разговор 2', CAST(N'2024-03-11T12:07:37.907' AS DateTime), 0)
INSERT [dbo].[Notifications] ([NotificationID], [UserID], [NotificationType], [NotificationText], [CreatedDate], [IsRead]) VALUES (18, 3, N'T', N'Вам поручено новое задание: Создать маркетинговые материалы', CAST(N'2024-03-11T12:07:37.907' AS DateTime), 0)
INSERT [dbo].[Notifications] ([NotificationID], [UserID], [NotificationType], [NotificationText], [CreatedDate], [IsRead]) VALUES (19, 4, N'N', N'У вас есть новая заметка: Организуйте домашний офис', CAST(N'2024-03-11T12:07:37.907' AS DateTime), 0)
INSERT [dbo].[Notifications] ([NotificationID], [UserID], [NotificationType], [NotificationText], [CreatedDate], [IsRead]) VALUES (20, 5, N'M', N'У вас есть новое сообщение в разделе Разговор 6', CAST(N'2024-03-11T12:07:37.907' AS DateTime), 0)
INSERT [dbo].[Notifications] ([NotificationID], [UserID], [NotificationType], [NotificationText], [CreatedDate], [IsRead]) VALUES (21, 1, N'M', N'У вас есть новое сообщение в Разговор 1', CAST(N'2024-03-11T12:07:39.283' AS DateTime), 0)
INSERT [dbo].[Notifications] ([NotificationID], [UserID], [NotificationType], [NotificationText], [CreatedDate], [IsRead]) VALUES (22, 2, N'T', N'Перед вами поставлена новая задача: Обновить веб-сайт', CAST(N'2024-03-11T12:07:39.283' AS DateTime), 0)
INSERT [dbo].[Notifications] ([NotificationID], [UserID], [NotificationType], [NotificationText], [CreatedDate], [IsRead]) VALUES (23, 3, N'N', N'У вас есть новая заметка: Подготовка к презентации', CAST(N'2024-03-11T12:07:39.283' AS DateTime), 0)
INSERT [dbo].[Notifications] ([NotificationID], [UserID], [NotificationType], [NotificationText], [CreatedDate], [IsRead]) VALUES (24, 4, N'M', N'У вас есть новое сообщение в разделе Разговор 4', CAST(N'2024-03-11T12:07:39.283' AS DateTime), 0)
INSERT [dbo].[Notifications] ([NotificationID], [UserID], [NotificationType], [NotificationText], [CreatedDate], [IsRead]) VALUES (25, 5, N'T', N'Вам назначено новое задание: Внесите улучшения в пользовательский интерфейс', CAST(N'2024-03-11T12:07:39.283' AS DateTime), 0)
INSERT [dbo].[Notifications] ([NotificationID], [UserID], [NotificationType], [NotificationText], [CreatedDate], [IsRead]) VALUES (26, 1, N'N', N'У вас есть новая заметка: прочитайте новую книгу о продуктивности', CAST(N'2024-03-11T12:07:39.283' AS DateTime), 0)
INSERT [dbo].[Notifications] ([NotificationID], [UserID], [NotificationType], [NotificationText], [CreatedDate], [IsRead]) VALUES (27, 2, N'M', N'У вас есть новое сообщение в разделе Разговор 2', CAST(N'2024-03-11T12:07:39.283' AS DateTime), 0)
INSERT [dbo].[Notifications] ([NotificationID], [UserID], [NotificationType], [NotificationText], [CreatedDate], [IsRead]) VALUES (28, 3, N'T', N'Вам поручено новое задание: Создать маркетинговые материалы', CAST(N'2024-03-11T12:07:39.283' AS DateTime), 0)
INSERT [dbo].[Notifications] ([NotificationID], [UserID], [NotificationType], [NotificationText], [CreatedDate], [IsRead]) VALUES (29, 4, N'N', N'У вас есть новая заметка: Организуйте домашний офис', CAST(N'2024-03-11T12:07:39.283' AS DateTime), 0)
INSERT [dbo].[Notifications] ([NotificationID], [UserID], [NotificationType], [NotificationText], [CreatedDate], [IsRead]) VALUES (30, 5, N'M', N'У вас есть новое сообщение в разделе Разговор 6', CAST(N'2024-03-11T12:07:39.283' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[Notifications] OFF
GO
SET IDENTITY_INSERT [dbo].[TaskCategories] ON 

INSERT [dbo].[TaskCategories] ([CategoryID], [CategoryName]) VALUES (5, N'Встреча')
INSERT [dbo].[TaskCategories] ([CategoryID], [CategoryName]) VALUES (7, N'Дизайн')
INSERT [dbo].[TaskCategories] ([CategoryID], [CategoryName]) VALUES (3, N'Излучение')
INSERT [dbo].[TaskCategories] ([CategoryID], [CategoryName]) VALUES (6, N'Исследование')
INSERT [dbo].[TaskCategories] ([CategoryID], [CategoryName]) VALUES (2, N'Личный')
INSERT [dbo].[TaskCategories] ([CategoryID], [CategoryName]) VALUES (9, N'Маркетинг')
INSERT [dbo].[TaskCategories] ([CategoryID], [CategoryName]) VALUES (4, N'Проект')
INSERT [dbo].[TaskCategories] ([CategoryID], [CategoryName]) VALUES (1, N'Работа')
INSERT [dbo].[TaskCategories] ([CategoryID], [CategoryName]) VALUES (8, N'Разработка')
INSERT [dbo].[TaskCategories] ([CategoryID], [CategoryName]) VALUES (10, N'Тестирование')
SET IDENTITY_INSERT [dbo].[TaskCategories] OFF
GO
SET IDENTITY_INSERT [dbo].[TaskCategoryMap] ON 

INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (1, 1, 1)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (2, 1, 4)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (3, 2, 1)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (4, 2, 8)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (5, 3, 1)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (6, 3, 4)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (7, 3, 7)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (8, 4, 1)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (9, 4, 6)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (10, 4, 9)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (11, 5, 1)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (12, 5, 5)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (13, 6, 1)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (14, 6, 8)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (15, 7, 1)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (16, 7, 8)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (17, 7, 10)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (18, 8, 1)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (19, 8, 9)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (20, 9, 1)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (21, 9, 6)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (22, 10, 1)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (23, 10, 7)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (24, 10, 8)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (25, 1, 1)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (26, 1, 4)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (27, 2, 1)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (28, 2, 8)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (29, 3, 1)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (30, 3, 4)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (31, 3, 7)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (32, 4, 1)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (33, 4, 6)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (34, 4, 9)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (35, 5, 1)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (36, 5, 5)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (37, 6, 1)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (38, 6, 8)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (39, 7, 1)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (40, 7, 8)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (41, 7, 10)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (42, 8, 1)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (43, 8, 9)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (44, 9, 1)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (45, 9, 6)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (46, 10, 1)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (47, 10, 7)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (48, 10, 8)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (49, 1, 1)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (50, 1, 4)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (51, 2, 1)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (52, 2, 8)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (53, 3, 1)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (54, 3, 4)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (55, 3, 7)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (56, 4, 1)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (57, 4, 6)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (58, 4, 9)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (59, 5, 1)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (60, 5, 5)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (61, 6, 1)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (62, 6, 8)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (63, 7, 1)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (64, 7, 8)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (65, 7, 10)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (66, 8, 1)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (67, 8, 9)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (68, 9, 1)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (69, 9, 6)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (70, 10, 1)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (71, 10, 7)
INSERT [dbo].[TaskCategoryMap] ([MapID], [TaskID], [CategoryID]) VALUES (72, 10, 8)
SET IDENTITY_INSERT [dbo].[TaskCategoryMap] OFF
GO
SET IDENTITY_INSERT [dbo].[Tasks] ON 

INSERT [dbo].[Tasks] ([TaskID], [AssignedToID], [AssignedByID], [TaskDescription], [CreatedDate], [DueDate], [Status]) VALUES (1, 1, 2, N'Закончите отчет', CAST(N'2024-03-11T12:07:37.607' AS DateTime), CAST(N'2023-04-01T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Tasks] ([TaskID], [AssignedToID], [AssignedByID], [TaskDescription], [CreatedDate], [DueDate], [Status]) VALUES (2, 2, 1, N'Обновление веб-сайта', CAST(N'2024-03-11T12:07:37.607' AS DateTime), CAST(N'2023-04-15T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Tasks] ([TaskID], [AssignedToID], [AssignedByID], [TaskDescription], [CreatedDate], [DueDate], [Status]) VALUES (3, 3, 4, N'Подготовьте презентацию', CAST(N'2024-03-11T12:07:37.607' AS DateTime), CAST(N'2023-05-01T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Tasks] ([TaskID], [AssignedToID], [AssignedByID], [TaskDescription], [CreatedDate], [DueDate], [Status]) VALUES (4, 4, 3, N'Исследование новых маркетинговых стратегий', CAST(N'2024-03-11T12:07:37.607' AS DateTime), CAST(N'2023-05-15T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Tasks] ([TaskID], [AssignedToID], [AssignedByID], [TaskDescription], [CreatedDate], [DueDate], [Status]) VALUES (5, 5, 2, N'Организуйте командное собрание', CAST(N'2024-03-11T12:07:37.607' AS DateTime), CAST(N'2023-06-01T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Tasks] ([TaskID], [AssignedToID], [AssignedByID], [TaskDescription], [CreatedDate], [DueDate], [Status]) VALUES (6, 1, 5, N'Обзор изменений в коде', CAST(N'2024-03-11T12:07:37.607' AS DateTime), CAST(N'2023-06-15T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Tasks] ([TaskID], [AssignedToID], [AssignedByID], [TaskDescription], [CreatedDate], [DueDate], [Status]) VALUES (7, 2, 3, N'Протестируйте новую функцию', CAST(N'2024-03-11T12:07:37.607' AS DateTime), CAST(N'2023-07-01T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Tasks] ([TaskID], [AssignedToID], [AssignedByID], [TaskDescription], [CreatedDate], [DueDate], [Status]) VALUES (8, 3, 1, N'Создание маркетинговых материалов', CAST(N'2024-03-11T12:07:37.607' AS DateTime), CAST(N'2023-07-15T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Tasks] ([TaskID], [AssignedToID], [AssignedByID], [TaskDescription], [CreatedDate], [DueDate], [Status]) VALUES (9, 4, 2, N'Анализируйте отзывы клиентов', CAST(N'2024-03-11T12:07:37.607' AS DateTime), CAST(N'2023-08-01T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Tasks] ([TaskID], [AssignedToID], [AssignedByID], [TaskDescription], [CreatedDate], [DueDate], [Status]) VALUES (10, 5, 4, N'Внесите улучшения в пользовательский интерфейс', CAST(N'2024-03-11T12:07:37.607' AS DateTime), CAST(N'2023-08-15T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Tasks] ([TaskID], [AssignedToID], [AssignedByID], [TaskDescription], [CreatedDate], [DueDate], [Status]) VALUES (11, 1, 2, N'Закончите отчет', CAST(N'2024-03-11T12:07:37.907' AS DateTime), CAST(N'2023-04-01T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Tasks] ([TaskID], [AssignedToID], [AssignedByID], [TaskDescription], [CreatedDate], [DueDate], [Status]) VALUES (12, 2, 1, N'Обновление веб-сайта', CAST(N'2024-03-11T12:07:37.907' AS DateTime), CAST(N'2023-04-15T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Tasks] ([TaskID], [AssignedToID], [AssignedByID], [TaskDescription], [CreatedDate], [DueDate], [Status]) VALUES (13, 3, 4, N'Подготовьте презентацию', CAST(N'2024-03-11T12:07:37.907' AS DateTime), CAST(N'2023-05-01T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Tasks] ([TaskID], [AssignedToID], [AssignedByID], [TaskDescription], [CreatedDate], [DueDate], [Status]) VALUES (14, 4, 3, N'Исследование новых маркетинговых стратегий', CAST(N'2024-03-11T12:07:37.907' AS DateTime), CAST(N'2023-05-15T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Tasks] ([TaskID], [AssignedToID], [AssignedByID], [TaskDescription], [CreatedDate], [DueDate], [Status]) VALUES (15, 5, 2, N'Организуйте командное собрание', CAST(N'2024-03-11T12:07:37.907' AS DateTime), CAST(N'2023-06-01T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Tasks] ([TaskID], [AssignedToID], [AssignedByID], [TaskDescription], [CreatedDate], [DueDate], [Status]) VALUES (16, 1, 5, N'Обзор изменений в коде', CAST(N'2024-03-11T12:07:37.907' AS DateTime), CAST(N'2023-06-15T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Tasks] ([TaskID], [AssignedToID], [AssignedByID], [TaskDescription], [CreatedDate], [DueDate], [Status]) VALUES (17, 2, 3, N'Протестируйте новую функцию', CAST(N'2024-03-11T12:07:37.907' AS DateTime), CAST(N'2023-07-01T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Tasks] ([TaskID], [AssignedToID], [AssignedByID], [TaskDescription], [CreatedDate], [DueDate], [Status]) VALUES (18, 3, 1, N'Создание маркетинговых материалов', CAST(N'2024-03-11T12:07:37.907' AS DateTime), CAST(N'2023-07-15T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Tasks] ([TaskID], [AssignedToID], [AssignedByID], [TaskDescription], [CreatedDate], [DueDate], [Status]) VALUES (19, 4, 2, N'Анализируйте отзывы клиентов', CAST(N'2024-03-11T12:07:37.907' AS DateTime), CAST(N'2023-08-01T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Tasks] ([TaskID], [AssignedToID], [AssignedByID], [TaskDescription], [CreatedDate], [DueDate], [Status]) VALUES (20, 5, 4, N'Внесите улучшения в пользовательский интерфейс', CAST(N'2024-03-11T12:07:37.907' AS DateTime), CAST(N'2023-08-15T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Tasks] ([TaskID], [AssignedToID], [AssignedByID], [TaskDescription], [CreatedDate], [DueDate], [Status]) VALUES (21, 1, 2, N'Закончите отчет', CAST(N'2024-03-11T12:07:39.280' AS DateTime), CAST(N'2023-04-01T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Tasks] ([TaskID], [AssignedToID], [AssignedByID], [TaskDescription], [CreatedDate], [DueDate], [Status]) VALUES (22, 2, 1, N'Закончите отчет', CAST(N'2024-03-11T12:07:39.280' AS DateTime), CAST(N'2023-04-15T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Tasks] ([TaskID], [AssignedToID], [AssignedByID], [TaskDescription], [CreatedDate], [DueDate], [Status]) VALUES (23, 3, 4, N'Подготовьте презентацию', CAST(N'2024-03-11T12:07:39.280' AS DateTime), CAST(N'2023-05-01T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Tasks] ([TaskID], [AssignedToID], [AssignedByID], [TaskDescription], [CreatedDate], [DueDate], [Status]) VALUES (24, 4, 3, N'Исследование новых маркетинговых стратегий', CAST(N'2024-03-11T12:07:39.280' AS DateTime), CAST(N'2023-05-15T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Tasks] ([TaskID], [AssignedToID], [AssignedByID], [TaskDescription], [CreatedDate], [DueDate], [Status]) VALUES (25, 5, 2, N'Организуйте командное собрание', CAST(N'2024-03-11T12:07:39.280' AS DateTime), CAST(N'2023-06-01T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Tasks] ([TaskID], [AssignedToID], [AssignedByID], [TaskDescription], [CreatedDate], [DueDate], [Status]) VALUES (26, 1, 5, N'Обзор изменений в коде', CAST(N'2024-03-11T12:07:39.280' AS DateTime), CAST(N'2023-06-15T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Tasks] ([TaskID], [AssignedToID], [AssignedByID], [TaskDescription], [CreatedDate], [DueDate], [Status]) VALUES (27, 2, 3, N'Протестируйте новую функцию', CAST(N'2024-03-11T12:07:39.280' AS DateTime), CAST(N'2023-07-01T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Tasks] ([TaskID], [AssignedToID], [AssignedByID], [TaskDescription], [CreatedDate], [DueDate], [Status]) VALUES (28, 3, 1, N'Создание маркетинговых материалов', CAST(N'2024-03-11T12:07:39.280' AS DateTime), CAST(N'2023-07-15T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Tasks] ([TaskID], [AssignedToID], [AssignedByID], [TaskDescription], [CreatedDate], [DueDate], [Status]) VALUES (29, 4, 2, N'Анализируйте отзывы клиентов', CAST(N'2024-03-11T12:07:39.280' AS DateTime), CAST(N'2023-08-01T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Tasks] ([TaskID], [AssignedToID], [AssignedByID], [TaskDescription], [CreatedDate], [DueDate], [Status]) VALUES (30, 5, 4, N'Внесите улучшения в пользовательский интерфейс', CAST(N'2024-03-11T12:07:39.280' AS DateTime), CAST(N'2023-08-15T00:00:00.000' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[Tasks] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserID], [Username], [Password], [Email], [RegistrationDate]) VALUES (1, N'user1', N'password1', N'user1@example.com', CAST(N'2024-03-11T12:07:37.600' AS DateTime))
INSERT [dbo].[Users] ([UserID], [Username], [Password], [Email], [RegistrationDate]) VALUES (2, N'user2', N'password2', N'user2@example.com', CAST(N'2024-03-11T12:07:37.600' AS DateTime))
INSERT [dbo].[Users] ([UserID], [Username], [Password], [Email], [RegistrationDate]) VALUES (3, N'user3', N'password3', N'user3@example.com', CAST(N'2024-03-11T12:07:37.600' AS DateTime))
INSERT [dbo].[Users] ([UserID], [Username], [Password], [Email], [RegistrationDate]) VALUES (4, N'user4', N'password4', N'user4@example.com', CAST(N'2024-03-11T12:07:37.600' AS DateTime))
INSERT [dbo].[Users] ([UserID], [Username], [Password], [Email], [RegistrationDate]) VALUES (5, N'user5', N'password5', N'user5@example.com', CAST(N'2024-03-11T12:07:37.600' AS DateTime))
INSERT [dbo].[Users] ([UserID], [Username], [Password], [Email], [RegistrationDate]) VALUES (6, N'user6', N'password6', N'user6@example.com', CAST(N'2024-03-11T12:07:37.600' AS DateTime))
INSERT [dbo].[Users] ([UserID], [Username], [Password], [Email], [RegistrationDate]) VALUES (7, N'user7', N'password7', N'user7@example.com', CAST(N'2024-03-11T12:07:37.600' AS DateTime))
INSERT [dbo].[Users] ([UserID], [Username], [Password], [Email], [RegistrationDate]) VALUES (8, N'user8', N'password8', N'user8@example.com', CAST(N'2024-03-11T12:07:37.600' AS DateTime))
INSERT [dbo].[Users] ([UserID], [Username], [Password], [Email], [RegistrationDate]) VALUES (9, N'user9', N'password9', N'user9@example.com', CAST(N'2024-03-11T12:07:37.600' AS DateTime))
INSERT [dbo].[Users] ([UserID], [Username], [Password], [Email], [RegistrationDate]) VALUES (10, N'user10', N'password10', N'user10@example.com', CAST(N'2024-03-11T12:07:37.600' AS DateTime))
INSERT [dbo].[Users] ([UserID], [Username], [Password], [Email], [RegistrationDate]) VALUES (17, N'0', N'0', N'@', CAST(N'2024-03-11T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__NoteCate__8517B2E0F2B9DF90]    Script Date: 04-Apr-24 6:14:24 PM ******/
ALTER TABLE [dbo].[NoteCategories] ADD UNIQUE NONCLUSTERED 
(
	[CategoryName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__TaskCate__8517B2E0FF5C8F37]    Script Date: 04-Apr-24 6:14:24 PM ******/
ALTER TABLE [dbo].[TaskCategories] ADD UNIQUE NONCLUSTERED 
(
	[CategoryName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__536C85E4CFD799E0]    Script Date: 04-Apr-24 6:14:24 PM ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__A9D10534F6807C4B]    Script Date: 04-Apr-24 6:14:24 PM ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ConversationParticipants] ADD  DEFAULT (getdate()) FOR [JoinedDate]
GO
ALTER TABLE [dbo].[Messages] ADD  DEFAULT (getdate()) FOR [SentDate]
GO
ALTER TABLE [dbo].[Notes] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Notifications] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Notifications] ADD  DEFAULT ((0)) FOR [IsRead]
GO
ALTER TABLE [dbo].[Tasks] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Tasks] ADD  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT (getdate()) FOR [RegistrationDate]
GO
ALTER TABLE [dbo].[Attachments]  WITH CHECK ADD FOREIGN KEY([MessageID])
REFERENCES [dbo].[Messages] ([MessageID])
GO
ALTER TABLE [dbo].[ConversationParticipants]  WITH CHECK ADD FOREIGN KEY([ConversationID])
REFERENCES [dbo].[Conversations] ([ConversationID])
GO
ALTER TABLE [dbo].[ConversationParticipants]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Messages]  WITH CHECK ADD FOREIGN KEY([ConversationID])
REFERENCES [dbo].[Conversations] ([ConversationID])
GO
ALTER TABLE [dbo].[Messages]  WITH CHECK ADD FOREIGN KEY([SenderID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[NoteCategoryMap]  WITH CHECK ADD FOREIGN KEY([CategoryID])
REFERENCES [dbo].[NoteCategories] ([CategoryID])
GO
ALTER TABLE [dbo].[NoteCategoryMap]  WITH CHECK ADD FOREIGN KEY([NoteID])
REFERENCES [dbo].[Notes] ([NoteID])
GO
ALTER TABLE [dbo].[Notes]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Notifications]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[TaskCategoryMap]  WITH CHECK ADD FOREIGN KEY([CategoryID])
REFERENCES [dbo].[TaskCategories] ([CategoryID])
GO
ALTER TABLE [dbo].[TaskCategoryMap]  WITH CHECK ADD FOREIGN KEY([TaskID])
REFERENCES [dbo].[Tasks] ([TaskID])
GO
ALTER TABLE [dbo].[Tasks]  WITH CHECK ADD FOREIGN KEY([AssignedByID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Tasks]  WITH CHECK ADD FOREIGN KEY([AssignedToID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Conversations]  WITH CHECK ADD CHECK  (([ConversationType]='G' OR [ConversationType]='P'))
GO
ALTER TABLE [dbo].[Notifications]  WITH CHECK ADD CHECK  (([NotificationType]='N' OR [NotificationType]='T' OR [NotificationType]='M'))
GO
USE [master]
GO
ALTER DATABASE [i_kak_message_ver4] SET  READ_WRITE 
GO
