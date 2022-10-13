<script setup lang="ts">
import Editor from "primevue/editor";

// This starter template is using Vue 3 <script setup> SFCs
// Check out https://v3.vuejs.org/api/sfc-script-setup.html#sfc-script-setup
import { onMounted, ref } from "vue";
import HelloWorld from "./components/HelloWorld.vue";
import { getEmployees } from "./services/db";

// const data = await getEmployees();
const values = ref();
onMounted(async () => {
  const { data } = await getEmployees();
  values.value = data;
});
</script>

<template>
  <div class="text-center selection:bg-green-100">
    <DataTable :value="values" responsiveLayout="scroll" v-if="values">
      <Column
        v-for="col in Object.keys(values[0])"
        :key="col"
        :field="col"
        :header="col"
      ></Column>
    </DataTable>
  </div>
</template>

<style></style>
