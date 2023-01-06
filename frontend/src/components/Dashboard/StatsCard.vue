<template>
  <div>
    <Card style="width: 25rem; margin-bottom: 2em">
      <template #content>
        <div class="card mb-0">
          <div class="justify-content-between mb-3 flex">
            <span class="text-500 mb-3 block font-medium">{{
              props.data
            }}</span>
            <div class="text-900 text-xl font-medium">{{ props.data }}</div>
            <div
              class="align-items-center justify-content-center border-round flex bg-blue-100"
              style="width: 2.5rem; height: 2.5rem"
            >

            </div>
            <Chart
              type="bar"
              :data="basicData"
            />
          </div>
        </div>
      </template>
    </Card>
  </div>
</template>

<script setup lang="ts">
import Card from "primevue/card";
import Chart from 'primevue/chart';

const props = defineProps<{
  labels: string[];
  data: number[];
  label: string;
  backgroundColor: string;
  chartType: string;
}>();

const basicData = {
  labels: props.labels,
  datasets: [
    {
      label: props.label,
      backgroundColor: props.backgroundColor,
      data: props.data
    }
  ]
}

</script>

<style scoped>

</style>
