<template>
  <div class="my-8 h-fit">
    <div class="h-full rounded-xl bg-white px-6 py-8 shadow-2xl">
      <div class="flex items-center justify-between">
        <h1
          class="bg-gradient-to-r from-blue-400 to-pink-800 bg-clip-text py-4 text-6xl font-extrabold text-transparent"
        >
          Rechungen
        </h1>
        <router-link to="/orders/addInvoice">
          <Button
            icon="pi pi-plus"
            class="mr-2 mb-2 rounded-lg !border-none !bg-gradient-to-r from-blue-400 to-pink-800 text-center text-2xl font-medium text-white shadow-lg hover:scale-105 hover:transform"
            label="Rechnung erstellen"
          />
        </router-link>
      </div>
      <Divider /> 
      
      <EntityTable
        :key="reRender"
        name="Rechnungen"
        primary-key="AufNr"
        :show-rows="25"
        :columns="columns"
        resource-name="invoices"
        :allow-edit="false"
        :allow-delete="false"
        :emit-edit-only="true"
        @on-row-select="onRowClick"
      />
    </div>
  </div>
</template>

<script setup lang="ts">
import EntityTable from "@/components/Entity/EntityTable.vue";
import { useDialog } from "primevue/usedialog";
import { ref } from "vue";
import { IMasterDataField, IRechnung } from "@/types";
import { router } from "@/router";

const reRender = ref(0);

const columns: IMasterDataField[] = [
  {
    label: "Datum",
    name: "RechDat",
    type: "date",
    allowCreate: false,
    allowUpdate: false,
  },
  {
    label: "Betrag",
    name: "RechBetrag",
    type: "money",
    allowCreate: false,
    allowUpdate: false,
  },
  {
    label: "KunNr",
    name: "KunNr",
    type: "relation",
    allowCreate: false,
    allowUpdate: false,
    relation: {
      label: "Kunde",
      name: "Kunde",
      resourceName: "masterdata/customers",
      primaryKey: "KunNr",
    },
  },
  {
    label: "Kundenname",
    name: "Kunde.KunName",
    type: "text",
    allowCreate: false,
    allowUpdate: false,
  },
  {
    label: "AufNr",
    name: "AufNr",
    type: "relation",
    allowCreate: false,
    allowUpdate: false,
    relation: {
      label: "Auftrag",
      name: "Auftrag",
      resourceName: "orders",
      primaryKey: "AufNr",
    },
  },
  {
    label: "Mitarbeiter",
    name: "Auftrag.Mitarbeiter.MitName",
    type: "relation",
    allowCreate: false,
    allowUpdate: false,
    relation: {
      label: "Mitarbeiter",
      name: "Auftrag",
      resourceName: "masterdata/employees",
      primaryKey: "Auftrag.Mitarbeiter.MitID",
    },
  },
];

const onRowClick = (order: IRechnung) => {
  router.push({
    name: "Invoice",
    params: { AufNr: order.AufNr, KunNr: order.KunNr },
  });
};
</script>

<style scoped></style>
