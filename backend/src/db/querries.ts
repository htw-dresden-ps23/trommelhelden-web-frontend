export const salesEmployeeQuery = (
  startDate: string,
  endDate: string,
  orderBy: string,
  orderByDirection: string
) => {
  return `SELECT 
  TOP (5)
        A.MitID,
        M.MitName,
        avg(A.Anfahrt) as avg_Anfahrt,
        max(A.Anfahrt) as max_Anfahrt,
        min(A.Anfahrt) as min_Anfahrt,
        sum(A.Anfahrt) as sum_Anfahrt,
        avg(A.Dauer) as avg_Dauer,
        max(A.Dauer) as max_Dauer,
        min(A.Dauer) as min_Dauer,
        sum(A.Dauer) as sum_Dauer,
        avg(R.RechBetrag) as avg_RechBetrag,
        max(R.RechBetrag) as max_RechBetrag,
        min(R.RechBetrag) as min_RechBetrag,
        sum(R.RechBetrag) as sum_RechBetrag
    FROM Auftrag A
        INNER JOIN Mitarbeiter M
        ON A.MitID = M.MitID
        LEFT JOIN Rechnung R
        ON R.AufNr = A.Aufnr
        LEFT JOIN KUNDE K
        ON K.KunNr = A.KunNr
        LEFT JOIN Niederlassung N
        ON N.NLNr = M.NLNr
    ${
      startDate && endDate ? `WHERE A.ErlDat BETWEEN '${startDate}' AND '${endDate}'` : ""
    }
    GROUP BY
    A.MitID,
    M.MitName
    ${orderBy ? `ORDER BY  ${orderBy} ${orderByDirection}` : ""}
    `;
};

export const salesBranchesQuery = (
  startDate: string,
  endDate: string,
  orderBy: string,
  orderByDirection: string
) => {
  return `SELECT 
  TOP (5)
        N.NLNR,
        N.Ort,
        avg(A.Anfahrt) as avg_Anfahrt,
        max(A.Anfahrt) as max_Anfahrt,
        min(A.Anfahrt) as min_Anfahrt,
        sum(A.Anfahrt) as sum_Anfahrt,
        avg(A.Dauer) as avg_Dauer,
        max(A.Dauer) as max_Dauer,
        min(A.Dauer) as min_Dauer,
        sum(A.Dauer) as sum_Dauer,
        avg(R.RechBetrag) as avg_RechBetrag,
        max(R.RechBetrag) as max_RechBetrag,
        min(R.RechBetrag) as min_RechBetrag,
        sum(R.RechBetrag) as sum_RechBetrag
    FROM Auftrag A
        INNER JOIN Mitarbeiter M
        ON A.MitID = M.MitID
        LEFT JOIN Rechnung R
        ON R.AufNr = A.Aufnr
        LEFT JOIN KUNDE K
        ON K.KunNr = A.KunNr
        LEFT JOIN Niederlassung N
        ON N.NLNr = M.NLNr
    ${
      startDate && endDate ? `WHERE A.ErlDat BETWEEN '${startDate}' AND '${endDate}'` : ""
    }
    GROUP BY
    N.NLNR,
    N.Ort
    ${orderBy ? `ORDER BY  ${orderBy} ${orderByDirection}` : ""}
    `;
};

export const salesCustomersQuery = (
  startDate: string,
  endDate: string,
  orderBy: string,
  orderByDirection: string
) => {
  return `SELECT 
  TOP (5)
        K.KunOrt,
        avg(A.Anfahrt) as avg_Anfahrt,
        max(A.Anfahrt) as max_Anfahrt,
        min(A.Anfahrt) as min_Anfahrt,
        sum(A.Anfahrt) as sum_Anfahrt,
        avg(A.Dauer) as avg_Dauer,
        max(A.Dauer) as max_Dauer,
        min(A.Dauer) as min_Dauer,
        sum(A.Dauer) as sum_Dauer,
        avg(R.RechBetrag) as avg_RechBetrag,
        max(R.RechBetrag) as max_RechBetrag,
        min(R.RechBetrag) as min_RechBetrag,
        sum(R.RechBetrag) as sum_RechBetrag
    FROM Auftrag A
        LEFT JOIN Mitarbeiter M
        ON A.MitID = M.MitID
        LEFT JOIN Rechnung R
        ON R.AufNr = A.Aufnr
        INNER JOIN KUNDE K
        ON K.KunNr = A.KunNr
        LEFT JOIN Niederlassung N
        ON N.NLNr = M.NLNr
    ${
      startDate && endDate ? `WHERE A.ErlDat BETWEEN '${startDate}' AND '${endDate}'` : ""
    }
    GROUP BY
    K.KunOrt
    ${orderBy ? `ORDER BY  ${orderBy} ${orderByDirection}` : ""}
    `;
};
