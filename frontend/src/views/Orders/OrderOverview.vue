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
        name="Aufträge"
        primary-key="Aufnr"
        :show-rows="50"
        :columns="columns"
        resource-name="orders"
        :allow-edit="false"
        :allow-delete="false"
      />
    </div>
  </div>
</template>

<script setup lang="ts">
import EntityTable from "@/components/Entity/EntityTable.vue";

const columns = [
  {
    name: "Aufnr",
    label: "Aufnr",
    type: "numeric",
    create: false,
    update: false,
  },
  {
    name: "MitID",
    label: "MitID",
    type: "text",
    create: false,
    update: false,
    format: "link",
    linkKey: "MitID",
    linkRoute: "masterdata/employees",
    color: "#e4ff7a",
  },
  {
    name: "KunNr",
    label: "KunNr",
    type: "numeric",
    create: false,
    update: false,
    format: "link",
    linkKey: "KunNr",
    linkRoute: "masterdata/customers",
    color: "#de8aff",
  },
  { name: "AufDat", label: "AufDat", type: "date" },
  { name: "ErlDat", label: "ErlDat", type: "date" },
  { name: "Dauer", label: "Dauer", type: "numeric" },
  { name: "Anfahrt", label: "Anfahrt", type: "numeric" },
  { name: "Beschreibung", label: "Beschreibung", type: "text" },
  { name: "Kunde.KunName", label: "Kundenname", type: "text" },
];
</script>

<style></style>
