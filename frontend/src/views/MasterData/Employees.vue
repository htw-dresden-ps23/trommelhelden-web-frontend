<template>
  <div
    class="card mx-[10%] flex flex-col items-stretch justify-center rounded-xl bg-white p-6 shadow-2xl"
  >
    <h1
      class="bg-gradient-to-r from-blue-500 to-pink-700 bg-clip-text py-4 text-6xl font-extrabold text-transparent"
    >
      Mitarbeiter
    </h1>
    <Divider />
    <EntityTable
      :apiService="employeeService"
      :columns="columns"
      :showRows="50"
    ></EntityTable>
  </div>
</template>

<script setup lang="ts">
import EntityTable from "@/components/EntityTable.vue";

import EmployeesService from "@/api/services/Employees";
import { IEntityTableColumns } from "@/types";

const employeeService = new EmployeesService();

const columns: IEntityTableColumns[] = [
  {
    header: "ID",
    field: "MitID",
    type: "text",
  },
  {
    header: "Vorname",
    field: "MitVorname",
    type: "text",
  },
  {
    header: "Nachname",
    field: "MitName",
    type: "text",
  },
  {
    header: "Stelle",
    field: "MitJob",
    type: "text",
  },
  {
    header: "Niederlassung",
    field: "NLNr",
    type: "text",
  },
  {
    header: "Stundensatz",
    field: "MitStundensatz",
    type: "numeric",
  },
];
</script>

<style scoped></style>
