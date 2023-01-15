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
   
    <CardStats class="max-w-sm"
        statSubtitle="PERFORMANCE"
        statTitle="49,65%"
        statArrow="up"
        statPercent="12"
        statPercentColor="text-emerald-500"
        statDescripiron="Since last month"
        statIconName="pi pi-chart-line"
        statIconColor="bg-emerald-500"
    />
      
    <StatCategory
      start-date=""
      end-date=""
      :data="employeeStats"
      name="Mitarbeiter"
    ></StatCategory>
    <StatCategory
      start-date=""
      end-date=""
      :data="branchStats"
      name="Niederlassung"
    ></StatCategory>
    <StatCategory
      start-date=""
      end-date=""
      :data="customerStats"
      name="Kunden"
    ></StatCategory>
  </div>
</template>

<script setup lang="ts">
import CardStats from "@/components/Dashboard/CardStats.vue" 


import Calendar from "primevue/calendar";
import { onBeforeMount, onMounted, ref } from "vue";
// import BusinessData from "@/api/services/BusinessData";
import StatsCard from "@/components/Dashboard/StatsCard.vue";
import { useStore } from "@/store";
import StatCategory from "@/components/Dashboard/StatCategory.vue";

const store = useStore();

onBeforeMount(() => {

  store.loadingTime = performance.now()

})
onMounted(() => {
  store.loadingTime = performance.now() - store.loadingTime;
})


const dateRange = ref()



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
    orderBy: "max_RechBetrag",
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
    orderByDirection: "desc",
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
    entity: "branches",
    orderBy: "min_RechBetrag",
    orderByDirection: "desc",
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

</script>

<style>

</style>
