

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
    [Aufnr] [int] IDENTITY(5000,1) NOT NULL,
    [MitID] [int] NULL,
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
    [KunNr] [int] IDENTITY(1000,1) NOT NULL,
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
    [MitID] [int] IDENTITY(100,1) NOT NULL,
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

CREATE OR ALTER TRIGGER create_invoice
ON auftrag
FOR UPDATE, INSERT
AS
    IF ( (SELECT COUNT(*)
FROM inserted i
WHERE i.Erldat IS NOT NULL AND i.Dauer is NOT NULL AND i.Anfahrt is NOT NULL)
> 0
) 
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
    SET @sum_arrival =(SELECT Sum(a.anfahrt * 2.5)
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
