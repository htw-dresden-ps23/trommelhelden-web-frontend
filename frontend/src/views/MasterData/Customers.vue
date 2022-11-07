<template>
  <div
    class="card mx-[10%] flex flex-col items-stretch justify-center rounded-xl bg-white p-6 shadow-2xl"
  >
    <h1
      class="bg-gradient-to-r from-blue-500 to-pink-700 bg-clip-text py-4 text-6xl font-extrabold text-transparent"
    >
      Kunden
    </h1>
    <Divider />
    <EntityTable
      :apiService="customerService"
      :columns="columns"
      :showRows="50"
    ></EntityTable>
  </div>
</template>

<script setup lang="ts">
import EntityTable from "@/components/EntityTable.vue";

import CustomerService from "@/api/services/Customers";
import { IEntityTableColumns } from "@/types";

const customerService = new CustomerService();

const columns: IEntityTableColumns[] = [
  {
    header: "Name",
    field: "KunName",
    type: "text",
  },
  {
    header: "Kunden Nr.",
    field: "KunNr",
    type: "numeric",
  },
  {
    header: "Ort",
    field: "KunOrt",
    type: "text",
  },
  {
    header: "Postleitzahl",
    field: "KunPLZ",
    type: "text",
  },
  {
    header: "Straße",
    field: "KunStrasse",
    type: "text",
  },
];
</script>

<style scoped></style>
