

USE master;
go

CREATE DATABASE trommelhelden;
go
USE trommelhelden;



/****** Object:  UserDefinedFunction [dbo].[getAnfahrtsPreis]    Script Date: 24.11.2022 17:59:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getAnfahrtsPreis](@Anfahrtsweg FLOAT ) 
RETURNS FLOAT 
AS 
	BEGIN
    DECLARE @Anfahrtspreis FLOAT
    SELECT @Anfahrtspreis = (@Anfahrtsweg * 2.5)


    IF((@Anfahrtsweg * 2.5) <= 30)
		SELECT @Anfahrtspreis = 30
    IF(@Anfahrtspreis < 0)
			SELECT @Anfahrtspreis = 0
    If((@Anfahrtsweg * 2.5) > 30)
		SELECT @Anfahrtspreis = (@Anfahrtsweg * 2.5)
    RETURN @Anfahrtspreis
END
GO
/****** Object:  Table [dbo].[Auftrag]    Script Date: 24.11.2022 17:59:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Auftrag]
(
    [Aufnr] [int] IDENTITY(1,1) NOT NULL,
    [MitID] [char](3) NULL,
    [KunNr] [int] NOT NULL,
    [AufDat] [date] NOT NULL,
    [ErlDat] [date] NULL,
    [Dauer] [decimal](5, 1) NULL,
    [Anfahrt] [int] NULL,
    [Beschreibung] [varchar](200) NULL,
    CONSTRAINT [PK__Auftrag__D56A0E13A096AE56] PRIMARY KEY CLUSTERED 
(
	[Aufnr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ersatzteil]    Script Date: 24.11.2022 17:59:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ersatzteil]
(
    [EtID] [char](5) NOT NULL,
    [EtBezeichnung] [varchar](100) NOT NULL,
    [EtPreis] [smallmoney] NOT NULL,
    [EtAnzLager] [int] NOT NULL,
    [EtHersteller] [varchar](30) NOT NULL,
    CONSTRAINT [PK__Ersatzte__E294A340180D917B] PRIMARY KEY CLUSTERED 
(
	[EtID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Gebiet]    Script Date: 24.11.2022 17:59:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Gebiet]
(
    [GebietID] [char](2) NOT NULL,
    [NLNr] [int] NULL,
    CONSTRAINT [PK__Gebiet__4A0BE64CC4519E84] PRIMARY KEY CLUSTERED 
(
	[GebietID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Kunde]    Script Date: 24.11.2022 17:59:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kunde]
(
    [KunNr] [int] IDENTITY(1,1) NOT NULL,
    [KunName] [varchar](20) NOT NULL,
    [KunOrt] [varchar](20) NOT NULL,
    [KunPLZ] [char](5) NOT NULL,
    [KunStrasse] [varchar](20) NOT NULL,
    CONSTRAINT [PK__Kunde__B067D81D772B141B] PRIMARY KEY CLUSTERED 
(
	[KunNr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Mitarbeiter]    Script Date: 24.11.2022 17:59:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mitarbeiter]
(
    [MitID] [char](3) NOT NULL,
    [MitName] [varchar](20) NOT NULL,
    [MitVorname] [varchar](20) NULL,
    [MitGebDat] [date] NOT NULL,
    [MitJob] [varchar](20) NOT NULL,
    [MitStundensatz] [smallmoney] NULL,
    [NLNr] [int] NULL,
    PRIMARY KEY CLUSTERED 
(
	[MitID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Montage]    Script Date: 24.11.2022 17:59:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Montage]
(
    [EtID] [char](5) NOT NULL,
    [AufNr] [int] NOT NULL,
    [Anzahl] [int] NOT NULL,
    PRIMARY KEY CLUSTERED 
(
	[EtID] ASC,
	[AufNr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Niederlassung]    Script Date: 24.11.2022 17:59:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Niederlassung]
(
    [NLNr] [int] IDENTITY(1,1) NOT NULL,
    [Ort] [varchar](50) NULL,
    CONSTRAINT [PK__Niederla__E26A7F379C157EC8] PRIMARY KEY CLUSTERED 
(
	[NLNr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rechnung]    Script Date: 24.11.2022 17:59:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rechnung]
(
    [KunNr] [int] NOT NULL,
    [AufNr] [int] NOT NULL,
    [RechDat] [date] NOT NULL,
    [RechBetrag] [smallmoney] NOT NULL,
    PRIMARY KEY CLUSTERED 
(
	[KunNr] ASC,
	[AufNr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Auftrag] ON

INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1191, N'103', 1281, CAST(N'2020-05-30' AS Date), CAST(N'2020-06-03' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'TEST')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1192, N'102', 1102, CAST(N'2020-05-30' AS Date), CAST(N'2020-06-03' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1193, N'105', 1329, CAST(N'2020-05-30' AS Date), CAST(N'2020-06-02' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1194, N'101', 1247, CAST(N'2020-05-30' AS Date), CAST(N'2020-06-02' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1195, N'107', 1477, CAST(N'2020-05-30' AS Date), CAST(N'2020-06-04' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1197, N'101', 1121, CAST(N'2020-05-31' AS Date), CAST(N'2020-06-02' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1198, N'102', 1145, CAST(N'2020-05-31' AS Date), CAST(N'2020-06-01' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1201, N'102', 1098, CAST(N'2020-05-31' AS Date), CAST(N'2020-06-03' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1202, N'106', 1090, CAST(N'2020-05-31' AS Date), CAST(N'2020-06-05' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1203, N'110', 1065, CAST(N'2020-05-31' AS Date), CAST(N'2020-06-02' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1204, N'107', 1472, CAST(N'2020-05-31' AS Date), CAST(N'2020-06-03' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1205, N'103', 1042, CAST(N'2020-05-31' AS Date), CAST(N'2020-06-05' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1206, N'103', 1214, CAST(N'2020-05-31' AS Date), CAST(N'2020-06-02' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1207, N'106', 1193, CAST(N'2020-05-31' AS Date), CAST(N'2020-06-04' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1208, N'102', 1237, CAST(N'2020-06-01' AS Date), CAST(N'2020-06-03' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1209, N'101', 1432, CAST(N'2020-06-01' AS Date), CAST(N'2020-06-06' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1210, N'102', 1089, CAST(N'2020-06-01' AS Date), CAST(N'2020-06-01' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1211, N'101', 1147, CAST(N'2020-06-01' AS Date), CAST(N'2020-06-01' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1212, N'102', 1292, CAST(N'2020-06-01' AS Date), CAST(N'2020-06-06' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1213, N'110', 1174, CAST(N'2020-06-02' AS Date), CAST(N'2020-06-04' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1214, N'110', 1475, CAST(N'2020-06-02' AS Date), CAST(N'2020-06-07' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1215, N'105', 1435, CAST(N'2020-06-02' AS Date), CAST(N'2020-06-05' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1216, N'101', 1320, CAST(N'2020-06-02' AS Date), CAST(N'2020-06-02' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1217, N'106', 1489, CAST(N'2020-06-03' AS Date), CAST(N'2020-06-03' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1218, N'101', 1452, CAST(N'2020-06-03' AS Date), CAST(N'2020-06-07' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1219, N'110', 1495, CAST(N'2020-06-03' AS Date), CAST(N'2020-06-04' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1220, N'106', 1123, CAST(N'2020-06-03' AS Date), CAST(N'2020-06-04' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1221, N'102', 1335, CAST(N'2020-06-03' AS Date), CAST(N'2020-06-04' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1222, N'103', 1485, CAST(N'2020-06-03' AS Date), CAST(N'2020-06-08' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1223, N'107', 1134, CAST(N'2020-06-03' AS Date), CAST(N'2020-06-06' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1224, N'103', 1061, CAST(N'2020-06-03' AS Date), CAST(N'2020-06-08' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1225, N'103', 1128, CAST(N'2020-06-03' AS Date), CAST(N'2020-06-05' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1226, N'103', 1242, CAST(N'2020-06-04' AS Date), CAST(N'2020-06-08' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1227, N'107', 1136, CAST(N'2020-06-04' AS Date), CAST(N'2020-06-04' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1228, N'101', 1379, CAST(N'2020-06-04' AS Date), CAST(N'2020-06-04' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1229, N'101', 1459, CAST(N'2020-06-04' AS Date), CAST(N'2020-06-06' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1230, N'106', 1319, CAST(N'2020-06-04' AS Date), CAST(N'2020-06-05' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1231, N'101', 1115, CAST(N'2020-06-04' AS Date), CAST(N'2020-06-04' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1232, N'101', 1404, CAST(N'2020-06-04' AS Date), CAST(N'2020-06-08' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1233, N'106', 1040, CAST(N'2020-06-05' AS Date), CAST(N'2020-06-07' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1234, N'106', 1029, CAST(N'2020-06-05' AS Date), CAST(N'2020-06-05' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1235, N'106', 1394, CAST(N'2020-06-05' AS Date), CAST(N'2020-06-09' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1236, N'101', 1023, CAST(N'2020-06-05' AS Date), CAST(N'2020-06-09' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1237, N'107', 1223, CAST(N'2020-06-05' AS Date), CAST(N'2020-06-07' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1238, N'105', 1020, CAST(N'2020-06-05' AS Date), CAST(N'2020-06-07' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1239, N'101', 1014, CAST(N'2020-06-05' AS Date), CAST(N'2020-06-09' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1240, N'106', 1174, CAST(N'2020-06-05' AS Date), CAST(N'2020-06-05' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1241, N'107', 1091, CAST(N'2020-06-05' AS Date), CAST(N'2020-06-09' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1242, N'101', 1216, CAST(N'2020-06-06' AS Date), CAST(N'2020-06-10' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1243, N'105', 1208, CAST(N'2020-06-06' AS Date), CAST(N'2020-06-10' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1244, N'106', 1001, CAST(N'2020-06-06' AS Date), CAST(N'2020-06-10' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1245, N'101', 1179, CAST(N'2020-06-06' AS Date), CAST(N'2020-06-07' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1246, N'105', 1078, CAST(N'2020-06-07' AS Date), CAST(N'2020-06-08' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1247, N'103', 1495, CAST(N'2020-06-07' AS Date), CAST(N'2020-06-11' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1248, N'106', 1355, CAST(N'2020-06-07' AS Date), CAST(N'2020-06-12' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1249, N'107', 1428, CAST(N'2020-06-07' AS Date), CAST(N'2020-06-10' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1250, N'106', 1079, CAST(N'2020-06-07' AS Date), CAST(N'2020-06-11' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1251, N'110', 1474, CAST(N'2020-06-07' AS Date), CAST(N'2020-06-12' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1252, N'107', 1071, CAST(N'2020-06-07' AS Date), CAST(N'2020-06-09' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1253, N'107', 1036, CAST(N'2020-06-07' AS Date), CAST(N'2020-06-12' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1254, N'102', 1473, CAST(N'2020-06-08' AS Date), CAST(N'2020-06-13' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1255, N'106', 1097, CAST(N'2020-06-08' AS Date), CAST(N'2020-06-12' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1256, N'101', 1022, CAST(N'2020-06-08' AS Date), CAST(N'2020-06-10' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1257, N'107', 1237, CAST(N'2020-06-09' AS Date), CAST(N'2020-06-10' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1258, N'103', 1161, CAST(N'2020-06-09' AS Date), CAST(N'2020-06-10' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1259, N'102', 1166, CAST(N'2020-06-09' AS Date), CAST(N'2020-06-13' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1260, N'103', 1285, CAST(N'2020-06-09' AS Date), CAST(N'2020-06-10' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1261, N'106', 1042, CAST(N'2020-06-09' AS Date), CAST(N'2020-06-14' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1262, N'105', 1112, CAST(N'2020-06-09' AS Date), CAST(N'2020-06-10' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1263, N'101', 1151, CAST(N'2020-06-10' AS Date), CAST(N'2020-06-15' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1264, N'106', 1154, CAST(N'2020-06-10' AS Date), CAST(N'2020-06-11' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1265, N'106', 1073, CAST(N'2020-06-10' AS Date), CAST(N'2020-06-12' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1266, N'107', 1245, CAST(N'2020-06-10' AS Date), CAST(N'2020-06-10' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1267, N'110', 1485, CAST(N'2020-06-10' AS Date), CAST(N'2020-06-11' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1268, N'102', 1187, CAST(N'2020-06-10' AS Date), CAST(N'2020-06-11' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1269, N'107', 1217, CAST(N'2020-06-10' AS Date), CAST(N'2020-06-10' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1270, N'102', 1077, CAST(N'2020-06-10' AS Date), CAST(N'2020-06-13' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1271, N'105', 1285, CAST(N'2020-06-10' AS Date), CAST(N'2020-06-10' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1272, N'105', 1070, CAST(N'2020-06-10' AS Date), CAST(N'2020-06-11' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1273, N'110', 1234, CAST(N'2020-06-11' AS Date), CAST(N'2020-06-12' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1274, N'102', 1403, CAST(N'2020-06-12' AS Date), CAST(N'2020-06-14' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1275, N'103', 1455, CAST(N'2020-06-12' AS Date), CAST(N'2020-06-13' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1276, N'105', 1219, CAST(N'2020-06-12' AS Date), CAST(N'2020-06-13' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1277, N'101', 1107, CAST(N'2020-06-13' AS Date), CAST(N'2020-06-16' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1278, N'110', 1309, CAST(N'2020-06-13' AS Date), CAST(N'2020-06-14' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1279, N'110', 1449, CAST(N'2020-06-13' AS Date), CAST(N'2020-06-13' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1280, N'110', 1321, CAST(N'2020-06-13' AS Date), CAST(N'2020-06-16' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1282, N'110', 1403, CAST(N'2020-06-13' AS Date), CAST(N'2020-06-16' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1283, N'106', 1240, CAST(N'2020-06-13' AS Date), CAST(N'2020-06-13' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1284, N'107', 1401, CAST(N'2020-06-13' AS Date), CAST(N'2020-06-14' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1285, N'110', 1337, CAST(N'2020-06-13' AS Date), CAST(N'2020-06-18' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1286, N'103', 1448, CAST(N'2020-06-13' AS Date), CAST(N'2020-06-14' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1287, N'110', 1110, CAST(N'2020-06-14' AS Date), CAST(N'2020-06-19' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1288, N'107', 1427, CAST(N'2020-06-14' AS Date), CAST(N'2020-06-19' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1289, N'110', 1090, CAST(N'2020-06-14' AS Date), CAST(N'2020-06-18' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1290, N'102', 1116, CAST(N'2020-06-14' AS Date), CAST(N'2020-06-14' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1291, N'105', 1449, CAST(N'2020-06-14' AS Date), CAST(N'2020-06-14' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1292, N'102', 1174, CAST(N'2020-06-15' AS Date), CAST(N'2020-06-20' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1293, N'101', 1423, CAST(N'2020-06-15' AS Date), CAST(N'2020-06-15' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
GO
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1294, N'102', 1316, CAST(N'2020-06-15' AS Date), CAST(N'2020-06-18' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1295, N'101', 1237, CAST(N'2020-06-15' AS Date), CAST(N'2020-06-20' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1296, N'101', 1309, CAST(N'2020-06-15' AS Date), CAST(N'2020-06-18' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1297, N'106', 1009, CAST(N'2020-06-15' AS Date), CAST(N'2020-06-16' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1298, N'107', 1277, CAST(N'2020-06-15' AS Date), CAST(N'2020-06-15' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1299, N'110', 1367, CAST(N'2020-06-15' AS Date), CAST(N'2020-06-16' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1300, N'107', 1054, CAST(N'2020-06-15' AS Date), CAST(N'2020-06-17' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1301, N'101', 1352, CAST(N'2020-06-16' AS Date), CAST(N'2020-06-20' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1302, N'106', 1413, CAST(N'2020-06-16' AS Date), CAST(N'2020-06-16' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1303, N'103', 1135, CAST(N'2020-06-17' AS Date), CAST(N'2020-06-18' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1304, N'101', 1303, CAST(N'2020-06-17' AS Date), CAST(N'2020-06-21' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1305, N'103', 1455, CAST(N'2020-06-18' AS Date), CAST(N'2020-06-18' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1306, N'101', 1429, CAST(N'2020-06-18' AS Date), CAST(N'2020-06-21' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1307, N'107', 1101, CAST(N'2020-06-18' AS Date), CAST(N'2020-06-18' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1308, N'107', 1003, CAST(N'2020-06-18' AS Date), CAST(N'2020-06-20' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1309, N'103', 1392, CAST(N'2020-06-18' AS Date), CAST(N'2020-06-19' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1310, N'103', 1247, CAST(N'2020-06-18' AS Date), CAST(N'2020-06-19' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1311, N'105', 1230, CAST(N'2020-06-18' AS Date), CAST(N'2020-06-22' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1312, N'103', 1213, CAST(N'2020-06-18' AS Date), CAST(N'2020-06-23' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1313, N'106', 1137, CAST(N'2020-06-18' AS Date), CAST(N'2020-06-22' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1314, N'105', 1347, CAST(N'2020-06-19' AS Date), CAST(N'2020-06-24' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1315, N'101', 1408, CAST(N'2020-06-19' AS Date), CAST(N'2020-06-19' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1316, N'110', 1457, CAST(N'2020-06-19' AS Date), CAST(N'2020-06-21' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1317, N'105', 1082, CAST(N'2020-06-19' AS Date), CAST(N'2020-06-21' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1318, N'101', 1422, CAST(N'2020-06-19' AS Date), CAST(N'2020-06-24' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1319, N'103', 1333, CAST(N'2020-06-19' AS Date), CAST(N'2020-06-23' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1320, N'102', 1491, CAST(N'2020-06-19' AS Date), CAST(N'2020-06-21' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1321, N'106', 1212, CAST(N'2020-06-19' AS Date), CAST(N'2020-06-21' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1322, N'106', 1090, CAST(N'2020-06-19' AS Date), CAST(N'2020-06-24' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1323, N'103', 1156, CAST(N'2020-06-19' AS Date), CAST(N'2020-06-22' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1324, N'106', 1088, CAST(N'2020-06-20' AS Date), CAST(N'2020-06-24' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1325, N'103', 1236, CAST(N'2020-06-20' AS Date), CAST(N'2020-06-21' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1326, N'102', 1328, CAST(N'2020-06-20' AS Date), CAST(N'2020-06-24' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1327, N'107', 1463, CAST(N'2020-06-20' AS Date), CAST(N'2020-06-23' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1328, N'105', 1137, CAST(N'2020-06-20' AS Date), CAST(N'2020-06-25' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1329, N'103', 1048, CAST(N'2020-06-20' AS Date), CAST(N'2020-06-22' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1330, N'105', 1074, CAST(N'2020-06-20' AS Date), CAST(N'2020-06-24' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1331, N'107', 1022, CAST(N'2020-06-20' AS Date), CAST(N'2020-06-25' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1332, N'107', 1398, CAST(N'2020-06-21' AS Date), CAST(N'2020-06-21' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1333, N'103', 1037, CAST(N'2020-06-21' AS Date), CAST(N'2020-06-22' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1334, N'102', 1235, CAST(N'2020-06-21' AS Date), CAST(N'2020-06-23' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1335, N'106', 1278, CAST(N'2020-06-21' AS Date), CAST(N'2020-06-22' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1336, N'106', 1220, CAST(N'2020-06-22' AS Date), CAST(N'2020-06-22' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1337, N'105', 1181, CAST(N'2020-06-22' AS Date), CAST(N'2020-06-25' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1338, N'101', 1134, CAST(N'2020-06-22' AS Date), CAST(N'2020-06-24' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1339, N'105', 1007, CAST(N'2020-06-22' AS Date), CAST(N'2020-06-24' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1340, N'105', 1003, CAST(N'2020-06-23' AS Date), CAST(N'2020-06-25' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1341, N'105', 1013, CAST(N'2020-06-24' AS Date), CAST(N'2020-06-28' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1342, N'102', 1265, CAST(N'2020-06-24' AS Date), CAST(N'2020-06-26' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1343, N'106', 1460, CAST(N'2020-06-24' AS Date), CAST(N'2020-06-27' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1344, N'105', 1118, CAST(N'2020-06-24' AS Date), CAST(N'2020-06-28' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1345, N'105', 1151, CAST(N'2020-06-24' AS Date), CAST(N'2020-06-29' AS Date), CAST(10.0 AS Decimal(5, 1)), 10, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1346, N'106', 1242, CAST(N'2020-06-24' AS Date), CAST(N'2020-06-25' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1347, N'107', 1333, CAST(N'2020-06-24' AS Date), CAST(N'2020-06-24' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1348, N'110', 1099, CAST(N'2020-06-24' AS Date), CAST(N'2020-06-24' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1349, N'101', 1146, CAST(N'2020-06-25' AS Date), CAST(N'2020-06-27' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1350, NULL, 1416, CAST(N'2020-06-26' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1351, NULL, 1117, CAST(N'2020-06-26' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1352, NULL, 1114, CAST(N'2020-06-26' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1353, NULL, 1293, CAST(N'2020-06-26' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1354, NULL, 1314, CAST(N'2020-06-27' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1355, NULL, 1286, CAST(N'2020-06-28' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1356, NULL, 1354, CAST(N'2020-06-28' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1357, NULL, 1176, CAST(N'2020-06-28' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1358, NULL, 1167, CAST(N'2020-06-28' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1359, NULL, 1105, CAST(N'2020-06-28' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1360, NULL, 1025, CAST(N'2020-06-28' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1361, NULL, 1088, CAST(N'2020-06-28' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1362, NULL, 1133, CAST(N'2020-06-28' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1363, NULL, 1218, CAST(N'2020-06-28' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1364, NULL, 1090, CAST(N'2020-06-28' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1365, NULL, 1425, CAST(N'2020-06-28' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1366, NULL, 1408, CAST(N'2020-06-28' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1367, NULL, 1266, CAST(N'2020-06-29' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1368, NULL, 1193, CAST(N'2020-06-29' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1369, NULL, 1212, CAST(N'2020-06-29' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1370, NULL, 1269, CAST(N'2020-06-29' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1371, NULL, 1195, CAST(N'2020-06-29' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1372, NULL, 1393, CAST(N'2020-06-29' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1373, NULL, 1331, CAST(N'2020-06-30' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1374, NULL, 1241, CAST(N'2020-06-30' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1375, NULL, 1042, CAST(N'2020-06-30' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1376, NULL, 1115, CAST(N'2020-06-30' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1377, NULL, 1323, CAST(N'2020-06-30' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1378, NULL, 1424, CAST(N'2020-06-30' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1379, NULL, 1364, CAST(N'2020-06-30' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1380, NULL, 1083, CAST(N'2020-06-30' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1381, NULL, 1393, CAST(N'2020-06-30' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1382, NULL, 1278, CAST(N'2020-06-30' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1383, NULL, 1460, CAST(N'2020-06-30' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1384, NULL, 1411, CAST(N'2020-06-30' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1385, N'102', 1349, CAST(N'2020-07-01' AS Date), CAST(N'2020-07-04' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1386, N'105', 1108, CAST(N'2020-07-01' AS Date), CAST(N'2020-07-05' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1387, N'105', 1341, CAST(N'2020-07-01' AS Date), CAST(N'2020-07-06' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1388, N'103', 1306, CAST(N'2020-07-01' AS Date), CAST(N'2020-07-05' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1389, N'101', 1313, CAST(N'2020-07-01' AS Date), CAST(N'2020-07-03' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1390, N'101', 1162, CAST(N'2020-07-01' AS Date), CAST(N'2020-07-04' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1391, N'110', 1093, CAST(N'2020-07-01' AS Date), CAST(N'2020-07-05' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1392, N'105', 1215, CAST(N'2020-07-01' AS Date), CAST(N'2020-07-06' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1393, N'105', 1028, CAST(N'2020-07-01' AS Date), CAST(N'2020-07-04' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
GO
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1394, N'106', 1220, CAST(N'2020-07-01' AS Date), CAST(N'2020-07-03' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1395, N'101', 1365, CAST(N'2020-07-01' AS Date), CAST(N'2020-07-06' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1396, N'101', 1101, CAST(N'2020-07-02' AS Date), CAST(N'2020-07-07' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1397, N'102', 1259, CAST(N'2020-07-02' AS Date), CAST(N'2020-07-05' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1398, N'103', 1031, CAST(N'2020-07-02' AS Date), CAST(N'2020-07-04' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1399, N'110', 1188, CAST(N'2020-07-02' AS Date), CAST(N'2020-07-05' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1400, N'103', 1123, CAST(N'2020-07-02' AS Date), CAST(N'2020-07-02' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1401, N'102', 1356, CAST(N'2020-07-02' AS Date), CAST(N'2020-07-05' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1402, N'101', 1200, CAST(N'2020-07-02' AS Date), CAST(N'2020-07-07' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1403, N'107', 1244, CAST(N'2020-07-02' AS Date), CAST(N'2020-07-07' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1404, N'103', 1429, CAST(N'2020-07-02' AS Date), CAST(N'2020-07-04' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1405, N'110', 1039, CAST(N'2020-07-02' AS Date), CAST(N'2020-07-06' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1406, N'105', 1079, CAST(N'2020-07-02' AS Date), CAST(N'2020-07-04' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1407, N'110', 1415, CAST(N'2020-07-03' AS Date), CAST(N'2020-07-05' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1408, N'102', 1278, CAST(N'2020-07-03' AS Date), CAST(N'2020-07-07' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1409, N'102', 1481, CAST(N'2020-07-03' AS Date), CAST(N'2020-07-04' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1410, N'110', 1263, CAST(N'2020-07-03' AS Date), CAST(N'2020-07-05' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1411, N'110', 1335, CAST(N'2020-07-04' AS Date), CAST(N'2020-07-05' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1412, N'110', 1412, CAST(N'2020-07-04' AS Date), CAST(N'2020-07-08' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1413, N'103', 1212, CAST(N'2020-07-04' AS Date), CAST(N'2020-07-07' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1414, N'106', 1421, CAST(N'2020-07-04' AS Date), CAST(N'2020-07-08' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1415, N'101', 1127, CAST(N'2020-07-04' AS Date), CAST(N'2020-07-09' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1416, N'110', 1178, CAST(N'2020-07-04' AS Date), CAST(N'2020-07-05' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1417, N'103', 1485, CAST(N'2020-07-04' AS Date), CAST(N'2020-07-09' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1418, N'107', 1392, CAST(N'2020-07-04' AS Date), CAST(N'2020-07-07' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1419, N'102', 1185, CAST(N'2020-07-04' AS Date), CAST(N'2020-07-08' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1420, N'107', 1095, CAST(N'2020-07-04' AS Date), CAST(N'2020-07-04' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1421, N'106', 1489, CAST(N'2020-07-04' AS Date), CAST(N'2020-07-05' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1422, N'101', 1014, CAST(N'2020-07-05' AS Date), CAST(N'2020-07-06' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1423, N'103', 1357, CAST(N'2020-07-05' AS Date), CAST(N'2020-07-09' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1424, N'105', 1429, CAST(N'2020-07-05' AS Date), CAST(N'2020-07-10' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1425, N'106', 1158, CAST(N'2020-07-05' AS Date), CAST(N'2020-07-08' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1426, N'107', 1357, CAST(N'2020-07-05' AS Date), CAST(N'2020-07-07' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1427, N'107', 1384, CAST(N'2020-07-05' AS Date), CAST(N'2020-07-06' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1428, N'101', 1467, CAST(N'2020-07-05' AS Date), CAST(N'2020-07-08' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1429, N'105', 1392, CAST(N'2020-07-05' AS Date), CAST(N'2020-07-09' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1430, N'105', 1495, CAST(N'2020-07-05' AS Date), CAST(N'2020-07-10' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1431, N'110', 1102, CAST(N'2020-07-05' AS Date), CAST(N'2020-07-08' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1432, N'107', 1308, CAST(N'2020-07-06' AS Date), CAST(N'2020-07-06' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1433, N'106', 1473, CAST(N'2020-07-06' AS Date), CAST(N'2020-07-10' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1434, N'107', 1316, CAST(N'2020-07-06' AS Date), CAST(N'2020-07-08' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1435, N'102', 1429, CAST(N'2020-07-06' AS Date), CAST(N'2020-07-08' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1436, N'110', 1443, CAST(N'2020-07-07' AS Date), CAST(N'2020-07-11' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1437, N'110', 1143, CAST(N'2020-07-07' AS Date), CAST(N'2020-07-09' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1438, N'103', 1110, CAST(N'2020-07-07' AS Date), CAST(N'2020-07-10' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1439, N'101', 1495, CAST(N'2020-07-07' AS Date), CAST(N'2020-07-12' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1440, N'105', 1033, CAST(N'2020-07-07' AS Date), CAST(N'2020-07-07' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1441, N'110', 1039, CAST(N'2020-07-07' AS Date), CAST(N'2020-07-09' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1442, N'101', 1146, CAST(N'2020-07-07' AS Date), CAST(N'2020-07-12' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1443, N'103', 1024, CAST(N'2020-07-07' AS Date), CAST(N'2020-07-09' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1444, N'106', 1420, CAST(N'2020-07-07' AS Date), CAST(N'2020-07-11' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1445, N'101', 1132, CAST(N'2020-07-07' AS Date), CAST(N'2020-07-12' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1446, N'107', 1399, CAST(N'2020-07-08' AS Date), CAST(N'2020-07-09' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1447, N'105', 1454, CAST(N'2020-07-08' AS Date), CAST(N'2020-07-11' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1448, N'103', 1348, CAST(N'2020-07-08' AS Date), CAST(N'2020-07-12' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1449, N'102', 1359, CAST(N'2020-07-08' AS Date), CAST(N'2020-07-10' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1450, N'106', 1061, CAST(N'2020-07-08' AS Date), CAST(N'2020-07-13' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1451, N'103', 1320, CAST(N'2020-07-08' AS Date), CAST(N'2020-07-09' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1452, N'106', 1297, CAST(N'2020-07-08' AS Date), CAST(N'2020-07-08' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1453, N'106', 1233, CAST(N'2020-07-08' AS Date), CAST(N'2020-07-09' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1454, N'107', 1273, CAST(N'2020-07-08' AS Date), CAST(N'2020-07-09' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1455, N'106', 1379, CAST(N'2020-07-08' AS Date), CAST(N'2020-07-13' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1456, N'106', 1316, CAST(N'2020-07-09' AS Date), CAST(N'2020-07-10' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1457, N'102', 1456, CAST(N'2020-07-09' AS Date), CAST(N'2020-07-14' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1458, N'102', 1338, CAST(N'2020-07-10' AS Date), CAST(N'2020-07-14' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1459, N'103', 1282, CAST(N'2020-07-10' AS Date), CAST(N'2020-07-12' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1460, N'107', 1335, CAST(N'2020-07-10' AS Date), CAST(N'2020-07-10' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1461, N'103', 1315, CAST(N'2020-07-10' AS Date), CAST(N'2020-07-14' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1462, N'107', 1297, CAST(N'2020-07-10' AS Date), CAST(N'2020-07-13' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1463, N'107', 1075, CAST(N'2020-07-10' AS Date), CAST(N'2020-07-10' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1464, N'110', 1078, CAST(N'2020-07-10' AS Date), CAST(N'2020-07-12' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1465, N'102', 1400, CAST(N'2020-07-10' AS Date), CAST(N'2020-07-11' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1466, N'101', 1227, CAST(N'2020-07-10' AS Date), CAST(N'2020-07-10' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1467, N'102', 1332, CAST(N'2020-07-10' AS Date), CAST(N'2020-07-10' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1468, NULL, 1441, CAST(N'2020-07-11' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1469, NULL, 1402, CAST(N'2020-07-11' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1470, NULL, 1168, CAST(N'2020-07-11' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1471, NULL, 1484, CAST(N'2020-07-11' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1472, NULL, 1015, CAST(N'2020-07-11' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1473, NULL, 1014, CAST(N'2020-07-11' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1474, NULL, 1125, CAST(N'2020-07-11' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1475, NULL, 1387, CAST(N'2020-07-11' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1476, NULL, 1419, CAST(N'2020-07-11' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1477, NULL, 1079, CAST(N'2020-07-11' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1478, NULL, 1478, CAST(N'2020-07-12' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1479, NULL, 1236, CAST(N'2020-07-12' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1480, NULL, 1160, CAST(N'2020-07-12' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1481, NULL, 1089, CAST(N'2020-07-12' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1482, NULL, 1448, CAST(N'2020-07-12' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1483, NULL, 1188, CAST(N'2020-07-12' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1484, NULL, 1120, CAST(N'2020-07-13' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1485, NULL, 1131, CAST(N'2020-07-13' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1486, NULL, 1389, CAST(N'2020-07-13' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1487, NULL, 1059, CAST(N'2020-07-13' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1488, NULL, 1115, CAST(N'2020-07-13' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1489, NULL, 1204, CAST(N'2020-07-14' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1490, NULL, 1113, CAST(N'2020-07-14' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1491, NULL, 1431, CAST(N'2020-07-14' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1492, NULL, 1039, CAST(N'2020-07-14' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1493, NULL, 1299, CAST(N'2020-07-14' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
GO
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1494, NULL, 1473, CAST(N'2020-07-14' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1495, NULL, 1347, CAST(N'2020-07-14' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1496, NULL, 1337, CAST(N'2020-07-14' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1497, NULL, 1095, CAST(N'2020-07-14' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1498, NULL, 1270, CAST(N'2020-07-15' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1499, NULL, 1472, CAST(N'2020-07-15' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1500, NULL, 1138, CAST(N'2020-07-15' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1501, NULL, 1301, CAST(N'2020-07-15' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1502, NULL, 1332, CAST(N'2020-07-15' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1503, NULL, 1437, CAST(N'2020-07-15' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1504, NULL, 1387, CAST(N'2020-07-15' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1505, NULL, 1109, CAST(N'2020-07-15' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1506, NULL, 1491, CAST(N'2020-07-15' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1507, NULL, 1008, CAST(N'2020-07-16' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1508, NULL, 1128, CAST(N'2020-07-16' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1509, NULL, 1349, CAST(N'2020-07-16' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1510, NULL, 1328, CAST(N'2020-07-16' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1511, NULL, 1499, CAST(N'2020-07-16' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1512, NULL, 1394, CAST(N'2020-07-16' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1513, NULL, 1210, CAST(N'2020-07-16' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1514, NULL, 1042, CAST(N'2020-07-16' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1515, NULL, 1330, CAST(N'2020-07-16' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1516, NULL, 1341, CAST(N'2020-07-16' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1517, NULL, 1105, CAST(N'2020-07-17' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1518, NULL, 1169, CAST(N'2020-07-17' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1519, NULL, 1408, CAST(N'2020-07-17' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1520, NULL, 1104, CAST(N'2020-07-17' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1521, NULL, 1475, CAST(N'2020-07-17' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1522, NULL, 1253, CAST(N'2020-07-17' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1523, NULL, 1025, CAST(N'2020-07-17' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1524, NULL, 1074, CAST(N'2020-07-17' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1525, NULL, 1134, CAST(N'2020-07-17' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1526, NULL, 1245, CAST(N'2020-07-17' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1527, NULL, 1239, CAST(N'2020-07-17' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1528, NULL, 1007, CAST(N'2020-07-17' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1529, NULL, 1440, CAST(N'2020-07-18' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1530, NULL, 1464, CAST(N'2020-07-20' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1531, NULL, 1090, CAST(N'2020-07-20' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1532, NULL, 1248, CAST(N'2020-07-20' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1533, NULL, 1085, CAST(N'2020-07-20' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1534, NULL, 1494, CAST(N'2020-07-20' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1535, NULL, 1006, CAST(N'2020-07-21' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1536, NULL, 1483, CAST(N'2020-07-21' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1537, NULL, 1335, CAST(N'2020-07-21' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1538, NULL, 1260, CAST(N'2020-07-21' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1539, NULL, 1375, CAST(N'2020-07-21' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1540, NULL, 1391, CAST(N'2020-07-21' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1541, NULL, 1290, CAST(N'2020-07-21' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1542, NULL, 1015, CAST(N'2020-07-21' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1543, NULL, 1027, CAST(N'2020-07-21' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1544, NULL, 1147, CAST(N'2020-07-21' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1545, NULL, 1475, CAST(N'2020-07-21' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1546, NULL, 1489, CAST(N'2020-07-22' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1547, NULL, 1364, CAST(N'2020-07-22' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1548, NULL, 1366, CAST(N'2020-07-22' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1549, NULL, 1325, CAST(N'2020-07-22' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1550, NULL, 1476, CAST(N'2020-07-22' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1551, NULL, 1222, CAST(N'2020-07-22' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1552, NULL, 1035, CAST(N'2020-07-23' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1553, NULL, 1438, CAST(N'2020-07-23' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1554, NULL, 1436, CAST(N'2020-07-23' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1555, NULL, 1469, CAST(N'2020-07-23' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1556, NULL, 1371, CAST(N'2020-07-23' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1557, NULL, 1467, CAST(N'2020-07-23' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1558, NULL, 1345, CAST(N'2020-07-23' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1559, NULL, 1424, CAST(N'2020-07-23' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1560, NULL, 1306, CAST(N'2020-07-23' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1561, NULL, 1035, CAST(N'2020-07-23' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1562, NULL, 1355, CAST(N'2020-07-23' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1563, NULL, 1354, CAST(N'2020-07-23' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1564, NULL, 1354, CAST(N'2020-07-24' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1565, NULL, 1318, CAST(N'2020-07-25' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1566, NULL, 1187, CAST(N'2020-07-25' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1567, NULL, 1348, CAST(N'2020-07-25' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1568, NULL, 1106, CAST(N'2020-07-25' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1569, NULL, 1224, CAST(N'2020-07-25' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1570, NULL, 1191, CAST(N'2020-07-25' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1571, NULL, 1393, CAST(N'2020-07-26' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1572, NULL, 1123, CAST(N'2020-07-26' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1573, NULL, 1361, CAST(N'2020-07-27' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1574, NULL, 1210, CAST(N'2020-07-27' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1575, NULL, 1156, CAST(N'2020-07-27' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1576, NULL, 1119, CAST(N'2020-07-27' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1577, NULL, 1436, CAST(N'2020-07-27' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1578, NULL, 1092, CAST(N'2020-07-27' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1579, NULL, 1131, CAST(N'2020-07-27' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1580, NULL, 1276, CAST(N'2020-07-27' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1581, NULL, 1421, CAST(N'2020-07-28' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1582, NULL, 1144, CAST(N'2020-07-28' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1583, NULL, 1164, CAST(N'2020-07-28' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1584, NULL, 1040, CAST(N'2020-07-29' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1585, NULL, 1113, CAST(N'2020-07-29' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1586, NULL, 1265, CAST(N'2020-07-29' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1587, NULL, 1152, CAST(N'2020-07-29' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1588, NULL, 1457, CAST(N'2020-07-29' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1589, NULL, 1321, CAST(N'2020-07-31' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1590, NULL, 1210, CAST(N'2020-07-31' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1591, NULL, 1128, CAST(N'2020-07-31' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1592, NULL, 1335, CAST(N'2020-07-31' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1593, NULL, 1418, CAST(N'2020-07-31' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
GO
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1594, NULL, 1330, CAST(N'2020-07-31' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1595, NULL, 1420, CAST(N'2020-07-31' AS Date), NULL, CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (1600, N'101', 508, CAST(N'2020-04-06' AS Date), CAST(N'2020-06-07' AS Date), CAST(4.0 AS Decimal(5, 1)), 81, N'Zufällig generierte Werte mit Stored Procedure')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3000, N'103', 1321, CAST(N'2020-10-01' AS Date), CAST(N'2020-10-03' AS Date), CAST(12.0 AS Decimal(5, 1)), 12, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3001, N'094', 1219, CAST(N'2020-10-01' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3002, N'094', 1251, CAST(N'2020-10-01' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3003, N'101', 1290, CAST(N'2020-10-01' AS Date), CAST(N'2020-10-04' AS Date), CAST(2.0 AS Decimal(5, 1)), 81, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3004, N'105', 1299, CAST(N'2020-10-02' AS Date), CAST(N'2020-10-02' AS Date), CAST(3.0 AS Decimal(5, 1)), 21, N'instabiler Aufstellort; Reinigung Vorfilter; Dichtung poroes; Hauptlager ausgeschlagen; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3005, N'106', 1466, CAST(N'2020-10-02' AS Date), CAST(N'2020-10-07' AS Date), CAST(10.0 AS Decimal(5, 1)), 10, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3006, N'101', 1004, CAST(N'2020-10-02' AS Date), CAST(N'2020-10-02' AS Date), CAST(1.5 AS Decimal(5, 1)), 17, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3007, N'103', 1037, CAST(N'2020-10-02' AS Date), CAST(N'2022-11-18' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3008, NULL, 1284, CAST(N'2020-10-03' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3009, NULL, 1078, CAST(N'2020-10-03' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3010, NULL, 1220, CAST(N'2020-10-03' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3011, N'103', 1308, CAST(N'2020-10-03' AS Date), CAST(N'2020-10-07' AS Date), CAST(1.0 AS Decimal(5, 1)), 57, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3012, N'103', 1396, CAST(N'2020-10-03' AS Date), CAST(N'2020-10-08' AS Date), CAST(2.5 AS Decimal(5, 1)), 88, N'Feinjustierung Axialmotor; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3013, NULL, 1145, CAST(N'2020-10-04' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3014, NULL, 1074, CAST(N'2020-10-05' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3015, NULL, 1338, CAST(N'2020-10-05' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3016, N'105', 1375, CAST(N'2020-10-05' AS Date), CAST(N'2020-10-05' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3017, N'101', 1207, CAST(N'2020-10-05' AS Date), CAST(N'2020-10-06' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3018, N'110', 1306, CAST(N'2020-10-05' AS Date), CAST(N'2020-10-08' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3019, N'102', 1332, CAST(N'2020-10-06' AS Date), CAST(N'2020-10-08' AS Date), CAST(1.5 AS Decimal(5, 1)), 33, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3020, NULL, 1218, CAST(N'2020-10-06' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3021, NULL, 1489, CAST(N'2020-10-06' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3022, NULL, 1358, CAST(N'2020-10-06' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3023, N'110', 1033, CAST(N'2020-10-06' AS Date), CAST(N'2020-10-10' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3024, N'106', 1054, CAST(N'2020-10-07' AS Date), CAST(N'2020-10-09' AS Date), CAST(1.5 AS Decimal(5, 1)), 51, N'Trommel klappert; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3025, NULL, 1457, CAST(N'2020-10-07' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3026, NULL, 1325, CAST(N'2020-10-07' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3027, N'103', 1386, CAST(N'2020-10-07' AS Date), CAST(N'2020-10-07' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3028, N'101', 1498, CAST(N'2020-10-07' AS Date), CAST(N'2020-10-07' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3029, NULL, 1083, CAST(N'2020-10-07' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3030, NULL, 1177, CAST(N'2020-10-07' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3031, N'101', 1384, CAST(N'2020-10-07' AS Date), CAST(N'2020-10-11' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3032, N'110', 1046, CAST(N'2020-10-07' AS Date), CAST(N'2020-10-08' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3033, N'101', 1092, CAST(N'2020-10-07' AS Date), CAST(N'2020-10-12' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3034, NULL, 1119, CAST(N'2020-10-07' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3035, N'107', 1121, CAST(N'2020-10-07' AS Date), CAST(N'2020-10-07' AS Date), CAST(3.0 AS Decimal(5, 1)), 57, N'Trommel klappert; Steckerleister korrodiert; Feinjustierung Axialmotor; instabiler Aufstellort; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3036, N'102', 1278, CAST(N'2020-10-08' AS Date), CAST(N'2020-10-13' AS Date), CAST(2.5 AS Decimal(5, 1)), 41, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3037, N'106', 1333, CAST(N'2020-10-08' AS Date), CAST(N'2020-10-08' AS Date), CAST(1.5 AS Decimal(5, 1)), 49, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3038, N'105', 1327, CAST(N'2020-10-08' AS Date), CAST(N'2020-10-09' AS Date), CAST(3.0 AS Decimal(5, 1)), 60, N'Hauptlager ausgeschlagen; Trommel klappert; Leckage am Wasserkreislauf; instabiler Aufstellort; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3039, N'107', 1248, CAST(N'2020-10-08' AS Date), CAST(N'2020-10-10' AS Date), CAST(1.5 AS Decimal(5, 1)), 28, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3040, N'102', 1156, CAST(N'2020-10-09' AS Date), CAST(N'2020-10-14' AS Date), CAST(2.0 AS Decimal(5, 1)), 101, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3041, NULL, 1119, CAST(N'2020-10-09' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3042, N'101', 1337, CAST(N'2020-10-09' AS Date), CAST(N'2020-10-12' AS Date), CAST(2.5 AS Decimal(5, 1)), 39, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3043, N'103', 1063, CAST(N'2020-10-09' AS Date), CAST(N'2020-10-11' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3044, N'107', 1443, CAST(N'2020-10-09' AS Date), CAST(N'2020-10-10' AS Date), CAST(2.0 AS Decimal(5, 1)), 57, N'Hauptlager ausgeschlagen; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3045, N'110', 1287, CAST(N'2020-10-09' AS Date), CAST(N'2020-10-09' AS Date), CAST(2.0 AS Decimal(5, 1)), 59, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3046, N'105', 1252, CAST(N'2020-10-09' AS Date), CAST(N'2020-10-12' AS Date), CAST(3.0 AS Decimal(5, 1)), 79, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3047, N'102', 1198, CAST(N'2020-10-09' AS Date), CAST(N'2020-10-10' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3048, NULL, 1453, CAST(N'2020-10-09' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3049, NULL, 1097, CAST(N'2020-10-09' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3050, NULL, 1261, CAST(N'2020-10-09' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3051, NULL, 1480, CAST(N'2020-10-10' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3052, N'105', 1309, CAST(N'2020-10-10' AS Date), CAST(N'2020-10-11' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3053, N'107', 1478, CAST(N'2020-10-10' AS Date), CAST(N'2020-10-10' AS Date), CAST(1.0 AS Decimal(5, 1)), 13, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3054, N'107', 1159, CAST(N'2020-10-10' AS Date), CAST(N'2020-10-15' AS Date), CAST(1.0 AS Decimal(5, 1)), 97, N'Leckage am Wasserkreislauf; Dichtung poroes; Heizstaebe verkalkt; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3055, NULL, 1366, CAST(N'2020-10-10' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3056, N'105', 1498, CAST(N'2020-10-10' AS Date), CAST(N'2020-10-12' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3057, N'110', 1486, CAST(N'2020-10-10' AS Date), CAST(N'2020-10-13' AS Date), CAST(2.0 AS Decimal(5, 1)), 93, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3058, N'103', 1195, CAST(N'2020-10-11' AS Date), CAST(N'2020-10-14' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3059, N'101', 1022, CAST(N'2020-10-11' AS Date), CAST(N'2020-10-16' AS Date), CAST(2.5 AS Decimal(5, 1)), 48, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3060, N'103', 1469, CAST(N'2020-10-11' AS Date), CAST(N'2020-10-13' AS Date), CAST(2.0 AS Decimal(5, 1)), 82, N'Steckerleister korrodiert; Steckerleister korrodiert; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3061, N'102', 1393, CAST(N'2020-10-11' AS Date), CAST(N'2020-10-15' AS Date), CAST(1.5 AS Decimal(5, 1)), 28, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3062, N'102', 1039, CAST(N'2020-10-11' AS Date), CAST(N'2020-10-11' AS Date), CAST(2.0 AS Decimal(5, 1)), 49, N'Sondermodell; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3063, N'107', 1002, CAST(N'2020-10-11' AS Date), CAST(N'2020-10-14' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3064, NULL, 1089, CAST(N'2020-10-11' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3065, NULL, 1253, CAST(N'2020-10-11' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3066, NULL, 1354, CAST(N'2020-10-11' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3067, N'107', 1114, CAST(N'2020-10-11' AS Date), CAST(N'2020-10-14' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3068, N'101', 1276, CAST(N'2020-10-12' AS Date), CAST(N'2020-10-13' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3069, NULL, 1323, CAST(N'2020-10-12' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3070, N'103', 1444, CAST(N'2020-10-14' AS Date), CAST(N'2020-10-14' AS Date), CAST(2.5 AS Decimal(5, 1)), 48, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3071, NULL, 1009, CAST(N'2020-10-14' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3072, NULL, 1308, CAST(N'2020-10-14' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3073, N'101', 1151, CAST(N'2020-10-14' AS Date), CAST(N'2020-10-14' AS Date), CAST(2.0 AS Decimal(5, 1)), 39, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3074, NULL, 1433, CAST(N'2020-10-14' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3075, N'105', 1341, CAST(N'2020-10-14' AS Date), CAST(N'2020-10-16' AS Date), CAST(3.0 AS Decimal(5, 1)), 65, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3076, NULL, 1214, CAST(N'2020-10-14' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3077, N'105', 1085, CAST(N'2020-10-15' AS Date), CAST(N'2020-10-18' AS Date), CAST(0.5 AS Decimal(5, 1)), 35, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3078, NULL, 1042, CAST(N'2020-10-16' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3079, N'110', 1485, CAST(N'2020-10-16' AS Date), CAST(N'2020-10-19' AS Date), CAST(2.0 AS Decimal(5, 1)), 8, N'Leckage am Wasserkreislauf; instabiler Aufstellort; Steckerleister korrodiert; Laugenpumpe leckt; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3080, NULL, 1418, CAST(N'2020-10-16' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3081, N'103', 1331, CAST(N'2020-10-16' AS Date), CAST(N'2020-10-19' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3082, NULL, 1152, CAST(N'2020-10-16' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3083, N'103', 1055, CAST(N'2020-10-18' AS Date), CAST(N'2020-10-21' AS Date), CAST(1.0 AS Decimal(5, 1)), 91, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3084, N'101', 1242, CAST(N'2020-10-18' AS Date), CAST(N'2020-10-23' AS Date), CAST(0.5 AS Decimal(5, 1)), 63, N'Trommel klappert; Kabelbruch; Heizstaebe verkalkt; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3085, N'101', 1057, CAST(N'2020-10-19' AS Date), CAST(N'2020-10-23' AS Date), CAST(2.0 AS Decimal(5, 1)), 12, N'Wackelkontakt Drehschalter; Vollverkalkung; Kabelbruch; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3086, N'110', 1492, CAST(N'2020-10-19' AS Date), CAST(N'2020-10-20' AS Date), CAST(1.0 AS Decimal(5, 1)), 10, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3087, N'101', 1390, CAST(N'2020-10-19' AS Date), CAST(N'2020-10-19' AS Date), CAST(2.0 AS Decimal(5, 1)), 55, N'instabiler Aufstellort; Sondermodell; instabiler Aufstellort; Kabelbruch; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3088, NULL, 1152, CAST(N'2020-10-19' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3089, NULL, 1340, CAST(N'2020-10-19' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3090, N'107', 1453, CAST(N'2020-10-19' AS Date), CAST(N'2020-10-23' AS Date), CAST(2.0 AS Decimal(5, 1)), 89, N'Reinigung Vorfilter; Dichtung poroes; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3091, N'106', 1023, CAST(N'2020-10-19' AS Date), CAST(N'2020-10-19' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3092, N'105', 1469, CAST(N'2020-10-20' AS Date), CAST(N'2020-10-21' AS Date), CAST(2.0 AS Decimal(5, 1)), 39, N'Leckage am Wasserkreislauf; Wackelkontakt Drehschalter; Heizstaebe verkalkt; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3093, N'105', 1335, CAST(N'2020-10-20' AS Date), CAST(N'2020-10-21' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3094, N'110', 1277, CAST(N'2020-10-20' AS Date), CAST(N'2020-10-23' AS Date), CAST(2.0 AS Decimal(5, 1)), 52, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3095, N'106', 1241, CAST(N'2020-10-20' AS Date), CAST(N'2020-10-23' AS Date), CAST(2.0 AS Decimal(5, 1)), 38, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3096, N'106', 1126, CAST(N'2020-10-20' AS Date), CAST(N'2020-10-23' AS Date), CAST(0.5 AS Decimal(5, 1)), 63, N'')
GO
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3097, NULL, 1319, CAST(N'2020-10-20' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3098, N'101', 1288, CAST(N'2020-10-20' AS Date), CAST(N'2020-10-25' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3099, N'106', 1293, CAST(N'2020-10-20' AS Date), CAST(N'2020-10-25' AS Date), CAST(3.0 AS Decimal(5, 1)), 77, N'haeufige Ueberladung; Wackelkontakt Drehschalter; instabiler Aufstellort; Wackelkontakt Steckerleiste; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3100, N'110', 1354, CAST(N'2020-10-20' AS Date), CAST(N'2020-10-25' AS Date), CAST(2.0 AS Decimal(5, 1)), 7, N'Kabelbruch; instabiler Aufstellort; Hauptlager ausgeschlagen; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3101, NULL, 1479, CAST(N'2020-10-20' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3102, NULL, 1195, CAST(N'2020-10-20' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3103, N'110', 1108, CAST(N'2020-10-20' AS Date), CAST(N'2020-10-21' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3104, NULL, 1072, CAST(N'2020-10-21' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3105, NULL, 1341, CAST(N'2020-10-21' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3106, N'107', 1148, CAST(N'2020-10-21' AS Date), CAST(N'2020-10-21' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3107, NULL, 1296, CAST(N'2020-10-21' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3108, N'107', 1156, CAST(N'2020-10-22' AS Date), CAST(N'2020-10-24' AS Date), CAST(2.5 AS Decimal(5, 1)), 9, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3109, N'103', 1231, CAST(N'2020-10-22' AS Date), CAST(N'2020-10-22' AS Date), CAST(2.5 AS Decimal(5, 1)), 64, N'Laugenpumpe leckt; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3110, N'103', 1443, CAST(N'2020-10-22' AS Date), CAST(N'2020-10-22' AS Date), CAST(1.5 AS Decimal(5, 1)), 88, N'Kabelbruch; Feinjustierung Axialmotor; Feinjustierung Axialmotor; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3111, N'105', 1487, CAST(N'2020-10-22' AS Date), CAST(N'2020-10-22' AS Date), CAST(3.0 AS Decimal(5, 1)), 31, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3112, NULL, 1026, CAST(N'2020-10-22' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3113, NULL, 1269, CAST(N'2020-10-22' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3114, N'101', 1173, CAST(N'2020-10-23' AS Date), CAST(N'2020-10-23' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3115, N'110', 1395, CAST(N'2020-10-24' AS Date), CAST(N'2020-10-27' AS Date), CAST(1.5 AS Decimal(5, 1)), 27, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3116, NULL, 1436, CAST(N'2020-10-24' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3117, NULL, 1472, CAST(N'2020-10-24' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3118, N'103', 1305, CAST(N'2020-10-24' AS Date), CAST(N'2020-10-29' AS Date), CAST(3.0 AS Decimal(5, 1)), 39, N'Leckage am Wasserkreislauf; Kabelbruch; Heizstaebe verkalkt; Wackelkontakt Drehschalter; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3119, N'102', 1387, CAST(N'2020-10-24' AS Date), CAST(N'2020-10-24' AS Date), CAST(2.5 AS Decimal(5, 1)), 60, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3120, N'105', 1353, CAST(N'2020-10-24' AS Date), CAST(N'2020-10-29' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3121, N'102', 1093, CAST(N'2020-10-24' AS Date), CAST(N'2020-10-25' AS Date), CAST(2.0 AS Decimal(5, 1)), 27, N'Heizstaebe verkalkt; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3122, N'102', 1346, CAST(N'2020-10-25' AS Date), CAST(N'2020-10-28' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3123, NULL, 1347, CAST(N'2020-10-25' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3124, N'101', 1101, CAST(N'2020-10-25' AS Date), CAST(N'2020-10-26' AS Date), CAST(1.5 AS Decimal(5, 1)), 19, N'Kabelbruch; Dichtung poroes; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3125, NULL, 1191, CAST(N'2020-10-25' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3126, N'106', 1365, CAST(N'2020-10-26' AS Date), CAST(N'2020-10-30' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3127, N'105', 1418, CAST(N'2020-10-26' AS Date), CAST(N'2020-10-28' AS Date), CAST(1.5 AS Decimal(5, 1)), 64, N'Feinjustierung Axialmotor; Hauptlager ausgeschlagen; Reinigung Vorfilter; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3128, NULL, 1430, CAST(N'2020-10-27' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3129, NULL, 1332, CAST(N'2020-10-27' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3130, N'105', 1133, CAST(N'2020-10-27' AS Date), CAST(N'2020-10-31' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3131, N'102', 1181, CAST(N'2020-10-27' AS Date), CAST(N'2020-10-28' AS Date), CAST(1.5 AS Decimal(5, 1)), 49, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3132, N'101', 1017, CAST(N'2020-10-27' AS Date), CAST(N'2020-11-01' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3133, NULL, 1132, CAST(N'2020-10-27' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3134, N'106', 1440, CAST(N'2020-10-27' AS Date), CAST(N'2020-10-27' AS Date), CAST(1.5 AS Decimal(5, 1)), 87, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3135, N'105', 1178, CAST(N'2020-10-27' AS Date), CAST(N'2020-10-27' AS Date), CAST(2.0 AS Decimal(5, 1)), 33, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3136, N'103', 1312, CAST(N'2020-10-27' AS Date), CAST(N'2020-10-28' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3137, NULL, 1231, CAST(N'2020-10-27' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3138, N'106', 1142, CAST(N'2020-10-27' AS Date), CAST(N'2020-10-29' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3139, N'101', 1385, CAST(N'2020-10-27' AS Date), CAST(N'2020-11-01' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3140, N'105', 1138, CAST(N'2020-10-28' AS Date), CAST(N'2020-11-02' AS Date), CAST(2.0 AS Decimal(5, 1)), 81, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3141, NULL, 1195, CAST(N'2020-10-28' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3142, N'110', 1211, CAST(N'2020-10-28' AS Date), CAST(N'2020-10-29' AS Date), CAST(2.5 AS Decimal(5, 1)), 31, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3143, N'106', 1492, CAST(N'2020-10-28' AS Date), CAST(N'2020-10-30' AS Date), CAST(1.5 AS Decimal(5, 1)), 73, N'Wackelkontakt Steckerleiste; Steckerleister korrodiert; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3144, N'107', 1016, CAST(N'2020-10-28' AS Date), CAST(N'2020-10-31' AS Date), CAST(2.5 AS Decimal(5, 1)), 73, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3145, N'102', 1345, CAST(N'2020-10-28' AS Date), CAST(N'2020-10-31' AS Date), CAST(1.5 AS Decimal(5, 1)), 18, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3146, N'110', 1193, CAST(N'2020-10-28' AS Date), CAST(N'2020-10-31' AS Date), CAST(1.5 AS Decimal(5, 1)), 52, N'Kabelbruch; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3147, NULL, 1139, CAST(N'2020-10-28' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3148, NULL, 1306, CAST(N'2020-10-28' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3149, N'103', 1036, CAST(N'2020-10-28' AS Date), CAST(N'2020-11-02' AS Date), CAST(3.0 AS Decimal(5, 1)), 36, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3150, N'107', 1391, CAST(N'2020-10-28' AS Date), CAST(N'2020-10-29' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3151, N'101', 1207, CAST(N'2020-10-28' AS Date), CAST(N'2020-10-28' AS Date), CAST(0.5 AS Decimal(5, 1)), 27, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3152, NULL, 1347, CAST(N'2020-10-29' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3153, N'106', 1356, CAST(N'2020-10-29' AS Date), CAST(N'2020-10-29' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3154, N'106', 1123, CAST(N'2020-10-29' AS Date), CAST(N'2020-11-02' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3155, N'105', 1351, CAST(N'2020-10-29' AS Date), CAST(N'2020-10-29' AS Date), CAST(2.0 AS Decimal(5, 1)), 24, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3156, N'106', 1095, CAST(N'2020-10-29' AS Date), CAST(N'2020-11-01' AS Date), CAST(1.5 AS Decimal(5, 1)), 14, N'Wackelkontakt Steckerleiste; Kabelbruch; Hauptlager ausgeschlagen; Kabelbruch; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3157, NULL, 1022, CAST(N'2020-10-29' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3158, N'101', 1423, CAST(N'2020-10-29' AS Date), CAST(N'2020-10-29' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3159, N'102', 1352, CAST(N'2020-10-29' AS Date), CAST(N'2020-11-02' AS Date), CAST(3.5 AS Decimal(5, 1)), 45, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3160, N'102', 1149, CAST(N'2020-10-30' AS Date), CAST(N'2020-11-02' AS Date), CAST(0.5 AS Decimal(5, 1)), 19, N'haeufige Ueberladung; Vollverkalkung; Hauptlager ausgeschlagen; Reinigung Vorfilter; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3161, NULL, 1399, CAST(N'2020-10-30' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3162, NULL, 1123, CAST(N'2020-10-30' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3163, NULL, 1335, CAST(N'2020-10-30' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3164, NULL, 1247, CAST(N'2020-10-30' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3165, N'110', 1168, CAST(N'2020-10-31' AS Date), CAST(N'2020-11-01' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3166, N'106', 1322, CAST(N'2020-10-31' AS Date), CAST(N'2020-10-31' AS Date), CAST(2.5 AS Decimal(5, 1)), 85, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3167, N'107', 1467, CAST(N'2020-10-31' AS Date), CAST(N'2020-11-03' AS Date), CAST(0.5 AS Decimal(5, 1)), 64, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3168, NULL, 1044, CAST(N'2020-10-31' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3169, N'110', 1482, CAST(N'2020-10-31' AS Date), CAST(N'2020-11-01' AS Date), CAST(1.0 AS Decimal(5, 1)), 46, N'Leckage am Wasserkreislauf; Dichtung poroes; Feinjustierung Axialmotor; Steckerleister korrodiert; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3170, N'105', 1003, CAST(N'2020-10-31' AS Date), CAST(N'2020-11-05' AS Date), CAST(2.5 AS Decimal(5, 1)), 32, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3171, N'102', 1179, CAST(N'2020-11-01' AS Date), CAST(N'2020-11-04' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3172, NULL, 1097, CAST(N'2020-11-02' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3173, N'105', 1437, CAST(N'2020-11-02' AS Date), CAST(N'2020-11-06' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3174, N'106', 1468, CAST(N'2020-11-02' AS Date), CAST(N'2020-11-03' AS Date), CAST(2.0 AS Decimal(5, 1)), 77, N'Trommel klappert; Hauptlager ausgeschlagen; Wackelkontakt Drehschalter; Wackelkontakt Steckerleiste; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3175, N'110', 1025, CAST(N'2020-11-02' AS Date), CAST(N'2020-11-05' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3176, NULL, 1227, CAST(N'2020-11-02' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3177, N'105', 1245, CAST(N'2020-11-02' AS Date), CAST(N'2020-11-05' AS Date), CAST(2.5 AS Decimal(5, 1)), 78, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3178, N'110', 1436, CAST(N'2020-11-02' AS Date), CAST(N'2020-11-05' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3179, NULL, 1097, CAST(N'2020-11-02' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3180, N'110', 1400, CAST(N'2020-11-02' AS Date), CAST(N'2020-11-02' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3181, N'107', 1326, CAST(N'2020-11-03' AS Date), CAST(N'2020-11-06' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3182, N'105', 1160, CAST(N'2020-11-03' AS Date), CAST(N'2020-11-05' AS Date), CAST(3.5 AS Decimal(5, 1)), 10, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3183, N'101', 1399, CAST(N'2020-11-04' AS Date), CAST(N'2020-11-05' AS Date), CAST(3.5 AS Decimal(5, 1)), 30, N'instabiler Aufstellort; Wackelkontakt Steckerleiste; Feinjustierung Axialmotor; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3184, NULL, 1224, CAST(N'2020-11-05' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3185, N'105', 1494, CAST(N'2020-11-05' AS Date), CAST(N'2020-11-09' AS Date), CAST(2.5 AS Decimal(5, 1)), 52, N'Vollverkalkung; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3186, NULL, 1491, CAST(N'2020-11-05' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3187, N'105', 1338, CAST(N'2020-11-05' AS Date), CAST(N'2020-11-07' AS Date), CAST(2.0 AS Decimal(5, 1)), 50, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3188, NULL, 1462, CAST(N'2020-11-05' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3189, N'103', 1095, CAST(N'2020-11-06' AS Date), CAST(N'2020-11-10' AS Date), CAST(1.0 AS Decimal(5, 1)), 94, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3190, N'102', 1173, CAST(N'2020-11-06' AS Date), CAST(N'2020-11-10' AS Date), CAST(2.5 AS Decimal(5, 1)), 49, N'Heizstaebe verkalkt; instabiler Aufstellort; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3191, N'110', 1495, CAST(N'2020-11-06' AS Date), CAST(N'2020-11-11' AS Date), CAST(1.5 AS Decimal(5, 1)), 56, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3192, N'105', 1101, CAST(N'2020-11-06' AS Date), CAST(N'2020-11-08' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3193, N'107', 1225, CAST(N'2020-11-06' AS Date), CAST(N'2020-11-07' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3194, N'106', 1372, CAST(N'2020-11-06' AS Date), CAST(N'2020-11-06' AS Date), CAST(1.5 AS Decimal(5, 1)), 51, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3195, NULL, 1069, CAST(N'2020-11-06' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3196, NULL, 1186, CAST(N'2020-11-06' AS Date), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3197, N'110', 1251, CAST(N'2020-11-06' AS Date), CAST(N'2020-11-08' AS Date), CAST(2.5 AS Decimal(5, 1)), 70, N'Steckerleister korrodiert; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3198, NULL, 1160, CAST(N'2020-11-06' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3199, N'103', 1215, CAST(N'2020-11-06' AS Date), CAST(N'2020-11-10' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3200, N'102', 1483, CAST(N'2020-11-06' AS Date), CAST(N'2020-11-09' AS Date), CAST(1.5 AS Decimal(5, 1)), 63, N'Reinigung Vorfilter; Hauptlager ausgeschlagen; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3201, N'102', 1256, CAST(N'2020-11-07' AS Date), CAST(N'2020-11-12' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3202, N'110', 1354, CAST(N'2020-11-07' AS Date), CAST(N'2020-11-11' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3203, N'105', 1101, CAST(N'2020-11-07' AS Date), CAST(N'2020-11-08' AS Date), CAST(3.0 AS Decimal(5, 1)), 51, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3204, N'101', 1461, CAST(N'2020-11-07' AS Date), CAST(N'2020-11-11' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3205, N'102', 1364, CAST(N'2020-11-07' AS Date), CAST(N'2020-11-09' AS Date), CAST(1.5 AS Decimal(5, 1)), 78, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3206, N'106', 1416, CAST(N'2020-11-07' AS Date), CAST(N'2020-11-12' AS Date), CAST(0.5 AS Decimal(5, 1)), 65, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3207, N'101', 1492, CAST(N'2020-11-07' AS Date), CAST(N'2020-11-12' AS Date), CAST(2.5 AS Decimal(5, 1)), 88, N'Heizstaebe verkalkt; Kabelbruch; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3208, N'102', 1490, CAST(N'2020-11-07' AS Date), CAST(N'2020-11-11' AS Date), CAST(0.5 AS Decimal(5, 1)), 6, N'Laugenpumpe leckt; Laugenpumpe leckt; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3209, N'110', 1348, CAST(N'2020-11-07' AS Date), CAST(N'2020-11-12' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3210, N'103', 1234, CAST(N'2020-11-07' AS Date), CAST(N'2020-11-08' AS Date), CAST(2.0 AS Decimal(5, 1)), 77, N'Vollverkalkung; Feinjustierung Axialmotor; Feinjustierung Axialmotor; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3211, N'110', 1280, CAST(N'2020-11-08' AS Date), CAST(N'2020-11-09' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3212, N'103', 1243, CAST(N'2020-11-08' AS Date), CAST(N'2020-11-08' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3213, N'102', 1119, CAST(N'2020-11-08' AS Date), CAST(N'2020-11-09' AS Date), CAST(1.5 AS Decimal(5, 1)), 65, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3214, N'107', 1481, CAST(N'2020-11-08' AS Date), CAST(N'2020-11-08' AS Date), CAST(2.0 AS Decimal(5, 1)), 66, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3215, N'102', 1008, CAST(N'2020-11-08' AS Date), CAST(N'2020-11-13' AS Date), CAST(2.0 AS Decimal(5, 1)), 10, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3216, NULL, 1215, CAST(N'2020-11-08' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3217, NULL, 1294, CAST(N'2020-11-08' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3218, N'110', 1381, CAST(N'2020-11-08' AS Date), CAST(N'2020-11-10' AS Date), CAST(2.5 AS Decimal(5, 1)), 33, N'Reinigung Vorfilter; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3219, N'106', 1195, CAST(N'2020-11-08' AS Date), CAST(N'2020-11-09' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3220, N'102', 1377, CAST(N'2020-11-08' AS Date), CAST(N'2020-11-08' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3221, N'101', 1263, CAST(N'2020-11-09' AS Date), CAST(N'2020-11-13' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3222, NULL, 1019, CAST(N'2020-11-10' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3223, N'105', 1471, CAST(N'2020-11-10' AS Date), CAST(N'2020-11-11' AS Date), CAST(2.5 AS Decimal(5, 1)), 102, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3224, NULL, 1116, CAST(N'2020-11-10' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3225, N'107', 1221, CAST(N'2020-11-10' AS Date), CAST(N'2020-11-10' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3226, NULL, 1234, CAST(N'2020-11-10' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3227, N'107', 1026, CAST(N'2020-11-10' AS Date), CAST(N'2020-11-15' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3228, N'101', 1154, CAST(N'2020-11-10' AS Date), CAST(N'2020-11-15' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3229, N'105', 1119, CAST(N'2020-11-10' AS Date), CAST(N'2020-11-10' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3230, N'105', 1142, CAST(N'2020-11-12' AS Date), CAST(N'2020-11-17' AS Date), CAST(1.5 AS Decimal(5, 1)), 100, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3231, N'110', 1446, CAST(N'2020-11-12' AS Date), CAST(N'2020-11-16' AS Date), CAST(1.5 AS Decimal(5, 1)), 12, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3232, N'102', 1038, CAST(N'2020-11-12' AS Date), CAST(N'2020-11-15' AS Date), CAST(1.0 AS Decimal(5, 1)), 86, N'Hauptlager ausgeschlagen; Trommel klappert; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3233, NULL, 1319, CAST(N'2020-11-12' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3234, NULL, 1469, CAST(N'2020-11-12' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3235, N'107', 1411, CAST(N'2020-11-12' AS Date), CAST(N'2020-11-15' AS Date), CAST(2.0 AS Decimal(5, 1)), 30, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3236, NULL, 1347, CAST(N'2020-11-12' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3237, N'101', 1372, CAST(N'2020-11-12' AS Date), CAST(N'2020-11-15' AS Date), CAST(2.0 AS Decimal(5, 1)), 5, N'Dichtung poroes; Kabelbruch; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3238, NULL, 1051, CAST(N'2020-11-12' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3239, N'106', 1134, CAST(N'2020-11-12' AS Date), CAST(N'2020-11-13' AS Date), CAST(0.5 AS Decimal(5, 1)), 43, N'Heizstaebe verkalkt; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3240, N'101', 1307, CAST(N'2020-11-12' AS Date), CAST(N'2020-11-17' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3241, N'103', 1497, CAST(N'2020-11-13' AS Date), CAST(N'2020-11-13' AS Date), CAST(2.0 AS Decimal(5, 1)), 8, N'Leckage am Wasserkreislauf; instabiler Aufstellort; Reinigung Vorfilter; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3242, N'103', 1251, CAST(N'2020-11-13' AS Date), CAST(N'2020-11-17' AS Date), CAST(1.5 AS Decimal(5, 1)), 62, N'Trommel klappert; Heizstaebe verkalkt; Kabelbruch; Laugenpumpe leckt; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3243, N'110', 1484, CAST(N'2020-11-13' AS Date), CAST(N'2020-11-14' AS Date), CAST(0.5 AS Decimal(5, 1)), 64, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3244, NULL, 1314, CAST(N'2020-11-13' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3245, NULL, 1178, CAST(N'2020-11-13' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3246, NULL, 1449, CAST(N'2020-11-13' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3247, N'106', 1188, CAST(N'2020-11-14' AS Date), CAST(N'2020-11-16' AS Date), CAST(2.0 AS Decimal(5, 1)), 30, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3248, NULL, 1007, CAST(N'2020-11-14' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3249, N'103', 1284, CAST(N'2020-11-14' AS Date), CAST(N'2020-11-17' AS Date), CAST(1.5 AS Decimal(5, 1)), 9, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3250, N'105', 1080, CAST(N'2020-11-14' AS Date), CAST(N'2020-11-14' AS Date), CAST(1.0 AS Decimal(5, 1)), 47, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3251, NULL, 1367, CAST(N'2020-11-15' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3252, NULL, 1402, CAST(N'2020-11-15' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3253, NULL, 1446, CAST(N'2020-11-15' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3254, N'105', 1453, CAST(N'2020-11-15' AS Date), CAST(N'2020-11-17' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3255, NULL, 1204, CAST(N'2020-11-15' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3256, N'110', 1261, CAST(N'2020-11-15' AS Date), CAST(N'2020-11-17' AS Date), CAST(3.5 AS Decimal(5, 1)), 50, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3257, N'107', 1314, CAST(N'2020-11-16' AS Date), CAST(N'2020-11-17' AS Date), CAST(2.0 AS Decimal(5, 1)), 102, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3258, NULL, 1235, CAST(N'2020-11-17' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3259, N'107', 1392, CAST(N'2020-11-17' AS Date), CAST(N'2020-11-19' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3260, N'105', 1398, CAST(N'2020-11-18' AS Date), CAST(N'2020-11-21' AS Date), CAST(0.5 AS Decimal(5, 1)), 9, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3261, N'110', 1474, CAST(N'2020-11-18' AS Date), CAST(N'2020-11-22' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3262, N'102', 1186, CAST(N'2020-11-18' AS Date), CAST(N'2020-11-22' AS Date), CAST(1.5 AS Decimal(5, 1)), 66, N'Wackelkontakt Steckerleiste; Dichtung poroes; Leckage am Wasserkreislauf; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3263, NULL, 1204, CAST(N'2020-11-18' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3264, N'103', 1145, CAST(N'2020-11-18' AS Date), CAST(N'2020-11-18' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3265, N'102', 1324, CAST(N'2020-11-18' AS Date), CAST(N'2020-11-23' AS Date), CAST(2.5 AS Decimal(5, 1)), 8, N'haeufige Ueberladung; Reinigung Vorfilter; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3266, NULL, 1066, CAST(N'2020-11-18' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3267, NULL, 1325, CAST(N'2020-11-18' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3268, N'107', 1421, CAST(N'2020-11-18' AS Date), CAST(N'2020-11-20' AS Date), CAST(3.5 AS Decimal(5, 1)), 80, N'Wackelkontakt Drehschalter; instabiler Aufstellort; Sondermodell; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3269, N'102', 1225, CAST(N'2020-11-18' AS Date), CAST(N'2020-11-22' AS Date), CAST(1.0 AS Decimal(5, 1)), 102, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3270, NULL, 1304, CAST(N'2020-11-18' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3271, N'107', 1287, CAST(N'2020-11-18' AS Date), CAST(N'2020-11-21' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3272, NULL, 1396, CAST(N'2020-11-19' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3273, N'107', 1244, CAST(N'2020-11-19' AS Date), CAST(N'2020-11-24' AS Date), CAST(1.0 AS Decimal(5, 1)), 19, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3274, N'110', 1398, CAST(N'2020-11-19' AS Date), CAST(N'2020-11-22' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3275, NULL, 1011, CAST(N'2020-11-19' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3276, N'106', 1307, CAST(N'2020-11-19' AS Date), CAST(N'2020-11-19' AS Date), CAST(1.5 AS Decimal(5, 1)), 28, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3277, N'110', 1045, CAST(N'2020-11-19' AS Date), CAST(N'2020-11-20' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3278, NULL, 1197, CAST(N'2020-11-19' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3279, NULL, 1061, CAST(N'2020-11-19' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3280, NULL, 1190, CAST(N'2020-11-19' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3281, N'103', 1015, CAST(N'2020-11-19' AS Date), CAST(N'2020-11-19' AS Date), CAST(2.5 AS Decimal(5, 1)), 99, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3282, N'106', 1405, CAST(N'2020-11-19' AS Date), CAST(N'2020-11-19' AS Date), CAST(1.0 AS Decimal(5, 1)), 28, N'Dichtung poroes; Wackelkontakt Steckerleiste; Leckage am Wasserkreislauf; instabiler Aufstellort; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3283, N'106', 1137, CAST(N'2020-11-20' AS Date), CAST(N'2020-11-21' AS Date), CAST(2.0 AS Decimal(5, 1)), 91, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3284, NULL, 1190, CAST(N'2020-11-20' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3285, N'105', 1400, CAST(N'2020-11-20' AS Date), CAST(N'2020-11-20' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3286, N'103', 1149, CAST(N'2020-11-20' AS Date), CAST(N'2020-11-24' AS Date), CAST(1.0 AS Decimal(5, 1)), 85, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3287, N'110', 1478, CAST(N'2020-11-20' AS Date), CAST(N'2020-11-24' AS Date), CAST(3.0 AS Decimal(5, 1)), 41, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3288, N'102', 1276, CAST(N'2020-11-20' AS Date), CAST(N'2020-11-24' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3289, N'105', 1091, CAST(N'2020-11-20' AS Date), CAST(N'2020-11-22' AS Date), CAST(0.5 AS Decimal(5, 1)), 94, N'Feinjustierung Axialmotor; Trommel klappert; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3290, N'101', 1211, CAST(N'2020-11-20' AS Date), CAST(N'2020-11-24' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3291, NULL, 1409, CAST(N'2020-11-20' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3292, N'107', 1360, CAST(N'2020-11-20' AS Date), CAST(N'2020-11-25' AS Date), CAST(2.5 AS Decimal(5, 1)), 12, N'Steckerleister korrodiert; Reinigung Vorfilter; Feinjustierung Axialmotor; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3293, N'103', 1387, CAST(N'2020-11-20' AS Date), CAST(N'2020-11-20' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3294, N'107', 1280, CAST(N'2020-11-21' AS Date), CAST(N'2020-11-26' AS Date), CAST(1.5 AS Decimal(5, 1)), 91, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3295, NULL, 1493, CAST(N'2020-11-21' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3296, N'107', 1468, CAST(N'2020-11-21' AS Date), CAST(N'2020-11-26' AS Date), CAST(2.0 AS Decimal(5, 1)), 81, N'')
GO
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3297, N'102', 1441, CAST(N'2020-11-21' AS Date), CAST(N'2020-11-22' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3298, NULL, 1320, CAST(N'2020-11-21' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3299, N'110', 1395, CAST(N'2020-11-21' AS Date), CAST(N'2020-11-21' AS Date), CAST(3.5 AS Decimal(5, 1)), 70, N'Leckage am Wasserkreislauf; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3300, N'106', 1152, CAST(N'2020-11-21' AS Date), CAST(N'2020-11-25' AS Date), CAST(2.5 AS Decimal(5, 1)), 75, N'Hauptlager ausgeschlagen; Wackelkontakt Steckerleiste; Reinigung Vorfilter; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3301, NULL, 1214, CAST(N'2020-11-21' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3302, N'110', 1162, CAST(N'2020-11-21' AS Date), CAST(N'2020-11-22' AS Date), CAST(3.0 AS Decimal(5, 1)), 83, N'Dichtung poroes; Feinjustierung Axialmotor; Sondermodell; Laugenpumpe leckt; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3303, NULL, 1489, CAST(N'2020-11-21' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3304, N'106', 1279, CAST(N'2020-11-21' AS Date), CAST(N'2020-11-24' AS Date), CAST(2.5 AS Decimal(5, 1)), 72, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3305, NULL, 1392, CAST(N'2020-11-22' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3306, N'102', 1115, CAST(N'2020-11-22' AS Date), CAST(N'2020-11-22' AS Date), CAST(3.5 AS Decimal(5, 1)), 35, N'Kabelbruch; Kabelbruch; Dichtung poroes; Laugenpumpe leckt; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3307, N'106', 1242, CAST(N'2020-11-22' AS Date), CAST(N'2020-11-22' AS Date), CAST(0.5 AS Decimal(5, 1)), 17, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3308, NULL, 1429, CAST(N'2020-11-22' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3309, N'103', 1485, CAST(N'2020-11-22' AS Date), CAST(N'2020-11-24' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3310, N'102', 1079, CAST(N'2020-11-22' AS Date), CAST(N'2020-11-23' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3311, N'101', 1129, CAST(N'2020-11-22' AS Date), CAST(N'2020-11-23' AS Date), CAST(2.0 AS Decimal(5, 1)), 47, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3312, N'101', 1397, CAST(N'2020-11-22' AS Date), CAST(N'2020-11-23' AS Date), CAST(3.0 AS Decimal(5, 1)), 21, N'Wackelkontakt Drehschalter; Laugenpumpe leckt; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3313, N'103', 1033, CAST(N'2020-11-23' AS Date), CAST(N'2020-11-25' AS Date), CAST(2.0 AS Decimal(5, 1)), 45, N'Dichtung poroes; Vollverkalkung; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3314, N'101', 1118, CAST(N'2020-11-23' AS Date), CAST(N'2020-11-24' AS Date), CAST(1.5 AS Decimal(5, 1)), 7, N'Sondermodell; Feinjustierung Axialmotor; Sondermodell; Reinigung Vorfilter; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3315, N'103', 1021, CAST(N'2020-11-23' AS Date), CAST(N'2020-11-27' AS Date), CAST(3.0 AS Decimal(5, 1)), 67, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3316, N'106', 1490, CAST(N'2020-11-23' AS Date), CAST(N'2020-11-24' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3317, N'107', 1396, CAST(N'2020-11-23' AS Date), CAST(N'2020-11-27' AS Date), CAST(2.0 AS Decimal(5, 1)), 85, N'haeufige Ueberladung; Vollverkalkung; Kabelbruch; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3318, N'105', 1211, CAST(N'2020-11-23' AS Date), CAST(N'2020-11-24' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3319, NULL, 1472, CAST(N'2020-11-24' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3320, NULL, 1434, CAST(N'2020-11-24' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3321, N'103', 1392, CAST(N'2020-11-24' AS Date), CAST(N'2020-11-27' AS Date), CAST(1.5 AS Decimal(5, 1)), 72, N'haeufige Ueberladung; Steckerleister korrodiert; Trommel klappert; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3322, N'102', 1268, CAST(N'2020-11-24' AS Date), CAST(N'2020-11-27' AS Date), CAST(2.5 AS Decimal(5, 1)), 20, N'Trommel klappert; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3323, N'110', 1467, CAST(N'2020-11-24' AS Date), CAST(N'2020-11-28' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3324, N'101', 1268, CAST(N'2020-11-24' AS Date), CAST(N'2020-11-26' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3325, NULL, 1129, CAST(N'2020-11-24' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3326, N'105', 1265, CAST(N'2020-11-24' AS Date), CAST(N'2020-11-29' AS Date), CAST(2.0 AS Decimal(5, 1)), 7, N'Wackelkontakt Steckerleiste; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3327, N'110', 1485, CAST(N'2020-11-24' AS Date), CAST(N'2020-11-25' AS Date), CAST(2.0 AS Decimal(5, 1)), 7, N'Steckerleister korrodiert; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3328, N'103', 1249, CAST(N'2020-11-24' AS Date), CAST(N'2020-11-27' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3329, N'110', 1430, CAST(N'2020-11-24' AS Date), CAST(N'2020-11-26' AS Date), CAST(2.0 AS Decimal(5, 1)), 95, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3330, NULL, 1329, CAST(N'2020-11-25' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3331, N'102', 1286, CAST(N'2020-11-25' AS Date), CAST(N'2020-11-26' AS Date), CAST(3.0 AS Decimal(5, 1)), 26, N'Wackelkontakt Steckerleiste; Vollverkalkung; Laugenpumpe leckt; Dichtung poroes; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3332, N'102', 1224, CAST(N'2020-11-25' AS Date), CAST(N'2020-11-27' AS Date), CAST(2.5 AS Decimal(5, 1)), 75, N'Sondermodell; Leckage am Wasserkreislauf; Laugenpumpe leckt; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3333, N'106', 1453, CAST(N'2020-11-26' AS Date), CAST(N'2020-11-29' AS Date), CAST(2.0 AS Decimal(5, 1)), 66, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3334, N'110', 1312, CAST(N'2020-11-26' AS Date), CAST(N'2020-11-28' AS Date), CAST(2.0 AS Decimal(5, 1)), 89, N'Reinigung Vorfilter; Wackelkontakt Steckerleiste; Hauptlager ausgeschlagen; Vollverkalkung; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3335, NULL, 1252, CAST(N'2020-11-26' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3336, N'106', 1021, CAST(N'2020-11-26' AS Date), CAST(N'2020-11-29' AS Date), CAST(2.0 AS Decimal(5, 1)), 77, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3337, NULL, 1055, CAST(N'2020-11-27' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3338, N'102', 1377, CAST(N'2020-11-27' AS Date), CAST(N'2020-12-02' AS Date), CAST(2.0 AS Decimal(5, 1)), 53, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3339, NULL, 1145, CAST(N'2020-11-27' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3340, N'101', 1079, CAST(N'2020-11-27' AS Date), CAST(N'2020-12-01' AS Date), CAST(2.0 AS Decimal(5, 1)), 7, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3341, N'106', 1298, CAST(N'2020-11-27' AS Date), CAST(N'2020-11-29' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3342, NULL, 1177, CAST(N'2020-11-27' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3343, NULL, 1085, CAST(N'2020-11-27' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3344, N'103', 1436, CAST(N'2020-11-28' AS Date), CAST(N'2020-12-01' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3345, N'103', 1112, CAST(N'2020-11-28' AS Date), CAST(N'2020-12-02' AS Date), CAST(1.5 AS Decimal(5, 1)), 52, N'Heizstaebe verkalkt; Kabelbruch; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3346, N'106', 1129, CAST(N'2020-11-28' AS Date), CAST(N'2020-11-28' AS Date), CAST(2.5 AS Decimal(5, 1)), 80, N'haeufige Ueberladung; Reinigung Vorfilter; Reinigung Vorfilter; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3347, NULL, 1444, CAST(N'2020-11-28' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3348, N'103', 1003, CAST(N'2020-11-28' AS Date), CAST(N'2020-12-03' AS Date), CAST(2.5 AS Decimal(5, 1)), 85, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3349, NULL, 1492, CAST(N'2020-11-29' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3350, NULL, 1121, CAST(N'2020-11-30' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3351, N'110', 1370, CAST(N'2020-11-30' AS Date), CAST(N'2020-12-02' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3352, N'102', 1268, CAST(N'2020-11-30' AS Date), CAST(N'2020-11-30' AS Date), CAST(2.0 AS Decimal(5, 1)), 81, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3353, N'101', 1178, CAST(N'2020-11-30' AS Date), CAST(N'2020-12-02' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3354, N'106', 1068, CAST(N'2020-11-30' AS Date), CAST(N'2020-12-04' AS Date), CAST(1.0 AS Decimal(5, 1)), 46, N'haeufige Ueberladung; Laugenpumpe leckt; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3355, N'107', 1323, CAST(N'2020-11-30' AS Date), CAST(N'2020-11-30' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3356, N'102', 1050, CAST(N'2020-11-30' AS Date), CAST(N'2020-12-03' AS Date), CAST(2.5 AS Decimal(5, 1)), 30, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3357, N'101', 1298, CAST(N'2020-11-30' AS Date), CAST(N'2020-12-03' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3358, N'101', 1263, CAST(N'2020-11-30' AS Date), CAST(N'2020-12-04' AS Date), CAST(2.0 AS Decimal(5, 1)), 11, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3359, N'107', 1193, CAST(N'2020-12-01' AS Date), CAST(N'2020-12-01' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3360, N'110', 1313, CAST(N'2020-12-01' AS Date), CAST(N'2020-12-06' AS Date), CAST(1.5 AS Decimal(5, 1)), 71, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3361, N'103', 1181, CAST(N'2020-12-01' AS Date), CAST(N'2020-12-06' AS Date), CAST(3.0 AS Decimal(5, 1)), 92, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3362, NULL, 1336, CAST(N'2020-12-01' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3363, N'105', 1038, CAST(N'2020-12-01' AS Date), CAST(N'2020-12-03' AS Date), CAST(2.0 AS Decimal(5, 1)), 43, N'haeufige Ueberladung; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3364, NULL, 1041, CAST(N'2020-12-01' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3365, N'110', 1296, CAST(N'2020-12-01' AS Date), CAST(N'2020-12-04' AS Date), CAST(3.0 AS Decimal(5, 1)), 23, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3366, N'106', 1375, CAST(N'2020-12-01' AS Date), CAST(N'2020-12-06' AS Date), CAST(3.5 AS Decimal(5, 1)), 19, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3367, N'102', 1463, CAST(N'2020-12-01' AS Date), CAST(N'2020-12-01' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3368, N'103', 1292, CAST(N'2020-12-02' AS Date), CAST(N'2020-12-02' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3369, N'105', 1297, CAST(N'2020-12-02' AS Date), CAST(N'2020-12-03' AS Date), CAST(2.0 AS Decimal(5, 1)), 11, N'Vollverkalkung; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3370, NULL, 1298, CAST(N'2020-12-05' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3371, N'103', 1439, CAST(N'2020-12-05' AS Date), CAST(N'2020-12-10' AS Date), CAST(1.0 AS Decimal(5, 1)), 32, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3372, N'110', 1198, CAST(N'2020-12-05' AS Date), CAST(N'2020-12-08' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3373, NULL, 1106, CAST(N'2020-12-05' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3374, N'110', 1116, CAST(N'2020-12-05' AS Date), CAST(N'2020-12-06' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3375, NULL, 1243, CAST(N'2020-12-05' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3376, N'107', 1359, CAST(N'2020-12-05' AS Date), CAST(N'2020-12-05' AS Date), CAST(2.5 AS Decimal(5, 1)), 62, N'Wackelkontakt Drehschalter; Reinigung Vorfilter; Wackelkontakt Steckerleiste; Heizstaebe verkalkt; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3377, N'102', 1417, CAST(N'2020-12-05' AS Date), CAST(N'2020-12-09' AS Date), CAST(1.0 AS Decimal(5, 1)), 46, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3378, N'110', 1489, CAST(N'2020-12-05' AS Date), CAST(N'2020-12-08' AS Date), CAST(2.5 AS Decimal(5, 1)), 26, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3379, N'103', 1171, CAST(N'2020-12-05' AS Date), CAST(N'2020-12-05' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3380, N'105', 1029, CAST(N'2020-12-05' AS Date), CAST(N'2020-12-06' AS Date), CAST(3.0 AS Decimal(5, 1)), 19, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3381, N'110', 1256, CAST(N'2020-12-05' AS Date), CAST(N'2020-12-08' AS Date), CAST(2.5 AS Decimal(5, 1)), 101, N'Feinjustierung Axialmotor; Heizstaebe verkalkt; Vollverkalkung; Hauptlager ausgeschlagen; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3382, N'110', 1079, CAST(N'2020-12-07' AS Date), CAST(N'2020-12-12' AS Date), CAST(1.5 AS Decimal(5, 1)), 82, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3383, N'106', 1395, CAST(N'2020-12-07' AS Date), CAST(N'2020-12-10' AS Date), CAST(2.0 AS Decimal(5, 1)), 49, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3384, N'101', 1398, CAST(N'2020-12-07' AS Date), CAST(N'2020-12-12' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3385, NULL, 1423, CAST(N'2020-12-07' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3386, N'110', 1147, CAST(N'2020-12-07' AS Date), CAST(N'2020-12-11' AS Date), CAST(1.5 AS Decimal(5, 1)), 10, N'Wackelkontakt Steckerleiste; Leckage am Wasserkreislauf; Wackelkontakt Steckerleiste; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3387, N'107', 1267, CAST(N'2020-12-07' AS Date), CAST(N'2020-12-12' AS Date), CAST(3.5 AS Decimal(5, 1)), 46, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3388, N'102', 1369, CAST(N'2020-12-07' AS Date), CAST(N'2020-12-09' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3389, NULL, 1006, CAST(N'2020-12-07' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3390, N'106', 1096, CAST(N'2020-12-07' AS Date), CAST(N'2020-12-07' AS Date), CAST(1.0 AS Decimal(5, 1)), 40, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3391, N'105', 1452, CAST(N'2020-12-07' AS Date), CAST(N'2020-12-12' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3392, N'103', 1306, CAST(N'2020-12-07' AS Date), CAST(N'2020-12-08' AS Date), CAST(1.0 AS Decimal(5, 1)), 98, N'Vollverkalkung; Wackelkontakt Steckerleiste; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3393, N'107', 1434, CAST(N'2020-12-07' AS Date), CAST(N'2020-12-08' AS Date), CAST(2.0 AS Decimal(5, 1)), 70, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3394, N'103', 1335, CAST(N'2020-12-08' AS Date), CAST(N'2020-12-13' AS Date), CAST(0.5 AS Decimal(5, 1)), 48, N'Trommel klappert; Kabelbruch; Wackelkontakt Steckerleiste; Steckerleister korrodiert; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3395, NULL, 1108, CAST(N'2020-12-08' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3396, N'103', 1305, CAST(N'2020-12-08' AS Date), CAST(N'2020-12-13' AS Date), NULL, NULL, NULL)
GO
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3397, NULL, 1239, CAST(N'2020-12-08' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3398, NULL, 1340, CAST(N'2020-12-08' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3399, N'101', 1244, CAST(N'2020-12-08' AS Date), CAST(N'2020-12-10' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3400, NULL, 1277, CAST(N'2020-12-08' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3401, N'103', 1309, CAST(N'2020-12-08' AS Date), CAST(N'2020-12-13' AS Date), CAST(2.0 AS Decimal(5, 1)), 84, N'Feinjustierung Axialmotor; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3402, NULL, 1218, CAST(N'2020-12-09' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3403, N'101', 1279, CAST(N'2020-12-09' AS Date), CAST(N'2020-12-11' AS Date), CAST(1.5 AS Decimal(5, 1)), 57, N'Hauptlager ausgeschlagen; Trommel klappert; Vollverkalkung; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3404, N'110', 1030, CAST(N'2020-12-09' AS Date), CAST(N'2020-12-09' AS Date), CAST(2.0 AS Decimal(5, 1)), 20, N'Sondermodell; Feinjustierung Axialmotor; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3405, N'101', 1137, CAST(N'2020-12-09' AS Date), CAST(N'2020-12-09' AS Date), CAST(3.5 AS Decimal(5, 1)), 12, N'Wackelkontakt Steckerleiste; Steckerleister korrodiert; haeufige Ueberladung; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3406, N'101', 1308, CAST(N'2020-12-09' AS Date), CAST(N'2020-12-13' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3407, NULL, 1007, CAST(N'2020-12-09' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3408, NULL, 1194, CAST(N'2020-12-09' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3409, N'106', 1398, CAST(N'2020-12-09' AS Date), CAST(N'2020-12-09' AS Date), CAST(2.5 AS Decimal(5, 1)), 75, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3410, NULL, 1318, CAST(N'2020-12-09' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3411, N'110', 1457, CAST(N'2020-12-09' AS Date), CAST(N'2020-12-09' AS Date), CAST(2.0 AS Decimal(5, 1)), 85, N'Wackelkontakt Steckerleiste; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3412, N'105', 1192, CAST(N'2020-12-10' AS Date), CAST(N'2020-12-13' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3413, N'105', 1148, CAST(N'2020-12-10' AS Date), CAST(N'2020-12-10' AS Date), CAST(3.0 AS Decimal(5, 1)), 92, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3414, N'105', 1326, CAST(N'2020-12-10' AS Date), CAST(N'2020-12-10' AS Date), CAST(3.5 AS Decimal(5, 1)), 16, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3415, N'105', 1206, CAST(N'2020-12-11' AS Date), CAST(N'2020-12-13' AS Date), CAST(2.0 AS Decimal(5, 1)), 62, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3416, NULL, 1334, CAST(N'2020-12-11' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3417, NULL, 1457, CAST(N'2020-12-11' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3418, N'107', 1112, CAST(N'2020-12-11' AS Date), CAST(N'2020-12-12' AS Date), CAST(3.0 AS Decimal(5, 1)), 48, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3419, N'105', 1187, CAST(N'2020-12-11' AS Date), CAST(N'2020-12-11' AS Date), CAST(1.5 AS Decimal(5, 1)), 37, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3420, N'106', 1124, CAST(N'2020-12-11' AS Date), CAST(N'2020-12-12' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3421, N'110', 1381, CAST(N'2020-12-11' AS Date), CAST(N'2020-12-16' AS Date), CAST(1.5 AS Decimal(5, 1)), 53, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3422, NULL, 1227, CAST(N'2020-12-11' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3423, NULL, 1003, CAST(N'2020-12-11' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3424, N'103', 1462, CAST(N'2020-12-11' AS Date), CAST(N'2020-12-13' AS Date), CAST(2.5 AS Decimal(5, 1)), 95, N'Leckage am Wasserkreislauf; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3425, NULL, 1473, CAST(N'2020-12-12' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3426, N'103', 1452, CAST(N'2020-12-12' AS Date), CAST(N'2020-12-12' AS Date), CAST(1.5 AS Decimal(5, 1)), 43, N'Sondermodell; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3427, N'107', 1327, CAST(N'2020-12-12' AS Date), CAST(N'2020-12-16' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3428, N'103', 1091, CAST(N'2020-12-12' AS Date), CAST(N'2020-12-14' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3429, N'105', 1297, CAST(N'2020-12-12' AS Date), CAST(N'2020-12-17' AS Date), CAST(2.0 AS Decimal(5, 1)), 69, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3430, N'103', 1014, CAST(N'2020-12-12' AS Date), CAST(N'2020-12-15' AS Date), CAST(3.5 AS Decimal(5, 1)), 47, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3431, N'101', 1392, CAST(N'2020-12-12' AS Date), CAST(N'2020-12-12' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3432, N'101', 1463, CAST(N'2020-12-12' AS Date), CAST(N'2020-12-15' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3433, N'103', 1300, CAST(N'2020-12-12' AS Date), CAST(N'2020-12-16' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3434, N'102', 1372, CAST(N'2020-12-12' AS Date), CAST(N'2020-12-16' AS Date), CAST(2.0 AS Decimal(5, 1)), 26, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3435, N'110', 1268, CAST(N'2020-12-13' AS Date), CAST(N'2020-12-14' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3436, NULL, 1242, CAST(N'2020-12-13' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3437, N'103', 1332, CAST(N'2020-12-13' AS Date), CAST(N'2020-12-14' AS Date), CAST(2.0 AS Decimal(5, 1)), 92, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3438, N'107', 1318, CAST(N'2020-12-13' AS Date), CAST(N'2020-12-18' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3439, NULL, 1463, CAST(N'2020-12-13' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3440, N'110', 1307, CAST(N'2020-12-13' AS Date), CAST(N'2020-12-15' AS Date), CAST(1.0 AS Decimal(5, 1)), 17, N'Wackelkontakt Drehschalter; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3441, N'102', 1348, CAST(N'2020-12-13' AS Date), CAST(N'2020-12-14' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3442, N'107', 1151, CAST(N'2020-12-13' AS Date), CAST(N'2020-12-15' AS Date), CAST(2.0 AS Decimal(5, 1)), 37, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3443, NULL, 1086, CAST(N'2020-12-13' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3444, N'101', 1021, CAST(N'2020-12-13' AS Date), CAST(N'2020-12-18' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3445, NULL, 1084, CAST(N'2020-12-14' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3446, N'102', 1036, CAST(N'2020-12-14' AS Date), CAST(N'2020-12-14' AS Date), CAST(1.5 AS Decimal(5, 1)), 76, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3447, N'102', 1303, CAST(N'2020-12-14' AS Date), CAST(N'2020-12-18' AS Date), CAST(1.0 AS Decimal(5, 1)), 14, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3448, NULL, 1145, CAST(N'2020-12-15' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3449, N'105', 1222, CAST(N'2020-12-15' AS Date), CAST(N'2020-12-18' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3450, N'110', 1445, CAST(N'2020-12-15' AS Date), CAST(N'2020-12-16' AS Date), CAST(3.0 AS Decimal(5, 1)), 40, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3451, NULL, 1250, CAST(N'2020-12-15' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3452, N'103', 1104, CAST(N'2020-12-15' AS Date), CAST(N'2020-12-18' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3453, NULL, 1338, CAST(N'2020-12-15' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3454, N'101', 1359, CAST(N'2020-12-15' AS Date), CAST(N'2020-12-17' AS Date), CAST(2.5 AS Decimal(5, 1)), 71, N'Hauptlager ausgeschlagen; Feinjustierung Axialmotor; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3455, NULL, 1056, CAST(N'2020-12-15' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3456, N'102', 1472, CAST(N'2020-12-15' AS Date), CAST(N'2020-12-16' AS Date), CAST(2.5 AS Decimal(5, 1)), 101, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3457, N'103', 1192, CAST(N'2020-12-15' AS Date), CAST(N'2020-12-16' AS Date), CAST(1.5 AS Decimal(5, 1)), 43, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3458, N'102', 1030, CAST(N'2020-12-15' AS Date), CAST(N'2020-12-18' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3459, NULL, 1434, CAST(N'2020-12-16' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3460, NULL, 1312, CAST(N'2020-12-16' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3461, NULL, 1173, CAST(N'2020-12-16' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3462, N'102', 1309, CAST(N'2020-12-16' AS Date), CAST(N'2020-12-16' AS Date), CAST(2.0 AS Decimal(5, 1)), 83, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3463, NULL, 1021, CAST(N'2020-12-16' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3464, NULL, 1086, CAST(N'2020-12-16' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3465, N'103', 1411, CAST(N'2020-12-16' AS Date), CAST(N'2020-12-17' AS Date), CAST(2.5 AS Decimal(5, 1)), 88, N'Kabelbruch; Hauptlager ausgeschlagen; haeufige Ueberladung; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3466, N'107', 1241, CAST(N'2020-12-16' AS Date), CAST(N'2020-12-21' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3467, NULL, 1379, CAST(N'2020-12-16' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3468, NULL, 1086, CAST(N'2020-12-16' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3469, N'103', 1109, CAST(N'2020-12-17' AS Date), CAST(N'2020-12-21' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3470, NULL, 1335, CAST(N'2020-12-17' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3471, NULL, 1471, CAST(N'2020-12-17' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3472, N'102', 1050, CAST(N'2020-12-17' AS Date), CAST(N'2020-12-20' AS Date), CAST(2.5 AS Decimal(5, 1)), 61, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3473, NULL, 1113, CAST(N'2020-12-17' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3474, NULL, 1169, CAST(N'2020-12-17' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3475, N'105', 1031, CAST(N'2020-12-18' AS Date), CAST(N'2020-12-22' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3476, NULL, 1349, CAST(N'2020-12-18' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3477, N'102', 1002, CAST(N'2020-12-18' AS Date), CAST(N'2020-12-21' AS Date), CAST(1.5 AS Decimal(5, 1)), 31, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3478, N'106', 1132, CAST(N'2020-12-18' AS Date), CAST(N'2020-12-19' AS Date), CAST(2.0 AS Decimal(5, 1)), 29, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3479, N'110', 1164, CAST(N'2020-12-18' AS Date), CAST(N'2020-12-20' AS Date), CAST(2.0 AS Decimal(5, 1)), 45, N'Dichtung poroes; Hauptlager ausgeschlagen; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3480, N'103', 1072, CAST(N'2020-12-18' AS Date), CAST(N'2020-12-22' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3481, N'101', 1434, CAST(N'2020-12-18' AS Date), CAST(N'2020-12-19' AS Date), CAST(1.0 AS Decimal(5, 1)), 69, N'Reinigung Vorfilter; Trommel klappert; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3482, NULL, 1192, CAST(N'2020-12-18' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3483, N'101', 1467, CAST(N'2020-12-18' AS Date), CAST(N'2020-12-19' AS Date), CAST(2.0 AS Decimal(5, 1)), 83, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3484, N'107', 1026, CAST(N'2020-12-18' AS Date), CAST(N'2020-12-23' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3485, N'101', 1481, CAST(N'2020-12-18' AS Date), CAST(N'2020-12-20' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3486, N'110', 1107, CAST(N'2020-12-18' AS Date), CAST(N'2020-12-21' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3487, N'105', 1156, CAST(N'2020-12-19' AS Date), CAST(N'2020-12-20' AS Date), CAST(3.0 AS Decimal(5, 1)), 7, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3488, N'106', 1240, CAST(N'2020-12-19' AS Date), CAST(N'2020-12-19' AS Date), CAST(3.0 AS Decimal(5, 1)), 47, N'Kabelbruch; Sondermodell; Laugenpumpe leckt; instabiler Aufstellort; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3489, N'101', 1022, CAST(N'2020-12-19' AS Date), CAST(N'2020-12-21' AS Date), CAST(0.5 AS Decimal(5, 1)), 91, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3490, N'110', 1393, CAST(N'2020-12-19' AS Date), CAST(N'2020-12-21' AS Date), CAST(0.5 AS Decimal(5, 1)), 68, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3491, N'101', 1023, CAST(N'2020-12-19' AS Date), CAST(N'2020-12-23' AS Date), CAST(2.5 AS Decimal(5, 1)), 96, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3492, NULL, 1481, CAST(N'2020-12-19' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3493, N'106', 1141, CAST(N'2020-12-19' AS Date), CAST(N'2020-12-19' AS Date), CAST(2.5 AS Decimal(5, 1)), 19, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3494, N'103', 1140, CAST(N'2020-12-19' AS Date), CAST(N'2020-12-24' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3495, N'106', 1453, CAST(N'2020-12-20' AS Date), CAST(N'2020-12-23' AS Date), CAST(2.0 AS Decimal(5, 1)), 5, N'Heizstaebe verkalkt; Leckage am Wasserkreislauf; Trommel klappert; Kabelbruch; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3496, N'103', 1344, CAST(N'2020-12-20' AS Date), CAST(N'2020-12-24' AS Date), NULL, NULL, NULL)
GO
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3497, NULL, 1270, CAST(N'2020-12-20' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3498, NULL, 1297, CAST(N'2020-12-20' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3499, NULL, 1196, CAST(N'2020-12-20' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3500, N'106', 1453, CAST(N'2020-12-20' AS Date), CAST(N'2020-12-25' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3501, N'106', 1156, CAST(N'2020-12-20' AS Date), CAST(N'2020-12-20' AS Date), CAST(1.5 AS Decimal(5, 1)), 80, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3502, NULL, 1456, CAST(N'2020-12-20' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3503, N'110', 1448, CAST(N'2020-12-20' AS Date), CAST(N'2020-12-21' AS Date), CAST(1.0 AS Decimal(5, 1)), 44, N'Trommel klappert; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3504, N'105', 1040, CAST(N'2020-12-20' AS Date), CAST(N'2020-12-20' AS Date), CAST(1.0 AS Decimal(5, 1)), 73, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3505, N'110', 1210, CAST(N'2020-12-21' AS Date), CAST(N'2020-12-23' AS Date), CAST(2.0 AS Decimal(5, 1)), 62, N'Feinjustierung Axialmotor; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3506, NULL, 1065, CAST(N'2020-12-21' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3507, N'110', 1277, CAST(N'2020-12-21' AS Date), CAST(N'2020-12-23' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3508, N'101', 1015, CAST(N'2020-12-21' AS Date), CAST(N'2020-12-24' AS Date), CAST(0.5 AS Decimal(5, 1)), 7, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3509, NULL, 1050, CAST(N'2020-12-21' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3510, NULL, 1359, CAST(N'2020-12-21' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3511, N'106', 1423, CAST(N'2020-12-21' AS Date), CAST(N'2020-12-21' AS Date), CAST(0.5 AS Decimal(5, 1)), 88, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3512, NULL, 1472, CAST(N'2020-12-21' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3513, NULL, 1478, CAST(N'2020-12-22' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3514, N'107', 1066, CAST(N'2020-12-22' AS Date), CAST(N'2020-12-23' AS Date), CAST(2.0 AS Decimal(5, 1)), 75, N'Wackelkontakt Drehschalter; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3515, NULL, 1346, CAST(N'2020-12-22' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3516, NULL, 1269, CAST(N'2020-12-22' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3517, NULL, 1474, CAST(N'2020-12-22' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3518, N'103', 1068, CAST(N'2020-12-23' AS Date), CAST(N'2020-12-26' AS Date), CAST(2.0 AS Decimal(5, 1)), 59, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3519, N'107', 1036, CAST(N'2020-12-23' AS Date), CAST(N'2020-12-28' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3520, N'105', 1434, CAST(N'2020-12-23' AS Date), CAST(N'2020-12-23' AS Date), CAST(1.0 AS Decimal(5, 1)), 76, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3521, NULL, 1372, CAST(N'2020-12-23' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3522, N'102', 1149, CAST(N'2020-12-23' AS Date), CAST(N'2020-12-23' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3523, N'105', 1069, CAST(N'2020-12-23' AS Date), CAST(N'2020-12-26' AS Date), CAST(2.5 AS Decimal(5, 1)), 72, N'Heizstaebe verkalkt; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3524, NULL, 1094, CAST(N'2020-12-23' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3525, NULL, 1374, CAST(N'2020-12-24' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3526, NULL, 1298, CAST(N'2020-12-24' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3527, N'107', 1345, CAST(N'2020-12-24' AS Date), CAST(N'2020-12-27' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3528, N'107', 1363, CAST(N'2020-12-24' AS Date), CAST(N'2020-12-26' AS Date), CAST(2.0 AS Decimal(5, 1)), 31, N'instabiler Aufstellort; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3529, N'102', 1026, CAST(N'2020-12-24' AS Date), CAST(N'2020-12-29' AS Date), CAST(1.0 AS Decimal(5, 1)), 70, N'Laugenpumpe leckt; Sondermodell; Kabelbruch; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3530, N'107', 1443, CAST(N'2020-12-24' AS Date), CAST(N'2020-12-26' AS Date), CAST(1.5 AS Decimal(5, 1)), 87, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3531, N'107', 1258, CAST(N'2020-12-24' AS Date), CAST(N'2020-12-27' AS Date), CAST(2.5 AS Decimal(5, 1)), 61, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3532, NULL, 1138, CAST(N'2020-12-24' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3533, N'101', 1072, CAST(N'2020-12-24' AS Date), CAST(N'2020-12-27' AS Date), CAST(2.0 AS Decimal(5, 1)), 90, N'haeufige Ueberladung; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3534, N'102', 1354, CAST(N'2020-12-24' AS Date), CAST(N'2020-12-24' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3535, NULL, 1120, CAST(N'2020-12-24' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3536, N'107', 1487, CAST(N'2020-12-24' AS Date), CAST(N'2020-12-26' AS Date), CAST(3.0 AS Decimal(5, 1)), 89, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3537, NULL, 1324, CAST(N'2020-12-25' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3538, NULL, 1132, CAST(N'2020-12-26' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3539, N'105', 1276, CAST(N'2020-12-26' AS Date), CAST(N'2020-12-29' AS Date), CAST(2.0 AS Decimal(5, 1)), 18, N'instabiler Aufstellort; Laugenpumpe leckt; Reinigung Vorfilter; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3540, N'102', 1424, CAST(N'2020-12-26' AS Date), CAST(N'2020-12-29' AS Date), CAST(2.0 AS Decimal(5, 1)), 78, N'Sondermodell; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3541, NULL, 1193, CAST(N'2020-12-27' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3542, NULL, 1063, CAST(N'2020-12-27' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3543, N'106', 1382, CAST(N'2020-12-27' AS Date), CAST(N'2020-12-27' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3544, N'105', 1485, CAST(N'2020-12-27' AS Date), CAST(N'2020-12-28' AS Date), CAST(10.0 AS Decimal(5, 1)), 10, N'Reinigung Vorfilter; Feinjustierung Axialmotor; Feinjustierung Axialmotor; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3545, NULL, 1148, CAST(N'2020-12-27' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3546, NULL, 1071, CAST(N'2020-12-27' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3547, N'105', 1145, CAST(N'2020-12-28' AS Date), CAST(N'2020-12-28' AS Date), CAST(2.0 AS Decimal(5, 1)), 73, N'Kabelbruch; Dichtung poroes; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3548, N'107', 1432, CAST(N'2020-12-28' AS Date), CAST(N'2021-01-02' AS Date), CAST(2.0 AS Decimal(5, 1)), 23, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3549, N'101', 1331, CAST(N'2020-12-28' AS Date), CAST(N'2021-01-01' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3550, NULL, 1168, CAST(N'2020-12-28' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3551, N'102', 1049, CAST(N'2020-12-28' AS Date), CAST(N'2020-12-29' AS Date), CAST(2.0 AS Decimal(5, 1)), 43, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3552, N'105', 1139, CAST(N'2020-12-28' AS Date), CAST(N'2020-12-28' AS Date), CAST(10.0 AS Decimal(5, 1)), 10, N'Laugenpumpe leckt; Steckerleister korrodiert; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3553, N'101', 1356, CAST(N'2020-12-28' AS Date), CAST(N'2020-12-31' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3554, N'105', 1256, CAST(N'2020-12-29' AS Date), CAST(N'2020-12-30' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3555, N'107', 1005, CAST(N'2020-12-29' AS Date), CAST(N'2021-01-01' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3556, NULL, 1329, CAST(N'2020-12-29' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3557, NULL, 1277, CAST(N'2020-12-29' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3558, NULL, 1385, CAST(N'2020-12-29' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3559, N'105', 1248, CAST(N'2020-12-29' AS Date), CAST(N'2021-01-02' AS Date), CAST(3.0 AS Decimal(5, 1)), 53, N'Wackelkontakt Drehschalter; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3560, N'105', 1079, CAST(N'2020-12-29' AS Date), CAST(N'2021-01-02' AS Date), CAST(2.0 AS Decimal(5, 1)), 75, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3561, NULL, 1045, CAST(N'2020-12-29' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3562, N'107', 1301, CAST(N'2020-12-29' AS Date), CAST(N'2021-01-03' AS Date), CAST(2.0 AS Decimal(5, 1)), 48, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3563, N'106', 1252, CAST(N'2020-12-29' AS Date), CAST(N'2020-12-29' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3564, N'106', 1003, CAST(N'2020-12-29' AS Date), CAST(N'2021-01-02' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3565, N'110', 1180, CAST(N'2020-12-29' AS Date), CAST(N'2021-01-03' AS Date), CAST(1.5 AS Decimal(5, 1)), 90, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3566, NULL, 1150, CAST(N'2020-12-30' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3567, N'110', 1083, CAST(N'2020-12-30' AS Date), CAST(N'2021-01-04' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3568, N'101', 1125, CAST(N'2020-12-30' AS Date), CAST(N'2020-12-31' AS Date), CAST(1.0 AS Decimal(5, 1)), 96, N'Hauptlager ausgeschlagen; ')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3569, NULL, 1261, CAST(N'2020-12-30' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3570, NULL, 1421, CAST(N'2020-12-30' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3571, NULL, 1216, CAST(N'2020-12-30' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3572, N'103', 1050, CAST(N'2020-12-30' AS Date), CAST(N'2021-01-04' AS Date), CAST(2.0 AS Decimal(5, 1)), 48, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3573, NULL, 1352, CAST(N'2020-12-30' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3574, N'094', 1254, CAST(N'2020-12-30' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3575, N'102', 1251, CAST(N'2020-12-31' AS Date), CAST(N'2021-01-05' AS Date), CAST(2.0 AS Decimal(5, 1)), 72, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3576, N'105', 1153, CAST(N'2020-12-31' AS Date), CAST(N'2021-01-04' AS Date), CAST(3.5 AS Decimal(5, 1)), 14, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3577, N'105', 1331, CAST(N'2020-12-31' AS Date), CAST(N'2021-01-02' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3578, N'094', 1264, CAST(N'2020-12-31' AS Date), NULL, NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3579, N'105', 1176, CAST(N'2020-12-31' AS Date), CAST(N'2021-01-02' AS Date), CAST(2.5 AS Decimal(5, 1)), 87, N'')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3580, N'106', 1284, CAST(N'2020-12-31' AS Date), CAST(N'2020-12-31' AS Date), NULL, NULL, NULL)
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3581, N'094', 508, CAST(N'2022-10-31' AS Date), NULL, CAST(12.0 AS Decimal(5, 1)), 12, N'asd')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3582, N'094', 1000, CAST(N'2022-11-20' AS Date), NULL, CAST(12.0 AS Decimal(5, 1)), 12, N'TEST')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3583, NULL, 508, CAST(N'2022-11-07' AS Date), CAST(N'2022-11-13' AS Date), NULL, NULL, N'12323')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3584, NULL, 1000, CAST(N'2022-11-13' AS Date), CAST(N'2022-11-13' AS Date), NULL, NULL, N'tesr1')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3585, N'094', 508, CAST(N'2022-11-14' AS Date), CAST(N'2022-11-15' AS Date), NULL, NULL, N'TEST')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3586, N'101', 508, CAST(N'2022-11-21' AS Date), CAST(N'2022-11-21' AS Date), CAST(12.0 AS Decimal(5, 1)), 12, N'sfgsdfg')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3587, N'094', 508, CAST(N'2022-10-31' AS Date), CAST(N'2022-11-13' AS Date), CAST(12.0 AS Decimal(5, 1)), 12, N'Finaler Test')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3588, N'101', 1001, CAST(N'2022-11-13' AS Date), CAST(N'2022-11-14' AS Date), CAST(12.0 AS Decimal(5, 1)), 12, N'Test')
INSERT [dbo].[Auftrag]
    ([Aufnr], [MitID], [KunNr], [AufDat], [ErlDat], [Dauer], [Anfahrt], [Beschreibung])
VALUES
    (3589, N'103', 1000, CAST(N'2022-11-14' AS Date), CAST(N'2022-11-18' AS Date), CAST(12.0 AS Decimal(5, 1)), 12, N'TEST')
SET IDENTITY_INSERT [dbo].[Auftrag] OFF
GO
INSERT [dbo].[Ersatzteil]
    ([EtID], [EtBezeichnung], [EtPreis], [EtAnzLager], [EtHersteller])
VALUES
    (N'2    ', N'2', 2.0000, 2, N'2')
INSERT [dbo].[Ersatzteil]
    ([EtID], [EtBezeichnung], [EtPreis], [EtAnzLager], [EtHersteller])
VALUES
    (N'A0100', N'Antriebsriemen', 15.0000, 200001, N'Mosch')
INSERT [dbo].[Ersatzteil]
    ([EtID], [EtBezeichnung], [EtPreis], [EtAnzLager], [EtHersteller])
VALUES
    (N'D0100', N'Federkolbendämpfer mit Befestigungssatz', 52.9900, 12, N'Mosch')
INSERT [dbo].[Ersatzteil]
    ([EtID], [EtBezeichnung], [EtPreis], [EtAnzLager], [EtHersteller])
VALUES
    (N'D0220', N'Flusensieb', 13.9900, 5, N'Hauknecht')
INSERT [dbo].[Ersatzteil]
    ([EtID], [EtBezeichnung], [EtPreis], [EtAnzLager], [EtHersteller])
VALUES
    (N'D0332', N'Anschlussschlauch', 19.9800, 3, N'Hauknecht')
INSERT [dbo].[Ersatzteil]
    ([EtID], [EtBezeichnung], [EtPreis], [EtAnzLager], [EtHersteller])
VALUES
    (N'D0444', N'Pumpensumpf Ablaufschlauch', 15.4600, 7, N'Hauknecht')
INSERT [dbo].[Ersatzteil]
    ([EtID], [EtBezeichnung], [EtPreis], [EtAnzLager], [EtHersteller])
VALUES
    (N'D0500', N'Saugschlauch', 27.4300, 10, N'Hauknecht')
INSERT [dbo].[Ersatzteil]
    ([EtID], [EtBezeichnung], [EtPreis], [EtAnzLager], [EtHersteller])
VALUES
    (N'D0600', N'Stoßdämpfer', 6.9900, 32, N'Liemens')
INSERT [dbo].[Ersatzteil]
    ([EtID], [EtBezeichnung], [EtPreis], [EtAnzLager], [EtHersteller])
VALUES
    (N'E0100', N'Einspülschale', 27.9900, 5, N'Tiele')
INSERT [dbo].[Ersatzteil]
    ([EtID], [EtBezeichnung], [EtPreis], [EtAnzLager], [EtHersteller])
VALUES
    (N'E0110', N'Einsatz für Einspülschale', 4.4900, 10, N'Mosch')
INSERT [dbo].[Ersatzteil]
    ([EtID], [EtBezeichnung], [EtPreis], [EtAnzLager], [EtHersteller])
VALUES
    (N'E0120', N'Einspülschalenunterteil', 27.9900, 4, N'Mosch')
INSERT [dbo].[Ersatzteil]
    ([EtID], [EtBezeichnung], [EtPreis], [EtAnzLager], [EtHersteller])
VALUES
    (N'H0200', N'Heizelement', 60.9900, 8, N'Liemens')
INSERT [dbo].[Ersatzteil]
    ([EtID], [EtBezeichnung], [EtPreis], [EtAnzLager], [EtHersteller])
VALUES
    (N'H0230', N'Temperaturfühler', 12.9900, 3, N'Tiele')
INSERT [dbo].[Ersatzteil]
    ([EtID], [EtBezeichnung], [EtPreis], [EtAnzLager], [EtHersteller])
VALUES
    (N'K0400', N'Kohlebürsten', 30.9900, 25, N'Tiele')
INSERT [dbo].[Ersatzteil]
    ([EtID], [EtBezeichnung], [EtPreis], [EtAnzLager], [EtHersteller])
VALUES
    (N'L0100', N'Lagersatz', 61.4900, 2, N'Mosch')
INSERT [dbo].[Ersatzteil]
    ([EtID], [EtBezeichnung], [EtPreis], [EtAnzLager], [EtHersteller])
VALUES
    (N'L0200', N'Kugellager', 6.4900, 35, N'Mosch')
INSERT [dbo].[Ersatzteil]
    ([EtID], [EtBezeichnung], [EtPreis], [EtAnzLager], [EtHersteller])
VALUES
    (N'M0200', N'Magnetventil', 29.9900, 7, N'Liemens')
INSERT [dbo].[Ersatzteil]
    ([EtID], [EtBezeichnung], [EtPreis], [EtAnzLager], [EtHersteller])
VALUES
    (N'P0110', N'Flusensieb', 15.4900, 6, N'Liemens')
INSERT [dbo].[Ersatzteil]
    ([EtID], [EtBezeichnung], [EtPreis], [EtAnzLager], [EtHersteller])
VALUES
    (N'P0111', N'Flusensiebeinsatz', 12.9900, 22, N'Liemens')
INSERT [dbo].[Ersatzteil]
    ([EtID], [EtBezeichnung], [EtPreis], [EtAnzLager], [EtHersteller])
VALUES
    (N'P0200', N'Laugenpumpe', 48.9900, 9, N'Mosch')
INSERT [dbo].[Ersatzteil]
    ([EtID], [EtBezeichnung], [EtPreis], [EtAnzLager], [EtHersteller])
VALUES
    (N'qweq ', N'1312', 1231.0000, 131, N'1321')
INSERT [dbo].[Ersatzteil]
    ([EtID], [EtBezeichnung], [EtPreis], [EtAnzLager], [EtHersteller])
VALUES
    (N'S0300', N'Anschlussschlauch', 22.4900, 7, N'Mosch')
INSERT [dbo].[Ersatzteil]
    ([EtID], [EtBezeichnung], [EtPreis], [EtAnzLager], [EtHersteller])
VALUES
    (N'S0400', N'Pumpensumpf Ablaufschlauch', 17.9900, 8, N'Tiele')
INSERT [dbo].[Ersatzteil]
    ([EtID], [EtBezeichnung], [EtPreis], [EtAnzLager], [EtHersteller])
VALUES
    (N'S0500', N'Saugschlauch', 29.4900, 15, N'Tiele')
INSERT [dbo].[Ersatzteil]
    ([EtID], [EtBezeichnung], [EtPreis], [EtAnzLager], [EtHersteller])
VALUES
    (N'T0250', N'Türverriegelung elektrisch', 32.9900, 8, N'Liemens')
INSERT [dbo].[Ersatzteil]
    ([EtID], [EtBezeichnung], [EtPreis], [EtAnzLager], [EtHersteller])
VALUES
    (N'T0333', N'Verriegelungsrelais', 32.4900, 13, N'Tiele')
GO
INSERT [dbo].[Gebiet]
    ([GebietID], [NLNr])
VALUES
    (N'01', 1)
INSERT [dbo].[Gebiet]
    ([GebietID], [NLNr])
VALUES
    (N'02', 1)
INSERT [dbo].[Gebiet]
    ([GebietID], [NLNr])
VALUES
    (N'03', 1)
INSERT [dbo].[Gebiet]
    ([GebietID], [NLNr])
VALUES
    (N'04', 3)
INSERT [dbo].[Gebiet]
    ([GebietID], [NLNr])
VALUES
    (N'06', 3)
INSERT [dbo].[Gebiet]
    ([GebietID], [NLNr])
VALUES
    (N'07', 2)
INSERT [dbo].[Gebiet]
    ([GebietID], [NLNr])
VALUES
    (N'08', 2)
INSERT [dbo].[Gebiet]
    ([GebietID], [NLNr])
VALUES
    (N'09', 2)
GO
SET IDENTITY_INSERT [dbo].[Kunde] ON

INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (508, N'Sandra Horn', N'Dresden12', N'01212', N'Ahornweg 12')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1000, N'Mengel', N'Burkau', N'01906', N'Lewickistrasse 56')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1001, N'Nehls', N'Heide', N'08340', N'An den Baechen 56')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1002, N'Scheu', N'Radeberg, Sachsen', N'01454', N'Helgolandstrasse 158')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1003, N'Stehr', N'Jesewitz', N'04838', N'Rathausplatz 159')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1004, N'Brust', N'Johannstadt', N'01169', N'Margaretendamm 83')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1005, N'Blau', N'Markkleeberg', N'04416', N'Blochmatt 133')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1006, N'Hirschfeld', N'Crostwitz', N'01920', N'Bernerstrasse 225')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1007, N'Ihle', N'Dorfhain', N'01738', N'Overbergstrasse 209')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1008, N'Alex', N'Oschatz', N'04758', N'Soester Strasse 56')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1009, N'Kuntz', N'Dresden', N'01309', N'Kleinhausweg 92')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1010, N'Trautwein', N'Niederau bei Meissen', N'01689', N'Kanizsaiweg 163')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1011, N'Waibel', N'Ockerwitz', N'01462', N'Im Wickengarten 59')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1012, N'Thielmann', N'Nauwalde', N'01609', N'Am Bauernbusch 225')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1013, N'Weitz', N'Joehstadt', N'09477', N'Hubertusstr. 117')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1014, N'Scheele', N'Wenigossa', N'04643', N'Steinfeldtstrasse 64')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1015, N'Sorg', N'Markersbach', N'08352', N'Rotdornweg 243')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1016, N'Klaas', N'Mutzschen', N'04688', N'Gruener Wald 5')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1017, N'Philipps', N'Diesbar-Seusslitz', N'01612', N'Richterstrasse 194')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1018, N'Kolodziej', N'Bernsbach', N'08315', N'Suedring 153')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1019, N'Ketterer', N'Bockelwitz', N'04703', N'Am Rittergut 9')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1020, N'Stief', N'Struppen', N'01796', N'Rebenweg 67')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1021, N'Engl', N'Nausslitz', N'01159', N'Hainbuchenweg 177')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1022, N'Renken', N'Wilsdruff', N'01723', N'Seebauerstr. 207')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1023, N'Burg', N'Waldsteinberg', N'04821', N'Mariannenstrasse 182')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1024, N'Russ', N'Pennrich', N'01156', N'Moosleite 199')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1025, N'Blumenthal', N'Remse bei Glauchau', N'08373', N'In den Biegen 179')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1026, N'Woelfle', N'Kirschau', N'02681', N'Lenbachstrasse 226')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1027, N'Moellers', N'Stetzsch', N'01097', N'Zur Bachwiese 145')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1028, N'Osswald', N'Laussnitz', N'01936', N'Heidemuehlweg 6')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1029, N'Birkholz', N'Kreischa bei Dresden', N'01731', N'Dorfplatz 29')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1030, N'Graetz', N'Neukirchen / Pleisse', N'08459', N'Scheidstrasse 172')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1031, N'Bienert', N'Battaune', N'04838', N'Am alten Bahnhof 112')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1032, N'Pichler', N'Thuemmlitzwalde', N'04668', N'Ziegeleistrasse 83')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1033, N'Glass', N'Glaubitz', N'01612', N'Rosentalweg 28')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1034, N'Neuner', N'Kaendler', N'09247', N'Am Alten Bahndamm 35')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1035, N'Heinisch', N'Neisseaue', N'02829', N'Zelenkastrasse 44')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1036, N'Gohlke', N'Plauen, Vogtland', N'08527', N'Lerchenweg 147')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1037, N'Langhammer', N'Steinpleis', N'08432', N'Suedhang 145')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1038, N'Sanders', N'Leipzig', N'04229', N'Rebenweg 35')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1039, N'Baeumer', N'Bad Schlema', N'08301', N'Neckarstrasse 160')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1040, N'Coenen', N'Paschwitz', N'04838', N'Malergaesschen 241')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1041, N'Kuck', N'Dresden', N'01237', N'Mainzer Strasse 224')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1042, N'Berens', N'Delitzsch', N'04509', N'Boecklerstrasse 131')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1043, N'Dost', N'Karcha', N'01683', N'Lepsiusstrasse 155')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1044, N'Heidt', N'Waldsteinberg', N'04821', N'Feldstrasse 121')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1045, N'Fix', N'Dennheritz', N'08393', N'Basaltstrasse 210')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1046, N'Marschner', N'Weisskeissel', N'02957', N'Gaertnereistrasse 3')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1047, N'Haberkorn', N'Karcha', N'01683', N'Repsoldstrasse 190')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1048, N'Redlich', N'Chemnitz, Sachsen', N'09111', N'Aspichring 5')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1049, N'Karle', N'Raeckelwitz', N'01920', N'Jarrestrasse 55')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1050, N'Dippel', N'Hainichen, Sachsen', N'09661', N'Neuburgstaedtel 142')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1051, N'Kloss', N'Leubnitz bei Plauen', N'08412', N'Hoefnageleck 44')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1052, N'Blau', N'Doberschau-Gaussig', N'02633', N'Kapellenweg 72')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1053, N'Schwenke', N'Gornau / Erzgebirge', N'09405', N'Oltersteinweg 5')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1054, N'Stoffel', N'Kreissa', N'01623', N'Raehnitzsteig 135')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1055, N'Krausse', N'Leipzig', N'04178', N'Am Ziegenberg 66')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1056, N'Lucht', N'Rackwitz', N'04519', N'Elmtwiete 243')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1057, N'Gaida', N'Gorbitz', N'01109', N'Mussstr. 78')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1058, N'Dehn', N'Reuth bei Plauen', N'08538', N'Diakonissenweg 8')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1059, N'Gilles', N'Oschatz', N'04758', N'Am Hirschknock 117')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1060, N'Schmoll', N'Kubschuetz', N'02627', N'Gaertnerstrasse 229')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1061, N'Bendel', N'Schlegel bei Zittau', N'02788', N'Emdener Strasse 72')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1062, N'Schwenke', N'Floeha', N'09557', N'Hittenkoferweg 87')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1063, N'Hinkel', N'Dresden', N'01279', N'Anwanderstr. 212')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1064, N'Daniels', N'Zwickau', N'08060', N'Erzbergerstrasse 202')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1065, N'Lehnen', N'Steinbach', N'01156', N'Zum Jammertal 98')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1066, N'Bernard', N'Chemnitz, Sachsen', N'09117', N'Moeringbogen 6')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1067, N'Kehr', N'Gornau / Erzgebirge', N'09405', N'Am Foehrenwald 176')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1068, N'Kienzle', N'Plattenthal', N'09488', N'Calvinstrasse 101')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1069, N'Coenen', N'Thermalbad Wiesenbad', N'09488', N'Grimoldweg 111')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1070, N'Wolfrum', N'Zschadrass', N'04680', N'Bitterfelder Weg 51')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1071, N'Sager', N'Nausslitz', N'01189', N'Am Weissen Turm 48')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1072, N'Liese', N'Wildenfels', N'08134', N'In der Suedflur 141')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1073, N'Dillmann', N'Gorbitz', N'01129', N'Zum Stulen 85')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1074, N'Dudek', N'Groeditz bei Riesa', N'01609', N'Albanusstrasse 77')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1075, N'Steinborn', N'Muelsen', N'08132', N'Dresdner Strasse 179')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1076, N'Eichholz', N'Demitz-Thumitz', N'01877', N'Dorfstrasse 43')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1077, N'Wilk', N'Abend', N'01623', N'Diebsgrundweg 163')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1078, N'Lay', N'Leisnig', N'04703', N'Im Burgfeld 180')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1079, N'Velten', N'Thuemmlitzwalde', N'04668', N'Kirchenweg 34')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1080, N'Moench', N'Johannstadt', N'01237', N'Torweg 39')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1081, N'Brix', N'Nossen', N'01683', N'Heynahtsstrasse 147')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1082, N'Blumenthal', N'Striesen-West', N'01307', N'Sandhoefer Allee 10')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1083, N'Edel', N'Naunhof bei Grimma', N'04683', N'Rhiemsweg 69')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1084, N'Findeisen', N'Sankt Micheln', N'08132', N'Ganghoferstrasse 38')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1085, N'Weidmann', N'Johannstadt', N'01307', N'Laschoberstrasse 59')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1086, N'Moench', N'Gorbitz', N'01156', N'Weegmannufer 91')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1087, N'Sacher', N'Elstertrebnitz', N'04523', N'Londoner Strasse 12')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1088, N'Guse', N'Eppendorf, Sachsen', N'09575', N'Boecklerstrasse 45')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1089, N'Vater', N'Gorbitz', N'01307', N'Zum Tierheim 26')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1090, N'Theil', N'Bad Dueben', N'04849', N'Falkenstrasse 58')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1091, N'Matthiesen', N'Augustusburg', N'09573', N'Raabestrasse 40')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1092, N'Reber', N'Muecka', N'02906', N'Niederschleems 148')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1093, N'Stoffel', N'Weissenberg, Sachsen', N'02627', N'Wilhelmstrasse 174')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1094, N'Steinborn', N'Nausslitz', N'01189', N'Tuchmachergasse 195')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1095, N'Geissler', N'Zitzschen', N'04442', N'Eisgrubenweg 11')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1096, N'Seliger', N'Bischofswerda', N'01877', N'Landgraben 19')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1097, N'Schoenberg', N'Gruenhain', N'08358', N'Seewiesenstr. 96')
GO
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1098, N'Laumann', N'Leipzig', N'04103', N'Hertelstrasse 56')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1099, N'Nehring', N'Leipzig', N'04205', N'Buergerweide 86')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1100, N'Ender', N'Dresden', N'01465', N'Faehrmannweg 132')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1101, N'Rist', N'Stoermthal', N'04463', N'Fabrikbau 149')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1102, N'Weihrauch', N'Deutschneudorf', N'09548', N'Am Talkenberg 66')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1103, N'Mildner', N'Siebenlehn', N'09634', N'Kapstadtring 43')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1104, N'Mauch', N'Malter', N'01744', N'Altraecknitz 12')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1105, N'Voelkl', N'Striesen-Sued', N'01307', N'Luchbergstrasse 147')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1106, N'Scheu', N'Dommitzsch', N'04880', N'Archivstrasse 212')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1107, N'Kapp', N'Brandis bei Wurzen', N'04821', N'Dalbergstrasse 8')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1108, N'Streich', N'Gorbitz', N'01169', N'Vierlinden 134')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1109, N'Coenen', N'Gorbitz', N'01462', N'Buergerstrasse 10')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1110, N'Prange', N'Ockerwitz', N'01462', N'Gerberstr. 113')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1111, N'Sieger', N'Doberschau-Gaussig', N'01877', N'Hirtenweg 138')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1112, N'Woehrle', N'Leipzig', N'04347', N'Untere Sandstr. 118')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1113, N'Dudek', N'Stannewisch', N'02923', N'Krugtwiete 25')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1114, N'Kaempf', N'Bad Brambach', N'08648', N'An der Flutrinne 100')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1115, N'Krell', N'Langenbernsdorf', N'08428', N'Bombaybruecke 9')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1116, N'Bensch', N'Grossbothen', N'04668', N'Grubenweg 202')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1117, N'Stevens', N'Doebeln', N'04720', N'Seeligstrasse 67')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1118, N'Giesecke', N'Rossau bei Mittweida', N'09661', N'Am Kronenhuegel 71')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1119, N'Ruhl', N'Steinpleis', N'08432', N'Bachforellenweg 186')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1120, N'Haberkorn', N'Hohenstein-Ernstthal', N'09337', N'Jochhoeh 51')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1121, N'Szymanski', N'Markranstaedt', N'04420', N'Tabulatorweg 118')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1122, N'Friedmann', N'Chemnitz, Sachsen', N'09120', N'Buger Hauptstr. 42')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1123, N'Koelsch', N'Gorbitz', N'01097', N'Lugaer Strasse 151')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1124, N'Juenger', N'Gorbitz', N'01307', N'Margeritenstrasse 10')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1125, N'Dannenberg', N'Mildenau', N'09456', N'Londoner Strasse 86')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1126, N'Lex', N'Stein', N'08118', N'Altkaditz 3')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1127, N'Kick', N'Rietschen', N'02956', N'Ludwig-Gehm-Weg 57')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1128, N'Back', N'Gorbitz', N'01127', N'Plattengasse 42')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1129, N'Wehrle', N'Doberschau-Gaussig', N'02633', N'Am Storchengrund 44')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1130, N'Fluegge', N'Porschdorf', N'01814', N'Stengeletwiete 163')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1131, N'Huetter', N'Leipzig', N'04109', N'Otto-Dix-Ring 209')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1132, N'Kehr', N'Neuschoenburg', N'08132', N'Hoepers Kamp 70')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1133, N'Klinke', N'Trebsen / Mulde', N'04687', N'Zelenkastrasse 137')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1134, N'Goerner', N'Stein', N'08118', N'Boberger Strasse 90')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1135, N'Knoche', N'Grossnaundorf', N'01936', N'Tullastrasse 105')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1136, N'Baumert', N'Bahretal', N'01819', N'Sternplatz 133')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1137, N'Wedekind', N'Wiedemar', N'04509', N'Karl-Gerold-Platz 34')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1138, N'Rump', N'Johannstadt', N'01099', N'Kirchweg 213')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1139, N'Burg', N'Nausslitz', N'01187', N'Hauptplatz 100')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1140, N'Freiberg', N'Neumark, Sachsen', N'08496', N'Miquelallee 139')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1141, N'Dill', N'Chemnitz, Sachsen', N'09128', N'Neudecker Strasse 46')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1142, N'Schwenke', N'Bautzen', N'02640', N'Eschenstrasse 98')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1143, N'Giebel', N'Grossharthau', N'01909', N'Langobardenweg 87')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1144, N'Zettl', N'Rosswein', N'04741', N'Teubnerweg 204')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1145, N'Diederichs', N'Kirschau', N'02681', N'Bergesgrundweg 201')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1146, N'Theil', N'Johannstadt', N'01307', N'Bulgakowstrasse 193')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1147, N'Bunge', N'Striegistal', N'09661', N'Querweg 95')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1148, N'Trautwein', N'Unkersdorf', N'01462', N'Tagetesweg 57')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1149, N'Waibel', N'Doebernitz', N'04509', N'Burgenlandweg 208')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1150, N'Heintz', N'Annaberg-Buchholz', N'09456', N'Heckenweg 18')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1151, N'Marschner', N'Dresden', N'01326', N'Hofwiesenstrasse 219')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1152, N'Behrmann', N'Leubnitz bei Plauen', N'08539', N'Weistropper Weg 99')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1153, N'Rosendahl', N'Leipzig', N'04109', N'An der Foersterei 88')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1154, N'Kaemmerer', N'Johannstadt', N'01109', N'Titusstr. 82')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1155, N'Schuele', N'Annaberg-Buchholz', N'09456', N'Dantestrasse 232')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1156, N'Leonhard', N'Neustadt in Sachsen', N'01844', N'Riedeck 209')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1157, N'Stueber', N'Gorbitz-Sued', N'01169', N'Hummelweg 100')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1158, N'Wittek', N'Gruna', N'01219', N'Schweizstrasse 197')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1159, N'Milz', N'Neusalza-Spremberg', N'02742', N'Neudobritzer Weg 178')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1160, N'Patzer', N'Zwickau', N'08064', N'Zimmerstrasse 25')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1161, N'Dettmann', N'Markkleeberg', N'04416', N'Burkersdorfer Weg 48')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1162, N'Irmer', N'Siebenlehn', N'09603', N'Edelhof 193')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1163, N'Steinle', N'Neschwitz', N'02699', N'Josephinenstrasse 21')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1164, N'Jungbluth', N'Striesen-West', N'01307', N'Altomsewitz 154')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1165, N'Brueckmann', N'Dresden', N'01109', N'Max-Bromme-Steig 153')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1166, N'Meindl', N'Arzberg bei Torgau', N'04886', N'Am Gaertchen 244')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1167, N'Jahns', N'Lohsa', N'02999', N'Diebweg 185')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1168, N'Nadler', N'Naunhof bei Grimma', N'04683', N'Brendelweg 166')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1169, N'Haecker', N'Kaendler', N'09212', N'Bruehlsche Gasse 26')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1170, N'Bergemann', N'Sankt Egidien', N'09356', N'Klauerstrasse 15')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1171, N'Schoeler', N'Zschepplin', N'04838', N'Am Zschonergrund 143')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1172, N'Herter', N'Elsterheide', N'02979', N'Trimbergstr. 44')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1173, N'Winzer', N'Doberschau-Gaussig', N'01877', N'Heidelbachstrasse 26')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1174, N'Bitzer', N'Stetzsch', N'01279', N'Meinhardtweg 121')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1175, N'Dinter', N'Oppach', N'02736', N'Stadthausbruecke 237')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1176, N'Hundt', N'Zinna', N'04860', N'Intzestrasse 238')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1177, N'Senft', N'Markneukirchen', N'08258', N'Herrnstrasse 50')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1178, N'Flick', N'Gorbitz', N'01157', N'Ludwig-Fulda-Weg 126')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1179, N'Haberland', N'Johannstadt', N'01099', N'Knorrstrasse 142')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1180, N'Nagler', N'Plauen, Vogtland', N'08525', N'Bredowstrasse 198')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1181, N'Breunig', N'Wehlen', N'01829', N'Affentorplatz 35')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1182, N'Osswald', N'Neugersdorf, Sachsen', N'02727', N'Schadowstrasse 184')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1183, N'Bonk', N'Gohrisch', N'01824', N'Altenburger Weg 244')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1184, N'Klostermann', N'Johannstadt', N'01307', N'Langaugasse 205')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1185, N'Koellner', N'Cotta', N'01157', N'Am Hafen 113')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1186, N'Hausner', N'Oderwitz', N'02791', N'Hainweg 92')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1187, N'Heinig', N'Roederaue', N'01609', N'Wunderburg 25')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1188, N'Bohlen', N'Bischofswerda', N'01877', N'Gompitzer Hang 150')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1189, N'Koehne', N'Bad Muskau', N'02953', N'Nachtigallenstieg 63')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1190, N'Kortmann', N'Thierfeld', N'08118', N'An der Mainkur 162')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1191, N'Kamps', N'Weinboehla', N'01689', N'Cottaweg 58')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1192, N'Thimm', N'Crostau', N'02681', N'Wandalenweg 76')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1193, N'Nienhaus', N'Johannstadt', N'01462', N'Derbyweg 147')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1194, N'Stach', N'Kossa', N'04849', N'Hoetzlring 233')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1195, N'Thome', N'Poehla, Erzgebirge', N'08352', N'Soltauer Chaussee 48')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1196, N'Stotz', N'Johannstadt', N'01277', N'Altstetzsch 94')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1197, N'Brust', N'Gruena bei Chemnitz', N'09224', N'Concordiastr. 151')
GO
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1198, N'Saathoff', N'Grossschirma', N'09603', N'Luisenhofstieg 191')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1199, N'Erben', N'Auerbach, Erzgebirge', N'09392', N'Fontanestrasse 109')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1200, N'Wanke', N'Grossweitzschen', N'04720', N'Lia-Woehr-Platz 36')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1201, N'Pietzsch', N'Johannstadt', N'01309', N'Buzzistrasse 199')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1202, N'Schnitzer', N'Brandis bei Wurzen', N'04821', N'Obere Sterngasse 245')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1203, N'Dahlke', N'Niederau bei Meissen', N'01689', N'Rat-Beil-Strasse 54')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1204, N'Kaltenbach', N'Wachau bei Radeberg', N'01454', N'Hemmerleinstr. 79')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1205, N'Hochmuth', N'Raschau-Markersbach', N'08352', N'Pflanzsteig 99')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1206, N'Moehle', N'Dresden', N'01067', N'Berger Weg 167')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1207, N'Voegele', N'Dorfhain', N'01738', N'Pfeiferstrasse 105')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1208, N'Gaida', N'Uhyst, Spree', N'02999', N'Rauenthaler Weg 125')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1209, N'Jaeschke', N'Liegau-Augustusbad', N'01454', N'Leisbergstrasse 42')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1210, N'Hoeller', N'Liebschuetzberg', N'04758', N'Steinbeker Berg 240')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1211, N'Fellner', N'Zwota', N'08267', N'Reitersfeldweg 190')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1212, N'Sutter', N'Quolsdorf', N'02923', N'Gruenwinkel 12')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1213, N'Pfisterer', N'Gorbitz', N'01217', N'Kruggasse 236')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1214, N'Wohlfarth', N'Strassgraebchen', N'01936', N'Simsonstrasse 63')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1215, N'Kamm', N'Penig', N'09322', N'Fetscherstrasse 237')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1216, N'Roediger', N'Frohburg', N'04654', N'Wehlener Strasse 196')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1217, N'Ammon', N'Stetzsch', N'01328', N'Gurkenallee 221')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1218, N'Strube', N'Bad Schandau', N'01814', N'Laurinstrasse 234')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1219, N'Scheerer', N'Bad Schlema', N'08301', N'Am Torfmoor 210')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1220, N'Ostermeier', N'Zwickau', N'08062', N'Am Waeldchen 158')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1221, N'Rhein', N'Spree', N'02923', N'Ottostr. 163')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1222, N'Seubert', N'Ostritz', N'02899', N'Riedgrund 225')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1223, N'Hendricks', N'Malter', N'01744', N'Friesstrasse 224')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1224, N'Franck', N'Wiesen bei Zwickau', N'08134', N'Danziger Strasse 207')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1225, N'Sohn', N'Elsterberg, Vogtland', N'07985', N'Kaltenbergen 195')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1226, N'Kloeckner', N'Plauen, Vogtland', N'08525', N'Hoeblinggasse 119')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1227, N'Gruhn', N'Leipzig', N'04277', N'Maternstr. 229')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1228, N'Schoenemann', N'Ostritz', N'02899', N'Seehofstrasse 54')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1229, N'Kappes', N'Burgstein bei Plauen', N'08538', N'Heunischstr. 233')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1230, N'Koelsch', N'Chemnitz, Sachsen', N'09112', N'Am Bahnhof 236')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1231, N'Kroell', N'Priestewitz', N'01561', N'Cohausenstrasse 117')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1232, N'Hey', N'Liebstadt', N'01825', N'Wilsdruffer Ring 214')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1233, N'Irmer', N'Gorbitz', N'01217', N'Vilbeler Strasse 234')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1234, N'Stegmaier', N'Heide', N'08340', N'Muehlenkampsweg 72')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1235, N'Selzer', N'Pennrich', N'01156', N'An der Rennbahn 241')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1236, N'Dillmann', N'Zschortau', N'04519', N'Alnpeckstrasse 221')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1237, N'Beetz', N'Stetzsch', N'01189', N'Kurmarkstrasse 74')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1238, N'Kettler', N'Gruenhainichen', N'09579', N'Am Langenzug 109')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1239, N'Adolf', N'Borna bei Leipzig', N'04552', N'Steinbeker Weg 4')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1240, N'Eichholz', N'Steinbach', N'01462', N'Riedhofweg 227')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1241, N'Niggemann', N'Gorbitz', N'01465', N'Besselstrasse 216')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1242, N'Senft', N'Chemnitz, Sachsen', N'09116', N'Diebweg 227')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1243, N'Fellner', N'Muegeln bei Oschatz', N'04769', N'Bernusstrasse 183')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1244, N'Moehle', N'Zschorlau', N'08321', N'Braumannstrasse 206')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1245, N'Nienhaus', N'Hochkirch', N'02627', N'Am Landigt 187')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1246, N'Mahnke', N'Johannstadt', N'01159', N'Rohrbachstrasse 187')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1247, N'Seufert', N'Chemnitz, Sachsen', N'09125', N'Im Kammerdorf 237')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1248, N'Kaltenbach', N'Friedrichstadt', N'01159', N'Obeliskgasse 172')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1249, N'Wassermann', N'Lichtentanne', N'08115', N'Sachsenstrasse 126')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1250, N'Stevens', N'Torgau', N'04860', N'Ohlendorffstrasse 86')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1251, N'Milz', N'Johannstadt', N'01109', N'Vogelsanger Weg 145')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1252, N'Wittich', N'Gorbitz', N'01277', N'Vogesenweg 154')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1253, N'Gaebler', N'Eilenburg', N'04838', N'Gederner Strasse 67')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1254, N'Fleischhauer', N'Kriebstein', N'09648', N'Schoenbacher Weg 105')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1255, N'Asmus', N'Syrau', N'08548', N'Schillerplatz 186')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1256, N'Bangert', N'Grossweitzschen', N'04720', N'Siedlungsstrasse 198')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1257, N'Effenberger', N'Thallwitz', N'04808', N'Meurerweg 45')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1258, N'Gold', N'Goerlitz, Neisse', N'02827', N'Alte Dorfstrasse 103')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1259, N'Dold', N'Cunewalde', N'02733', N'Wartegaesschen 131')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1260, N'Weniger', N'Steinigtwolmsdorf', N'01904', N'Chapeaurougeweg 136')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1261, N'Kracht', N'Triebel / Vogtland', N'08606', N'Hanfftsweg 161')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1262, N'Weinberg', N'Woellnau', N'04838', N'Bauerberg 69')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1263, N'Markgraf', N'Eilenburg', N'04838', N'Gerberstrasse 210')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1264, N'Wehrmann', N'Groeditz bei Riesa', N'01609', N'Rubensweg 241')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1265, N'Buechler', N'Gorbitz', N'01097', N'Dielmannstrasse 54')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1266, N'Fellner', N'Chemnitz, Sachsen', N'09030', N'Melchiorstrasse 203')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1267, N'Pawlowski', N'Gorbitz', N'01109', N'Am Bahndamm 67')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1268, N'Piontek', N'Mochau bei Doebeln', N'04720', N'Altgomlitz 24')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1269, N'Doehler', N'Elstertrebnitz', N'04523', N'Olbrichstrasse 196')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1270, N'Escher', N'Gorbitz', N'01069', N'Kleemattstrasse 166')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1271, N'Waibel', N'Limbach-Oberfrohna', N'09212', N'Masurenweg 66')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1272, N'Germann', N'Liebschuetzberg', N'04758', N'Pflugspfad 235')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1273, N'Krupp', N'Dresden', N'01324', N'Hutbergstrasse 91')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1274, N'Glock', N'Gruenhainichen', N'09579', N'Pflugspfad 30')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1275, N'Siemer', N'Marienau bei Zwickau', N'08132', N'Klein Herl 213')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1276, N'Bitzer', N'Dresden', N'01108', N'Am Muehlenberg 176')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1277, N'Goerner', N'Siebenlehn', N'09603', N'Fiefstuecken 235')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1278, N'Trommer', N'Bad Schlema', N'08301', N'Woogstrasse 177')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1279, N'Plum', N'Muegeln bei Oschatz', N'04769', N'Landseestrasse 42')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1280, N'Rump', N'Stetzsch', N'01465', N'Langriedgasse 232')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1281, N'Piotrowski', N'Lauter / Sachsen', N'08312', N'Hasselhorstweg 236')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1282, N'Peukert', N'Niederwiesa', N'09577', N'Ratsstrasse 195')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1283, N'Mittelstaedt', N'Stetzsch', N'01189', N'Kransberger Weg 157')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1284, N'Schlemmer', N'Johannstadt', N'01219', N'Goerresstrasse 229')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1285, N'Klumpp', N'Dresden', N'01159', N'Rathenaustrasse 152')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1286, N'Kaufhold', N'Weisser Hirsch', N'01324', N'Markusplatz 208')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1287, N'Thum', N'Gorbitz', N'01069', N'Schwanmanweg 26')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1288, N'Handke', N'Erlbach-Kirchberg', N'09385', N'Mitterweg 133')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1289, N'Kuck', N'Niesky', N'02906', N'Gruene Telle 60')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1290, N'Grosskopf', N'Zoeblitz', N'09517', N'Telemannstrasse 162')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1291, N'Scheele', N'Ossling', N'01920', N'Kirchberg 103')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1292, N'Scheffel', N'Porschdorf', N'01814', N'Stemmanns Weg 32')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1293, N'Mehler', N'Gorbitz', N'01239', N'Am Zaukenfeld 93')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1294, N'Stehr', N'Gorbitz', N'01067', N'Oberndorfer Weg 225')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1295, N'Deininger', N'Sohland an der Spree', N'02689', N'Am Badweg 23')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1296, N'Dieterle', N'Gorbitz', N'01189', N'Korolenkostrasse 3')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1297, N'Schepers', N'Taucha bei Leipzig', N'04425', N'Ruehlstrasse 152')
GO
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1298, N'Droege', N'Zschepplin', N'04838', N'Falltorstrasse 123')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1299, N'Denecke', N'Pegau', N'04523', N'Grempstrasse 68')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1300, N'Nordmann', N'Kohren-Sahlis', N'04655', N'Airportring 242')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1301, N'Vaupel', N'Elstra', N'01920', N'Geigerstrasse 74')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1302, N'Griebel', N'Grosslehna', N'04420', N'Dammgasse 130')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1303, N'Weck', N'Rammenau', N'01877', N'Arensweg 59')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1304, N'Heinecke', N'Hartha bei Doebeln', N'04746', N'Oberer Kreutberg 113')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1305, N'Karger', N'Schoeneck / Vogtland', N'08261', N'Bruckertshof 7')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1306, N'Eitel', N'Leipzig', N'04279', N'Gaertnerstrasse 227')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1307, N'Hackbarth', N'Frohburg', N'04654', N'Teichrosenweg 242')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1308, N'Stang', N'Muegeln bei Oschatz', N'04769', N'Schlossstr. 109')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1309, N'Gilles', N'Zoellmen', N'01462', N'Loeherstrasse 139')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1310, N'Blankenburg', N'Grossnaundorf', N'01936', N'Zum Lehmfeld 82')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1311, N'Fick', N'Chemnitz, Sachsen', N'09111', N'Wiesengrund 178')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1312, N'Klostermann', N'Markkleeberg', N'04416', N'Schreberweg 83')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1313, N'Sohn', N'Mildenau', N'09456', N'Neunkircher Weg 144')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1314, N'Graupner', N'Koenigsbrueck', N'01936', N'Kruppstrasse 160')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1315, N'Kirschbaum', N'Ketzerbachtal', N'01623', N'Suedhoehe 149')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1316, N'Zach', N'Stoermthal', N'04463', N'Bundenweg 80')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1317, N'Wittek', N'Wilsdruff', N'01723', N'Grauener Weg 13')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1318, N'Koppe', N'Elstertrebnitz', N'04523', N'Reussstr. 191')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1319, N'Kamps', N'Ostritz', N'02899', N'Dinglingerstrasse 85')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1320, N'Thom', N'Geising', N'01778', N'Konopkastrasse 87')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1321, N'Stang', N'Schoenau bei Zwickau', N'08134', N'Brueckenweg 152')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1322, N'Pongratz', N'Reinhardtsgrimma', N'01768', N'Boehmertstrasse 153')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1323, N'Hirschfeld', N'Bennewitz bei Wurzen', N'04828', N'Niederauer Platz 36')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1324, N'Schulten', N'Steinbach', N'01462', N'Satzriedgasse 245')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1325, N'Woehrle', N'Kreba-Neudorf', N'02906', N'Hainer Weg 244')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1326, N'Lex', N'Doberschau-Gaussig', N'02633', N'Battenberger Weg 146')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1327, N'Hansmann', N'Dresden', N'01259', N'Gereuthstr. 178')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1328, N'Edel', N'Leippen', N'01665', N'Querstrasse 66')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1329, N'Klingenberg', N'Niederwiesa', N'09577', N'Elkenbachstrasse 193')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1330, N'Angermann', N'Gelenau / Erzgebirge', N'09423', N'Reclamstrasse 130')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1331, N'Schlemmer', N'Dresden', N'01169', N'Holzhauerweg 190')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1332, N'Heppner', N'Rosenbach bei Loebau', N'02708', N'Severusstrasse 177')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1333, N'Storz', N'Muegeln bei Oschatz', N'04769', N'Muenzgasse 153')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1334, N'Behrmann', N'Dresden', N'01069', N'Schlossstrasse 188')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1335, N'Ortner', N'Waldsteinberg', N'04821', N'Am Dorfplatz 194')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1336, N'Tempel', N'Zwota', N'08267', N'Am Spritzenhaus 92')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1337, N'Burk', N'Schkeuditz', N'04435', N'Waldwiesenstr. 139')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1338, N'Orlowski', N'Bad Schandau', N'01814', N'Kaendlerstrasse 230')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1339, N'Breidenbach', N'Stetzsch', N'01067', N'Luebecker Strasse 72')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1340, N'Ploetz', N'Altfranken', N'01156', N'Elkenbachstrasse 156')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1341, N'Hoelzel', N'Waldhufen', N'02906', N'Schraegkamp 210')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1342, N'Loibl', N'Freiberg', N'08626', N'Lannerstrasse 92')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1343, N'Felber', N'Johannstadt', N'01237', N'Lukasstrasse 244')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1344, N'Brueckmann', N'Floeha', N'09557', N'Doebraer Strasse 158')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1345, N'Schneck', N'Leubnitz bei Plauen', N'08412', N'Am Hollergraben 243')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1346, N'Juettner', N'Gersdorf', N'04746', N'Gasse 203')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1347, N'Markmann', N'Wittichenau', N'02997', N'Fischergasse 114')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1348, N'Berberich', N'Wermsdorf', N'04779', N'Buger Hauptstr. 172')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1349, N'Kullmann', N'Johannstadt', N'01109', N'Moenchhofstrasse 52')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1350, N'Felber', N'Grossbothen', N'04668', N'Severusstrasse 39')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1351, N'Alber', N'Gorbitz-Sued', N'01169', N'Altnausslitz 17')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1352, N'Salewski', N'Wyhratal', N'04552', N'Scheibenbergweg 78')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1353, N'Wiest', N'Stetzsch', N'01069', N'Hoepers Kamp 49')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1354, N'Velten', N'Floeha', N'09557', N'Ignaz Nuss-Weg 103')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1355, N'Knittel', N'Zwickau', N'08056', N'LennÃ©strasse 223')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1356, N'Mandel', N'Leippen', N'01665', N'Zschaukegraben 9')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1357, N'Mast', N'Kleindalzig', N'04442', N'Rugestrasse 114')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1358, N'Heidt', N'Johannstadt', N'01127', N'Blumenstr. 112')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1359, N'Lanz', N'Bad Brambach', N'08648', N'Am Marienbad 14')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1360, N'Emde', N'Chemnitz, Sachsen', N'09113', N'Blagnac-Bruecke 243')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1361, N'Kienle', N'Stetzsch', N'01259', N'Ilextwiete 30')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1362, N'Michler', N'Stetzsch', N'01129', N'Tiberiusstrasse 182')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1363, N'Rick', N'Dresden', N'01067', N'Blanchardstrasse 110')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1364, N'Holm', N'Burkau', N'01906', N'Zinggstrasse 185')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1365, N'Wittek', N'Goerlitz, Neisse', N'02828', N'Spliedtring 107')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1366, N'Doehler', N'Waldheim, Sachsen', N'04736', N'Flughafenstrasse 12')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1367, N'Mueck', N'Ehrenfriedersdorf', N'09427', N'Kemmerstr. 189')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1368, N'Angermann', N'Schoepstal', N'02829', N'Moenchsleite 87')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1369, N'Juengling', N'Muehlental', N'08626', N'Gucksbergweg 244')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1370, N'Spitz', N'Rackwitz', N'04519', N'Huswertstrasse 225')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1371, N'Wurster', N'Bennewitz bei Wurzen', N'04828', N'Laschoberstrasse 78')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1372, N'Retzlaff', N'Stein', N'08118', N'Stegstrasse 87')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1373, N'Seelig', N'Tharandt', N'01737', N'Steinigtwiesenweg 32')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1374, N'Edel', N'Dresden', N'01462', N'Blochmatt 64')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1375, N'Tappe', N'Bernsbach', N'08315', N'Laubegaster Weg 182')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1376, N'Steigerwald', N'Rochlitz', N'09306', N'Klarastrasse 28')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1377, N'Kuntze', N'Mittweida', N'09648', N'Wormser Strasse 213')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1378, N'Fritzsch', N'Zschocken', N'08118', N'Adickesallee 2')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1379, N'Brueckmann', N'Neustadt / Vogtland', N'08223', N'Stoeckelstrasse 66')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1380, N'Gaul', N'Lohmen, Sachsen', N'01847', N'Lugbank 33')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1381, N'Blohm', N'Oderwitz', N'02791', N'Lersnerstrasse 236')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1382, N'Kimmel', N'Rohrbach', N'01920', N'Lippeltstrasse 69')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1383, N'Ostermeier', N'Gruenbach, Vogtland', N'08223', N'Am Schreiberbach 203')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1384, N'Franck', N'Pennrich', N'01156', N'Markusstr. 244')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1385, N'Grosse', N'Leipzig', N'04129', N'Karlshagener Weg 25')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1386, N'Schiessl', N'Bernsbach', N'08315', N'Fuhrenkamp 206')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1387, N'Nehring', N'Niederstriegis', N'04741', N'Am Hopfenfeld 157')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1388, N'Kienle', N'Oederan', N'09569', N'Howisch 32')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1389, N'Matheis', N'Grossolbersdorf', N'09432', N'Hebebrandstrasse 129')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1390, N'Sohn', N'Grimma', N'04668', N'Muehlensteig 180')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1391, N'Ruck', N'Bad Muskau', N'02953', N'Birkenallee 126')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1392, N'Amend', N'Stetzsch', N'01259', N'Hellbrookstrasse 79')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1393, N'Heppner', N'Cossebaude', N'01462', N'Kamelienweg 168')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1394, N'Till', N'Riesa', N'01587', N'Erlengrund 163')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1395, N'Pietschmann', N'Mochau bei Doebeln', N'04720', N'Am Ende 125')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1396, N'Reinsch', N'Plauen, Vogtland', N'08525', N'Adalbertstrasse 192')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1397, N'Breitenbach', N'Kurort Oybin', N'02797', N'Schwarmweg 138')
GO
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1398, N'Zitzmann', N'Gorbitz', N'01478', N'Am Brauhaus 156')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1399, N'Mauch', N'Grosstreben-Zwethau', N'04886', N'Handelsstrasse 127')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1400, N'Mittelstaedt', N'Pulsnitz', N'01896', N'Roseggerstrasse 8')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1401, N'Klostermann', N'Dresden', N'01309', N'Waldsportpfad 177')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1402, N'Sebastian', N'Gruena bei Chemnitz', N'09224', N'Dielmannstrasse 73')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1403, N'Clauss', N'Glashuette, Sachsen', N'01768', N'Buchsbaumstrasse 245')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1404, N'Fels', N'Friedrichstadt', N'01157', N'Gaertnerweg 198')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1405, N'Hildenbrand', N'Hoyerswerda', N'02977', N'Franklinstrasse 202')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1406, N'Runkel', N'Doberschau-Gaussig', N'02633', N'Spitalgasse 53')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1407, N'Schmoll', N'Doberschau-Gaussig', N'02692', N'Georginenweg 26')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1408, N'Reisch', N'Stetzsch', N'01237', N'Vollmarstrasse 6')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1409, N'Pitz', N'Mehltheuer, Vogtland', N'08539', N'Fersenfeldtsweg 177')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1410, N'Moog', N'Wyhratal', N'04552', N'Tornaer Ring 186')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1411, N'Diefenbach', N'Zabeltitz', N'01561', N'Michael Mayr-Gasse 8')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1412, N'Juenemann', N'Stetzsch', N'01279', N'Wunschring 51')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1413, N'Brennecke', N'Nepperwitz', N'04828', N'Am Pfarrlehn 140')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1414, N'Limbach', N'Leipzig', N'04178', N'Tornaer Ring 116')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1415, N'Michler', N'Kirschau', N'02681', N'Kampener Stieg 222')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1416, N'Buechel', N'Dresden', N'01189', N'Bluecherweg 210')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1417, N'Strube', N'Chemnitz, Sachsen', N'09120', N'Sudetenstr. 151')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1418, N'Storz', N'Sankt Egidien', N'09356', N'Kirchnerstrasse 175')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1419, N'Scheele', N'Zeithain', N'01619', N'Wachwitzblick 34')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1420, N'Strube', N'Gorbitz', N'01219', N'Kurparkstrasse 210')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1421, N'Christian', N'Grosstreben-Zwethau', N'04886', N'Barfussweg 5')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1422, N'Stief', N'Elterlein', N'09481', N'Am Dorfende 14')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1423, N'Loth', N'Zschortau', N'04519', N'Hahnbergweg 205')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1424, N'Schnitzer', N'Pausa / Vogtland', N'07952', N'Herriotstrasse 75')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1425, N'Fuehrer', N'Wuelknitz bei Riesa', N'01609', N'Seebachstrasse 127')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1426, N'Unruh', N'Hundshuebel', N'08318', N'Gadelsdorfer Weg 39')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1427, N'Streich', N'Dresden', N'01156', N'Am Viverdamm 231')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1428, N'Vaupel', N'Gorbitz', N'01277', N'Junghansstrasse 6')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1429, N'Zeiler', N'Elsterheide', N'02979', N'NicodÃ©strasse 138')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1430, N'Weigert', N'Theuma', N'08541', N'Ochsenangerstr. 165')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1431, N'Dobler', N'Imnitz', N'04442', N'Rote Bruecke 220')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1432, N'Franzke', N'Syrau', N'08548', N'Lange Allee 96')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1433, N'Reinsch', N'Grossharthau', N'01909', N'Graben 163')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1434, N'Dorner', N'Doberschau-Gaussig', N'01877', N'Mirabellenweg 216')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1435, N'Gessner', N'Mausitz', N'04442', N'Panoramaweg 168')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1436, N'Lembke', N'Oberschoena', N'09600', N'Nordstrasse 122')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1437, N'Helfrich', N'Sehmatal', N'09465', N'Stammannstrasse 17')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1438, N'Hotz', N'Neuensalz', N'08541', N'Bauhofstrasse 25')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1439, N'Edel', N'Niedercunnersdorf', N'02708', N'Tichystrasse 227')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1440, N'Pausch', N'Mulda / Sachsen', N'09619', N'Muenterweg 39')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1441, N'Bacher', N'Falkenau, Sachsen', N'09569', N'Bickenbacher Weg 105')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1442, N'Mueck', N'Stein', N'08118', N'Am Weissiger Bach 1')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1443, N'Selle', N'Schoenteichen', N'01920', N'Wartenau 94')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1444, N'Rohrbach', N'Zschaitz-Ottewig', N'04720', N'Wiesenteich 60')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1445, N'Heinzel', N'Kittlitz bei Loebau', N'02708', N'Stiehlerstrasse 237')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1446, N'Staub', N'Eulowitz', N'02692', N'Holzgrund 106')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1447, N'Wassermann', N'Bretnig-Hauswalde', N'01900', N'Schadowstrasse 89')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1448, N'Groll', N'Grosspoesna', N'04463', N'Muehlsdorfer Weg 58')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1449, N'Haeuser', N'Hochkirch', N'02627', N'Rotenbrueckenweg 80')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1450, N'Jahns', N'Altfranken', N'01156', N'Barlachstrasse 91')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1451, N'Nass', N'Brand-Erbisdorf', N'09618', N'Elli-Lucht-Park 180')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1452, N'Andreas', N'Ockerwitz', N'01462', N'Rattlergasse 44')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1453, N'Prill', N'Cavertitz', N'04758', N'Max-Bromme-Steig 28')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1454, N'Niehoff', N'Oberlungwitz', N'09353', N'Koerberstrasse 186')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1455, N'Fels', N'Johannstadt', N'01328', N'Pietzschstrasse 190')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1456, N'Dannenberg', N'Haselbach', N'09526', N'Schanzstrasse 220')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1457, N'Grossmann', N'Karcha', N'01683', N'Hohle Gasse 53')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1458, N'Matheis', N'Pennrich', N'01156', N'Quosdorfstrasse 47')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1459, N'Graeber', N'Unkersdorf', N'01462', N'Stadtdeich 230')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1460, N'Goldbach', N'Lohmen, Sachsen', N'01847', N'Keulenbergstrasse 31')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1461, N'Dannenberg', N'Chemnitz, Sachsen', N'09112', N'Am Burghof 139')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1462, N'Vollrath', N'Johannstadt', N'01237', N'Diemelstrasse 91')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1463, N'Nolting', N'Ottendorf-Okrilla', N'01458', N'Ruppendorfer Weg 163')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1464, N'Brennecke', N'Colditz', N'04680', N'Cheruskerweg 134')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1465, N'Piel', N'Struppen', N'01796', N'Haarweg 236')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1466, N'Wenger', N'Machern bei Wurzen', N'04827', N'Poeppelmannstrasse 1')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1467, N'Goerlich', N'Stetzsch', N'01277', N'Tocklergasse 224')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1468, N'Bonn', N'Kamenz', N'01917', N'Lia-Woehr-Platz 171')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1469, N'Rebmann', N'Taura bei Burgstaedt', N'09249', N'Seilergasse 147')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1470, N'Haider', N'Innere Altstadt', N'01067', N'Willemerstrasse 91')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1471, N'Jasper', N'Bernsbach', N'08315', N'Olenhoffweg 226')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1472, N'Sternberg', N'Otterwisch', N'04668', N'Burgsdorffstrasse 59')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1473, N'Sauermann', N'Niederwartha', N'01462', N'Faehrmannweg 23')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1474, N'Liese', N'Riesa', N'01589', N'Billufer 185')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1475, N'Eichmann', N'Nausslitz', N'01159', N'Heerstrasse 144')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1476, N'Nordmann', N'Hainichen, Sachsen', N'09661', N'Suedhang 125')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1477, N'Hochmuth', N'Muehlau bei Chemnitz', N'09241', N'Melisseweg 223')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1478, N'Effenberger', N'Gorbitz', N'01189', N'Borgesch 125')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1479, N'Dieterle', N'Reinhardtsgrimma', N'01768', N'Brunnenstrasse 154')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1480, N'Zell', N'Niederfrohna', N'09243', N'Am Weissen Turm 186')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1481, N'Hackbarth', N'Grosshartmannsdorf', N'09618', N'Casimirstrasse 59')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1482, N'Wiemer', N'Obergurig', N'02692', N'Im Gutacker 131')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1483, N'Lichtenberg', N'Eulatal', N'04651', N'Pohrsdorfer Weg 210')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1484, N'Hengst', N'Zschortau', N'04519', N'Ermelstrasse 92')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1485, N'Strehl', N'Thallwitz', N'04808', N'Kellerberg 25')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1486, N'Ferber', N'Friedrichstadt', N'01157', N'Spiegelweg 76')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1487, N'Weinzierl', N'Plauen, Vogtland', N'08523', N'Flurstrasse 87')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1488, N'Kahlert', N'Stetzsch', N'01279', N'Knorrstrasse 181')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1489, N'Voegele', N'Kreissa', N'01623', N'Bahnhaeuser 187')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1490, N'Liebe', N'Niederwuerschnitz', N'09399', N'Friebelstrasse 99')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1491, N'Guettler', N'Neukirch / Lausitz', N'01904', N'Aronstr. 34')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1492, N'Schnoor', N'Johannstadt', N'01187', N'Am Gleise 214')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1493, N'Israel', N'Johannstadt', N'01129', N'Herchenhainer Weg 76')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1494, N'Gessner', N'Leipzig', N'04107', N'Brauereiweg 147')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1495, N'Sand', N'Bad Muskau', N'02953', N'Amselgrund 231')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1496, N'Kaluza', N'Doberschau-Gaussig', N'02633', N'Pommernweg 178')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1497, N'Pfitzner', N'Kaendler', N'09247', N'Am Dorngraben 51')
GO
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1498, N'Weiner', N'Johannstadt', N'01328', N'Gleinaer Strasse 159')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1499, N'Schlesinger', N'Doberschau-Gaussig', N'01877', N'Lehmkuhlenweg 132')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1500, N'Mehler', N'Siebenlehn', N'09634', N'Buenaustrasse 96')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1501, N'Test', N'Test', N'0233 ', N'Test')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1502, N'asdasd', N'adsasd', N'asds ', N'asdsd')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1503, N'Klemens Trägers', N'Dresden', N'01213', N'Am Geiger 112')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1505, N'Lecker', N'Lecker', N'34234', N'adasd 23')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1506, N'alsdasd', N'dadsas', N'3434 ', N'asdasd')
INSERT [dbo].[Kunde]
    ([KunNr], [KunName], [KunOrt], [KunPLZ], [KunStrasse])
VALUES
    (1507, N'Tets', N'test', N'01313', N'Test')
SET IDENTITY_INSERT [dbo].[Kunde] OFF
GO
INSERT [dbo].[Mitarbeiter]
    ([MitID], [MitName], [MitVorname], [MitGebDat], [MitJob], [MitStundensatz], [NLNr])
VALUES
    (N'101', N'Hase', N'Hoppel', CAST(N'1994-04-30' AS Date), N'Monteur', 80.0000, 1)
INSERT [dbo].[Mitarbeiter]
    ([MitID], [MitName], [MitVorname], [MitGebDat], [MitJob], [MitStundensatz], [NLNr])
VALUES
    (N'102', N'Nass', N'Anna', CAST(N'1986-02-20' AS Date), N'Meister', 120.0000, 1)
INSERT [dbo].[Mitarbeiter]
    ([MitID], [MitName], [MitVorname], [MitGebDat], [MitJob], [MitStundensatz], [NLNr])
VALUES
    (N'103', N'Fuchs', N'Reinecke', CAST(N'1993-07-19' AS Date), N'Monteur', 80.0000, 2)
INSERT [dbo].[Mitarbeiter]
    ([MitID], [MitName], [MitVorname], [MitGebDat], [MitJob], [MitStundensatz], [NLNr])
VALUES
    (N'104', N'Gloerr', N'Renate', CAST(N'1987-05-27' AS Date), N'Einkauf', NULL, NULL)
INSERT [dbo].[Mitarbeiter]
    ([MitID], [MitName], [MitVorname], [MitGebDat], [MitJob], [MitStundensatz], [NLNr])
VALUES
    (N'105', N'Uhu', N'Uhu', CAST(N'1987-05-27' AS Date), N'Monteur', 80.0000, 3)
INSERT [dbo].[Mitarbeiter]
    ([MitID], [MitName], [MitVorname], [MitGebDat], [MitJob], [MitStundensatz], [NLNr])
VALUES
    (N'106', N'Rabe', N'Weiser', CAST(N'1976-12-13' AS Date), N'Meister', 120.0000, 2)
INSERT [dbo].[Mitarbeiter]
    ([MitID], [MitName], [MitVorname], [MitGebDat], [MitJob], [MitStundensatz], [NLNr])
VALUES
    (N'107', N'Roerich', N'Walter', CAST(N'1969-09-20' AS Date), N'Meister', 125.0000, 1)
INSERT [dbo].[Mitarbeiter]
    ([MitID], [MitName], [MitVorname], [MitGebDat], [MitJob], [MitStundensatz], [NLNr])
VALUES
    (N'108', N'Beinert', N'Werner', CAST(N'1998-11-30' AS Date), N'Monteur', 30.0000, 3)
INSERT [dbo].[Mitarbeiter]
    ([MitID], [MitName], [MitVorname], [MitGebDat], [MitJob], [MitStundensatz], [NLNr])
VALUES
    (N'109', N'Nass', N'Anna', CAST(N'1993-07-19' AS Date), N'Auftragskoordinator', NULL, NULL)
INSERT [dbo].[Mitarbeiter]
    ([MitID], [MitName], [MitVorname], [MitGebDat], [MitJob], [MitStundensatz], [NLNr])
VALUES
    (N'110', N'Broesel', N'Eckhardt', CAST(N'1987-05-27' AS Date), N'Monteur', 75.0000, 1)
INSERT [dbo].[Mitarbeiter]
    ([MitID], [MitName], [MitVorname], [MitGebDat], [MitJob], [MitStundensatz], [NLNr])
VALUES
    (N'111', N'Dorant', N'Theo', CAST(N'1995-11-30' AS Date), N'Lagermitarbeiter', NULL, NULL)
INSERT [dbo].[Mitarbeiter]
    ([MitID], [MitName], [MitVorname], [MitGebDat], [MitJob], [MitStundensatz], [NLNr])
VALUES
    (N'112', N'Hase', N'Hoppeline', CAST(N'1997-10-28' AS Date), N'Monteur', 30.0000, 2)
INSERT [dbo].[Mitarbeiter]
    ([MitID], [MitName], [MitVorname], [MitGebDat], [MitJob], [MitStundensatz], [NLNr])
VALUES
    (N'122', N'Bertel', N'Tom', CAST(N'1999-07-22' AS Date), N'Monteur', 12.0000, NULL)
INSERT [dbo].[Mitarbeiter]
    ([MitID], [MitName], [MitVorname], [MitGebDat], [MitJob], [MitStundensatz], [NLNr])
VALUES
    (N'198', N'Peters', N'Jörn', CAST(N'1999-07-22' AS Date), N'Monteur', 80.0000, 2)
INSERT [dbo].[Mitarbeiter]
    ([MitID], [MitName], [MitVorname], [MitGebDat], [MitJob], [MitStundensatz], [NLNr])
VALUES
    (N'950', N'Mustermann', N'Max', CAST(N'1999-09-09' AS Date), N'Monteur', 80.0000, 1)
INSERT [dbo].[Mitarbeiter]
    ([MitID], [MitName], [MitVorname], [MitGebDat], [MitJob], [MitStundensatz], [NLNr])
VALUES
    (N'998', N'TEST', N'TEST', CAST(N'2022-11-15' AS Date), N'Monteur', 12.0000, 3)
INSERT [dbo].[Mitarbeiter]
    ([MitID], [MitName], [MitVorname], [MitGebDat], [MitJob], [MitStundensatz], [NLNr])
VALUES
    (N'999', N'Test1', N'Test', CAST(N'2022-11-22' AS Date), N'Mongo', 10000.0000, 2)
GO
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'A0100', 1219, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'A0100', 1251, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'A0100', 1266, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'A0100', 1284, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'A0100', 1293, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'A0100', 1326, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'A0100', 1404, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'A0100', 1421, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'A0100', 3006, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'A0100', 3011, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'A0100', 3045, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'A0100', 3070, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'A0100', 3110, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'A0100', 3156, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'A0100', 3182, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'A0100', 3185, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'A0100', 3190, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'A0100', 3231, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'A0100', 3256, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'A0100', 3282, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'A0100', 3315, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'A0100', 3348, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'A0100', 3361, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'A0100', 3363, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'A0100', 3442, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'A0100', 3478, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'A0100', 3544, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'A0100', 3559, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0100', 1211, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0100', 1217, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0100', 1265, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0100', 1310, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0100', 1320, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0100', 1395, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0100', 1396, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0100', 1423, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0100', 1425, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0100', 1431, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0100', 3038, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0100', 3044, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0100', 3118, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0100', 3142, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0100', 3197, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0100', 3256, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0100', 3365, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0100', 3382, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0100', 3393, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0100', 3409, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0100', 3418, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0100', 3530, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0100', 3548, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0100', 3551, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0100', 3559, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0100', 3579, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0220', 1230, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0220', 1232, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0220', 1269, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0220', 1284, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0220', 1294, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0220', 1304, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0220', 1309, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0220', 1331, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0220', 1403, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0220', 1418, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0220', 1422, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0220', 1429, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0332', 1211, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0332', 1228, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0332', 1229, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0332', 1240, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0332', 1241, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0332', 1242, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0332', 1292, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0332', 1318, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0332', 1393, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0332', 1403, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0332', 1409, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0332', 1411, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0332', 1425, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0332', 1429, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0444', 1209, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0444', 1230, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0444', 1248, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0444', 1250, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0444', 1286, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0444', 1305, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0444', 1329, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0444', 1409, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0500', 1218, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0500', 1235, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0500', 1241, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0500', 1271, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0500', 1283, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0500', 1290, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0500', 1299, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0500', 1318, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0500', 1323, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0500', 1330, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0500', 1398, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0500', 1406, 1)
GO
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0600', 1214, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0600', 1223, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0600', 1233, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0600', 1240, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0600', 1256, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0600', 1257, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0600', 1270, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0600', 1385, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0600', 1388, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0600', 3024, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0600', 3062, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0600', 3111, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0600', 3142, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0600', 3149, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0600', 3200, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0600', 3203, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0600', 3214, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0600', 3215, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0600', 3241, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0600', 3249, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0600', 3292, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0600', 3334, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0600', 3338, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0600', 3356, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0600', 3413, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0600', 3424, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'D0600', 3488, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0100', 1208, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0100', 1220, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0100', 1222, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0100', 1228, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0100', 1229, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0100', 1240, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0100', 1275, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0100', 1301, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0100', 1312, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0100', 1314, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0100', 1320, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0100', 1323, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0100', 1325, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0100', 1385, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0100', 1388, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0100', 1393, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0100', 1398, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0100', 3035, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0100', 3036, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0100', 3111, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0100', 3187, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0100', 3242, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0100', 3269, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0100', 3315, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0100', 3322, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0100', 3376, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0100', 3418, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0100', 3430, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0100', 3472, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0100', 3477, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0100', 3565, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0100', 3579, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0110', 1209, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0110', 1231, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0110', 1252, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0110', 1255, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0110', 1256, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0110', 1398, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0110', 1405, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0110', 1407, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0110', 1413, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0110', 3024, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0110', 3090, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0110', 3099, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0110', 3159, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0110', 3247, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0110', 3304, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0110', 3340, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0110', 3360, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0110', 3380, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0110', 3411, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0110', 3430, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0110', 3462, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0110', 3533, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0120', 1213, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0120', 1214, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0120', 1224, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0120', 1225, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0120', 1259, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0120', 1265, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0120', 1268, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0120', 1280, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0120', 1282, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0120', 1287, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0120', 1292, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0120', 1299, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0120', 1324, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0120', 1387, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0120', 1394, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0120', 1410, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0120', 1420, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0120', 1426, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0120', 3004, 1)
GO
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0120', 3038, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0120', 3045, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0120', 3085, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0120', 3092, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0120', 3100, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0120', 3108, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0120', 3119, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0120', 3121, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0120', 3135, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0120', 3143, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0120', 3218, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0120', 3235, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0120', 3237, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0120', 3312, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0120', 3361, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0120', 3383, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0120', 3404, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0120', 3426, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0120', 3430, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0120', 3488, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0120', 3518, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'E0120', 3523, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'H0200', 1243, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'H0200', 1274, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'H0200', 1275, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'H0200', 1287, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'H0200', 1293, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'H0200', 1386, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'H0200', 1395, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'H0200', 1401, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'H0200', 1408, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'H0200', 1414, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'H0200', 3035, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'H0200', 3040, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'H0200', 3070, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'H0200', 3085, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'H0200', 3145, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'H0200', 3223, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'H0200', 3241, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'H0200', 3249, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'H0200', 3306, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'H0200', 3332, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'H0200', 3348, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'H0200', 3382, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'H0200', 3383, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'H0200', 3401, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'H0200', 3403, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'H0200', 3411, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'H0200', 3454, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'H0200', 3551, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'H0200', 3565, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'H0200', 3576, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'H0230', 1212, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'H0230', 1229, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'H0230', 1241, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'H0230', 1267, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'H0230', 1270, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'H0230', 1306, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'H0230', 1315, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'H0230', 1400, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'H0230', 1422, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'H0230', 1425, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'H0230', 3019, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'H0230', 3038, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'H0230', 3046, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'H0230', 3070, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'H0230', 3094, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'H0230', 3109, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'H0230', 3257, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'H0230', 3283, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'H0230', 3299, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'H0230', 3302, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'H0230', 3306, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'H0230', 3313, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'H0230', 3352, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'H0230', 3369, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'H0230', 3530, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'K0400', 1243, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'K0400', 1248, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'K0400', 1267, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'K0400', 1274, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'K0400', 1279, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'K0400', 1318, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'K0400', 1411, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'K0400', 1412, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'K0400', 1417, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'K0400', 1422, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'K0400', 3012, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'K0400', 3094, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'K0400', 3115, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'K0400', 3166, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'K0400', 3183, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'K0400', 3299, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'K0400', 3304, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'K0400', 3329, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'K0400', 3345, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'K0400', 3346, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'K0400', 3411, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'K0400', 3429, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'K0400', 3457, 2)
GO
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'K0400', 3528, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'K0400', 3536, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'K0400', 3540, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0100', 1208, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0100', 1214, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0100', 1217, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0100', 1242, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0100', 1274, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0100', 1286, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0100', 1287, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0100', 1290, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0100', 1312, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0100', 1325, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0100', 1404, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0100', 1413, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0100', 1416, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0100', 1421, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0100', 3042, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0100', 3045, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0100', 3185, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0100', 3205, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0100', 3215, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0100', 3218, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0100', 3287, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0100', 3306, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0100', 3321, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0100', 3352, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0100', 3356, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0100', 3376, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0100', 3413, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0100', 3415, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0100', 3419, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0100', 3424, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0100', 3454, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0100', 3493, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0100', 3531, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0200', 1251, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0200', 1276, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0200', 1279, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0200', 1292, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0200', 1315, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0200', 1330, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0200', 1393, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0200', 1408, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0200', 1411, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0200', 3003, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0200', 3054, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0200', 3059, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0200', 3060, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0200', 3083, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0200', 3099, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0200', 3100, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0200', 3109, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0200', 3143, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0200', 3174, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0200', 3177, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0200', 3213, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0200', 3214, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0200', 3262, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0200', 3268, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0200', 3292, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0200', 3304, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0200', 3314, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0200', 3381, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0200', 3405, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0200', 3454, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0200', 3491, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'L0200', 3531, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'M0200', 1237, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'M0200', 1238, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'M0200', 1245, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'M0200', 1255, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'M0200', 1259, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'M0200', 1264, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'M0200', 1273, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'M0200', 1277, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'M0200', 1301, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'M0200', 1395, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'M0200', 1417, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'M0200', 3040, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'M0200', 3042, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'M0200', 3085, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'M0200', 3149, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'M0200', 3191, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'M0200', 3358, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'M0200', 3380, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'M0200', 3536, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'M0200', 3544, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'M0200', 3547, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0110', 1219, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0110', 1223, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0110', 1227, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0110', 1236, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0110', 1247, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0110', 1265, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0110', 1289, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0110', 1306, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0110', 1312, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0110', 1386, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0110', 1401, 1)
GO
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0110', 3004, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0110', 3046, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0110', 3109, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0110', 3166, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0110', 3183, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0110', 3200, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0110', 3205, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0110', 3207, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0110', 3223, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0110', 3231, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0110', 3315, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0110', 3345, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0110', 3346, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0110', 3348, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0110', 3387, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0110', 3405, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0110', 3415, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0110', 3450, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0110', 3477, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0110', 3559, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0110', 3575, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0111', 1232, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0111', 1243, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0111', 1311, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0111', 1314, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0111', 1323, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0111', 1404, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0111', 1417, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0111', 1423, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0111', 3075, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0111', 3119, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0111', 3190, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0111', 3313, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0111', 3314, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0111', 3540, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0200', 1208, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0200', 1210, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0200', 1261, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0200', 1329, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0200', 1330, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0200', 1392, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0200', 1408, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0200', 1413, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0200', 3003, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0200', 3060, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0200', 3099, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0200', 3108, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0200', 3185, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0200', 3189, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0200', 3237, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0200', 3265, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0200', 3287, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0200', 3312, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0200', 3317, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0200', 3363, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0200', 3378, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0200', 3393, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0200', 3405, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0200', 3414, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0200', 3456, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0200', 3533, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'P0200', 3579, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0300', 1215, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0300', 1226, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0300', 1228, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0300', 1238, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0300', 1263, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0300', 1267, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0300', 1308, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0300', 1409, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0300', 3006, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0300', 3012, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0300', 3119, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0300', 3140, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0300', 3144, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0300', 3170, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0300', 3182, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0300', 3218, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0300', 3268, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0300', 3292, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0300', 3331, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0300', 3332, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0300', 3366, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0300', 3378, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0300', 3392, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0300', 3404, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0300', 3450, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0300', 3456, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0300', 3472, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0300', 3487, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0300', 3488, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0300', 3518, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0300', 3539, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0300', 3547, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0400', 1231, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0400', 1237, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0400', 1270, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0400', 1271, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0400', 1296, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0400', 1302, 2)
GO
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0400', 1305, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0400', 1401, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0400', 1403, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0400', 3040, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0400', 3075, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0400', 3118, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0400', 3182, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0400', 3194, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0400', 3197, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0400', 3241, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0400', 3247, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0400', 3268, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0400', 3281, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0400', 3287, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0400', 3358, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0400', 3366, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0400', 3414, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0400', 3440, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0400', 3479, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0400', 3493, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0400', 3547, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0400', 3576, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0500', 1223, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0500', 1249, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0500', 1252, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0500', 1259, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0500', 1289, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0500', 1302, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0500', 1324, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0500', 1327, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0500', 1328, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0500', 1329, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0500', 1394, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0500', 1426, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0500', 1429, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0500', 3003, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0500', 3035, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0500', 3044, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0500', 3108, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0500', 3131, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0500', 3149, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0500', 3166, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0500', 3170, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0500', 3174, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0500', 3190, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0500', 3237, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0500', 3257, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0500', 3300, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0500', 3302, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0500', 3366, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0500', 3387, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0500', 3393, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0500', 3409, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0500', 3493, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0500', 3539, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'S0500', 3576, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0250', 1210, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0250', 1211, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0250', 1213, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0250', 1220, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0250', 1221, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0250', 1227, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0250', 1248, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0250', 1264, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0250', 1277, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0250', 1300, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0250', 1309, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0250', 1331, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0250', 1416, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0250', 3121, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0250', 3145, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0250', 3155, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0250', 3257, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0250', 3262, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0250', 3300, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0250', 3380, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0250', 3387, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0250', 3450, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0250', 3478, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0250', 3501, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0250', 3551, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0250', 3562, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0250', 3568, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0333', 1213, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0333', 1219, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0333', 1230, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0333', 1249, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0333', 1251, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0333', 1262, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0333', 1269, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0333', 1300, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0333', 1301, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0333', 1302, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0333', 1314, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0333', 1316, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0333', 1431, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0333', 3004, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0333', 3036, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0333', 3053, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0333', 3075, 1)
GO
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0333', 3118, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0333', 3183, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0333', 3194, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0333', 3203, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0333', 3214, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0333', 3299, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0333', 3317, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0333', 3358, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0333', 3365, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0333', 3418, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0333', 3419, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0333', 3424, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0333', 3429, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0333', 3465, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0333', 3478, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0333', 3501, 2)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0333', 3539, 1)
INSERT [dbo].[Montage]
    ([EtID], [AufNr], [Anzahl])
VALUES
    (N'T0333', 3540, 2)
GO
SET IDENTITY_INSERT [dbo].[Niederlassung] ON

INSERT [dbo].[Niederlassung]
    ([NLNr], [Ort])
VALUES
    (1, N'Dresden2')
INSERT [dbo].[Niederlassung]
    ([NLNr], [Ort])
VALUES
    (2, N'Chemnitz')
INSERT [dbo].[Niederlassung]
    ([NLNr], [Ort])
VALUES
    (3, N'Radebeul')
INSERT [dbo].[Niederlassung]
    ([NLNr], [Ort])
VALUES
    (5, N'Dippoldiswalde')
SET IDENTITY_INSERT [dbo].[Niederlassung] OFF
GO
INSERT [dbo].[Rechnung]
    ([KunNr], [AufNr], [RechDat], [RechBetrag])
VALUES
    (1139, 3552, CAST(N'2022-11-24' AS Date), 1600.0000)
INSERT [dbo].[Rechnung]
    ([KunNr], [AufNr], [RechDat], [RechBetrag])
VALUES
    (1151, 1345, CAST(N'2020-10-15' AS Date), 180.0000)
INSERT [dbo].[Rechnung]
    ([KunNr], [AufNr], [RechDat], [RechBetrag])
VALUES
    (1154, 1264, CAST(N'2020-10-15' AS Date), 154.5000)
GO
ALTER TABLE [dbo].[Auftrag] ADD  CONSTRAINT [df_Auftragsdatum]  DEFAULT (CONVERT([date],getdate())) FOR [AufDat]
GO
ALTER TABLE [dbo].[Mitarbeiter] ADD  CONSTRAINT [df_MitJob]  DEFAULT ('Monteur') FOR [MitJob]
GO
ALTER TABLE [dbo].[Gebiet]  WITH CHECK ADD  CONSTRAINT [FK__Gebiet__NLNr__08B54D69] FOREIGN KEY([NLNr])
REFERENCES [dbo].[Niederlassung] ([NLNr])
GO
ALTER TABLE [dbo].[Gebiet] CHECK CONSTRAINT [FK__Gebiet__NLNr__08B54D69]
GO
ALTER TABLE [dbo].[Mitarbeiter]  WITH CHECK ADD  CONSTRAINT [FK__Mitarbeite__NLNr__09A971A2] FOREIGN KEY([NLNr])
REFERENCES [dbo].[Niederlassung] ([NLNr])
GO
ALTER TABLE [dbo].[Mitarbeiter] CHECK CONSTRAINT [FK__Mitarbeite__NLNr__09A971A2]
GO
ALTER TABLE [dbo].[Montage]  WITH CHECK ADD  CONSTRAINT [FK__Montage__EtID__32E0915F] FOREIGN KEY([EtID])
REFERENCES [dbo].[Ersatzteil] ([EtID])
GO
ALTER TABLE [dbo].[Montage] CHECK CONSTRAINT [FK__Montage__EtID__32E0915F]
GO
ALTER TABLE [dbo].[Montage]  WITH CHECK ADD  CONSTRAINT [FK_Montage_Auftrag] FOREIGN KEY([AufNr])
REFERENCES [dbo].[Auftrag] ([Aufnr])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Montage] CHECK CONSTRAINT [FK_Montage_Auftrag]
GO
ALTER TABLE [dbo].[Rechnung]  WITH CHECK ADD  CONSTRAINT [FK__Rechnung__KunNr__0C85DE4D] FOREIGN KEY([KunNr])
REFERENCES [dbo].[Kunde] ([KunNr])
GO
ALTER TABLE [dbo].[Rechnung] CHECK CONSTRAINT [FK__Rechnung__KunNr__0C85DE4D]
GO
ALTER TABLE [dbo].[Rechnung]  WITH CHECK ADD  CONSTRAINT [FK_Aufnr] FOREIGN KEY([AufNr])
REFERENCES [dbo].[Auftrag] ([Aufnr])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Rechnung] CHECK CONSTRAINT [FK_Aufnr]
GO
ALTER TABLE [dbo].[Mitarbeiter]  WITH CHECK ADD  CONSTRAINT [CK_MitId] CHECK  (([MitId] like '[0-9][0-9][0-9]'))
GO
ALTER TABLE [dbo].[Mitarbeiter] CHECK CONSTRAINT [CK_MitId]
GO

CREATE OR ALTER TRIGGER create_invoice
ON auftrag
FOR UPDATE
AS
    IF ( Update(anfahrt)
    AND Update(dauer) AND
    (SELECT COUNT(*)
    FROM inserted i
    WHERE i.Erldat IS NOT NULL AND i.Dauer is NOT NULL AND i.Anfahrt is NOT NULL)
> 0)
      BEGIN
    print 'LOL';
    --  ERSATZTEILE
    DECLARE @sum_parts FLOAT
    DECLARE @sum_arrival FLOAT
    DECLARE @sum_work_hours FLOAT
    DECLARE @Aufnr FLOAT
    DECLARE @KunNr FLOAT
    DECLARE @sum FLOAT

    SET @sum_parts=0
    SET @sum = 0
    SET @Aufnr = (SELECT DISTINCT i.aufnr
    FROM inserted i
        INNER JOIN auftrag a
        ON i.aufnr = a.aufnr)
    SET @KunNr = (SELECT DISTINCT i.kunnr
    FROM inserted i
        INNER JOIN auftrag a
        ON i.aufnr = a.aufnr)
    SET @sum_parts = (SELECT Isnull(Sum (etpreis * anzahl), 0) AS
                                   Summe_Ersatzteile
    FROM inserted i
        INNER JOIN auftrag a
        ON i.aufnr = a.aufnr
        INNER JOIN montage M
        ON M.aufnr = i.aufnr
        INNER JOIN ersatzteil E
        ON E.etid = M.etid)
    --  STUNDENKOSTEN
    SET @sum_arrival =(SELECT Sum(a.anfahrt * 2,50)
    FROM inserted i
        INNER JOIN auftrag a
        ON i.aufnr = a.aufnr
        INNER JOIN mitarbeiter M
        ON M.mitid = i.mitid)
    -- ANFAHRTSKOSTEN
    SET @sum_work_hours =(SELECT Sum(a.dauer * M.mitstundensatz)
    FROM inserted i
        INNER JOIN auftrag a
        ON i.aufnr = a.aufnr
        INNER JOIN mitarbeiter M
        ON M.mitid = i.mitid)
    SET @sum = @sum_arrival + @sum_work_hours + @sum_parts

    INSERT INTO rechnung
        (kunnr,
        aufnr,
        rechdat,
        rechbetrag)
    VALUES
        (@KunNr,
            @Aufnr,
            CURRENT_TIMESTAMP,
            @sum )
END; 
