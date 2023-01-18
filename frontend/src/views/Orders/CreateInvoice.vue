<template>
  <div class="card mx-[20%] flex flex-1 flex-col items-stretch justify-center rounded-xl bg-white p-6 shadow-2xl">
    <h1 class="bg-gradient-to-r from-blue-500 to-pink-700 bg-clip-text py-4 text-6xl font-extrabold text-transparent">
      Rechnung erstellen
    </h1>
    <Divider />

    <div class="my-4 justify-between flex flex-col items-start">
      <div
        v-if="order.AufNr"
        class="grid flex-1 grid-cols-2 mb-12 text-lg font-medium text-gray-900 dark:text-black"
      >

        <label class="w-32 mb-1 text-gray-800 block font-bold text-sm uppercase tracking-wide">Auftragnummer:</label>
        <span
          id="datepicker1"
          class="bg-gray-200  mb-1  appearance-none border-2 border-gray-200 rounded w-48 py-2 px-4 text-gray-700 leading-tight focus:outline-none focus:bg-white focus:border-blue-500 js-datepicker"
          type="text"
          x-model="invoiceDate"
          autocomplete="off"
          readonly
        >{{ order.AufNr }}</span>
        <label class="w-32 text-gray-800 block font-bold text-sm uppercase tracking-wide">Kundennummer:</label>
        <span
          id="datepicker1"
          class="bg-gray-200  mb-1  appearance-none border-2 border-gray-200 rounded w-48 py-2 px-4 text-gray-700 leading-tight focus:outline-none focus:bg-white focus:border-blue-500 js-datepicker"
          type="text"
          x-model="invoiceDate"
          autocomplete="off"
          readonly
        >{{ order.KunNr }}</span>
        <label class="w-32 text-gray-800 block font-bold text-sm uppercase tracking-wide">Mitarbeiternummer:</label>
        <span
          id="datepicker1"
          class="bg-gray-200  mb-1  appearance-none border-2 border-gray-200 rounded w-48 py-2 px-4 text-gray-700 leading-tight focus:outline-none focus:bg-white focus:border-blue-500 js-datepicker"
          type="text"
          x-model="invoiceDate"
          autocomplete="off"
          readonly
        >{{ order.AufDat }}</span>
        <label class="w-32 text-gray-800 block font-bold text-sm uppercase tracking-wide">Beschreibung:</label>
        <span
          id="datepicker1"
          class="bg-gray-200  mb-1  appearance-none border-2 border-gray-200 rounded w-48 py-2 px-4 text-gray-700 leading-tight focus:outline-none focus:bg-white focus:border-blue-500 js-datepicker"
          type="text"
          x-model="invoiceDate"
          autocomplete="off"
          readonly
        >{{ order.Beschreibung }}</span>
        <label class="w-32 text-gray-800 block font-bold text-sm uppercase tracking-wide">Erledigungsdatum:</label>
        <span
          id="datepicker1"
          class="bg-gray-200  mb-1  appearance-none border-2 border-gray-200 rounded w-48 py-2 px-4 text-gray-700 leading-tight focus:outline-none focus:bg-white focus:border-blue-500 js-datepicker"
          type="text"
          x-model="invoiceDate"
          autocomplete="off"
          readonly
        >{{ useDateFormat(order.ErlDat, "DD.MM.YYYY", {
          locales: "de-DE",
        }).value }}</span>
        <label class="w-32 text-gray-800 block font-bold text-sm uppercase tracking-wide">Auftragsdatum:</label>
        <span
          id="datepicker1"
          class="bg-gray-200  mb-1  appearance-none border-2 border-gray-200 rounded w-48 py-2 px-4 text-gray-700 leading-tight focus:outline-none focus:bg-white focus:border-blue-500 js-datepicker"
          type="text"
          x-model="invoiceDate"
          autocomplete="off"
          readonly
        >{{ useDateFormat(order.AufDat, "DD.MM.YYYY", {
          locales: "de-DE",
        }).value }}</span>


      </div>
      <Button
        type="button"
        icon="pi pi-search"
        :label="'Auftrag wählen'"
        aria-haspopup="true"
        aria-controls="overlay_panel"
        @click="toggle"
      />

      <div>
        <OverlayPanel
          id="overlay_panel2"
          ref="op"
          append-to="body"
          :show-close-icon="true"
          style="margin-top: -28rem;"
          :dismissable="false"
          :breakpoints="{ '960px': '75vw' }"
        >
          <EntityTable
            name="Aufträge"
            primary-key="Aufnr"
            :show-rows="5"
            :columns="columns"
            resource-name="orders"
            :allow-delete="false"
            :opt-params="{ status: 'completed' }"
            :emit-edit-only="true"
            @on-row-select="onSelectOrder"
          />
        </OverlayPanel>
      </div>
    </div>
    <Divider />


    <Divider />
    <div>
      <!-- <span class="p-float-label my-4">
        <Calendar
          id="order-calendar"
          v-model="order.AufDat"
          :show-icon="true"
        />
        <label for="order-calendar">Auftragsdatum</label>
      </span> -->
    </div>
    <Divider />
    <div class="flex justify-between">
      <Button
        type="submit"
        icon="pi pi-check"
        label="Erstellen"
        class="ml-auto"
        :disabled="!order"
        @click="createInovice"
      />
      <Button
        style="background-color: #d92979"
        label="Zurück"
        icon="pi pi-backward"
        @click="$router.go(-1)"
      />
    </div>
  </div>
