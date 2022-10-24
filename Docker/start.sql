-- Anmeldung auf Database
EXEC sp_addlinkedserver @server = '141.56.2.45';
EXEC sp_addlinkedsrvlogin '141.56.2.45', 'false', NULL, 's82082', 's82082';

-- Schattenkopie erstellen
SELECT * INTO Niederlassung FROM [141.56.2.45].[iw20s82082].[dbo].[Niederlassung];
SELECT * INTO Gebiet FROM [141.56.2.45].[iw20s82082].[dbo].[Gebiet];
SELECT * INTO Mitarbeiter FROM [141.56.2.45].[iw20s82082].[dbo].[Mitarbeiter];
SELECT * INTO Ersatzteil FROM [141.56.2.45].[iw20s82082].[dbo].[Ersatzteil];
SELECT * INTO Kunde FROM [141.56.2.45].[iw20s82082].[dbo].[Kunde];
SELECT * INTO Auftrag FROM [141.56.2.45].[iw20s82082].[dbo].[Auftrag];
SELECT * INTO Montage FROM [141.56.2.45].[iw20s82082].[dbo].[Montage];
SELECT * INTO Rechnung FROM [141.56.2.45].[iw20s82082].[dbo].[Rechnung];