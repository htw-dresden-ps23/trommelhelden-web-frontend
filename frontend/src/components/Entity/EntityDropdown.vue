<template>
  <div>
    <Dropdown
      v-model="selectedItem2"
      :options="values"
      :filter="true"
      option-value="value"
      :virtual-scroller-options="{
        lazy: true,
        onLazyLoad: onLazyLoad,
        itemSize: pageSize,
        showLoader: true,
        loading: loading,
        delay: 250,
      }"
      placeholder="Select Item"
    >
      <template #loader="{ options }">
        <div
          class="align-items-center flex p-2"
          style="height: 38px"
        >
          <Skeleton
            :width="options.even ? '60%' : '50%'"
            height="1rem"
          />
        </div>
      </template>
    </Dropdown>
  </div>
</template>

<script setup lang="ts">
import GenericService from "@/api/services/Generic";
import { onMounted, ref } from "vue";

const pageSize = ref(50);
const loading = ref(false);
const values = ref();
const props = defineProps({
  tableName: {
    type: String,
    required: true,
  },
  selectedValue: {
    type: Object,
    required: false,
    default: null,
  },
});

const genericService = new GenericService(props.tableName);

onMounted(async () => {
  values.value = await genericService.list(null, null, 0, pageSize.value);
});

const onLazyLoad = async (event) => {
  console.log(event);

  loading.value = true;
  values.value = await genericService.list();
  loading.value = false;
};
</script>

<style scoped></style>
