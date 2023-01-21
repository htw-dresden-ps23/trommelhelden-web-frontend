import { PropType } from "vue";

import { PropType } from "vue";

<template>
  <div
    class="relative flex flex-col min-w-0 break-words bg-white rounded-xl  mb-6 xl:mb-0 shadow-lg hover:scale-[1.02] transition-all duration-300"
  >
    <div class="flex-auto p-4">
      <div class="flex flex-wrap">
        <div class="relative w-full pr-4 max-w-full flex-grow flex-1">
          <h5 class="text-blueGray-400 uppercase font-bold text-xs">
            {{ statSubtitle }}
          </h5>
          <span class="font-semibold text-xl text-blueGray-700">
            {{ statTitle }}
          </span>
        </div>
        <div class="relative w-auto pl-4 flex-initial">
          <div
            class="text-white p-3 text-center inline-flex items-center justify-center w-12 h-12 shadow-lg rounded-full"
            :class="[statIconColor]"
          >
            <i :class="[statIconName]"></i>
          </div>
        </div>
      </div>
      <p class="text-sm text-blueGray-400 mt-4">
        <span
          class="mr-2"
          :class="[statPercentColor]"
        >
          <i :class="[
            statArrow === 'up' ? `fas fa-arrow-up` : `fas fa-arrow-down`,
          ]"></i>
          {{ statPercent }}%
        </span>
        <span class="whitespace-nowrap">{{ statDescripiron }}</span>
      </p>
    </div>
  </div>
</template>

<script lang="ts" setup>
import { PropType } from 'vue';


const props = defineProps({
  statSubtitle: {
    type: String,
    default: "Traffic",
  },
  statTitle: {
    type: String,
    default: "350,897",
  },
  statArrow: {
   type: String,
   default: "up",
  },
  statPercent: {
    type: String,
    default: "3.48",
  },
  // can be any of the text color utilities
  // from tailwindcss
  statPercentColor: {
    type: String,
    default: "text-emerald-500",
  },
  statDescripiron: {
    type: String,
    default: "Since last month",
  },
  statIconName: {
    type: String,
    default: "far fa-chart-bar",
  },
  // can be any of the background color utilities
  // from tailwindcss
  statIconColor: {
    type: String,
    default: "bg-red-500",
  }
})




</script>
