<template>
 <BarChart v-bind="barChartProps" style="padding-right:10rem"/>
 <DoughnutChart :chartData="chartData"  style="padding-right:10rem"/>
 <LineChart :chartData="chartData"/>

<!-- 
 <div class="grid grid-cols-1 gap-6 lg:grid-cols-3 mb-6">
        <CardBoxWidget
          trend="12%"
          trend-type="up"
          color="text-emerald-500"
          :icon="mdiAccountMultiple"
          :number="512"
          label="Clients"
        />
        <CardBoxWidget
          trend="12%"
          trend-type="down"
          color="text-blue-500"
          :icon="mdiCartOutline"
          :number="7770"
          prefix="$"
          label="Sales"
        />
        <CardBoxWidget
          trend="Overflow"
          trend-type="alert"
          color="text-red-500"
          :icon="mdiChartTimelineVariant"
          :number="256"
          suffix="%"
          label="Performance"
        />
      </div>

  -->

 </template>
  
<script lang="ts">

// import {
//   mdiAccountMultiple,
//   mdiCartOutline,
//   mdiChartTimelineVariant,
//   mdiMonitorCellphone,
//   mdiReload,
//   mdiGithub,
//   mdiChartPie,
// } from "@mdi/js";




import { ref, computed, defineComponent } from 'vue';
import { Chart, registerables } from 'chart.js';
import { BarChart, useBarChart, DoughnutChart, LineChart } from 'vue-chart-3';


Chart.register(...registerables);

export default defineComponent({
    name: 'DashboardTH',
    components: { DoughnutChart, BarChart, LineChart },
    setup() {
        const data = ref([30, 40, 60, 70, 5]);

        const chartData = computed(() => ({
            labels: ['Mitarbeiter', 'Nîmes', 'Toulon', 'Perpignan', 'Autre'],
            datasets: [
                {
                    data: data.value,
                    backgroundColor: ['#77CEFF', '#0079AF', '#123E6B', '#97B0C4', '#A5C8ED'],
                },
            ],
        }));


        const bubbleChartData = computed(() => ({
            labels: ['Paris', 'Nîmes', 'Toulon', 'Perpignan', 'Autre'],
            
        }));

        const { barChartProps, barChartRef } = useBarChart({
            chartData,
        });


        return { barChartProps, barChartRef, chartData,bubbleChartData };
    },
});
</script>