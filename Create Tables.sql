if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Tb_Requests_Tb_Consumer]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Tb_Requests] DROP CONSTRAINT FK_Tb_Requests_Tb_Consumer
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Tb_Transactions_Tb_Consumer]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Tb_Transactions] DROP CONSTRAINT FK_Tb_Transactions_Tb_Consumer
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Tb_Offers_Tb_Product]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Tb_Offers] DROP CONSTRAINT FK_Tb_Offers_Tb_Product
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Tb_Requests_Tb_Product]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Tb_Requests] DROP CONSTRAINT FK_Tb_Requests_Tb_Product
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Tb_Transactions_Tb_Product]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Tb_Transactions] DROP CONSTRAINT FK_Tb_Transactions_Tb_Product
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Tb_Offers_Tb_Supplier]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Tb_Offers] DROP CONSTRAINT FK_Tb_Offers_Tb_Supplier
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Tb_Transactions_Tb_Supplier]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Tb_Transactions] DROP CONSTRAINT FK_Tb_Transactions_Tb_Supplier
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tb_Offers]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Tb_Offers]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tb_Consumer]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Tb_Consumer]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tb_Product]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Tb_Product]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tb_Requests]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Tb_Requests]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tb_Supplier]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Tb_Supplier]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tb_Transactions]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Tb_Transactions]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tb_Date]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Tb_Date]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tb_Time]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Tb_Time]
GO

CREATE TABLE [dbo].[Tb_Offers] (
	[Supp_ID] [int] NOT NULL ,
	[Prod_ID] [int] NOT NULL ,
	[Price] [money] NULL ,
	[Quantity] [float] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Tb_Consumer] (
	[Con_ID] [int] IDENTITY (1, 1) NOT NULL ,
	[Name] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[City] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[State] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Tb_Product] (
	[Prod_ID] [int] IDENTITY (1, 1) NOT NULL ,
	[Name] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Product_Category] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Product_Line] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Product_Packaging][varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Tb_Requests] (
	[Con_ID] [int] NOT NULL ,
	[Prod_ID] [int] NOT NULL ,
	[Price] [money] NULL ,
	[Quantity] [float] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Tb_Supplier] (
	[Supp_ID] [int] IDENTITY (1, 1) NOT NULL ,
	[Name] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[City] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[State] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
) ON [PRIMARY]
GO

--one day resolution, start date January 1, 2018 is day 0
CREATE TABLE [dbo].[Tb_Date] (
	DateKey smallint IDENTITY (0, 1) PRIMARY KEY,
	--origin date periods, unique sequences
	DateWeek AS DateKey/7+1,
	DateMonth AS DATEPART(mm, DATEADD(dd, DateKey, 'January 1, 2018'))+(DATEPART(yy, DATEADD(dd, DateKey, 'January 1, 2018'))-2018)*12,
	DateMonthName AS DATENAME(mm, DATEADD(dd, DateKey, 'January 1, 2018')),
	DateQuarter AS DATEPART(qq, DATEADD(dd, DateKey, 'January 1, 2018'))+(DATEPART(yy, DATEADD(dd, DateKey, 'January 1, 2018'))-2018)*4,
	DateYear AS DATEPART(yy, DATEADD(dd, DateKey, 'January 1, 2018')),
	
	--year relative periods
	DateDayOfWeek AS DATENAME(dw, DATEADD(dd, DateKey, 'January 1, 2018')),
	DateDayOfMonth AS DATEPART(dd, DATEADD(dd, DateKey, 'January 1, 2018')),
	DateDayOfYear AS DATEPART(dy, DATEADD(dd, DateKey, 'January 1, 2018')),
	DateWeekOfYear AS DATEPART(ww, DATEADD(dd, DateKey, 'January 1, 2018')),
	DateMonthOfYear AS DATEPART(mm, DATEADD(dd, DateKey, 'January 1, 2018')),
	DateQuarterOfYear AS DATEPART(qq, DATEADD(dd, DateKey, 'January 1, 2018')),

	--184 = DATEDIFF(dd, 'January 1, 2018', 'July 1, 2017')
	FiscalWeek AS DATEPART(ww,  DATEADD(dd, DateKey + 184, 'January 1, 2018')),
	IsWeekEnd bit,
	IsHoliday bit,
	HolidayName varchar(20)
) ON [PRIMARY]
GO

