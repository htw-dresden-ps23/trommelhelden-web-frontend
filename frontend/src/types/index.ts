interface Auftrag {
  Aufnr: number;
  MitID?: string;
  KunNr: number;
  AufDat: Date;
  ErlDat?: Date;
  Dauer?: number;
  Anfahrt?: number;
  Beschreibung?: string;
  Kunde: IKunde;
  Mitarbeiter?: Mitarbeiter;
  Montage: Montage[];
  Rechnung: Rechnung[];
}

interface Ersatzteil {
  EtID: string;
  EtBezeichnung: string;
  EtPreis: number;
  EtAnzLager: number;
  EtHersteller: string;
  Montage: Montage[];
}

interface Gebiet {
  GebietID: string;
  NLNr?: number;
  Niederlassung?: Niederlassung;
}

interface Geografie {
  Land_ID: string;
  Bundesland?: string;
  Region?: string;
  Staat?: string;
  Plandaten: Plandaten[];
  Umsatzdaten: Umsatzdaten[];
}

interface IKunde {
  KunNr: number;
  KunName: string;
  KunOrt: string;
  KunPLZ: string;
  KunStrasse: string;
  Auftrag?: Auftrag[];
  Rechnung?: Rechnung[];
}

interface Mitarbeiter {
  MitID: string;
  MitName: string;
  MitVorname?: string;
  MitGebDat: Date;
  MitJob: string;
  MitStundensatz?: number;
  NLNr?: number;
  Niederlassung?: Niederlassung;
  Auftrag: Auftrag[];
}

interface MitarbeiterShop {
  Mitarbeiter_ID: string;
  Name?: string;
  Manager_ID?: string;
  MitarbeiterShop?: MitarbeiterShop;
  other_MitarbeiterShop: MitarbeiterShop[];
  Umsatzdaten: Umsatzdaten[];
}

interface Montage {
  EtID: string;
  AufNr: number;
  Anzahl: number;
  Ersatzteil: Ersatzteil;
  Auftrag: Auftrag;
}

interface Niederlassung {
  NLNr: number;
  Ort?: string;
  Gebiet: Gebiet[];
  Mitarbeiter: Mitarbeiter[];
}

interface Plandaten {
  Mon_ID: string;
  Land_ID: string;
  Produkt_ID: string;
  Umsatzplan?: number;
  Geografie: Geografie;
  Zeit: Zeit;
  Produkt: Produkt;
}

interface Produkt {
  Produkt_ID: string;
  Markenname?: string;
  Produktname?: string;
  Preis?: number;
  Subkategorie_ID?: string;
  Produktsubkategorie?: Produktsubkategorie;
  Plandaten: Plandaten[];
  Umsatzdaten: Umsatzdaten[];
}

interface Produktkategorie {
  Kategorie_ID: string;
  Kategorie?: string;
  Kategorie_Manager?: string;
  Produktsubkategorie: Produktsubkategorie[];
}

interface Produktsubkategorie {
  Subkategorie_ID: string;
  Subkategorie?: string;
  Subkategorie_Manager?: string;
  Kategorie_ID?: string;
  Mitarbeiter_ID?: string;
  Produktkategorie?: Produktkategorie;
  Produkt: Produkt[];
}

interface Rechnung {
  KunNr: number;
  AufNr: number;
  RechDat: Date;
  RechBetrag: number;
  Kunde: IKunde;
  Auftrag: Auftrag;
}

interface Umsatzdaten {
  Produkt_ID: string;
  Mon_ID: string;
  Land_ID: string;
  Mitarbeiter_ID: string;
  Umsatzbetrag?: number;
  Umsatzmenge?: number;
  Geografie: Geografie;
  MitarbeiterShop: MitarbeiterShop;
  Zeit: Zeit;
  Produkt: Produkt;
}

interface Zeit {
  Mon_ID: string;
  Monatsname?: string;
  Q_ID?: string;
  Quartal?: string;
  Jahr?: string;
  Plandaten: Plandaten[];
  Umsatzdaten: Umsatzdaten[];
}

export {
  Auftrag,
  Ersatzteil,
  Gebiet,
  Geografie,
  IKunde,
  Mitarbeiter,
  MitarbeiterShop,
  Montage,
  Niederlassung,
  Plandaten,
  Produkt,
  Produktkategorie,
  Produktsubkategorie,
  Rechnung,
  Umsatzdaten,
  Zeit,
};
