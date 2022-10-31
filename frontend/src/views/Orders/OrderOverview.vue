<template>
  <div class="my-8">
    <div class="h-full rounded-xl bg-white px-6 py-8 shadow-2xl">
      <h1
        class="bg-gradient-to-r from-blue-400 to-pink-800 bg-clip-text py-4 text-6xl font-extrabold text-transparent"
      >
        Aufträge
      </h1>
      <Divider />
      <EntityTable :apiService="orderService" :columns="columns"></EntityTable>
    </div>
  </div>
</template>

<script setup lang="ts">
import OrderService from "@/api/services/Order";

import EntityTable from "@/components/EntityTable.vue";
import { IEntityTableColumns } from "@/types";

const orderService = new OrderService();

const columns: IEntityTableColumns[] = [
  {
    field: "Aufnr",
    header: "Aufnr",
    type: "text",
    format: "link",
    linkKey: "Aufnr",
    linkRoute: "order",
  },
  {
    field: "MitID",
    header: "MitID",
    format: "link",
    linkKey: "MitID",
    linkRoute: "employees",
    color: "#e4ff7a",
  },
  {
    field: "KunNr",
    header: "KunNr",
    format: "link",
    linkKey: "KunNr",
    linkRoute: "customers",
    color: "#de8aff",
  },
  { field: "AufDat", header: "AufDat", type: "date" },
  { field: "ErlDat", header: "ErlDat", type: "date" },
  { field: "Dauer", header: "Dauer", type: "numeric" },
  { field: "Anfahrt", header: "Anfahrt", type: "numeric" },
  { field: "Beschreibung", header: "Beschreibung" },
  { field: "Kunde.KunName", header: "Kundenname" },
];
</script>

<style></style>
