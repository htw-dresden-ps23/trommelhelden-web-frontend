<template>
  <div class="my-8">
    <div class="h-full rounded-xl bg-white px-6 py-8 shadow-2xl">
      <h1
        class="bg-gradient-to-r from-blue-400 to-pink-800 bg-clip-text py-4 text-6xl font-extrabold text-transparent"
      >
        Aufträge
      </h1>
      <Divider />

      <DataTable :value="values" responsiveLayout="scroll">
        <Column
          v-for="col in columns"
          :key="col.field"
          :field="col.field"
          :header="col.header"
        >
          <template #body="{ data }">
            <div v-if="isLoading"><Skeleton></Skeleton></div>
            <div v-else>{{ data ? data[col.field] : "" }}</div>
          </template>
        </Column>
      </DataTable>
    </div>
  </div>
</template>

<script setup lang="ts">
import { onMounted, ref } from "vue";
import OrderService from "@/api/services/Order";
import { IAuftrag } from "@/types";
import { useLoading } from "vue-loading-overlay";
import { flatten } from "flat";
const orderService = new OrderService();
const $loading = useLoading();
const isLoading = ref(false);
const values = ref<IAuftrag[]>(new Array(50));

onMounted(async () => {
  isLoading.value = true;

  values.value = await orderService.list(null, null);
  values.value = values.value.map((value) => flatten(value));
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
  { field: "Kunde.KunName", header: "Kundenname" },
];
</script>

<style></style>
