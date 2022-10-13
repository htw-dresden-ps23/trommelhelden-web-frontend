<template>
  <DataTable
    :value="values"
    responsiveLayout="scroll"
    v-if="values"
    isLoading=""
  >
    <Column
      v-for="col in Object.keys(values[0])"
      :key="col"
      :field="col"
      :header="col"
    ></Column>
  </DataTable>
</template>

<script setup lang="ts">
import { getCurrentInstance } from "vue";
import { onMounted, ref } from "vue";
import { listOrders } from "../services/db";

const isLoading = ref(false);
const values = ref();
const internalInstance = getCurrentInstance();

onMounted(async () => {
  internalInstance.appContext.config.globalProperties.$Progress.start();

  values.value = (await listOrders()).data;
  console.log(values.value);
  internalInstance.appContext.config.globalProperties.$Progress.finish();
});
</script>

<style></style>
