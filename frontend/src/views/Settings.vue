<template>
  <div>
    <Card>
      <template #content>
        <h1
          class="bg-gradient-to-l from-blue-500 to-pink-700 bg-clip-text py-4 text-6xl font-extrabold text-transparent"
        >
          Settings
        </h1>
        <div class="flex flex-col">
          <div>Which method shall be used to create invoices?</div>
          <SelectButton
            v-model="mode"
            class="flex-1"
            option-label="name"
            :options="options"
            option-value="value"
            aria-labelledby="single"
            @change="onInvoiceMethodChange"
          />
        </div>
        <div class="flex flex-col">
          <div>Which method shall be used to fetch Business Data?</div>
          <SelectButton
            v-model="store.settings.calcType"
            class="flex-1"
            option-label="name"
            :options="options2"
            option-value="value"
            aria-labelledby="single"
          />
        </div>
        <div class="field-checkbox">
          <Checkbox
            v-model="store.showDebugBar"
            :binary="true"
          />
          <label for="binary">Show debug Bar</label>
        </div>
        <!-- <button
          class="group relative mb-2 mr-2 inline-flex items-center justify-center overflow-hidden rounded-lg bg-gradient-to-br from-purple-500 to-pink-500 p-0.5 text-sm font-medium text-gray-900 shadow-lg shadow-purple-400 hover:text-white focus:outline-none focus:ring-4 focus:ring-purple-200 group-hover:from-purple-500 group-hover:to-pink-500"
        >
          <span
            class="relative rounded-md bg-white px-5 py-2.5 transition-all duration-75 ease-in group-hover:bg-opacity-0"
          >
            Purple to pink
          </span>
        </button> -->
      </template>
    </Card>
  </div>
</template>

<script setup lang="ts">
import Checkbox from "primevue/checkbox";
import { useStore } from "@/store";
import Card from "primevue/card";
import SelectButton, { SelectButtonChangeEvent } from "primevue/selectbutton";
import { ref } from "vue";

const store = useStore();

const mode = ref(store.settings.useTrigger ? 1 : 2);
const calcMode = ref(store.settings.calcType);

console.log(mode.value);

const options = [
  {
    name: "use Backend",
    value: 2,
  },
  {
    name: "use Database trigger",
    value: 1,
  },
];

const options2 = [
  {
    name: "use Backend (node)",
    value: "backend",
  },
  {
    name: "use SQL",
    value: "database",
  },

];

const onInvoiceMethodChange = async (event: SelectButtonChangeEvent) => {
  await store.updateSettings("useTrigger", event.value === 1);
};

const onCalcMethodChange = async (event: SelectButtonChangeEvent) => {
  await store.updateSettings("calcType", calcMode.value);
};
</script>

<style scoped>

</style>
