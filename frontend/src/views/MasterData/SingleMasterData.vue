<template>
  <div class="h-full w-fit rounded-xl bg-white py-8 px-[10%] shadow-2xl">
    <h1
      class="bg-gradient-to-r from-blue-500 to-pink-700 bg-clip-text py-4 text-6xl font-extrabold text-transparent"
    >
      {{ props.label }} | ID: {{ data[primaryKey] }}
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
        <div v-if="field.type === 'relation'">
          <EntityDropdown :table-name="field.tableName" />
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
  </div>
</template>

<script setup lang="ts">
import GenericService from "@/api/services/Generic";
import { router } from "@/router";
import { TGenericService } from "@/types";
import { useToast } from "primevue/usetoast";
import { onMounted, ref } from "vue";
import { useRoute } from "vue-router";
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
  data.value = await service.get(route.params.id as string);
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
  await service.delete(route.params.id as string);
  toast.add({
    severity: "success",
    summary: "Success",
    detail: `Successfully deleted ${props.label} with ${props.primaryKey} ${route.params.id}`,
    life: 5000,
  });
  router.push({ name: props.name });
};
</script>

<style scoped></style>
