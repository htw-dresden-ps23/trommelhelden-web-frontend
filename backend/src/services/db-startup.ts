import { faker } from "@faker-js/faker/locale/de";
import {
  Auftrag,
  Ersatzteil,
  Kunde,
  Mitarbeiter,
  Montage,
  Niederlassung,
  Prisma,
  PrismaClient,
  prisma,
} from "@prisma/client";


function createRandomErsatzteil(): Prisma.ErsatzteilCreateManyInput {
    const EtID = faker.helpers.unique(faker.random.alphaNumeric, [
        5,
        {
          casing: "upper",
        },
    ]);

    const ersatzteilNamen = [
        "Anschlussschlauch",
        "Antriebsriemen",
        "Einsatz für Einspülschale",
        "Einspülschale",
        "Einspülschalenunterteil",
        "Federkolbendämpfer mit Befestigungssatz",
        "Flusensieb",
        "Flusensiebeinsatz",
        "Heizelement",
        "Kohlebürsten",
        "Kugellager",
        "Lagersatz",
        "Laugenpumpe",
        "Magnetventil",
        "Pumpensumpf Ablaufschlauch",
        "Saugschlauch",
        "Stoßdämpfer",
        "Temperaturfühler",
        "Türverriegelung elektrisch",
        "Verriegelungsrelais"
    ];

    const zufälligerIndexErsatzteil = Math.floor(Math.random() * ersatzteilNamen.length);
    const EtBezeichnung = ersatzteilNamen[zufälligerIndexErsatzteil];
    // const EtBezeichnung = faker.helpers.unique(faker.commerce.productName);
    const EtPreis = faker.datatype.number({ min: 2, max: 70, precision: 0.01 });
    const EtAnzLager = faker.datatype.number({ min: 0, max: 400 });

    const herstellerNamen = [
        "Hauknecht",
        "Liemens",
        "Mosch",
        "Tiele"
    ];
    
    const zufälligerIndexHersteller = Math.floor(Math.random() * herstellerNamen.length);
    const EtHersteller = herstellerNamen[zufälligerIndexHersteller];

    // const EtHersteller = faker.company.name().slice(0, 30);

    return {
      EtID,
      EtBezeichnung,
      EtPreis,
      EtAnzLager,
      EtHersteller,
    };
}

function createRandomNiederlassung(i: number): Prisma.NiederlassungCreateManyInput {
  const Ort = faker.address.cityName();
  return {
    Ort,
  };
}

function createRandomKunde(i: number): Prisma.KundeCreateManyInput {
  const KunNr = i;
  const KunName = faker.name.fullName().slice(0, 20);
  const KunOrt = faker.address.cityName().slice(0, 20);
  const KunPLZ = faker.address.zipCode();
  const KunStrasse = faker.address.streetAddress().slice(0, 20);

  return {
    KunName,
    KunOrt,
    KunPLZ,
    KunStrasse,
  };
}

function createRandomMitarbeiter(
  i: number,
  ret: Niederlassung[]
): Prisma.MitarbeiterCreateInput {
//   const MitID = i;
  const MitName = faker.name.lastName();
  const MitVorname = faker.name.firstName();
  const MitGebDat = faker.date.between("1950-01-01", "2000-12-31");

  const jobNamen = [
    "Auftragskoordinator",
    "Einkauf",
    "Lagermitarbeiter",
    "Meister",
    "Monteur"
  ];

  const zufälligerIndexJob = Math.floor(Math.random() * jobNamen.length);
  const MitJob = jobNamen[zufälligerIndexJob];

  // const MitJob = faker.name.jobType();
  const MitStundensatz = faker.datatype.number({ min: 75, max: 125 });
  const NLNr = faker.helpers.arrayElement(ret).NLNr;

  return {
    // MitID,
    MitName,
    MitVorname,
    MitGebDat,
    MitJob,
    MitStundensatz,
    Niederlassung: {
      connect: {
        NLNr,
      },
    },
  };
}