--one minute resolution, first minute after midnight is minute 0
CREATE TABLE [dbo].[Tb_Time] (
	TimeKey smallint IDENTITY (0, 1) PRIMARY KEY,
	TheHour AS TimeKey/60,
	IsLunchHour AS CASE 
				WHEN TimeKey/60 BETWEEN 12 AND 13 THEN 1
				ELSE 0
			END,
	IsBusinessHour AS CASE 
				WHEN TimeKey/60 BETWEEN 9 AND 17 THEN 1
				ELSE 0
			END,
	ShiftNumber AS TimeKey/60/8 + 1
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Tb_Transactions] (
	[Tran_ID] [int] IDENTITY (1, 1) NOT NULL ,
	[Supp_ID] [int] NOT NULL ,
	[Con_ID] [int] NOT NULL ,
	[Prod_ID] [int] NOT NULL ,
	[Price] [money] NULL ,
	[Quantity] [float] NULL,
	DateKey smallint REFERENCES Tb_Date(DateKey),
	TimeKey smallint REFERENCES Tb_Time(TimeKey)
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Tb_Offers] WITH NOCHECK ADD 
	CONSTRAINT [PK_Tb_Offers] PRIMARY KEY  CLUSTERED 
	(
		[Supp_ID],
		[Prod_ID]
	)  ON [PRIMARY] ,
	CONSTRAINT [CK_Tb_Offers] CHECK ([Price] > 0.00),
	CONSTRAINT [CK_Tb_Offers_1] CHECK ([Quantity] >= 0)
GO

ALTER TABLE [dbo].[Tb_Consumer] WITH NOCHECK ADD 
	CONSTRAINT [PK_Tb_Consumer] PRIMARY KEY  CLUSTERED 
	(
		[Con_ID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Tb_Product] WITH NOCHECK ADD 
	CONSTRAINT [PK_Tb_Product] PRIMARY KEY  CLUSTERED 
	(
		[Prod_ID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Tb_Requests] WITH NOCHECK ADD 
	CONSTRAINT [PK_Tb_Requests] PRIMARY KEY  CLUSTERED 
	(
		[Con_ID],
		[Prod_ID]
	)  ON [PRIMARY] ,
	CONSTRAINT [CK_Tb_Requests] CHECK ([Price] > 0.00),
	CONSTRAINT [CK_Tb_Requests_1] CHECK ([Quantity] >= 0)
GO

ALTER TABLE [dbo].[Tb_Supplier] WITH NOCHECK ADD 
	CONSTRAINT [PK_Tb_Supplier] PRIMARY KEY  CLUSTERED 
	(
		[Supp_ID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Tb_Transactions] WITH NOCHECK ADD 
	CONSTRAINT [PK_Tb_Transactions] PRIMARY KEY  CLUSTERED 
	(
		[Tran_ID]
	)  ON [PRIMARY] ,
	CONSTRAINT [CK_Tb_Transactions] CHECK ([Price] > 0.00),
	CONSTRAINT [CK_Tb_Transactions_1] CHECK ([Quantity] > 0)
GO

ALTER TABLE [dbo].[Tb_Offers] ADD 
	CONSTRAINT [FK_Tb_Offers_Tb_Product] FOREIGN KEY 
	(
		[Prod_ID]
	) REFERENCES [dbo].[Tb_Product] (
		[Prod_ID]
	),
	CONSTRAINT [FK_Tb_Offers_Tb_Supplier] FOREIGN KEY 
	(
		[Supp_ID]
	) REFERENCES [dbo].[Tb_Supplier] (
		[Supp_ID]
	)
GO

ALTER TABLE [dbo].[Tb_Requests] ADD 
	CONSTRAINT [FK_Tb_Requests_Tb_Consumer] FOREIGN KEY 
	(
		[Con_ID]
	) REFERENCES [dbo].[Tb_Consumer] (
		[Con_ID]
	),
	CONSTRAINT [FK_Tb_Requests_Tb_Product] FOREIGN KEY 
	(
		[Prod_ID]
	) REFERENCES [dbo].[Tb_Product] (
		[Prod_ID]
	)
GO

ALTER TABLE [dbo].[Tb_Transactions] ADD 
	CONSTRAINT [FK_Tb_Transactions_Tb_Consumer] FOREIGN KEY 
	(
		[Con_ID]
	) REFERENCES [dbo].[Tb_Consumer] (
		[Con_ID]
	),
	CONSTRAINT [FK_Tb_Transactions_Tb_Product] FOREIGN KEY 
	(
		[Prod_ID]
	) REFERENCES [dbo].[Tb_Product] (
		[Prod_ID]
	),
	CONSTRAINT [FK_Tb_Transactions_Tb_Supplier] FOREIGN KEY 
	(
		[Supp_ID]
	) REFERENCES [dbo].[Tb_Supplier] (
		[Supp_ID]
	)
GO

