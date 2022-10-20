<template>
  <DataTable :value="values" responsiveLayout="scroll" :loading="isLoading">
    <Column
      v-if="values"
      v-for="col in columns"
      :key="col.field"
      :field="col.field"
      :header="col.header"
    ></Column>
  </DataTable>
</template>

<script setup lang="ts">
import { onMounted, ref } from "vue";
import OrderService from "@/services/Order";
import { Auftrag } from "@/types";

const orderService = new OrderService();

const isLoading = ref(false);
const values = ref<Auftrag[]>();

onMounted(async () => {
  isLoading.value = true;
  values.value = await orderService.list();
  isLoading.value = false;
});

const columns = [
  { field: "Aufnr", header: "Aufnr" },
  { field: "MitID", header: "MitID" },
  { field: "KunNr", header: "KunNr" },
  { field: "AufDat", header: "AufDat" },
  { field: "ErlDat", header: "ErlDat" },
  { field: "Dauer", header: "Dauer" },
  { field: "Anfahrt", header: "Anfahrt" },
  { field: "Beschreibung", header: "Beschreibung" },
  { field: "Kunde.KunNr", header: "Kundenname" },
];
</script>

<style></style>