function createRandomAuftrag(
  mitarbeiter: Mitarbeiter[],
  kunden: Kunde[],
  Ersatzteil: Ersatzteil[]
): Prisma.AuftragCreateInput {
  const MitID = faker.helpers.arrayElement(mitarbeiter).MitID;
  const KunNr = faker.helpers.arrayElement(kunden).KunNr;
  
  const beschreibungAuftrag = [
    "Dichtung porös",
    "Feinjustierung Axialmotor",
    "häufige Überladung",
    "Hauptlager ausgeschlagen",
    "Heizstäbe verkalkt",
    "instabiler Aufstellort",
    "Kabelbruch",
    "Laugenpumpe leckt",
    "Leckage am Wasserkreislauf",
    "Reinigung Vorfilter",
    "Sondermodell",
    "Steckerleister korrodiert",
    "Trommel klappert",
    "Vollverkalkung",
    "Wackelkontakt Drehschalter",
    "Wackelkontakt Steckerleiste"
  ];

  var Beschreibung = "";

  if (Math.random() <= 0.03) {
    const zufälligerIndexBeschreibung = Math.floor(Math.random() * beschreibungAuftrag.length);
    Beschreibung = beschreibungAuftrag[zufälligerIndexBeschreibung];
  } 

  // const Beschreibung = faker.company.bs();
  
  const ErlDat = faker.date.between(
    new Date().setFullYear(2015),
    new Date().setFullYear(2023)
  );
  const AufDat = faker.date.between(new Date().setFullYear(2015), ErlDat);
  const Dauer = new Prisma.Decimal(faker.datatype.number({ min: 1, max: 20 }));
  const Anfahrt = faker.datatype.number({ min: 1, max: 100 });

  return {
    Beschreibung,
    ErlDat,
    AufDat,
    Dauer,
    Anfahrt,
    Kunde: {
      connect: {
        KunNr,
      },
    },
    Mitarbeiter: {
      connect: {
        MitID,
      },
    },
    Montage: {
      create: {
        Anzahl: faker.datatype.number({ min: 1, max: 3 }),
        Ersatzteil: {
          connect: {
            EtID: faker.helpers.arrayElement(Ersatzteil).EtID,
          },
        },
      },
    },
  };
}

export const createData = async (
  customers: number,
  employees: number,
  orders: number,
  branches: number,
  spareparts: number
) => {
  const prisma = new PrismaClient();

  const niederlassungen: Prisma.NiederlassungCreateManyInput[] = [];
  for (let i = 0; i < branches; i++) {
    niederlassungen.push(createRandomNiederlassung(i));
  }
  await prisma.niederlassung.createMany({
    data: niederlassungen as Prisma.NiederlassungCreateManyInput[],
  });

  let baa = await prisma.niederlassung.findMany();

  for (let i = 100; i < employees + 100; i++) {
    let o = createRandomMitarbeiter(i, baa);

    await prisma.mitarbeiter.create({ data: o });
  }

  const ersatzteile: Prisma.ErsatzteilCreateManyInput[] = [];
  for (let i = 0; i < spareparts; i++) {
    ersatzteile.push(createRandomErsatzteil());
  }

  await prisma.ersatzteil.createMany({ data: ersatzteile });

  const kunden: Prisma.KundeCreateInput[] = [];

  for (let i = 0; i < customers; i++) {
    kunden.push(createRandomKunde(i));
  }

  await prisma.kunde.createMany({ data: kunden });

  const mitar = await prisma.mitarbeiter.findMany();
  const kund = await prisma.kunde.findMany();
  const ersa = await prisma.ersatzteil.findMany();
  console.log(createRandomAuftrag(mitar, kund, ersa));
  for (let i = 0; i < orders; i++) {
    await prisma.auftrag.create({ data: createRandomAuftrag(mitar, kund, ersa) });
  }
  await prisma.$disconnect();
};
