<template>
    <div class="my-8 h-fit">
    <div class="h-full rounded-xl bg-white px-6 py-8 shadow-2xl">
      <div class="flex items-center justify-between">
        <h1
          class="bg-gradient-to-r from-blue-400 to-pink-800 bg-clip-text py-4 text-6xl font-extrabold text-transparent"
        >
          Rechungen
        </h1>
       
      </div>
      <Divider />
    <EntityTable
        :key="reRender"
        name="Rechnungen"
        primary-key="KunNr|AufNr"
        :show-rows="5"
        :columns="columns"
        resource-name="invoices"
        :allow-edit="false"
        :allow-delete="false"
        :opt-params="{ status: 'planned' }"
        :emit-edit-only="true"
        @edit-row="onButtonClick"
      />
    </div>
  </div>
</template>

<script setup lang="ts">
import EntityTable from "@/components/Entity/EntityTable.vue";
import { useDialog } from "primevue/usedialog";
import { inject, onMounted, ref } from "vue";
import { IRechnung } from "@/types";
import CompleteOrderForm from "@/components/Order/CompleteOrderForm.vue";


const reRender = ref(0);
const dialog = useDialog();


const columns = [
  {
    label: "Datum",
    name: "RechDat",
    type: "date",
  },
  {
    label: "Betrag",
    name: "RechBetrag",
    type: "numeric",
  },
  {
    label: "KunNr",
    name: "KunNr",
    type: "numeric",
  },
  {
    label: "Kunde.KunName",
    name: "Kunde",
    type: "relation",
  },
  {
    label: "AufNr",
    name: "AufNr",
    type: "numeric",
  },
  {
    label: "Auftrag",
    name: "Auftrag",
    type: "relation",
  },
];


const onButtonClick = (order: IRechnung) => {
  console.log(order);
};


</script>

<style scoped></style>
