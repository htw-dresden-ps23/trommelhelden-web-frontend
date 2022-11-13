<template>
  <div
    class="card flex h-fit flex-1 flex-col items-stretch justify-center rounded-xl bg-white p-6 shadow-2xl"
  >
    <div class="flex items-center justify-between">
      <h1
        class="bg-gradient-to-r from-blue-500 to-pink-700 bg-clip-text py-4 text-6xl font-extrabold text-transparent"
      >
        {{ props.label }}
      </h1>
      <RouterLink :to="{ name: 'Create' + props.name }">
        <Button
          icon="pi pi-plus"
          class="mr-2 mb-2 rounded-lg !border-none !bg-gradient-to-r from-blue-400 to-pink-800 text-center text-2xl font-medium text-white shadow-lg hover:scale-105 hover:transform"
          :label="`${props.label} erstellen`"
          @click="openDialog = true"
      /></RouterLink>
    </div>
    <Divider />
    <EntityTable
      :name="props.name"
      :primary-key="props.primaryKey"
      :show-rows="50"
      :columns="props?.fields"
      :resource-name="props.resourceName"
      :allow-edit="true"
      :allow-delete="true"
      @edit-row="onEditRow"
    />
    <ConfirmDialog></ConfirmDialog>
  </div>
</template>

<script setup lang="ts">
import EntityTable from "@/components/Entity/EntityTable.vue";

import Divider from "primevue/divider";

import { ref } from "vue";

const props = defineProps([
  "resourceName",
  "fields",
  "label",
  "name",
  "primaryKey",
]);

const row = ref();
const isUpdate = ref(false);
const openDialog = ref(false);

const onEditRow = (data: any) => {
  isUpdate.value = true;
  row.value = data;
  openDialog.value = true;
};
</script>

<style scoped></style>
