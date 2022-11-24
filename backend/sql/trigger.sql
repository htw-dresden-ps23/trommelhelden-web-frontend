use trommelhelden
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
    SET @sum_arrival =(SELECT Sum(a.anfahrt * M.mitstundensatz)
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

UPDATE Auftrag SET Anfahrt = 10, Dauer = 10 WHERE Aufnr = 3007