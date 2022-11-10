<template>
  <div class="flex flex-col px-4">
    <div
      class="col-span-1 grid grid-cols-2 justify-items-center gap-x-4 gap-y-6 py-8"
    >
      <span
        v-for="(cols, index) in props.columns.filter((x) => x.create)"
        :id="`input-${cols.field}`"
        :key="cols.field"
        class="w-full"
      >
        <InputText
          v-if="cols.type === 'text'"
          v-model="data[cols.field]"
          class="w-full"
          :placeholder="cols.field"
        ></InputText>
        <InputNumber
          v-if="cols.type === 'numeric'"
          v-model="data[cols.field]"
          class="w-full"
          :placeholder="cols.field"
        ></InputNumber>
        <div v-if="cols.type === 'relation'">
          <Button
            type="button"
            icon="pi pi-search"
            :label="`${cols.linkRoute} wählen`"
            aria-haspopup="true"
            aria-controls="overlay_panel"
            @click="toggle($event, index)"
          />
          <OverlayPanel
            :id="`overlay-${index}`"
            ref="op"
            :show-close-icon="true"
            style="width: 800px"
            :auto-z-index="false"
            :dismissable="false"
            class="z-[2102]"
            :breakpoints="{ '960px': '75vw' }"
          >
            <EntityTable
              :api-service="new GenericService(cols.linkRoute as string)"
              :columns="
                masterdata.find((x) => x.id === cols.linkRoute)?.columns as IEntityTableColumns[]
              "
              :show-rows="5"
              @select-row="
                (val:any) => {
                  data[cols.field] = val;
                }
              "
            />
          </OverlayPanel>
        </div>
      </span>
    </div>
    <div class="flex justify-between">
      <Button
        label="Cancel"
        icon="pi pi-times"
      />
      <Button
        :label="props.update ? 'Update' : 'Create'"
        icon="pi pi-check"
        :disabled="isValid && !props.update"
      />
    </div>
  </div>
</template>

<script setup lang="ts">
import EntityTable from "@/components/Entity/EntityTable.vue";
import { IEntityTableColumns } from "@/types";
import { computed, onMounted, PropType, ref } from "vue";
import GenericService from "@/api/services/Generic";
import { masterdata } from "@/master-data";

const op: any = ref({});

const data: any = ref({});

onMounted(() => {
  if (props.update) {
    data.value = props.data;
  }
});

const toggle = async (event: Event, index: number) => {
  console.log(op.value);

  let foo = op.value.find((x: any) => x.$attrs.id === `overlay-${index}`);
  if (foo) foo.toggle(event);
};

const props = defineProps({
  columns: {
    type: Array as PropType<IEntityTableColumns[]>,
    required: true,
  },
  update: {
    type: Boolean,
    required: false,
    default: false,
  },
  data: {
    type: Object,
    required: false,
    default: {},
  },
});

const isValid = computed(() => {
  return !(
    Object.keys(data.value).filter((x) => data.value[x]).length ===
    props.columns.filter((x) => x.create).length
  );
});
</script>

<style scoped></style>
