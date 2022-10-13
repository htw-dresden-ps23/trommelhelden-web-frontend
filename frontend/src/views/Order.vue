<template>
  <DataTable :value="values" responsiveLayout="scroll" :loading="isLoading">
    <Column
      v-if="values"
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
  isLoading.value = true;
  values.value = listOrders().then((x) => {
    values.value = x.data;
    isLoading.value = false;
  });
});
</script>

<style></style>
