<template>
  <div class="mb-8">
    <h1
      class="bg-gradient-to-r from-blue-400 to-pink-800 bg-clip-text py-4 text-6xl font-extrabold text-transparent"
    >
      Aufträge
    </h1>
    <div class="rounded-xl bg-white shadow-2xl">
      <DataTable :value="values" responsiveLayout="scroll" :loading="isLoading">
        <Column
          v-if="values"
          v-for="col in columns"
          :key="col.field"
          :field="col.field"
          :header="col.header"
        ></Column>
      </DataTable>
    </div>
  </div>
</template>

<script setup lang="ts">
import { onMounted, ref } from "vue";
import OrderService from "@/services/Order";
import { Auftrag } from "@/types";
import { useLoading } from "vue-loading-overlay";

const orderService = new OrderService();
const $loading = useLoading();
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
