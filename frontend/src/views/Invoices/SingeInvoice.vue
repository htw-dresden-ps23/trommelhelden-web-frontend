<template>
   <div class="box-border text-2xl w-full main-app">
            <div class="main-header">
              <h1
                class="bg-gradient-to-r from-blue-400 to-pink-800 bg-clip-text py-4 text-4xl font-extrabold text-transparent">
                Rechnung {{ invoice?.AufNr }}|{{ invoice?.KunNr }}
              </h1>
              <div   class="addr">AN: {{invoice?.Auftrag.Mitarbeiter?.MitName }}
                {{ invoice?.Auftrag.Mitarbeiter?.MitVorname }} <br> {{invoice?.Auftrag.Kunde?.KunStrasse}}, {{invoice?.Auftrag.Kunde?.KunPLZ}}, {{invoice?.Auftrag.Kunde?.KunOrt}} </div>
            </div>
            <div class=" big-top-margin">
              <div class="main-content">
                <div class="customer"><span class="order_column_header">Kunde:</span>{{invoice?.Auftrag.Kunde?.KunName}} <br>  #{{invoice?.Auftrag.Kunde?.KunNr}}</div>
                <div class="inv"><span class="order_column_header">Auftrag Nr:</span><span>#{{invoice?.Auftrag.Aufnr }}</span>
                </div>
                <div class="due"><span class="order_column_header">Auftragsdatum:</span><span>{{
                    useDateFormat(invoice?.Auftrag.AufDat, "DD.MM.YYYY", {
                      locales: "de-DE",
                    }).value
                }}</span>
                </div>
                <div class="amount"><span class="order_column_header">Gesamtbetrag
                    (EUR)</span><span class="big-font bold-font gradient-bg-1">{{
                        invoice?.Auftrag.Rechnung[0].RechBetrag
                    }}€</span>
                </div>
              </div>
            </div>
            <div>
              <div class="main-content-tab">
                <table aria-colcount="4" class="inv-table">
                  <thead class="dark-bg-1">
                    <tr>
                      <th>Montage</th>
                      <th>Price</th>
                      <th>Menge</th>
                      <th>Netto Betrag</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr class="">
                      <td>Montage{{invoice?.Auftrag.Montage?.EtID}}</td>
                      <td>0 €</td>
                      <td>Menge{{invoice?.Auftrag.Montage?.Anzahl}} St.</td>
                      <td>0 €</td>
                    </tr>
                  </tbody>
                </table>
                <div>
                 <span class="definition"> Beschreibung: {{invoice?.Auftrag.Beschreibung}}</span>
                </div>
                <div class="summary">
                  <div><span>Netto </span><span>
                      {{ ((invoice?.Auftrag.Rechnung[0].RechBetrag * 1) / 1.19).toFixed(2) }}€</span></div>
                  <div><span>MwSt. </span><span>
                      {{ (invoice?.Auftrag.Rechnung[0].RechBetrag * 0.19).toFixed(2) }}€</span></div>
                  <div class=" sum"><span>Gesamt (EUR)</span><span> {{ invoice?.Auftrag.Rechnung[0].RechBetrag
                  }}€</span></div>
                </div>
              </div>
            </div>
          </div>
        <div>
        </div>
  <!-- <Card>
    <template #content> 
        <h1
          class="bg-gradient-to-r from-blue-400 to-pink-800 bg-clip-text py-4 text-4xl font-extrabold text-transparent">
          Rechnung {{ invoice?.AufNr }}|{{ invoice?.KunNr }}
        </h1>
        <Card class="!border-2 !border-solid !border-gray-300 !bg-slate-100">
          <template #title>
            <div class="text-xl">Auftrag</div>
          </template>
          <template #content>
            <div class="grid grid-cols-2">
              <span>Auftragsnr:</span><span>{{ invoice?.Auftrag.Aufnr }}</span>
              <span>Auftragsdatum:</span><span>{{
                  useDateFormat(invoice?.Auftrag.AufDat, "DD.MM.YYYY", {
                    locales: "de-DE",
                  }).value
              }}</span>
              <span>Beschreibung:</span><span>{{ invoice?.Auftrag.Beschreibung }}</span>
              <span>Dauer:</span><span>{{ invoice?.Auftrag.Dauer }}</span>
              <span>Anfahrt:</span><span>{{ invoice?.Auftrag.Anfahrt }}</span>
            </div>
          </template>
        </Card>

        <Card class="mt-4 !border-2 !border-solid !border-gray-300 !bg-slate-100">
          <template #title>
            <div class="text-xl">Mitarbeiter</div>
          </template>
          <template #content>
            <div class="grid grid-cols-2">
              <span>MitID:</span><span>{{ invoice?.Auftrag.Mitarbeiter?.MitID }}</span>
              <span>Name:</span><span>{{ invoice?.Auftrag.Mitarbeiter?.MitName }}</span>
              <span>Stundensatz:</span><span>{{ invoice?.Auftrag.Mitarbeiter?.MitStundensatz }}</span>
            </div>
          </template>
        </Card>
        <Card v-if="invoice?.Auftrag?.Montage?.length > 0"
          class="mt-4 !border-2 !border-solid !border-gray-300 !bg-slate-100">
          <template #title>
            <div class="text-xl">Montage</div>
          </template>
          <template #content>
            <div class="grid grid-cols-2">
              <span>MitID:</span><span>{{ invoice?.Auftrag.Mitarbeiter?.MitID }}</span>
              <span>Name:</span><span>{{ invoice?.Auftrag.Mitarbeiter?.MitName }}</span>
              <span>Stundensatz:</span><span>{{ invoice?.Auftrag.Mitarbeiter?.MitStundensatz }}</span>
            </div>
          </template>
        </Card>
        <Card class="mt-4 !border-2 !border-solid !border-gray-300 !bg-slate-100">
          <template #title>
            <div class="text-xl">Gesamt</div>
          </template>
          <template #content>
            <div class="grid grid-cols-2">
              <span>Netto:</span>
              <span>{{
                  (invoice?.Auftrag.Rechnung[0].RechBetrag * 1) / 1.19
              }}</span>
              <span>Mehrwertsteuer: </span>
              <span>{{ invoice?.Auftrag.Rechnung[0].RechBetrag * 0.19 }}</span>
              <span>Bruttobetrag: </span>
              <span>{{ invoice?.Auftrag.Rechnung[0].RechBetrag }}</span>
            </div>
          </template>
        </Card>
    </template>
  </Card> -->
