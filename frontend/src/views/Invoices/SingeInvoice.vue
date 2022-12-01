<template>
  <Card>
    <template #content>
      <div>
        <h1
          class="bg-gradient-to-r from-blue-400 to-pink-800 bg-clip-text py-4 text-4xl font-extrabold text-transparent"
        >
          Rechnung {{ invoice?.AufNr }}|{{ invoice?.KunNr }}
        </h1>
        <Card class="!border-2 !border-solid !border-gray-300 !bg-slate-100">
          <template #title> <div class="text-xl">Auftrag</div></template>
          <template #content>
            <div class="grid grid-cols-2">
              <span>Auftragsnr:</span><span>{{ invoice?.Auftrag.Aufnr }}</span>
              <span>Auftragsdatum:</span
              ><span>{{
                useDateFormat(invoice?.Auftrag.AufDat, "DD.MM.YYYY", {
                  locales: "de-DE",
                }).value
              }}</span>
              <span>Beschreibung:</span
              ><span>{{ invoice?.Auftrag.Beschreibung }}</span>
              <span>Dauer:</span><span>{{ invoice?.Auftrag.Dauer }}</span>
              <span>Anfahrt:</span><span>{{ invoice?.Auftrag.Anfahrt }}</span>
            </div>
          </template>
        </Card>

        <Card
          class="mt-4 !border-2 !border-solid !border-gray-300 !bg-slate-100"
        >
          <template #title> <div class="text-xl">Mitarbeiter</div></template>
          <template #content>
            <div class="grid grid-cols-2">
              <span>MitID:</span
              ><span>{{ invoice?.Auftrag.Mitarbeiter?.MitID }}</span>
              <span>Name:</span
              ><span>{{ invoice?.Auftrag.Mitarbeiter?.MitName }}</span>
              <span>Stundensatz:</span
              ><span>{{ invoice?.Auftrag.Mitarbeiter?.MitStundensatz }}</span>
            </div>
          </template>
        </Card>
        <Card
          v-if="invoice?.Auftrag?.Montage?.length > 0"
          class="mt-4 !border-2 !border-solid !border-gray-300 !bg-slate-100"
        >
          <template #title> <div class="text-xl">Montage</div></template>
          <template #content>
            <div class="grid grid-cols-2">
              <span>MitID:</span
              ><span>{{ invoice?.Auftrag.Mitarbeiter?.MitID }}</span>
              <span>Name:</span
              ><span>{{ invoice?.Auftrag.Mitarbeiter?.MitName }}</span>
              <span>Stundensatz:</span
              ><span>{{ invoice?.Auftrag.Mitarbeiter?.MitStundensatz }}</span>
            </div>
          </template>
        </Card>
        <Card
          class="mt-4 !border-2 !border-solid !border-gray-300 !bg-slate-100"
        >
          <template #title> <div class="text-xl">Gesamt</div></template>
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
      </div>
    </template>
  </Card>
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
h1,
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
}
</style>
