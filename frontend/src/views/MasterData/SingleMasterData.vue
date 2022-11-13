<template>
  <div
    v-if="!isLoading"
    class="h-full w-fit rounded-xl bg-white py-8 px-[10%] shadow-2xl"
  >
    <h1
      class="bg-gradient-to-r from-blue-500 to-pink-700 bg-clip-text py-4 text-6xl font-extrabold text-transparent"
    >
      {{ props.label }} | {{ data[primaryKey] }}
    </h1>
    <div
      class="col-span-1 grid grid-cols-1 justify-items-center gap-x-4 gap-y-6 py-8"
    >
      <span
        v-for="field in props.fields.filter((x:any) => x.allowUpdate)"
        :id="`input-${field.name}`"
        :key="field.name"
        class="w-full"
      >
        <div>{{ field.label }}</div>
        <InputText
          v-if="field.type === 'text'"
          v-model="data[field.name]"
          class="w-full"
          :placeholder="field.name"
        ></InputText>
        <InputNumber
          v-if="field.type === 'numeric'"
          v-model="data[field.name]"
          class="w-full"
          :placeholder="field.name"
        ></InputNumber>
        <Calendar
          v-if="field.type === 'date'"
          v-model="data[field.name]"
          date-format="dd.mm.yy"
        ></Calendar>
        <div v-if="field.type === 'relation'">
          <EntityDropdown
            v-model="data[field.name]"
            :resource-name="field.relation.resourceName"
            :label-key="field.relation.labelKey"
            :value-key="field.relation.valueKey"
          />
        </div>
      </span>
    </div>
    <div class="flex justify-between">
      <Button
        label="Delete"
        icon="pi pi-trash"
        class="p-button-danger"
        @click="onDelete"
      />
      <Button
        label="Update"
        icon="pi pi-refresh"
        @click="onUpdate"
      />
    </div>
    <ConfirmDialog></ConfirmDialog>
  </div>
</template>

<script setup lang="ts">
import ConfirmDialog from "primevue/confirmdialog";

import EntityDropdown from "@/components/Entity/EntityDropdown.vue";
import Calendar from "primevue/calendar";
import { useConfirm } from "primevue/useconfirm";

import GenericService from "@/api/services/Generic";
import { router } from "@/router";
import { TGenericService } from "@/types";
import { useToast } from "primevue/usetoast";
import { onMounted, ref } from "vue";
import { useRoute } from "vue-router";

const confirm = useConfirm();

const isLoading = ref(false);
const data: any = ref({});
const route = useRoute();
const toast = useToast();
const props = defineProps([
  "resourceName",
  "fields",
  "label",
  "name",
  "primaryKey",
]);

const service = new GenericService<TGenericService>(
  props.resourceName as string,
);

onMounted(async () => {
  isLoading.value = true;
  data.value = await service.get(route.params.id as string);
  isLoading.value = false;
});

const onUpdate = async () => {
  await service.update(route.params.id as string, data.value);
  toast.add({
    severity: "success",
    summary: "Success",
    detail: `Successfully updated ${props.label} with ${props.primaryKey} ${route.params.id}`,
    life: 5000,
  });
};

const onDelete = async () => {
  confirm.require({
    message: `Are you sure you want to delete the item?`,
    header: "Confirmation",
    icon: "pi pi-exclamation-triangle",
    accept: async () => {
      await service.delete(route.params.id as string);
      toast.add({
        severity: "success",
        summary: "Success",
        detail: `Successfully deleted ${props.label} with ${props.primaryKey} ${route.params.id}`,
        life: 5000,
      });
      router.push({ name: props.name });
    },
  });
};
</script>

<style scoped></style>
