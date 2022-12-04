<template>
  <div>
    <BarChart
      v-if="props.chartType === 'bar'"
      :chart-data="data"
      style="padding-right: 10rem"
    />
    <DoughnutChart
      v-if="props.chartType === 'Dough'"
      :chart-data="data"
      style="padding-right: 10rem"
    />
    <LineChart
      v-if="props.chartType === 'line'"
      :chart-data="data"
    />
  </div>
</template>

<script setup lang="ts">
import { ref, computed, defineComponent } from "vue";
import { Chart, registerables } from "chart.js";
import { BarChart, useBarChart, DoughnutChart, LineChart } from "vue-chart-3";

Chart.register(...registerables);

const props = defineProps<{
  data: any;

  chartType: string;
}>();
</script>

<style scoped></style>
