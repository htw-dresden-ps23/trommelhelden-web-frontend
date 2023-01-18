<template>
  <div class="h-full w-fit rounded-xl bg-white py-8 px-[10%] shadow-2xl">
    <h1 class="bg-gradient-to-r from-blue-500 to-pink-700 bg-clip-text py-4 text-6xl font-extrabold text-transparent">
      {{ props.label }} erstellen
    </h1>
    <div class="col-span-1 grid grid-cols-1 justify-items-center gap-x-4 gap-y-6 py-8">
      <span
        v-for="field in props.fields.filter((x: any) => x.allowUpdate)"
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
        label="Erstellen"
        icon="pi pi-plus"
        :disabled="!isFilled"
        @click="onCreate"
      />
      <Button
        style="background-color: #d92979"
        label="Zurück"
        icon="pi pi-backward"
        @click="$router.go(-1)"
      />
    </div>
  </div>
</template>

<script setup lang="ts">
import Calendar from "primevue/calendar";
import EntityDropdown from "@/components/Entity/EntityDropdown.vue";
import GenericService from "@/api/services/Generic";
import { router } from "@/router";
import { TGenericService } from "@/types";
import { useToast } from "primevue/usetoast";
import { computed, ref } from "vue";
const data: any = ref({});
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

const onCreate = async () => {
  const response: any = await service.create(data.value);
  router.push({ name: props.name });
  toast.add({
    severity: "success",
    summary: "Success",
    detail: `Successfully created new ${props.label} with ID ${response}`,
    life: 5000,
  });
};

const isFilled = computed(() => {




  return Object.keys(data.value).filter(x => data.value[x]).length === props.fields.filter((x: any) => x.allowUpdate).length;



})



</script>

<style scoped>

</style>
