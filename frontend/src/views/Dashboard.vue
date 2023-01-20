<template>
  <div>

    <div class="w-full flex  items-end my-8">
      <h1 class=" bg-gradient-to-r from-blue-500 to-pink-700 bg-clip-text text-6xl font-extrabold text-transparent ">
        Trommelhelden Dashboard
      </h1>
      <Calendar
        v-model="dateRange"
        placeholder="All Time"
        input-id="icon"
        :show-icon="true"
        selection-mode="range"
        :manual-input="false"
        class="ml-auto h-1/2"
      />
    </div>
    <div class="w-full flex  items-end my-8">
      <CardStats
        class="max-w-sm mr-10"
        stat-subtitle="Anzahl der Kunden "
        :stat-title="String(singleStats.customers)"
        stat-arrow="up"
        stat-percent="12"
        stat-percent-color="text-emerald-500"
        stat-descripiron="Since last month"
        stat-icon-name="pi pi-users"
        stat-icon-color="bg-orange-600"
      />
      <CardStats
        class="max-w-sm mr-10"
        stat-subtitle="Anzahl der Aufträge "
        :stat-title="String(singleStats.orders)"
        stat-arrow="up"
        stat-percent="12"
        stat-percent-color="text-emerald-500"
        stat-descripiron="Since last month"
        stat-icon-name="pi pi-chart-line"
        stat-icon-color="bg-cyan-500"
      />
      <CardStats
        class="max-w-sm mr-10"
        stat-subtitle="Gesamte Umsatz"
        :stat-title="singleStats.revenue + '€'"
        stat-arrow="up"
        stat-percent="12"
        stat-percent-color="text-emerald-500"
        stat-descripiron="Since last month"
        stat-icon-name="pi pi-money-bill"
        stat-icon-color="bg-emerald-500"
      />
    </div>
    <StatCategory
      :key="String(dateRange[0]) + String(dateRange[1])"
      :start-date="dateRange[0]"
      :end-date="dateRange[1]"
      :data="employeeStats"
      name="Mitarbeiter"
    ></StatCategory>
    <StatCategory
      :key="String(dateRange[0]) + String(dateRange[1])"
      :start-date="dateRange[0]"
      :end-date="dateRange[1]"
      :data="branchStats"
      name="Niederlassung"
    ></StatCategory>
    <StatCategory
      :key="String(dateRange[0]) + String(dateRange[1])"
      :start-date="dateRange[0]"
      :end-date="dateRange[1]"
      :data="customerStats"
      name="Kunden"
    ></StatCategory>
  </div>
</template>

<script setup lang="ts">
import CardStats from "@/components/Dashboard/CardStats.vue"


import Calendar from "primevue/calendar";
import { onBeforeMount, onMounted, onUnmounted, ref } from "vue";
// import BusinessData from "@/api/services/BusinessData";
import StatsCard from "@/components/Dashboard/StatsCard.vue";
import { useStore } from "@/store";
import StatCategory from "@/components/Dashboard/StatCategory.vue";
import GenericService from "@/api/services/Generic";
import { ISort } from "@/types";

const store = useStore();



const singleStats = ref({
  customers: 0,
  orders: 0,
  revenue: 0,
});


onBeforeMount(async () => {
  console.log("onBeforeMount");

  store.loadingTime = performance.now()


  const customerService = new GenericService("customers");
  singleStats.value.customers = (await customerService.listAndCount([], {})).count;

  const orderService = new GenericService("orders");
  let foo = (await orderService.listAndCount([], {},));

  singleStats.value.orders = foo.count;
  singleStats.value.revenue = foo.sum
  console.log("onBeforeMount2");


})

onUnmounted(() => {
  console.log("onUnmounted");
  store.firstLoadingTimeStamp = 0;
  store.lastLoadingTimeStamp = 0;


})



const dateRange = ref([new Date(new Date().setFullYear(2015)), new Date()])



const employeeStats = [

  {
    label: "Umsatz in €",
    name: " mit höchstem Umsatz",
    entity: "employees",
    orderBy: "max_RechBetrag",
    orderByDirection: "desc",
    labelKey: "MitName",
    chartType: "bar"

  },
  {
    label: "Umsatz in €",
    name: "mit niedrigstem Umsatz",
    entity: "employees",
    orderBy: "min_RechBetrag",
    orderByDirection: "asc",
    labelKey: "MitName",
    chartType: "bar"

  },
  {
    label: "Anfahrt in km",
    name: "Wer hat die längste Anfahrt?",
    entity: "employees",
    orderBy: "sum_Anfahrt",
    orderByDirection: "desc",
    labelKey: "MitName",
    chartType: "bar"

  },
  {
    label: "Arbeitszeit in h",
    name: "Wer hat am längsten gearbeitet?",
    entity: "employees",
    orderBy: "sum_Dauer",
    orderByDirection: "desc",
    labelKey: "MitName",
    chartType: "bar"

  },
]

const branchStats = [

  {
    label: "Umsatz in €",
    name: " mit höchstem Umsatz",
    entity: "branches",
    orderBy: "max_RechBetrag",
    orderByDirection: "desc",
    labelKey: "Ort",
    chartType: "bar"

  },
  {
    label: "Umsatz in €",
    name: " mit niedrigstem Umsatz",
    entity: "branches",
    orderBy: "min_RechBetrag",
    orderByDirection: "asc",
    labelKey: "Ort",
    chartType: "bar"

  },
  {
    label: "Anfahrt in km",
    name: "Anfahrt",
    entity: "branches",
    orderBy: "sum_Anfahrt",
    orderByDirection: "desc",
    labelKey: "Ort",
    chartType: "bar"

  },
  {
    label: "Arbeitszeit in h",
    name: "Arbeitszeit",
    entity: "branches",
    orderBy: "sum_Dauer",
    orderByDirection: "desc",
    labelKey: "Ort",
    chartType: "bar"

  },

]

const customerStats = [

  {
    label: "Umsatz in €",
    name: "Stadt mit höchstem Umsatz",
    entity: "customers",
    orderBy: "sum_RechBetrag",
    orderByDirection: "desc",
    labelKey: "KunOrt",
    chartType: "bar"

  },
  {
    label: "Umsatz in €",
    name: " mit niedrigstem Umsatz",
    entity: "customers",
    orderBy: "sum_RechBetrag",
    orderByDirection: "asc",
    labelKey: "KunOrt",
    chartType: "bar"
  },
  {
    label: "Umsatz in €",
    name: " mit niedrigstem Umsatz",
    entity: "customers",
    orderBy: "sum_RechBetrag",
    orderByDirection: "asc",
    labelKey: "KunName",
    chartType: "bar"
  },


]

</script>

<style>

</style>
