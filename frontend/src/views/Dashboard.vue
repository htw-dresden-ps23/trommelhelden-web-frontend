<template>
  <div>
    <Calendar
      v-model="dateRange"
      input-id="icon"
      :show-icon="true"
      selection-mode="range"
      :manual-input="false"
    />
    <div class="grid grid-cols-4 gap-8">

      <!-- <StatsCard
        v-for="stat in ret"
        :key="stat?.name"
        :data="stat?.data"
        :title="stat?.name"
        :icon="'pi-chart-line'"
      ></StatsCard> -->
      <!-- <Chart
      v-for="chart in data"
      :key="chart.name"
      class="m-2 flex p-2"
    ></Chart> -->
    </div>
  </div>
</template>

<script setup lang="ts">
import Calendar from "primevue/calendar";
import { onMounted, ref } from "vue";
// import BusinessData from "@/api/services/BusinessData";
import StatsCard from "@/components/Dashboard/StatsCard.vue";
import { useStore } from "@/store";
import axios from "axios";

const store = useStore();

const dateRange = ref()

const singleStatsEntitys = [
  "customers",
  "orders",
  "invoices",
  "assembly",
  "orders",
];
const singleStats = ref([{} as any]);

// const businessDataService = new BusinessData("");
const ret = []

const stats = [
  {
    name: "Umsatz pro Gebiet",
    url: "/api/business-data/umsatz-pro-gebiet",

  },
  {
    name: "Umsatz pro Mitarbeiter",
    url: "/api/business-data/umsatz-pro-mitarbeiter",

  },
  {
    name: "Umsatz pro Kunde",
    url: "/api/business-data/umsatz-pro-gebiet",

  },
  {
    name: "Kilometer pro Mitarbeiter",
    url: "/api/business-data/umsatz-pro-gebiet",

  },
]

onMounted(async () => {


  for (let i = 0; i < stats.length; i++) {

    // let labels = (await axios.post(stats[i].url, {
    //   dateRange: dateRange.value
    // })).data.map(x => x.)


    // ret.push({
    //   name: stats[i].name,
    //   data: singleStat.data
    // })


  }
});







// const {
//   KunNr,
//   AufNr,
// }: {
//   KunNr: string;
//   AufNr: string;
// } = route.params as any;

// onMounted(async () => {
//     orders.value = await ordersService.getOrder(AufNr, KunNr);
// })

// const charts = [
//   {
//     name: "Bar Chart",
//     data: {
//       labels: ["January", "February", "March", "April", "May", "June", "July"],
//       datasets: [
//         {
//           label: "Data One",
//           data: orders.value,
//           backgroundColor: "rgba(255, 99, 132, 0.2)",
//           borderColor: "rgba(255, 99, 132, 1)",
//           borderWidth: 1,
//         },
//       ],
//     },
//   },
// ];
</script>

<style>

</style>