</template>



<script setup lang="ts">
import EntityTable from "@/components/Entity/EntityTable.vue";
import { useDateFormat } from "@vueuse/core";

import { IMasterDataField, IRechnung } from "@/types";
import { ref } from "vue";
import { useToast } from "primevue/usetoast";
import { useRouter } from "vue-router";
import InvoiceService from "@/api/services/Invoices";
import Button from "primevue/button";
import Divider from "primevue/divider";
import OverlayPanel from "primevue/overlaypanel";

const router = useRouter();
const toast = useToast();

const invoiceService = new InvoiceService();
const op = ref();
const order = ref<IRechnung>();


const toggle = async (event: Event) => {
  op.value.toggle(event);
};

const onSelectOrder = (newOrder: IRechnung) => {
  order.value = newOrder;
  op.value.hide()
};

const createInovice = async () => {
  try {
    if (order.value) {
      await invoiceService.create(order.value);
      toast.add({
        severity: "success",
        summary: "Invoice Created ",
        detail: "",
        life: 5000,
      });
      router.push("/invoices");
    }
  } catch (e) {
    toast.add({
      severity: "error",
      summary: "Error while creating Invoice ",
      detail: e,
      life: 5000,
    });
    // order.value = {} as IAuftrag;

  }
};



const columns: IMasterDataField[] = [
  {
    name: "Aufnr",
    label: "Auftragsnummer",
    type: "text",
    allowCreate: false,
    allowUpdate: false,
  },
  {
    name: "KunNr",
    label: "Kundennummer",
    type: "text",
    allowCreate: false,
    allowUpdate: false,
  },
  {
    name: "Kunde.KunName",
    label: "Kunde",
    type: "text",
    allowCreate: false,
    allowUpdate: false,
  },
  {
    name: "AufDat",
    label: "Auftragsdatum",
    type: "date",
    allowCreate: false,
    allowUpdate: false,
  },
  {
    name: "ErlDat",
    label: "Erledigungsdatum",
    type: "date",
    allowCreate: false,
    allowUpdate: false,
  },
  {
    name: "Mitarbeiter.MitID",
    label: "Mitarbeiter ID",
    type: "text",
    allowCreate: false,
    allowUpdate: false,
  },
  {
    name: "Mitarbeiter.MitName",
    label: "Mitarbeiter ID",
    type: "text",
    allowCreate: false,
    allowUpdate: false,
  },
];
</script>

<style>

</style>
