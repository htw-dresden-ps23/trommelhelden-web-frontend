<template>
  <div class="rounded-xl bg-white px-6 py-8 shadow-lg hover:scale-[1.02] transition-all duration-300">
    <div class="card mb-0 w-full">
      <div
        v-if="!isLoading"
        class="justify-content-between mb-3 flex flex-col"
      >
        <div class="text-lg font-semibold">{{ props.name }}</div>
        <Chart
          :options="basicOptions"
          :type="chartType"
          :data="basicData"
        />



      </div>

      <Skeleton
        v-if="isLoading"
        width="10rem"
        class=" !w-[300px] !h-[178px]"
      ></Skeleton>

    </div>
  </div>
</template>

<script setup lang="ts">
import Chart from 'primevue/chart';
import BusinessDataService from "@/api/services/BusinessData";
import { onMounted, ref } from "vue";

const isLoading = ref(false);

const props = defineProps<{
  entity: string;
  orderBy: string;
  orderByDirection: "asc" | "desc";
  label: string;
  name: string;
  startDate: Date;
  endDate: Date;
  labelKey: string;
  chartType: string;
}>();

const buisnessDataService = new BusinessDataService(props.entity);
const data = ref();
const basicData = ref()


onMounted(async () => {
  isLoading.value = true;
  data.value = await buisnessDataService.getStats(props.startDate, props.endDate, props.orderBy, props.orderByDirection);

  basicData.value = {
    labels: data.value.map((x: any) => x[props.labelKey]),
    datasets: [
      {
        label: props.label,
        data: data.value.map((x: any) => x[props.orderBy]),
        backgroundColor: (ctx: any) => {

          return colors.map(x => {
            const canvas = ctx.chart.ctx;
            const gradient = canvas.createLinearGradient(0, 0, 0, 160);

            gradient.addColorStop(0, x.color1);
            gradient.addColorStop(1, x.color2);

            return gradient;
          })

        },
      }
    ]
  }

  console.log("finished");

  isLoading.value = false;

})

const colors = [{
  color1: "#ff5858",
  color2: "#ffc8c8"
},
{
  color1: "#0061ff",
  color2: "#60efff"
},


{
  color1: "#ff930f",
  color2: "#fff95b"
},
{
  color1: "#f9c823",
  color2: "#fc506e"
},
{
  color1: "#6ef195",
  color2: "#00e3fd"
},
{
  color1: "#51c26f",
  color2: "#f2e901"
},
{
  color1: "#fcef64",
  color2: "#f44c7d"
}
  , {
  color1: "#ef709b",
  color2: "#fa9372"
}
]

const basicOptions = ref(
  {
    plugins: {
      legend: {
        labels: {
          color: '#495057'
        }
      }
    },
    scales: {
      x: {
        ticks: {
          color: '#495057'
        },
        grid: {
          color: '#ebedef'
        }
      },
      y: {
        ticks: {
          color: '#495057'
        },
        grid: {
          color: '#ebedef'
        }
      }
    }
  }
);




</script>





