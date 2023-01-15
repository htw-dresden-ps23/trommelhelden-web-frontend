<template>
  <div>
    <Dropdown
      v-model="selectedValue"
      :loading="isLoading"
      :options="values"
      :filter="true"
      :option-value="props.valueKey"
      :option-label="props.labelKey"
      :virtual-scroller-options="{
        lazy: true,
        onLazyLoad: onLazyLoad,
        itemSize: pageSize,
        showLoader: true,
        loading: loading,
        delay: 250,
      }"
      placeholder="Select Item"
      @change="
        (event: any) => {
          $emit('update:modelValue', event.value);
          selectedValue = event.value;
        }
      "
    >
      <template #loader="{}">
        <div
          class="align-items-center flex p-2"
          style="height: 38px"
        >
          <Skeleton height="1rem" />
        </div>
      </template>
    </Dropdown>
  </div>
</template>

<script setup lang="ts">
import GenericService from "@/api/services/Generic";
import { IFilter } from "@/types";
import { onMounted, ref } from "vue";

const selectedValue = ref();
const pageSize = ref(50);
const loading = ref(false);
const isLoading = ref(false);
const values = ref();
const props = defineProps({
  resourceName: {
    type: String,
    required: true,
  },
  labelKey: {
    type: String,
    required: true,
  },
  valueKey: {
    type: String,
    required: true,
  },
  modelValue: {
    type: Number,
    required: false,
    default: null,
  },
});

const genericService = new GenericService(props.resourceName);

onMounted(async () => {
  isLoading.value = true;
  values.value = await genericService.list(
    [],
    {} as IFilter,
    0,
    pageSize.value,
  );

  if (!props.modelValue) {
    isLoading.value = false;
    return;
  }

  let foo: any = await genericService.get(String(props.modelValue));
  selectedValue.value = props.modelValue;
  if (
    !values.value.find((value: any) => {
      return value[props.valueKey] === foo[props.valueKey];
    })
  ) {
    values.value.push(foo);
  }

  isLoading.value = false;
});

const onLazyLoad = async (event: any) => {
  console.log(event);
  const { first, last } = event;
  loading.value = true;
  values.value = await genericService.list(
    [],
    {} as IFilter,
    first,
    pageSize.value,
  );
  loading.value = false;
};
</script>

<style scoped>

</style>
