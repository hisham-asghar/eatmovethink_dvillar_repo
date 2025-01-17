USE [master]
GO
/****** Object:  Database [EatMoveThink]    Script Date: 20-Feb-17 3:39:31 AM ******/
CREATE DATABASE [EatMoveThink]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'EatMoveThink', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\EatMoveThink.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'EatMoveThink_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\EatMoveThink_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [EatMoveThink] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [EatMoveThink].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [EatMoveThink] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [EatMoveThink] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [EatMoveThink] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [EatMoveThink] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [EatMoveThink] SET ARITHABORT OFF 
GO
ALTER DATABASE [EatMoveThink] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [EatMoveThink] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [EatMoveThink] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [EatMoveThink] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [EatMoveThink] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [EatMoveThink] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [EatMoveThink] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [EatMoveThink] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [EatMoveThink] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [EatMoveThink] SET  DISABLE_BROKER 
GO
ALTER DATABASE [EatMoveThink] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [EatMoveThink] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [EatMoveThink] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [EatMoveThink] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [EatMoveThink] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [EatMoveThink] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [EatMoveThink] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [EatMoveThink] SET RECOVERY FULL 
GO
ALTER DATABASE [EatMoveThink] SET  MULTI_USER 
GO
ALTER DATABASE [EatMoveThink] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [EatMoveThink] SET DB_CHAINING OFF 
GO
ALTER DATABASE [EatMoveThink] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [EatMoveThink] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [EatMoveThink] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'EatMoveThink', N'ON'
GO
USE [EatMoveThink]
GO
/****** Object:  Table [dbo].[AddtionalProgram]    Script Date: 20-Feb-17 3:39:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AddtionalProgram](
	[AddtionalProgramId] [int] IDENTITY(1,1) NOT NULL,
	[ProgramId] [int] NOT NULL,
	[ReferencedProgram] [int] NOT NULL,
 CONSTRAINT [PK_AddtionalProgram] PRIMARY KEY CLUSTERED 
(
	[AddtionalProgramId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DailyTaskPoints]    Script Date: 20-Feb-17 3:39:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DailyTaskPoints](
	[TaskID] [int] IDENTITY(1,1) NOT NULL,
	[TaskName] [varchar](50) NOT NULL,
	[Points] [int] NOT NULL,
 CONSTRAINT [PK_DailyTaskPoints] PRIMARY KEY CLUSTERED 
(
	[TaskID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Program]    Script Date: 20-Feb-17 3:39:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Program](
	[ProgramID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](200) NOT NULL,
	[Text] [ntext] NOT NULL,
	[Intensity] [int] NOT NULL,
	[Points] [int] NOT NULL CONSTRAINT [DF_Program_Points]  DEFAULT ((0)),
	[ImageURL] [varchar](350) NULL,
	[pdf] [varchar](350) NULL,
	[TotalPoints] [int] NOT NULL CONSTRAINT [DF_Program_TotalPoints]  DEFAULT ((0)),
 CONSTRAINT [PK_Program] PRIMARY KEY CLUSTERED 
(
	[ProgramID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProgramTasks]    Script Date: 20-Feb-17 3:39:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProgramTasks](
	[ProgramTaskID] [int] IDENTITY(1,1) NOT NULL,
	[ProgramID] [int] NOT NULL,
	[DayID] [int] NOT NULL,
	[WeekID] [int] NOT NULL,
	[Points] [int] NOT NULL,
	[Text] [ntext] NOT NULL,
 CONSTRAINT [PK_ProgramTasks] PRIMARY KEY CLUSTERED 
(
	[ProgramTaskID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[StaticPageData]    Script Date: 20-Feb-17 3:39:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[StaticPageData](
	[PageID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](50) NOT NULL,
	[Data] [ntext] NOT NULL,
 CONSTRAINT [PK_StaticPageData] PRIMARY KEY CLUSTERED 
(
	[PageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SubscribeProgram]    Script Date: 20-Feb-17 3:39:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubscribeProgram](
	[SubscribeProgramID] [int] IDENTITY(1,1) NOT NULL,
	[ProgramID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[Finish] [bit] NOT NULL,
	[onSubscribe] [date] NOT NULL,
 CONSTRAINT [PK_SubscribeProgram] PRIMARY KEY CLUSTERED 
(
	[SubscribeProgramID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SubscribeProgramTask]    Script Date: 20-Feb-17 3:39:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubscribeProgramTask](
	[SubscribeProgramTaskID] [int] IDENTITY(1,1) NOT NULL,
	[SubscribeProgramID] [int] NOT NULL,
	[ProgramTaskID] [int] NOT NULL,
 CONSTRAINT [PK_SubscribeProgramTask] PRIMARY KEY CLUSTERED 
(
	[SubscribeProgramTaskID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[User]    Script Date: 20-Feb-17 3:39:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[User](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](50) NOT NULL,
	[email] [varchar](100) NOT NULL,
	[dob] [date] NOT NULL,
	[mobileph] [varchar](20) NULL,
	[workph] [varchar](20) NULL,
	[company] [varchar](100) NULL,
	[gender] [int] NOT NULL CONSTRAINT [DF_User_gender]  DEFAULT ((0)),
	[password] [varchar](50) NOT NULL,
	[ispublic] [bit] NOT NULL,
	[newsletter] [bit] NULL,
	[info] [text] NOT NULL,
	[isActive] [bit] NOT NULL CONSTRAINT [DF_User_isActive]  DEFAULT ((1)),
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserDailyTasks]    Script Date: 20-Feb-17 3:39:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserDailyTasks](
	[UserDailyTaskID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[Day] [date] NOT NULL,
	[TaskID] [int] NOT NULL,
	[Finish] [bit] NOT NULL,
 CONSTRAINT [PK_UserDailyTasks] PRIMARY KEY CLUSTERED 
(
	[UserDailyTaskID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserRequest]    Script Date: 20-Feb-17 3:39:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserRequest](
	[RequestId] [int] IDENTITY(1,1) NOT NULL,
	[Email] [varchar](100) NOT NULL,
	[token] [varchar](300) NULL,
	[active] [bit] NOT NULL,
	[oncreated] [datetime] NOT NULL CONSTRAINT [DF_UserRequest_oncreated]  DEFAULT (getdate()),
 CONSTRAINT [PK_UserRequest] PRIMARY KEY CLUSTERED 
(
	[RequestId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[AddtionalProgram] ON 

INSERT [dbo].[AddtionalProgram] ([AddtionalProgramId], [ProgramId], [ReferencedProgram]) VALUES (1, 15, 9)
INSERT [dbo].[AddtionalProgram] ([AddtionalProgramId], [ProgramId], [ReferencedProgram]) VALUES (2, 15, 11)
INSERT [dbo].[AddtionalProgram] ([AddtionalProgramId], [ProgramId], [ReferencedProgram]) VALUES (3, 16, 9)
INSERT [dbo].[AddtionalProgram] ([AddtionalProgramId], [ProgramId], [ReferencedProgram]) VALUES (4, 16, 11)
INSERT [dbo].[AddtionalProgram] ([AddtionalProgramId], [ProgramId], [ReferencedProgram]) VALUES (5, 18, 17)
INSERT [dbo].[AddtionalProgram] ([AddtionalProgramId], [ProgramId], [ReferencedProgram]) VALUES (6, 28, 20)
INSERT [dbo].[AddtionalProgram] ([AddtionalProgramId], [ProgramId], [ReferencedProgram]) VALUES (7, 29, 20)
SET IDENTITY_INSERT [dbo].[AddtionalProgram] OFF
SET IDENTITY_INSERT [dbo].[DailyTaskPoints] ON 

INSERT [dbo].[DailyTaskPoints] ([TaskID], [TaskName], [Points]) VALUES (1, N'enjoy', 2)
INSERT [dbo].[DailyTaskPoints] ([TaskID], [TaskName], [Points]) VALUES (2, N'affirmation', 2)
INSERT [dbo].[DailyTaskPoints] ([TaskID], [TaskName], [Points]) VALUES (3, N'smile', 2)
INSERT [dbo].[DailyTaskPoints] ([TaskID], [TaskName], [Points]) VALUES (4, N'meditate', 2)
INSERT [dbo].[DailyTaskPoints] ([TaskID], [TaskName], [Points]) VALUES (5, N'breath', 2)
INSERT [dbo].[DailyTaskPoints] ([TaskID], [TaskName], [Points]) VALUES (6, N'posture', 2)
INSERT [dbo].[DailyTaskPoints] ([TaskID], [TaskName], [Points]) VALUES (7, N'weight', 2)
INSERT [dbo].[DailyTaskPoints] ([TaskID], [TaskName], [Points]) VALUES (8, N'exercise', 2)
INSERT [dbo].[DailyTaskPoints] ([TaskID], [TaskName], [Points]) VALUES (9, N'walk', 2)
INSERT [dbo].[DailyTaskPoints] ([TaskID], [TaskName], [Points]) VALUES (10, N'stretch', 2)
INSERT [dbo].[DailyTaskPoints] ([TaskID], [TaskName], [Points]) VALUES (11, N'water', 1)
INSERT [dbo].[DailyTaskPoints] ([TaskID], [TaskName], [Points]) VALUES (12, N'veggies', 1)
INSERT [dbo].[DailyTaskPoints] ([TaskID], [TaskName], [Points]) VALUES (13, N'processedFood', 1)
INSERT [dbo].[DailyTaskPoints] ([TaskID], [TaskName], [Points]) VALUES (14, N'cafineIntake', 1)
INSERT [dbo].[DailyTaskPoints] ([TaskID], [TaskName], [Points]) VALUES (15, N'breakfast', 1)
INSERT [dbo].[DailyTaskPoints] ([TaskID], [TaskName], [Points]) VALUES (16, N'snack', 1)
INSERT [dbo].[DailyTaskPoints] ([TaskID], [TaskName], [Points]) VALUES (17, N'lunch', 1)
INSERT [dbo].[DailyTaskPoints] ([TaskID], [TaskName], [Points]) VALUES (18, N'dinner', 1)
INSERT [dbo].[DailyTaskPoints] ([TaskID], [TaskName], [Points]) VALUES (19, N'alcohol', 2)
SET IDENTITY_INSERT [dbo].[DailyTaskPoints] OFF
SET IDENTITY_INSERT [dbo].[Program] ON 

INSERT [dbo].[Program] ([ProgramID], [Title], [Text], [Intensity], [Points], [ImageURL], [pdf], [TotalPoints]) VALUES (17, N'Food Cleanse', N'View document for details', 1, 50, N'/img/6d6a4e94-933b-4126-83c7-51b08060bd8e.jpg', N'/docs/5acf3c09-f171-4706-8724-a59c6ef600cd.pdf', 150)
INSERT [dbo].[Program] ([ProgramID], [Title], [Text], [Intensity], [Points], [ImageURL], [pdf], [TotalPoints]) VALUES (19, N'MINI DETOX CHALLENGE', N'If you want to slowly detox your body from toxins follow these 3 simple steps to better health. These simple yet effective tips will help you detox your body without the need of supplements or yummy food. We all need to get rid of toxins in our system. Our foods, products and environment are full of artificial toxins and pollutants. 
This simple detox will eliminate some toxins, boost metabolism and make you feel great.
', 1, 50, N'/img/714678bb-15c9-460a-a898-a46b4de8a8ca.jpg', N'/docs/2816f9c4-c9a0-4b22-a95f-6ed078159b82.pdf', 150)
INSERT [dbo].[Program] ([ProgramID], [Title], [Text], [Intensity], [Points], [ImageURL], [pdf], [TotalPoints]) VALUES (20, N'FUNCTIONAL TRAINING PROGRAM', N'This program contains exercise that will strengthen and lengthen muscle groups that are essential for optimum function.  View /Join (see below the links to program) 
The following are exercises designed to suit levels of fitness, follow the exercises most suited to your level.
<br />
If you are a beginner : 
<a href=''#''>
Beginner Functional Training 
</a>
<br />

If you are intermediate:
<a href=''#''>Intermediate Functional Training
</a>

<br />
If you are advanced: 
<a href=''#''>
 Advanced Functional Training
</a>', 3, 100, N'/img/323bc748-8a00-428a-b595-e93f7ed9e0ff.jpg', N'', 200)
INSERT [dbo].[Program] ([ProgramID], [Title], [Text], [Intensity], [Points], [ImageURL], [pdf], [TotalPoints]) VALUES (21, N'IMPROVE YOUR POSTURE', N'Posture is the window to your musculoskeletal system. This program will have you looking and feeling great. A great addition for people that sit at a desk all day. 
<br />
<a href=''https://secure.webexercises.com/desktop/patient/rx.html?OXAOCXYBZ04W''>
Posture up </a>
', 1, 100, N'/img/6d852a99-eaa0-4a6e-b55a-b547871339d0.jpg', N'', 200)
INSERT [dbo].[Program] ([ProgramID], [Title], [Text], [Intensity], [Points], [ImageURL], [pdf], [TotalPoints]) VALUES (22, N'GET FIT TONE UP', N'This program will get you fit and tone in no time. Full body training with no equipment needed. 
<a href=''https://secure.webexercises.com/desktop/patient/rx.html?UPPCEOQK4CJK''>
GET FIT TONE UP
</a>
', 1, 100, N'/img/cfc562c0-74fd-4fb3-9091-f78e5bd98761.jpg', N'', 200)
INSERT [dbo].[Program] ([ProgramID], [Title], [Text], [Intensity], [Points], [ImageURL], [pdf], [TotalPoints]) VALUES (23, N'MARATHON TRAINING- 12 WEEKS TO A MARATHON', N'Your complete 12 week training to finishing a marathon. Make sure you also add the flexibility challenge to prevent injury.  <br />
If you are aiming to complete your first marathon event, this training program is for you. <br />
Everyone is an individual and your base level of fitness may vary.  <br />
For those who already have been doing some running, this general program should give you all the endurance you will need to reach your marathon goal
This 12-week training guide is just that, a guide, so feel free to be a little flexible to make it work for you. <br />

<b>A few points to take into consideration:</b><br />
<b>Long runs:</b> The key to the guide is the long run on weekends, which builds from 10km in week 1 to 32km in week 10. The long runs are really the ones you can’t miss.
<b>Run slow: </b> Do your long runs at a comfortable pace, one that would allow you to converse
with a training partner, at least during the beginning of the run. If you finish the long run
at a pace significantly slower than your early pace, you need to start much slower. 
It’s better to run too slow during these long runs, than too fast, the purpose is to cover the
prescribed distance.
<b> Walking breaks: </b> It is okay to walk during the marathon, in particular your first
marathon. You can walk during training runs too. In a race the best time to walk is
entering a drinks station, that way you can drink more easily while walking as opposed
to running.<b>
Cross-training:</b> Sundays in the training guide are for cross-training. The best cross training
exercises are swimming, cycling or walking. You don’t have to cross-train the
same each weekend and you could even combine two or more exercises: walking and
cycling or swimming and riding an exercise bike in a gym. Cross-training on Sunday will
help you recover after your Saturday long runs.
Midweek training: Sessions during the week should be done at an easy pace.<b>
Rest:</b> Days designated to rest are very important. Muscles actually regenerate and get
stronger during rest and rest helps prevent injury. The key to this guide is consistency
– if you are feeling particularly tired at any stage, take an extra rest day and get your
energy back to keep going.
', 3, 240, N'/img/b731dd71-e7fc-4df2-a237-57b5434557f9.jpg', N'/docs/12-weeks-to-marathon.pdf', 480)
INSERT [dbo].[Program] ([ProgramID], [Title], [Text], [Intensity], [Points], [ImageURL], [pdf], [TotalPoints]) VALUES (24, N'STRENGTHEN YOUR CORE', N'Core strength is essential to improve posture and prevent back pain. These simple yet effective exercises will help you feel and look strong. 
<br />
<a href=''https://secure.webexercises.com/desktop/patient/rx.html?K2G6U1NHSKHV''>
Strengthen Your Core
</a>
', 1, 100, N'/img/b54bf623-cdeb-43aa-bd0a-72f59d201d05.jpg', N'', 200)
INSERT [dbo].[Program] ([ProgramID], [Title], [Text], [Intensity], [Points], [ImageURL], [pdf], [TotalPoints]) VALUES (25, N'30 day SQUAT CHALLENGE', N'The squat has been found to be an essential exercise that needs to be added to any exercise routine. This Challenge only has 1 exercise which you have to do each day, and the time spent doing the exercise slowly increases day by day to help you build up your core body muscle strength gradually, ensuring you are able to complete the final day of the challenge easily. This challenge will take you from 30 to 200 squats in 30 days. 
', 1, 0, N'/img/a7c2db25-95a3-4ae0-a8fd-a5a2ab6fac60.jpg', N'', 60)
INSERT [dbo].[Program] ([ProgramID], [Title], [Text], [Intensity], [Points], [ImageURL], [pdf], [TotalPoints]) VALUES (26, N'30 day PLANK CHALLENGE', N'The 30 day plank challenge only has 1 exercise which you have to do each day, and the time spent doing the exercise slowly increases day by day to help you build up your core body muscle strength gradually, ensuring you are able to complete the final day of the challenge easily. The plank strengthens legs, core , and many other muscles making it a complete exercises to improve muscle strength. Start by getting into a press up position.
Bend your elbows and rest your weight on your forearms and not on your hands.
Your body should form a straight line from shoulders to ankles.
Engage your core by sucking your belly button into your spine.
Hold this position for the prescribed time.', 1, 0, N'/img/30ff6958-2a7d-4e24-b4fa-3e094fa2db38.jpg', N'', 60)
INSERT [dbo].[Program] ([ProgramID], [Title], [Text], [Intensity], [Points], [ImageURL], [pdf], [TotalPoints]) VALUES (27, N'BEGINNER RUNNING PROGRAM', N' From couch to 5 km in 6 weeks. Safely and without injury. This program is recommended together with the flexibility challenge. 
', 1, 0, N'/img/a2a10227-af5e-49c7-839b-a85b69c952d5.jpg', N'', 100)
INSERT [dbo].[Program] ([ProgramID], [Title], [Text], [Intensity], [Points], [ImageURL], [pdf], [TotalPoints]) VALUES (28, N'5 day Health Kickstart', N'Join this program to kick-start your health in only 5 days. Delicious sugar and gluten free recipes and a complete functional program for beginners, intermediate and advanced participants.', 1, 0, N'/img/a070ddb2-77bc-4581-9ae4-ae28ec2f1e2d.jpg', N'', 100)
INSERT [dbo].[Program] ([ProgramID], [Title], [Text], [Intensity], [Points], [ImageURL], [pdf], [TotalPoints]) VALUES (29, N'5 day Health Kickstart', N'Join this program to kick-start your health in only 5 days. Delicious sugar and gluten free recipes and a complete functional program for beginners, intermediate and advanced participants.', 1, 0, N'/img/ba37d242-3976-4dca-b7eb-7b621f3e45b7.jpg', N'', 100)
SET IDENTITY_INSERT [dbo].[Program] OFF
SET IDENTITY_INSERT [dbo].[ProgramTasks] ON 

INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (17, 7, 1, 1, 2, N'Running 5mins')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (18, 7, 2, 1, 3, N'Running 10mins')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (19, 7, 1, 2, 1, N'Running 15 mins')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (20, 7, 1, 3, 6, N'Running 30mins')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (21, 7, 2, 3, 10, N'Running 45mins')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (22, 8, 1, 1, 1, N'sadasdasdas')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (23, 9, 1, 1, 10, N'Walking 50m')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (24, 9, 2, 1, 15, N'Running 100m')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (25, 9, 1, 2, 20, N'Running 500m')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (26, 9, 2, 2, 30, N'Running 1000m')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (27, 9, 1, 3, 50, N'Running 5000m')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (28, 11, 1, 1, 20, N'a')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (29, 15, 1, 1, 20, N'ssa')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (30, 16, 1, 1, 25, N'--------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (31, 17, 1, 1, 20, N'------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (32, 17, 2, 1, 20, N'------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (33, 17, 3, 1, 20, N'------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (34, 17, 4, 1, 20, N'------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (35, 17, 5, 1, 20, N'------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (36, 18, 1, 1, 20, N'-----------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (37, 19, 1, 1, 20, N'---------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (38, 19, 2, 1, 20, N'---------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (39, 19, 3, 1, 20, N'---------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (40, 19, 4, 1, 20, N'---------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (41, 19, 5, 1, 20, N'---------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (42, 20, 1, 1, 20, N'-----------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (43, 20, 2, 1, 20, N'-----------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (44, 20, 3, 1, 20, N'-----------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (45, 20, 4, 1, 20, N'-----------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (46, 20, 5, 1, 20, N'-----------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (47, 21, 1, 1, 20, N'---------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (48, 21, 2, 1, 20, N'---------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (49, 21, 3, 1, 20, N'---------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (50, 21, 4, 1, 20, N'---------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (51, 21, 5, 1, 20, N'---------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (52, 22, 1, 1, 20, N'---------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (53, 22, 2, 1, 20, N'---------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (54, 22, 3, 1, 20, N'---------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (55, 22, 4, 1, 20, N'---------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (56, 22, 5, 1, 20, N'---------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (57, 23, 1, 1, 0, N'Rest')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (58, 23, 2, 1, 4, N'5km run')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (59, 23, 3, 1, 4, N'5km run')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (60, 23, 4, 1, 4, N'5km run')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (61, 23, 5, 1, 0, N'Rest')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (62, 23, 6, 1, 4, N'10km run')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (63, 23, 7, 1, 4, N'1hr x-train')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (64, 23, 1, 2, 0, N'Rest')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (65, 23, 2, 2, 4, N'5km run')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (66, 23, 3, 2, 4, N'5km run')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (67, 23, 4, 2, 4, N'5km run')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (68, 23, 5, 2, 0, N'Rest')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (69, 23, 6, 2, 4, N'11km run')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (70, 23, 7, 2, 4, N'1hr x-train')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (71, 23, 1, 3, 0, N'Rest')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (72, 23, 2, 3, 4, N'5km run')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (73, 23, 3, 3, 4, N'6km run')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (74, 23, 4, 3, 4, N'5km run')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (75, 23, 5, 3, 0, N'Rest')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (76, 23, 6, 3, 4, N'15km run')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (77, 23, 7, 3, 4, N'1hr x-train')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (78, 23, 1, 4, 0, N'Rest')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (79, 23, 2, 4, 4, N'5km run')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (80, 23, 3, 4, 4, N'9km run')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (81, 23, 4, 4, 4, N'5km run')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (82, 23, 5, 4, 0, N'Rest')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (83, 23, 6, 4, 4, N'19km run')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (84, 23, 7, 4, 4, N'1hr x-train')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (85, 23, 1, 5, 0, N'Rest')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (86, 23, 2, 5, 4, N'5km run')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (87, 23, 3, 5, 4, N'11km run')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (88, 23, 4, 5, 4, N'7km run')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (89, 23, 5, 5, 0, N'Rest')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (90, 23, 6, 5, 4, N'16km run')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (91, 23, 7, 5, 4, N'1hr x-train')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (92, 23, 1, 6, 0, N'Rest')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (93, 23, 2, 6, 4, N'5km run')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (94, 23, 3, 6, 4, N'11km run')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (95, 23, 4, 6, 4, N'7km run')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (96, 23, 5, 6, 0, N'Rest')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (97, 23, 6, 6, 4, N'24km run')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (98, 23, 7, 6, 4, N'1hr x-train')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (99, 23, 1, 7, 0, N'Rest')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (100, 23, 2, 7, 4, N'7km run')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (101, 23, 3, 7, 4, N'13km run')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (102, 23, 4, 7, 4, N'7km run')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (103, 23, 5, 7, 0, N'Rest')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (104, 23, 6, 7, 4, N'25km run')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (105, 23, 7, 7, 4, N'1hr x-train')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (106, 23, 1, 8, 0, N'Rest')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (107, 23, 2, 8, 4, N'7km run')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (108, 23, 3, 8, 4, N'13km run')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (109, 23, 4, 8, 4, N'8km run')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (110, 23, 5, 8, 0, N'Rest')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (111, 23, 6, 8, 4, N'19km run')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (112, 23, 7, 8, 4, N'1hr x-train')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (113, 23, 1, 9, 0, N'Rest')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (114, 23, 2, 9, 4, N'7km run')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (115, 23, 3, 9, 4, N'15km run')
GO
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (116, 23, 4, 9, 4, N'8km run')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (117, 23, 5, 9, 0, N'Rest')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (118, 23, 6, 9, 4, N'29km run')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (119, 23, 7, 9, 4, N'1hr x-train')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (120, 23, 1, 10, 0, N'Rest')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (121, 23, 2, 10, 4, N'8km run')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (122, 23, 3, 10, 4, N'15km run')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (123, 23, 4, 10, 4, N'8km run')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (124, 23, 5, 10, 0, N'Rest')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (125, 23, 6, 10, 4, N'32km run')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (126, 23, 7, 10, 4, N'1hr x-train')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (127, 23, 1, 11, 0, N'Rest')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (128, 23, 2, 11, 4, N'7km run')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (129, 23, 3, 11, 4, N'10km run')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (130, 23, 4, 11, 4, N'5km run')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (131, 23, 5, 11, 0, N'Rest')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (132, 23, 6, 11, 4, N'12km run')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (133, 23, 7, 11, 4, N'1hr x-train')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (134, 23, 1, 12, 0, N'Rest')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (135, 23, 2, 12, 5, N'5km run')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (136, 23, 3, 12, 5, N'6km run')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (137, 23, 4, 12, 5, N'3km run')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (138, 23, 5, 12, 0, N'Rest')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (139, 23, 6, 12, 0, N'Rest')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (140, 23, 7, 12, 5, N'Race Day')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (141, 24, 1, 1, 20, N'------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (142, 24, 2, 1, 20, N'------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (143, 24, 3, 1, 20, N'------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (144, 24, 4, 1, 20, N'------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (145, 24, 5, 1, 20, N'------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (146, 25, 1, 1, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (147, 25, 2, 1, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (148, 25, 3, 1, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (149, 25, 4, 1, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (150, 25, 5, 1, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (151, 25, 6, 1, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (152, 25, 7, 1, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (153, 25, 1, 2, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (154, 25, 2, 2, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (155, 25, 3, 2, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (156, 25, 4, 2, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (157, 25, 5, 2, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (158, 25, 6, 2, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (159, 25, 7, 2, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (160, 25, 1, 3, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (161, 25, 2, 3, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (162, 25, 3, 3, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (163, 25, 4, 3, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (164, 25, 5, 3, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (165, 25, 6, 3, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (166, 25, 7, 3, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (167, 25, 1, 4, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (168, 25, 2, 4, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (169, 25, 3, 4, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (170, 25, 4, 4, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (171, 25, 5, 4, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (172, 25, 6, 4, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (173, 25, 7, 4, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (174, 25, 1, 5, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (175, 25, 2, 5, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (176, 26, 1, 1, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (177, 26, 2, 1, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (178, 26, 3, 1, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (179, 26, 4, 1, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (180, 26, 5, 1, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (181, 26, 6, 1, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (182, 26, 7, 1, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (183, 26, 1, 2, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (184, 26, 2, 2, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (185, 26, 3, 2, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (186, 26, 4, 2, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (187, 26, 5, 2, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (188, 26, 6, 2, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (189, 26, 7, 2, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (190, 26, 1, 3, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (191, 26, 2, 3, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (192, 26, 3, 3, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (193, 26, 4, 3, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (194, 26, 5, 3, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (195, 26, 6, 3, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (196, 26, 7, 3, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (197, 26, 1, 4, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (198, 26, 2, 4, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (199, 26, 3, 4, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (200, 26, 4, 4, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (201, 26, 5, 4, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (202, 26, 6, 4, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (203, 26, 7, 4, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (204, 26, 1, 5, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (205, 26, 2, 5, 2, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (206, 27, 1, 1, 20, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (207, 27, 2, 1, 20, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (208, 27, 3, 1, 20, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (209, 27, 4, 1, 20, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (210, 27, 5, 1, 20, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (211, 28, 1, 1, 20, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (212, 28, 2, 1, 20, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (213, 28, 3, 1, 20, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (214, 28, 4, 1, 20, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (215, 28, 5, 1, 20, N'------------------------------------------')
GO
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (216, 29, 1, 1, 20, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (217, 29, 2, 1, 20, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (218, 29, 3, 1, 20, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (219, 29, 4, 1, 20, N'------------------------------------------')
INSERT [dbo].[ProgramTasks] ([ProgramTaskID], [ProgramID], [DayID], [WeekID], [Points], [Text]) VALUES (220, 29, 5, 1, 20, N'------------------------------------------')
SET IDENTITY_INSERT [dbo].[ProgramTasks] OFF
SET IDENTITY_INSERT [dbo].[StaticPageData] ON 

INSERT [dbo].[StaticPageData] ([PageID], [Title], [Data]) VALUES (1, N'Eat', N'<p><span style="font-size: 18pt;"><strong>Sugar</strong></span>&nbsp;is toxic and research has shown that it plays a significant role in lifestyle related diseases. Many people are aware of the dangers of extra sugar in their diet but what many may not know is that sugar is added to most food products, such as smoked salmon, pasta sauces, bread and more.&nbsp;<br />Our recommended sugar intake, even from natural occurring sugar like fruit, should be 5- 9 teaspoons a day.&nbsp;<br />Learning to read labels is essential so you are aware of how much sugar you are consuming when eating a food product.&nbsp;<br />When reading labels, you should remember that 4 grams of sugar equals 1 teaspoon of sugar.&nbsp;<br />This way you can assess if you are eating above the recommended amount. The average Australian has about 45 teaspoons a day!</p>
<h3>Here&rsquo;s 8 easy starter tips to quit sugar for good...............!!!</h3>
<ol style="list-style-type: disc;">
<li><strong>Remove all sugar from your diet&nbsp;</strong>&ndash; not just the overt sugars but any packaged foods and sauces that contain added sugars. Watch-out for dried fruit in cereals and nut mixes &ndash; dried fruit is extremely high in sugars.Remove all sugar from your diet &ndash; not just the overt sugars but any packaged foods and sauces that contain added sugars. Watch-out for dried fruit in cereals and nut mixes &ndash; dried fruit is extremely high in sugars.</li>
<li><strong>Know that once you remove sugars your cravings will start to reduce&nbsp;</strong>&ndash; sugars are additive, once you remove them from your diet, your cravings will start to dissipate.</li>
<li><strong>Make sure you have protein at every meal</strong>&nbsp;&ndash; adequate protein in our diet helps with blood glucose regulation which stops us reaching for sugary snacks to boost our energy.</li>
<li><strong>Drink more water</strong>&nbsp;&ndash; often when we think we need a sugary snack, we are just thirsty. Drink at least 1.5- 2 litres of water a day. Add fresh lemon, lime or mint to change up the flavour.</li>
<li><strong>Drink Cinnamon herbal tea</strong>&nbsp;&ndash; cinnamon is a natural blood glucose regulator. If you are craving something sweet, a simple cinnamon herbal tea can replace this craving.</li>
<li><strong>Raw cacao powder</strong>&nbsp;&ndash; this is chocolate in its natural state before it&rsquo;s processed (and isn&rsquo;t bitter!). High in antioxidants and magnesium, it is a natural blood glucose regulator. Add to protein balls, smoothies or chia puddings for a &ldquo;healthy&rdquo; treat.</li>
<li><strong>Be prepared</strong>&nbsp;&ndash; make your own protein balls, chia puddings or healthy smoothies to have as snacks. Or activate your own nuts or prepare vegetable sticks to have with hummus.</li>
<li><strong>Do something different</strong>&nbsp;&ndash; if you do get a sugar craving&hellip; go for a walk around the block, go sit in a nearby park for 10 minutes and get your daily dose of vitamin D, download a guided Meditation App such as Headspace and do a 10-minute meditation, call a friend. You&rsquo;ll notice once you&rsquo;ve distracted yourself, the sugar craving will most likely pass. If you are doing all the above and you still notice you are having sugar cravings, you may have some underlying nutritional deficiencies or your blood glucose levels or insulin may be out of range.</li>
</ol>
<h3>Here are healthy sweet treats, all without refined sugar, gluten or anything processed.</h3>
<h5>Chocolate Bliss Balls:</h5>
<ol style="list-style-type: disc;">
<li>1 cup raw seeds or nuts of choice (eg. sunflower and pumpkin seeds)</li>
<li>1/4 cup cacao</li>
<li>1 tsp vanilla extract</li>
<li>1/4 tsp sea salt</li>
<li>1 cup medjool dates, pitted and chopped</li>
<li>1-3 tbsp water</li>
<li>1/4 cup cacao nibs (optional)</li>
<li>cacao powder or unsweetened shredded coconut, optional for coating</li>
</ol>
<h5>Instructions</h5>
<ol style="list-style-type: disc;">
<li>Place seeds/nuts in a food processor, and process until finely ground. Pulse in cacao, vanilla, and salt.</li>
<li>Add in the chopped dates and water, 1 tablespoon at a time until the dough comes together nicely. Process until all ingredients are distributed evenly (you may need to stop a few times and scrape down the sides and separate the dough if it forms a ball).</li>
<li>Pulse in the cacao nibs or chips.</li>
<li>Roll pieces of the dough into small, tablespoon-sized balls. You may roll them in the cacao powder, shredded coconut, or any other toppings of choice.</li>
<li>Place your energy bites in a container in the refrigerator or freezer for at least 30 minutes, then serve!</li>
</ol>')
INSERT [dbo].[StaticPageData] ([PageID], [Title], [Data]) VALUES (2, N'Move', N'<p>Is sitting really the new smoking?</p>
<p>At our presentations, we often delve into the research surrounding the health issues that sitting all day can cause. It has been coined &ldquo;the new smoking&rdquo;.</p>
<p>A study published in the journal Diabetologia in November 2012 studied the results of 18 studies with a total of nearly 800,000 participants. When comparing people who spent the most time sitting with those who do not, researchers found that sitting:</p>
<ul>
<li><strong>increases the risks of diabetes (112%),</strong></li>
<li><strong>increases cardiovascular events (147%),</strong></li>
<li><strong>increases the risk of death from cardiovascular causes (90%) and</strong></li>
<li><strong>increases the risk of death from all causes (49%).&nbsp;</strong></li>
</ul>
<p>As soon as you sit, electrical activity in the leg muscles shuts off; calorie burning drops to 1 per minute and insulin effectiveness drops to 24% hence the increase risk of diabetes.</p>
<p>So it is wise to say that a standing workstation is a great solution to the epidemic that is sitting, however over the 15 years of working and caring for the corporate community, I have noticed some issues that have arisen when my clients get their standing workstations.</p>
<p>Clients have reported the following:</p>
<ul>
<li>Increase in back pain: The reason that may be happening is that standing for prolonged periods also can put pressure on a weak or problematic back, especially for long hours.</li>
<li>Leg and foot pain: This is also caused from standing on hard surfaces, wearing the wrong shoes to work and or pre-existing knee or foot problems.</li>
<li>Lack of focus: This is usually due to pain or discomfort in the above-mentioned areas</li>
<li>Increase in shoulder tension: Standing requires correct posture, just like sitting does. Forward head posture and rounded shoulders will both cause pain in neck and tension in the shoulder region.</li>
</ul>
<p>So what is the solution if sitting is the new smoking and standing can cause pain and discomfort? I believe that movement is the answer. Being able to modify your desk to sit and stand helps counteract the above-mentioned problems. So when ordering a new desk make sure you opt for a sit-stand desk, and vary your time standing and sitting.</p>
<p>Whether you&rsquo;re sitting or standing you should move every 45 minutes, which mean walk around or stretch.</p>
<p>Movement is life, so move to live long and well.</p>')
INSERT [dbo].[StaticPageData] ([PageID], [Title], [Data]) VALUES (3, N'Think', N'<p class="MsoNormal" style="margin-bottom: 15.0pt; mso-outline-level: 2;"><span style="font-family: Arial, sans-serif;">Are you running away from a lion everyday?</span></p>
<p class="MsoNormal" style="margin-bottom: 7.5pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;"><span style="font-family: Arial, sans-serif;">Well, you may think you are not running away from a lion every day but your body may feel, react and process its environment as such. I am talking about the dreaded S word, STREEEESSS!</span></p>
<p class="MsoNormal" style="margin-bottom: 7.5pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;"><span style="font-family: Arial, sans-serif;">We all have it and we cannot avoid it, our fast paced lifestyle, high work demands, our environment are all conducive&nbsp;to high stress levels. &nbsp;Some&nbsp;50 years ago the level of stress was much less. We could live on one wage, the bread winner would come home and was able to switch off at the end of the day and spend time with his family. This does not happen today, the increasing cost of living, constant contact&nbsp;with work via&nbsp;with emails, messages and other digital medias, make as be constantly connected and the ability to &ldquo;switch off&rdquo; ( literally) does not happen.</span></p>
<p class="MsoNormal" style="margin-bottom: 7.5pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;"><span style="font-family: Arial, sans-serif;">When exposed to stress the body perceives it as danger and goes into what is called &ldquo;fight or flight response&rdquo; which is&nbsp;what we need so we can run&nbsp;away from lions. &nbsp;Stress is a survival tool, it enables us to run faster and react instantly, &nbsp;&nbsp;the release of chemicals in your body when faced with such danger results in the production of cortisol, increased&nbsp;blood pressure, blood sugar and suppressed&nbsp;nervous system. &nbsp;Can you imagine this process going through your body daily? High blood pressure, increase blood sugar and&nbsp;increase heart rate, imagine what that will do to your health? &nbsp;In terms of the suppression of the immune&nbsp;system, are you the type of person that never gets sick and goes on a much needed holiday and gets sick? Well that is a big sign of chronic stress, when in fight or flight being ill is not good for survival but when the stress is removed, the body has a huge rebound response&nbsp;and your immune system expresses itself with illness.</span></p>
<p class="MsoNormal" style="margin-bottom: 7.5pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;"><span style="font-family: ''Arial'',sans-serif; color: #4c4c4c;">These are 10 simple steps to decrease stress and increase health has&nbsp;made a huge difference to how I felt and to&nbsp;&nbsp;my health and I have recommended it hundreds of times to my busy and stressed clients.</span></p>
<p class="MsoNormal" style="margin-bottom: 7.5pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;"><strong><span style="font-family: ''Arial'',sans-serif; color: #4c4c4c;">10 Steps to manage stress and survive&nbsp;&nbsp;</span></strong></p>
<ol>
<li class="MsoNormal" style="margin-left: 0.25in; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;"><span style="font-family: ''Arial'',sans-serif; mso-fareast-font-family: ''Times New Roman''; color: #4c4c4c;">Identify the stress! There is no point living in denial and not recognizing what is happening in your life.</span></li>
<li class="MsoNormal" style="margin-left: 0.25in; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;"><span style="font-family: ''Arial'',sans-serif; mso-fareast-font-family: ''Times New Roman''; color: #4c4c4c;">Write it down. Write what source of stress is,&nbsp;how and why it is&nbsp;&nbsp;affecting you. And what you have learned from it. What has it taught you? How has it served you? How have you grown from it?</span></li>
<li class="MsoNormal" style="margin-left: 0.25in; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;"><span style="font-family: ''Arial'',sans-serif; mso-fareast-font-family: ''Times New Roman''; color: #4c4c4c;">What can you do to improve it? That is different for each person. I wrote my &ldquo;bucket list&rdquo; and planned when and how I was going to start crossing those things off my list.</span></li>
<li class="MsoNormal" style="margin-left: 0.25in; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;"><span style="font-family: ''Arial'',sans-serif; mso-fareast-font-family: ''Times New Roman''; color: #4c4c4c;">Meditate. Ok, &nbsp;so not everyone can be Zen and it can be a hard habit to stick to , but we found a guided meditation app done that daily for 10 minutes&nbsp;every night and morning, made sleep better, deeper and hleps you feel refreshed in the morning , and it only took 10 mins.</span></li>
<li class="MsoNormal" style="margin-left: 0.25in; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;"><span style="font-family: ''Arial'',sans-serif; mso-fareast-font-family: ''Times New Roman''; color: #4c4c4c;">Exercise, this&nbsp;is so important, it is&nbsp;a great stress relief and essential for good health.</span></li>
<li class="MsoNormal" style="margin-left: 0.25in; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;"><span style="font-family: ''Arial'',sans-serif; mso-fareast-font-family: ''Times New Roman''; color: #4c4c4c;">EAT REAL FOOD. A high sugar, high carbohydrates and a diet full of preservatives and other nasties will only aggravate your condition causing higher levels of blood sugar and inflammation in your body.</span></li>
<li class="MsoNormal" style="margin-left: 0.25in; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;"><span style="font-family: ''Arial'',sans-serif; mso-fareast-font-family: ''Times New Roman''; color: #4c4c4c;">Write down your to-do list at night. This will help you sleep better and feel like your next day is organised. Allowing you a more relaxed and deeper sleep.</span></li>
<li class="MsoNormal" style="margin-left: 0.25in; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;"><span style="font-family: ''Arial'',sans-serif; mso-fareast-font-family: ''Times New Roman''; color: #4c4c4c;">Do something relaxing at night before bed. Don&rsquo;t use laptop, phone, TV for relaxation since it stimulates part of the brain that causes bad sleeping patterns. Read a book, talk to your partner or meditate.</span></li>
<li class="MsoNormal" style="margin-left: 0.25in; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;"><span style="font-family: ''Arial'',sans-serif; mso-fareast-font-family: ''Times New Roman''; color: #4c4c4c;">Laugh! At least once a day, watch something funny, read something that will make you smile or speak to your funny friend. Laughter is a release of energy that sends happy hormones all through&nbsp;our body.</span></li>
<li class="MsoNormal" style="margin-left: 0.25in; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;"><span style="font-family: ''Arial'',sans-serif; mso-fareast-font-family: ''Times New Roman''; color: #4c4c4c;">Get in touch with Nature, go outside and walk. We all have time for it, do it on your lunch break, before or after walk. Being in the sun with allow Vitamin D exposure and increase Serotonin levels which&nbsp;helps with mood balance&nbsp;and deficiency has&nbsp;been linked to depression.</span></li>
</ol>
<p>&nbsp;</p>
<p class="MsoNormal" style="margin-left: .25in;"><span style="font-family: Arial, sans-serif; color: #4c4c4c; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;">So unless you are moving to&nbsp;a deserted island and living stress free, I hope you implement&nbsp;some of these easy and simple tips to help you IGNITE your life, and live stress free, well, maybe manage it well instead.</span></p>')
INSERT [dbo].[StaticPageData] ([PageID], [Title], [Data]) VALUES (4, N'WhatsNew', N'<p class="MsoNormal" style="margin-left: .25in;"><span style="font-family: Arial, sans-serif; color: #4c4c4c; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;">WORLD HEALTH ORGANISATION &ndash; WORLD HEALTH DAY. A LOOK AT DEPRESSION</span></p>
<p class="MsoNormal" style="margin-left: .25in;"><span style="font-family: Arial, sans-serif; color: #4c4c4c; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;">&nbsp;</span></p>
<h3 style="margin: 0in 15pt 6.75pt 0in; line-height: 13.5pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; vertical-align: baseline;"><span style="font-family: Arial, sans-serif; color: #4c4c4c; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;">&nbsp;</span><span style="font-family: ''Arial'',sans-serif; mso-fareast-font-family: ''Times New Roman''; color: #333333;"> Key facts</span></h3>
<p class="MsoNormal" style="margin: 0in 15pt 0.0001pt 0in; text-indent: -0.25in; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; vertical-align: baseline;"><!-- [if !supportLists]--><span style="font-size: 10.0pt; mso-bidi-font-size: 12.0pt; font-family: Symbol; mso-fareast-font-family: Symbol; mso-bidi-font-family: Symbol; color: #333333;">&middot;<span style="font-variant-numeric: normal; font-stretch: normal; font-size: 7pt; line-height: normal; font-family: ''Times New Roman'';">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><!--[endif]--><span style="font-family: ''Arial'',sans-serif; mso-fareast-font-family: ''Times New Roman''; color: #333333;">Depression is a common mental disorder. Globally, an estimated 350 million people of all ages suffer from depression.</span></p>
<p class="MsoNormal" style="margin: 0in 15pt 0.0001pt 0in; text-indent: -0.25in; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; vertical-align: baseline;"><!-- [if !supportLists]--><span style="font-size: 10.0pt; mso-bidi-font-size: 12.0pt; font-family: Symbol; mso-fareast-font-family: Symbol; mso-bidi-font-family: Symbol; color: #333333;">&middot;<span style="font-variant-numeric: normal; font-stretch: normal; font-size: 7pt; line-height: normal; font-family: ''Times New Roman'';">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><!--[endif]--><span style="font-family: ''Arial'',sans-serif; mso-fareast-font-family: ''Times New Roman''; color: #333333;">Depression is the leading cause of disability worldwide, and is a major contributor to the overall global burden of disease.</span></p>
<p class="MsoNormal" style="margin: 0in 15pt 0.0001pt 0in; text-indent: -0.25in; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; vertical-align: baseline;"><!-- [if !supportLists]--><span style="font-size: 10.0pt; mso-bidi-font-size: 12.0pt; font-family: Symbol; mso-fareast-font-family: Symbol; mso-bidi-font-family: Symbol; color: #333333;">&middot;<span style="font-variant-numeric: normal; font-stretch: normal; font-size: 7pt; line-height: normal; font-family: ''Times New Roman'';">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><!--[endif]--><span style="font-family: ''Arial'',sans-serif; mso-fareast-font-family: ''Times New Roman''; color: #333333;">More women are affected by depression than men.</span></p>
<p class="MsoNormal" style="margin: 0in 15pt 0.0001pt 0in; text-indent: -0.25in; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; vertical-align: baseline;"><!-- [if !supportLists]--><span style="font-size: 10.0pt; mso-bidi-font-size: 12.0pt; font-family: Symbol; mso-fareast-font-family: Symbol; mso-bidi-font-family: Symbol; color: #333333;">&middot;<span style="font-variant-numeric: normal; font-stretch: normal; font-size: 7pt; line-height: normal; font-family: ''Times New Roman'';">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><!--[endif]--><span style="font-family: ''Arial'',sans-serif; mso-fareast-font-family: ''Times New Roman''; color: #333333;">At its worst, depression can lead to suicide.</span></p>
<p class="MsoNormal" style="margin: 0in 15pt 0.0001pt 0in; text-indent: -0.25in; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; vertical-align: baseline;"><!-- [if !supportLists]--><span style="font-size: 10.0pt; mso-bidi-font-size: 12.0pt; font-family: Symbol; mso-fareast-font-family: Symbol; mso-bidi-font-family: Symbol; color: #333333;">&middot;<span style="font-variant-numeric: normal; font-stretch: normal; font-size: 7pt; line-height: normal; font-family: ''Times New Roman'';">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><!--[endif]--><span style="font-family: ''Arial'',sans-serif; mso-fareast-font-family: ''Times New Roman''; color: #333333;">There are effective treatments for depression.</span></p>
<div class="MsoNormal" style="text-align: center; margin: 7.5pt 0in 7.5pt 0in;" align="center"><hr style="color: #333333;" align="center" noshade="noshade" size="4" width="100%" /></div>
<h3 style="margin: 0in 15pt 6.75pt 0in; line-height: 13.5pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; vertical-align: baseline;"><span style="font-family: ''Arial'',sans-serif; mso-fareast-font-family: ''Times New Roman''; color: #333333;">Overview</span></h3>
<p style="margin: 0in 15pt 0.0001pt 0in; line-height: 13.5pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; vertical-align: baseline;"><span style="font-family: ''Arial'',sans-serif; color: #333333; border: none windowtext 1.0pt; mso-border-alt: none windowtext 0in; padding: 0in;">Depression is a common illness worldwide, with an estimated 350 million people affected. Depression is different from usual mood fluctuations and short-lived emotional responses to challenges in everyday life. Especially when long-lasting and with moderate or severe intensity, depression may become a serious health condition. It can cause the affected person to suffer greatly and function poorly at work, at school and in the family. At its worst, depression can lead to suicide. Over 800 000 people die due to suicide every year. Suicide is the second leading cause of death in 15-29-year-olds.</span></p>
<p style="margin: 0in 15pt 0.0001pt 0in; line-height: 13.5pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; vertical-align: baseline;"><span style="font-family: ''Arial'',sans-serif; color: #333333; border: none windowtext 1.0pt; mso-border-alt: none windowtext 0in; padding: 0in;">Although there are known, effective treatments for depression, fewer than half of those affected in the world (in many countries, fewer than 10%) receive such treatments. Barriers to effective care include a lack of resources, lack of trained health care providers, and social stigma associated with mental disorders. Another barrier to effective care is inaccurate assessment. In countries of all income levels, people who are depressed are often not correctly diagnosed, and others who do not have the disorder are too often misdiagnosed and prescribed antidepressants.</span></p>
<p style="margin: 0in 15pt 0.0001pt 0in; line-height: 13.5pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; vertical-align: baseline;"><span style="font-family: ''Arial'',sans-serif; color: #333333; border: none windowtext 1.0pt; mso-border-alt: none windowtext 0in; padding: 0in;">The burden of depression and other mental health conditions is on the rise globally. A World Health Assembly resolution passed in May 2013 has called for a comprehensive, coordinated response to mental disorders at country level.</span></p>
<h3 style="margin: 0in 15pt 6.75pt 0in; line-height: 13.5pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; vertical-align: baseline;"><span style="font-family: ''Arial'',sans-serif; mso-fareast-font-family: ''Times New Roman''; color: #333333;">Types and symptoms</span></h3>
<p style="margin: 0in 15pt 0.0001pt 0in; line-height: 13.5pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; vertical-align: baseline;"><span style="font-family: ''Arial'',sans-serif; color: #333333; border: none windowtext 1.0pt; mso-border-alt: none windowtext 0in; padding: 0in;">Depending on the number and severity of symptoms, a depressive episode can be categorized as mild, moderate, or severe.</span></p>
<p style="margin: 0in 15pt 0.0001pt 0in; line-height: 13.5pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; vertical-align: baseline;"><span style="font-family: ''Arial'',sans-serif; color: #333333; border: none windowtext 1.0pt; mso-border-alt: none windowtext 0in; padding: 0in;">A key distinction is also made between depression in people who have or do not have a history of manic episodes. Both types of depression can be chronic (i.e. over an extended period of time) with relapses, especially if they go untreated.</span></p>
<p style="margin: 0in 15pt 0.0001pt 0in; line-height: 13.5pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; vertical-align: baseline;"><strong><span style="font-family: ''Arial'',sans-serif; color: #333333; border: none windowtext 1.0pt; mso-border-alt: none windowtext 0in; padding: 0in;">Recurrent depressive disorder:</span></strong><span class="apple-converted-space"><span style="font-family: ''Arial'',sans-serif; color: #333333; border: none windowtext 1.0pt; mso-border-alt: none windowtext 0in; padding: 0in;">&nbsp;</span></span><span style="font-family: ''Arial'',sans-serif; color: #333333; border: none windowtext 1.0pt; mso-border-alt: none windowtext 0in; padding: 0in;">this disorder involves repeated depressive episodes. During these episodes, the person experiences depressed mood, loss of interest and enjoyment, and reduced energy leading to diminished activity for at least two weeks. Many people with depression also suffer from anxiety symptoms, disturbed sleep and appetite and may have feelings of guilt or low self-worth, poor concentration and even medically unexplained symptoms.</span></p>
<p style="margin: 0in 15pt 0.0001pt 0in; line-height: 13.5pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; vertical-align: baseline;"><span style="font-family: ''Arial'',sans-serif; color: #333333; border: none windowtext 1.0pt; mso-border-alt: none windowtext 0in; padding: 0in;">Depending on the number and severity of symptoms, a depressive episode can be categorized as mild, moderate, or severe. An individual with a mild depressive episode will have some difficulty in continuing with ordinary work and social activities, but will probably not cease to function completely. During a severe depressive episode, it is very unlikely that the sufferer will be able to continue with social, work, or domestic activities, except to a very limited extent.</span></p>
<p style="margin: 0in 15pt 0.0001pt 0in; line-height: 13.5pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; vertical-align: baseline;"><strong><span style="font-family: ''Arial'',sans-serif; color: #333333; border: none windowtext 1.0pt; mso-border-alt: none windowtext 0in; padding: 0in;">Bipolar affective disorder:</span></strong><span class="apple-converted-space"><span style="font-family: ''Arial'',sans-serif; color: #333333; border: none windowtext 1.0pt; mso-border-alt: none windowtext 0in; padding: 0in;">&nbsp;</span></span><span style="font-family: ''Arial'',sans-serif; color: #333333; border: none windowtext 1.0pt; mso-border-alt: none windowtext 0in; padding: 0in;">this type of depression typically consists of both manic and depressive episodes separated by periods of normal mood. Manic episodes involve elevated or irritable mood, over-activity, pressure of speech, inflated self-esteem and a decreased need for sleep.</span></p>
<h3 style="margin: 0in 15pt 6.75pt 0in; line-height: 13.5pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; vertical-align: baseline;"><span style="font-family: ''Arial'',sans-serif; mso-fareast-font-family: ''Times New Roman''; color: #333333;">Contributing factors and prevention</span></h3>
<p style="margin: 0in 15pt 0.0001pt 0in; line-height: 13.5pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; vertical-align: baseline;"><span style="font-family: ''Arial'',sans-serif; color: #333333; border: none windowtext 1.0pt; mso-border-alt: none windowtext 0in; padding: 0in;">Depression results from a complex interaction of social, psychological and biological factors. People who have gone through adverse life events (unemployment, bereavement, psychological trauma) are more likely to develop depression. Depression can, in turn, lead to more stress and dysfunction and worsen the affected person&rsquo;s life situation and depression itself.</span></p>
<p style="margin: 0in 15pt 0.0001pt 0in; line-height: 13.5pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; vertical-align: baseline;"><span style="font-family: ''Arial'',sans-serif; color: #333333; border: none windowtext 1.0pt; mso-border-alt: none windowtext 0in; padding: 0in;">There are interrelationships between depression and physical health. For example, cardiovascular disease can lead to depression and vice versa.</span></p>
<p style="margin: 0in 15pt 0.0001pt 0in; line-height: 13.5pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; vertical-align: baseline;"><span style="font-family: ''Arial'',sans-serif; color: #333333; border: none windowtext 1.0pt; mso-border-alt: none windowtext 0in; padding: 0in;">Prevention programmes have been shown to reduce depression. Effective community approaches to prevent depression include school-based programmes to enhance a pattern of positive thinking in children and adolescents. Interventions for parents of children with behavioural problems may reduce parental depressive symptoms and improve outcomes for their children. Exercise programmes for the elderly can also be effective in depression prevention.</span></p>
<p style="margin: 0in 15pt 0.0001pt 0in; line-height: 13.5pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; vertical-align: baseline;">&nbsp;</p>
<h3 style="margin: 0in 15pt 6.75pt 0in; line-height: 13.5pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; vertical-align: baseline;"><span style="font-family: ''Arial'',sans-serif; mso-fareast-font-family: ''Times New Roman''; color: #333333;">Diagnosis and treatment</span></h3>
<p style="margin: 0in 15pt 0.0001pt 0in; line-height: 13.5pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; vertical-align: baseline;"><span style="font-family: ''Arial'',sans-serif; color: #333333; border: none windowtext 1.0pt; mso-border-alt: none windowtext 0in; padding: 0in;">There are effective treatments for moderate and severe depression. Health care providers may offer psychological treatments (such as behavioural activation, cognitive behavioural therapy [CBT], and interpersonal psychotherapy [IPT]) or antidepressant medication (such as selective serotonin reuptake inhibitors [SSRIs] and tricyclic antidepressants [TCAs]). Health care providers should keep in mind the possible adverse effects associated with antidepressant medication, the ability to deliver either intervention (in terms of expertise, and/or treatment availability), and individual preferences. Different psychological treatment formats for consideration include individual and/or group face-to-face psychological treatments delivered by professionals and supervised lay therapists.</span></p>
<p style="margin: 0in 15pt 0.0001pt 0in; line-height: 13.5pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; vertical-align: baseline;"><span style="font-family: ''Arial'',sans-serif; color: #333333; border: none windowtext 1.0pt; mso-border-alt: none windowtext 0in; padding: 0in;">Psychosocial treatments are also effective for mild depression. Antidepressants can be an effective form of treatment for moderate-severe depression but are not the first line of treatment for cases of mild depression. They should not be used for treating depression in children and are not the first line of treatment in adolescents, among whom they should be used with caution.</span></p>
<p style="margin: 0in 15pt 0.0001pt 0in; line-height: 13.5pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; vertical-align: baseline;">&nbsp;</p>
<h3 style="margin: 0in 15pt 6.75pt 0in; line-height: 13.5pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; vertical-align: baseline;"><span style="font-family: ''Arial'',sans-serif; mso-fareast-font-family: ''Times New Roman''; color: #333333;">WHO response</span></h3>
<p style="margin: 0in 15pt 0.0001pt 0in; line-height: 13.5pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; vertical-align: baseline;"><span style="font-family: ''Arial'',sans-serif; color: #333333; border: none windowtext 1.0pt; mso-border-alt: none windowtext 0in; padding: 0in;">&nbsp; &nbsp; &nbsp; Depression is one of the priority conditions covered by WHO&rsquo;s Mental Health Gap Action Programme (mhGAP). The Programme aims to help countries increase services for people with mental, neurological and substance use disorders, through care provided by health workers who are not specialists in mental health. The Programme asserts that with proper care, psychosocial assistance and medication, tens of millions of people with mental disorders, including depression, could begin to lead normal lives &ndash; even where resources are scarce.</span></p>
<p style="margin: 0in 15pt 0.0001pt 0in; line-height: 13.5pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; vertical-align: baseline;"><span style="font-family: ''Arial'',sans-serif; color: #333333; border: none windowtext 1.0pt; mso-border-alt: none windowtext 0in; padding: 0in;">&nbsp;</span></p>
<p>&nbsp;</p>
<p style="margin: 0in 15pt 0.0001pt 0in; line-height: 13.5pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; vertical-align: baseline;"><span style="font-family: ''Arial'',sans-serif; color: #333333; border: none windowtext 1.0pt; mso-border-alt: none windowtext 0in; padding: 0in;">&nbsp;</span></p>')
SET IDENTITY_INSERT [dbo].[StaticPageData] OFF
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([UserID], [username], [email], [dob], [mobileph], [workph], [company], [gender], [password], [ispublic], [newsletter], [info], [isActive]) VALUES (4, N'Admin', N'admin@gmail.com', CAST(N'2017-02-09' AS Date), N'03214445292', N'03214445292', N'WELL BEING', 0, N'admin', 1, 1, N'Hi i am admin', 1)
INSERT [dbo].[User] ([UserID], [username], [email], [dob], [mobileph], [workph], [company], [gender], [password], [ispublic], [newsletter], [info], [isActive]) VALUES (5, N'Hisham', N'tagheir@gmail.com', CAST(N'1994-07-15' AS Date), N'03214445292', N'03214445292', N'WELL BEING', 0, N'pak123lahore', 1, 1, N'I want to be healthy', 0)
INSERT [dbo].[User] ([UserID], [username], [email], [dob], [mobileph], [workph], [company], [gender], [password], [ispublic], [newsletter], [info], [isActive]) VALUES (6, N'Hisham', N'tagheir.hisham@gmail.com', CAST(N'2008-06-11' AS Date), N'03214445292', N'03214445292', N'sadadasd', 0, N'hisham', 0, NULL, N'asdasdadadas', 1)
INSERT [dbo].[User] ([UserID], [username], [email], [dob], [mobileph], [workph], [company], [gender], [password], [ispublic], [newsletter], [info], [isActive]) VALUES (7, N'HISHAM PUCIT', N'bcsf13m023@pucit.edu.pk', CAST(N'2017-02-16' AS Date), N'03214445292', N'03214445292', N'sadasdas', 0, N'pak123lahore', 0, NULL, N'sdasdasdasd', 1)
SET IDENTITY_INSERT [dbo].[User] OFF
SET IDENTITY_INSERT [dbo].[UserDailyTasks] ON 

INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (67, 5, CAST(N'2017-02-17' AS Date), 11, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (68, 5, CAST(N'2017-02-17' AS Date), 12, 0)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (69, 5, CAST(N'2017-02-14' AS Date), 14, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (70, 5, CAST(N'2017-02-15' AS Date), 13, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (71, 5, CAST(N'2017-02-16' AS Date), 16, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (72, 5, CAST(N'2017-02-17' AS Date), 17, 0)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (73, 5, CAST(N'2017-02-17' AS Date), 18, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (74, 5, CAST(N'2017-02-17' AS Date), 15, 0)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (75, 5, CAST(N'2017-02-17' AS Date), 19, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (76, 5, CAST(N'2017-02-17' AS Date), 6, 0)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (77, 5, CAST(N'2017-02-17' AS Date), 7, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (78, 5, CAST(N'2017-02-17' AS Date), 8, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (79, 5, CAST(N'2017-02-17' AS Date), 9, 0)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (80, 5, CAST(N'2017-02-17' AS Date), 10, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (81, 5, CAST(N'2017-02-17' AS Date), 1, 0)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (82, 5, CAST(N'2017-02-17' AS Date), 2, 0)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (83, 5, CAST(N'2017-02-17' AS Date), 3, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (84, 5, CAST(N'2017-02-17' AS Date), 4, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (85, 5, CAST(N'2017-02-17' AS Date), 5, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (86, 4, CAST(N'2017-02-17' AS Date), 11, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (87, 4, CAST(N'2017-02-17' AS Date), 12, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (88, 4, CAST(N'2017-02-17' AS Date), 14, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (89, 4, CAST(N'2017-02-17' AS Date), 13, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (90, 4, CAST(N'2017-02-17' AS Date), 16, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (91, 4, CAST(N'2017-02-18' AS Date), 17, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (92, 4, CAST(N'2017-02-17' AS Date), 18, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (93, 4, CAST(N'2017-02-17' AS Date), 15, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (94, 4, CAST(N'2017-02-17' AS Date), 19, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (95, 4, CAST(N'2017-02-17' AS Date), 6, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (96, 4, CAST(N'2017-02-17' AS Date), 7, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (97, 4, CAST(N'2017-02-17' AS Date), 8, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (98, 4, CAST(N'2017-02-17' AS Date), 9, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (99, 4, CAST(N'2017-02-17' AS Date), 10, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (100, 4, CAST(N'2017-02-17' AS Date), 1, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (101, 4, CAST(N'2017-02-17' AS Date), 2, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (102, 4, CAST(N'2017-02-17' AS Date), 3, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (103, 4, CAST(N'2017-02-17' AS Date), 4, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (104, 4, CAST(N'2017-02-17' AS Date), 5, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (110, 5, CAST(N'2017-02-18' AS Date), 11, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (111, 4, CAST(N'2017-02-18' AS Date), 11, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (112, 4, CAST(N'2017-02-18' AS Date), 12, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (113, 4, CAST(N'2017-02-18' AS Date), 14, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (114, 4, CAST(N'2017-02-18' AS Date), 13, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (115, 4, CAST(N'2017-02-18' AS Date), 16, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (116, 4, CAST(N'2017-02-18' AS Date), 18, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (117, 4, CAST(N'2017-02-18' AS Date), 15, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (118, 4, CAST(N'2017-02-18' AS Date), 19, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (119, 4, CAST(N'2017-02-18' AS Date), 6, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (120, 4, CAST(N'2017-02-18' AS Date), 7, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (121, 4, CAST(N'2017-02-18' AS Date), 8, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (122, 4, CAST(N'2017-02-18' AS Date), 9, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (123, 4, CAST(N'2017-02-18' AS Date), 10, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (124, 4, CAST(N'2017-02-18' AS Date), 1, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (125, 4, CAST(N'2017-02-18' AS Date), 2, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (126, 4, CAST(N'2017-02-18' AS Date), 3, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (127, 4, CAST(N'2017-02-18' AS Date), 4, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (128, 4, CAST(N'2017-02-18' AS Date), 5, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (129, 4, CAST(N'2017-02-17' AS Date), 17, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (130, 4, CAST(N'2017-02-15' AS Date), 11, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (131, 4, CAST(N'2017-02-15' AS Date), 12, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (132, 4, CAST(N'2017-02-15' AS Date), 14, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (133, 4, CAST(N'2017-02-15' AS Date), 13, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (134, 4, CAST(N'2017-02-15' AS Date), 16, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (135, 4, CAST(N'2017-02-15' AS Date), 17, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (136, 4, CAST(N'2017-02-15' AS Date), 18, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (137, 4, CAST(N'2017-02-15' AS Date), 15, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (138, 4, CAST(N'2017-02-15' AS Date), 19, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (139, 5, CAST(N'2017-02-18' AS Date), 12, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (140, 5, CAST(N'2017-02-18' AS Date), 14, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (141, 5, CAST(N'2017-02-18' AS Date), 13, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (142, 5, CAST(N'2017-02-18' AS Date), 16, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (143, 5, CAST(N'2017-02-18' AS Date), 17, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (144, 5, CAST(N'2017-02-18' AS Date), 18, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (145, 5, CAST(N'2017-02-18' AS Date), 15, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (146, 5, CAST(N'2017-02-18' AS Date), 19, 0)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (147, 5, CAST(N'2017-02-18' AS Date), 6, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (148, 5, CAST(N'2017-02-18' AS Date), 7, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (149, 5, CAST(N'2017-02-18' AS Date), 8, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (150, 5, CAST(N'2017-02-18' AS Date), 9, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (151, 5, CAST(N'2017-02-18' AS Date), 10, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (152, 5, CAST(N'2017-02-18' AS Date), 1, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (153, 5, CAST(N'2017-02-18' AS Date), 2, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (154, 5, CAST(N'2017-02-18' AS Date), 3, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (155, 5, CAST(N'2017-02-18' AS Date), 4, 1)
INSERT [dbo].[UserDailyTasks] ([UserDailyTaskID], [UserID], [Day], [TaskID], [Finish]) VALUES (156, 5, CAST(N'2017-02-18' AS Date), 5, 1)
SET IDENTITY_INSERT [dbo].[UserDailyTasks] OFF
SET IDENTITY_INSERT [dbo].[UserRequest] ON 

INSERT [dbo].[UserRequest] ([RequestId], [Email], [token], [active], [oncreated]) VALUES (1, N'admin@gmail.com', N'admin@gmail.com', 1, CAST(N'2017-02-18 23:49:08.057' AS DateTime))
INSERT [dbo].[UserRequest] ([RequestId], [Email], [token], [active], [oncreated]) VALUES (2, N'tagheir@gmail.com', N'tagheir@gmail.com', 1, CAST(N'2017-02-18 23:49:22.840' AS DateTime))
INSERT [dbo].[UserRequest] ([RequestId], [Email], [token], [active], [oncreated]) VALUES (3, N'tagheiranas@gmail.com', N'df0a79d2-81e2-40b6-8f39-133e93bb84f9', 0, CAST(N'2017-02-19 00:17:48.500' AS DateTime))
INSERT [dbo].[UserRequest] ([RequestId], [Email], [token], [active], [oncreated]) VALUES (6, N'tagheir.hisham@gmail.com', N'5c1e1432-9494-45c1-b5c3-69b48fdb85c8', 1, CAST(N'2017-02-19 01:25:54.017' AS DateTime))
INSERT [dbo].[UserRequest] ([RequestId], [Email], [token], [active], [oncreated]) VALUES (7, N'bcsf13m023@pucit.edu.pk', N'ff7709d9-f168-4e27-8be6-5fd1600be04b', 1, CAST(N'2017-02-19 01:50:48.957' AS DateTime))
INSERT [dbo].[UserRequest] ([RequestId], [Email], [token], [active], [oncreated]) VALUES (8, N'hisham_don@yahoo.com', N'72235c58-4a14-42eb-b7c5-5bbc22da5bf4', 1, CAST(N'2017-02-19 06:57:33.390' AS DateTime))
INSERT [dbo].[UserRequest] ([RequestId], [Email], [token], [active], [oncreated]) VALUES (9, N'tagheir.c@gmail.com', N'e4444355-dfa1-48a9-a797-8e926f5f6213', 1, CAST(N'2017-02-19 07:21:05.897' AS DateTime))
SET IDENTITY_INSERT [dbo].[UserRequest] OFF
/****** Object:  Index [IX_AddtionalProgram]    Script Date: 20-Feb-17 3:39:31 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_AddtionalProgram] ON [dbo].[AddtionalProgram]
(
	[ProgramId] ASC,
	[ReferencedProgram] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [ProgramTaskConstraint]    Script Date: 20-Feb-17 3:39:31 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [ProgramTaskConstraint] ON [dbo].[ProgramTasks]
(
	[DayID] ASC,
	[ProgramID] ASC,
	[WeekID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_SubscribeProgram]    Script Date: 20-Feb-17 3:39:31 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_SubscribeProgram] ON [dbo].[SubscribeProgram]
(
	[ProgramID] ASC,
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [EMail_User]    Script Date: 20-Feb-17 3:39:31 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [EMail_User] ON [dbo].[User]
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_UserDailyTasks]    Script Date: 20-Feb-17 3:39:31 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_UserDailyTasks] ON [dbo].[UserDailyTasks]
(
	[TaskID] ASC,
	[UserID] ASC,
	[Day] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_UserRequest]    Script Date: 20-Feb-17 3:39:31 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_UserRequest] ON [dbo].[UserRequest]
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SubscribeProgram] ADD  CONSTRAINT [DF_SubscribeProgram_onSubscribe]  DEFAULT (getdate()) FOR [onSubscribe]
GO
ALTER TABLE [dbo].[SubscribeProgram]  WITH CHECK ADD  CONSTRAINT [FK_SubscribeProgram_Program] FOREIGN KEY([ProgramID])
REFERENCES [dbo].[Program] ([ProgramID])
GO
ALTER TABLE [dbo].[SubscribeProgram] CHECK CONSTRAINT [FK_SubscribeProgram_Program]
GO
ALTER TABLE [dbo].[SubscribeProgram]  WITH CHECK ADD  CONSTRAINT [FK_SubscribeProgram_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[SubscribeProgram] CHECK CONSTRAINT [FK_SubscribeProgram_User]
GO
ALTER TABLE [dbo].[SubscribeProgramTask]  WITH CHECK ADD  CONSTRAINT [FK_SubscribeProgramTask_ProgramTask] FOREIGN KEY([ProgramTaskID])
REFERENCES [dbo].[ProgramTasks] ([ProgramTaskID])
GO
ALTER TABLE [dbo].[SubscribeProgramTask] CHECK CONSTRAINT [FK_SubscribeProgramTask_ProgramTask]
GO
ALTER TABLE [dbo].[SubscribeProgramTask]  WITH CHECK ADD  CONSTRAINT [FK_SubscribeProgramTask_SubscribeProgram] FOREIGN KEY([SubscribeProgramID])
REFERENCES [dbo].[SubscribeProgram] ([SubscribeProgramID])
GO
ALTER TABLE [dbo].[SubscribeProgramTask] CHECK CONSTRAINT [FK_SubscribeProgramTask_SubscribeProgram]
GO
ALTER TABLE [dbo].[UserDailyTasks]  WITH CHECK ADD  CONSTRAINT [FK_UserDailyTasks_Tasks] FOREIGN KEY([TaskID])
REFERENCES [dbo].[DailyTaskPoints] ([TaskID])
GO
ALTER TABLE [dbo].[UserDailyTasks] CHECK CONSTRAINT [FK_UserDailyTasks_Tasks]
GO
ALTER TABLE [dbo].[UserDailyTasks]  WITH CHECK ADD  CONSTRAINT [FK_UserDailyTasks_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[UserDailyTasks] CHECK CONSTRAINT [FK_UserDailyTasks_Users]
GO
USE [master]
GO
ALTER DATABASE [EatMoveThink] SET  READ_WRITE 
GO
