<template>
  <div class="my-8 h-fit">
    <div class="h-full rounded-xl bg-white px-6 py-8 shadow-2xl">
      <div class="flex items-center justify-between">
        <h1
          class="bg-gradient-to-r from-blue-400 to-pink-800 bg-clip-text py-4 text-6xl font-extrabold text-transparent"
        >
          Aufträge
        </h1>
        <router-link to="/orders/create">
          <Button
            icon="pi pi-plus"
            class="mr-2 mb-2 rounded-lg !border-none !bg-gradient-to-r from-blue-400 to-pink-800 text-center text-2xl font-medium text-white shadow-lg hover:scale-105 hover:transform"
            label="Auftrag erstellen"
          />
        </router-link>
      </div>
      <Divider />
      <EntityTable
        :api-service="orderService"
        :columns="columns"
        :show-max-active-filter="5"
      />
    </div>
  </div>
</template>

<script setup lang="ts">
import OrderService from "@/api/services/Order";

import EntityTable from "@/components/Entity/EntityTable.vue";
import { IEntityTableColumns } from "@/types";

const orderService = new OrderService();

const columns: IEntityTableColumns[] = [
  {
    field: "Aufnr",
    header: "Aufnr",
    type: "numeric",
    create: false,
    update: false,
  },
  {
    field: "MitID",
    header: "MitID",
    type: "numeric",
    create: false,
    update: false,
    format: "link",
    linkKey: "MitID",
    linkRoute: "masterdata/employees",
    color: "#e4ff7a",
  },
  {
    field: "KunNr",
    header: "KunNr",
    type: "numeric",
    create: false,
    update: false,
    format: "link",
    linkKey: "KunNr",
    linkRoute: "masterdata/customers",
    color: "#de8aff",
  },
  { field: "AufDat", header: "AufDat", type: "date" },
  { field: "ErlDat", header: "ErlDat", type: "date" },
  { field: "Dauer", header: "Dauer", type: "numeric" },
  { field: "Anfahrt", header: "Anfahrt", type: "numeric" },
  { field: "Beschreibung", header: "Beschreibung", type: "text" },
  { field: "Kunde.KunName", header: "Kundenname" },
];
</script>

<style></style>
