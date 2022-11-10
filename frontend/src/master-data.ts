import { IMasterData } from "./types";

export const masterdata: IMasterData[] = [
  {
    name: "Kunden",
    id: "customers",
    columns: [
      {
        header: "Name",
        field: "KunName",
        type: "text",
        create: true,
        update: true,
      },
      {
        header: "Kunden Nr.",
        field: "KunNr",
        type: "numeric",
        create: false,
        update: false,
      },
      {
        header: "Ort",
        field: "KunOrt",
        type: "text",
        create: true,
        update: true,
      },
      {
        header: "Postleitzahl",
        field: "KunPLZ",
        type: "text",
        create: true,
        update: true,
      },
      {
        header: "Straße",
        field: "KunStrasse",
        type: "text",
        create: true,
        update: true,
      },
    ],
  },
  {
    name: "Mitarbeiter",
    id: "employees",
    columns: [
      {
        header: "ID",
        field: "MitID",
        type: "text",
        create: false,
        update: false,
      },
      {
        header: "Vorname",
        field: "MitVorname",
        type: "text",
        create: true,
        update: true,
      },
      {
        header: "Nachname",
        field: "MitName",
        type: "text",
        create: true,
        update: true,
      },
      {
        header: "Stelle",
        field: "MitJob",
        type: "text",
        create: true,
        update: true,
      },
      {
        header: "Niederlassung",
        field: "NLNr",
        type: "relation",
        format: "link",
        linkKey: "NLNr",
        linkRoute: "branches",
        create: true,
        update: true,
      },
      {
        header: "Stundensatz",
        field: "MitStundensatz",
        type: "numeric",
        create: true,
        update: true,
      },
    ],
  },
  {
    name: "Ersatzteile",
    id: "sprareparts",
    columns: [
      {
        header: "ID",
        field: "EtID",
        type: "numeric",
        create: false,
        update: false,
      },
      {
        header: "Bezeichnung",
        field: "EtBezeichnung",
        type: "text",
        create: true,
        update: true,
      },
      {
        header: "Preis",
        field: "EtPreis",
        type: "numeric",
        create: true,
        update: true,
      },
      {
        header: "Anzahl auf Lager",
        field: "EtAnzLager",
        type: "numeric",
        create: true,
        update: true,
      },
      {
        header: "Hersteller",
        field: "EtHersteller",
        type: "text",
        create: true,
        update: true,
      },
    ],
  },
  {
    name: "Niederlassung",
    id: "branches",
    columns: [
      {
        header: "Nr",
        field: "NLNr",
        type: "numeric",
      },
      {
        header: "Ort",
        field: "Ort",
        type: "text",
      },
    ],
  },
];
