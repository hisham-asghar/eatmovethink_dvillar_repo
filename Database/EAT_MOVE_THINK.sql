USE [EatMoveThink]
GO
/****** Object:  Table [dbo].[DailyTaskPoints]    Script Date: 18-Feb-17 3:29:34 AM ******/
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
/****** Object:  Table [dbo].[Program]    Script Date: 18-Feb-17 3:29:34 AM ******/
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
	[ImageURL] [varchar](50) NULL,
	[pdf] [varchar](50) NULL,
 CONSTRAINT [PK_Program] PRIMARY KEY CLUSTERED 
(
	[ProgramID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProgramTasks]    Script Date: 18-Feb-17 3:29:34 AM ******/
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
/****** Object:  Table [dbo].[StaticPageData]    Script Date: 18-Feb-17 3:29:34 AM ******/
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
/****** Object:  Table [dbo].[SubscribeProgram]    Script Date: 18-Feb-17 3:29:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubscribeProgram](
	[SubscribeProgramID] [int] IDENTITY(1,1) NOT NULL,
	[ProgramID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[Finish] [bit] NOT NULL,
	[onSubscribe] [date] NOT NULL CONSTRAINT [DF_SubscribeProgram_onSubscribe]  DEFAULT (getdate()),
 CONSTRAINT [PK_SubscribeProgram] PRIMARY KEY CLUSTERED 
(
	[SubscribeProgramID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SubscribeProgramTask]    Script Date: 18-Feb-17 3:29:34 AM ******/
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
/****** Object:  Table [dbo].[User]    Script Date: 18-Feb-17 3:29:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[User](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](50) NOT NULL,
	[email] [varchar](50) NOT NULL,
	[dob] [date] NOT NULL,
	[mobileph] [varchar](20) NULL,
	[workph] [varchar](20) NULL,
	[company] [varchar](100) NULL,
	[gender] [int] NOT NULL CONSTRAINT [DF_User_gender]  DEFAULT ((0)),
	[password] [varchar](50) NOT NULL,
	[ispublic] [bit] NOT NULL,
	[newsletter] [bit] NULL,
	[info] [text] NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserDailyTasks]    Script Date: 18-Feb-17 3:29:34 AM ******/
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

INSERT [dbo].[Program] ([ProgramID], [Title], [Text], [Intensity], [Points], [ImageURL], [pdf]) VALUES (7, N'5 Days Challenge', N'Running Challenge
Running Challenge
Running Challenge
Running Challenge', 1, 22, N'/img/a4d95591-f268-407e-b13c-c4640518cbee.jpg', NULL)
INSERT [dbo].[Program] ([ProgramID], [Title], [Text], [Intensity], [Points], [ImageURL], [pdf]) VALUES (8, N'5 days Program', N'Program 1
Program 1
Program 1
Program 1Program 1Program 1
Program 1
Program 1
Program 1
', 2, 1, N'/img/4a32fe19-64ec-4242-9525-3d47a2221b66.jpg', N'/docs/38f13160-8712-4ec9-8594-460b50965d9e.pdf')
INSERT [dbo].[Program] ([ProgramID], [Title], [Text], [Intensity], [Points], [ImageURL], [pdf]) VALUES (9, N'5_day_health_kickstart', N'This is a five day program for health ....', 1, 125, N'/img/2ab1147d-95f2-4c4b-8ab2-70aa66038898.jpg', N'/docs/b46e01ed-0280-4265-a7d4-70fb01070431.pdf')
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
SET IDENTITY_INSERT [dbo].[SubscribeProgram] ON 

INSERT [dbo].[SubscribeProgram] ([SubscribeProgramID], [ProgramID], [UserID], [Finish], [onSubscribe]) VALUES (13, 7, 5, 0, CAST(N'2017-02-17' AS Date))
INSERT [dbo].[SubscribeProgram] ([SubscribeProgramID], [ProgramID], [UserID], [Finish], [onSubscribe]) VALUES (14, 8, 4, 0, CAST(N'2017-02-17' AS Date))
INSERT [dbo].[SubscribeProgram] ([SubscribeProgramID], [ProgramID], [UserID], [Finish], [onSubscribe]) VALUES (15, 7, 4, 0, CAST(N'2017-02-17' AS Date))
INSERT [dbo].[SubscribeProgram] ([SubscribeProgramID], [ProgramID], [UserID], [Finish], [onSubscribe]) VALUES (16, 9, 5, 0, CAST(N'2017-02-18' AS Date))
SET IDENTITY_INSERT [dbo].[SubscribeProgram] OFF
SET IDENTITY_INSERT [dbo].[SubscribeProgramTask] ON 

INSERT [dbo].[SubscribeProgramTask] ([SubscribeProgramTaskID], [SubscribeProgramID], [ProgramTaskID]) VALUES (5, 13, 17)
INSERT [dbo].[SubscribeProgramTask] ([SubscribeProgramTaskID], [SubscribeProgramID], [ProgramTaskID]) VALUES (6, 14, 22)
INSERT [dbo].[SubscribeProgramTask] ([SubscribeProgramTaskID], [SubscribeProgramID], [ProgramTaskID]) VALUES (7, 15, 18)
INSERT [dbo].[SubscribeProgramTask] ([SubscribeProgramTaskID], [SubscribeProgramID], [ProgramTaskID]) VALUES (8, 13, 18)
INSERT [dbo].[SubscribeProgramTask] ([SubscribeProgramTaskID], [SubscribeProgramID], [ProgramTaskID]) VALUES (9, 16, 23)
SET IDENTITY_INSERT [dbo].[SubscribeProgramTask] OFF
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([UserID], [username], [email], [dob], [mobileph], [workph], [company], [gender], [password], [ispublic], [newsletter], [info]) VALUES (4, N'Admin', N'admin@gmail.com', CAST(N'2017-02-09' AS Date), N'03214445292', N'03214445292', N'WELL BEING', 0, N'admin', 1, 1, N'Hi i am admin')
INSERT [dbo].[User] ([UserID], [username], [email], [dob], [mobileph], [workph], [company], [gender], [password], [ispublic], [newsletter], [info]) VALUES (5, N'Hisham', N'tagheir@gmail.com', CAST(N'1994-07-15' AS Date), N'03214445292', N'03214445292', N'WELL BEING', 0, N'pak123lahore', 1, 1, N'I want to be healthy')
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
/****** Object:  Index [ProgramTaskConstraint]    Script Date: 18-Feb-17 3:29:34 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [ProgramTaskConstraint] ON [dbo].[ProgramTasks]
(
	[DayID] ASC,
	[ProgramID] ASC,
	[WeekID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_SubscribeProgram]    Script Date: 18-Feb-17 3:29:34 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_SubscribeProgram] ON [dbo].[SubscribeProgram]
(
	[ProgramID] ASC,
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [EMail_User]    Script Date: 18-Feb-17 3:29:34 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [EMail_User] ON [dbo].[User]
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_UserDailyTasks]    Script Date: 18-Feb-17 3:29:34 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_UserDailyTasks] ON [dbo].[UserDailyTasks]
(
	[TaskID] ASC,
	[UserID] ASC,
	[Day] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
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
