<template>
  <div>
    <Chart 
    v-for="chart in charts"
      :key="chart.name"
      class="m-2 p-2 flex "
    ></Chart>
  </div>
</template>

<script lang="ts">

import Chart from "@/components/Chart.vue";
import OrderService from "@/api/services/Order";
import { IAuftrag } from "@/types";
import { onMounted, ref } from "vue";
import { useRoute } from "vue-router";

const ordersService = new OrderService();
const orders = ref<IAuftrag>();
const route = useRoute();

const {
  KunNr,
  AufNr,
}: {
  KunNr: string;
  AufNr: string;
} = route.params as any;

onMounted(async () => {
    orders.value = await ordersService.getOrder(AufNr, KunNr);
})

const charts = [
  {
    name: "Bar Chart",
    data: {
      labels: ["January", "February", "March", "April", "May", "June", "July"],
      datasets: [
        {
          label: "Data One",
          data: orders.value,
          backgroundColor: "rgba(255, 99, 132, 0.2)",
          borderColor: "rgba(255, 99, 132, 1)",
          borderWidth: 1,
        },
      ],
    },
  },
];
</script>


<style>


</style>