</template>

<script setup lang="ts">
import { useDateFormat } from "@vueuse/core";

import InvoiceService from "@/api/services/Invoices";
import { IRechnung } from "@/types";
import Card from "primevue/card";
import { onMounted, ref } from "vue";
import { useRoute } from "vue-router";

const route = useRoute();

const {
  KunNr,
  AufNr,
}: {
  KunNr: string;
  AufNr: string;
} = route.params as any;

const invoiceService = new InvoiceService();
const invoice = ref<IRechnung>();

onMounted(async () => {
  invoice.value = await invoiceService.getInvoice(AufNr, KunNr);
  console.log(invoice.value);
});
</script>

<style scoped>
/* h1,
h2 {
  font-weight: normal;
}

ul {
  list-style-type: none;
  padding: 0;
}

li {
  display: inline-block;
  margin: 0 10px;
}

a {
  color: #426cb9;
}

.single-page {
  background-color: #ffffffe5;
}

.invoice {
  margin-top: 20px;
} */

.main-app {
  margin: 2rem auto;
  border: 1px solid #eee;
  border-radius: 10px;
  padding: 4rem 5rem;
  max-width: 800px;
  min-width: 900px;
  box-shadow: 0 1.5rem 4rem #a4a4a4;
}

.main-header {
  box-sizing: border-box;
  display: -webkit-box;
  -webkit-box-pack: justify;
}

.addr {
  font-size: 1.2rem;
  color: #a4a4a4;
  text-align: right;
  width: 40%;
}

.big-top-margin {
  font-size: 1.2rem;
  box-sizing: border-box;
  margin-top: 5rem;
  margin-bottom: 2rem;
}

.main-content {
  font-size: 1.2rem;
  box-sizing: border-box;
  display: flex;
  justify-content: space-between;
}


.order_column_header {
  color: #a4a4a4;
  display: block;
  text-align: left;
}

.bold-font {
  box-sizing: border-box;
  font-weight: 700 !important;
  text-transform: uppercase;
  background-image: linear-gradient(90deg, #4279b8, #1a2327);
  -webkit-background-clip: text;
  color: transparent;
  display: block;
  text-align: left;
}

.inv {
  text-align: center;
  color: #2c3e50;
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

.due {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  text-align: center;
  color: #2c3e50;
  ;
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

.amount {
  text-align: center;
  color: #2c3e50;
  font-size: 1.1rem;
  margin: 0;
  padding: 0;
  box-sizing: border-box;

}

.inv-table {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  text-align: center;
  color: #2c3e50;
  font-size: 1.3rem;
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  padding-right: 5rem;
  margin-top: 2rem;
  width: 100%;
  margin-bottom: 1rem;
  border-collapse: collapse;
}

.dark-bg-1 {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  text-align: center;
  border-collapse: collapse;
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  margin-top: 2rem;
  background-color: #4279b8 !important;
  color: #eee;
}

.summary {
  flex-direction: column;
  align-items: flex-end;
  display: flex;
  text-align: right;
  margin-top: 4rem;
}

.sum {
  box-sizing: border-box;
  font-weight: 700 !important;
  background-color: #4279b8 !important;
  color: #eee;
  display: flex;
  text-align: right;
  width: 20rem;
  justify-content: space-between;
  margin-top: 2rem;
}

.definition{
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-size: 1.2rem;
  color: #868686;
  text-align: left;
  margin-bottom: 100px;
}
</style>
