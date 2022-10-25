import { FilterMatchModeOptions } from "primevue/api";

interface IAuftrag {
  Aufnr: number;
  MitID?: string;
  KunNr: number;
  AufDat: Date;
  ErlDat?: Date;
  Dauer?: number;
  Anfahrt?: number;
  Beschreibung?: string;
  Kunde: IKunde;
  Mitarbeiter?: IMitarbeiter;
  Montage: IMontage[];
  Rechnung: IRechnung[];
}

interface IErsatzteil {
  EtID: string;
  EtBezeichnung: string;
  EtPreis: number;
  EtAnzLager: number;
  EtHersteller: string;
  Montage: IMontage[];
}

interface IGebiet {
  GebietID: string;
  NLNr?: number;
  Niederlassung?: INiederlassung;
}

interface IGeografie {
  Land_ID: string;
  Bundesland?: string;
  Region?: string;
  Staat?: string;
  Plandaten: IPlandaten[];
  Umsatzdaten: IUmsatzdaten[];
}

interface IKunde {
  KunNr: number;
  KunName: string;
  KunOrt: string;
  KunPLZ: string;
  KunStrasse: string;
  Auftrag?: IAuftrag[];
  Rechnung?: IRechnung[];
}

interface IMitarbeiter {
  MitID: string;
  MitName: string;
  MitVorname?: string;
  MitGebDat: Date;
  MitJob: string;
  MitStundensatz?: number;
  NLNr?: number;
  Niederlassung?: INiederlassung;
  Auftrag: IAuftrag[];
}

interface IMitarbeiterShop {
  Mitarbeiter_ID: string;
  Name?: string;
  Manager_ID?: string;
  MitarbeiterShop?: IMitarbeiterShop;
  other_MitarbeiterShop: IMitarbeiterShop[];
  Umsatzdaten: IUmsatzdaten[];
}

interface IMontage {
  EtID: string;
  AufNr: number;
  Anzahl: number;
  Ersatzteil: IErsatzteil;
  Auftrag: IAuftrag;
}

interface INiederlassung {
  NLNr: number;
  Ort?: string;
  Gebiet: IGebiet[];
  Mitarbeiter: IMitarbeiter[];
}

interface IPlandaten {
  Mon_ID: string;
  Land_ID: string;
  Produkt_ID: string;
  Umsatzplan?: number;
  Geografie: IGeografie;
  Zeit: Zeit;
  Produkt: IProdukt;
}

interface IProdukt {
  Produkt_ID: string;
  Markenname?: string;
  Produktname?: string;
  Preis?: number;
  Subkategorie_ID?: string;
  Produktsubkategorie?: IProduktsubkategorie;
  Plandaten: IPlandaten[];
  Umsatzdaten: IUmsatzdaten[];
}

interface IProduktkategorie {
  Kategorie_ID: string;
  Kategorie?: string;
  Kategorie_Manager?: string;
  Produktsubkategorie: IProduktsubkategorie[];
}

interface IProduktsubkategorie {
  Subkategorie_ID: string;
  Subkategorie?: string;
  Subkategorie_Manager?: string;
  Kategorie_ID?: string;
  Mitarbeiter_ID?: string;
  Produktkategorie?: IProduktkategorie;
  Produkt: IProdukt[];
}

interface IRechnung {
  KunNr: number;
  AufNr: number;
  RechDat: Date;
  RechBetrag: number;
  Kunde: IKunde;
  Auftrag: IAuftrag;
}

interface IUmsatzdaten {
  Produkt_ID: string;
  Mon_ID: string;
  Land_ID: string;
  Mitarbeiter_ID: string;
  Umsatzbetrag?: number;
  Umsatzmenge?: number;
  Geografie: IGeografie;
  MitarbeiterShop: IMitarbeiterShop;
  Zeit: Zeit;
  Produkt: IProdukt;
}

interface Zeit {
  Mon_ID: string;
  Monatsname?: string;
  Q_ID?: string;
  Quartal?: string;
  Jahr?: string;
  Plandaten: IPlandaten[];
  Umsatzdaten: IUmsatzdaten[];
}

interface ISort {
  [Key: string]: "asc" | "desc";
}

interface IFilter {
  [Key: string]: IFilterValue;
}

interface IFilterValue {
  value: string | number | Date;
  matchMode: FilterMatchModeOptions;
}

export {
  IAuftrag,
  IErsatzteil,
  IGebiet,
  IGeografie,
  IKunde,
  IMitarbeiter,
  IMitarbeiterShop,
  IMontage,
  INiederlassung,
  IPlandaten,
  IProdukt,
  IProduktkategorie,
  IProduktsubkategorie,
  IRechnung,
  IUmsatzdaten,
  Zeit,
  ISort,
  IFilter,
  IFilterValue,
};
