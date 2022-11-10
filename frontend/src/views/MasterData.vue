<template>
  <div
    class="card mx-[10%] flex h-fit flex-col items-stretch justify-center rounded-xl bg-white p-6 shadow-2xl"
  >
    <div class="flex items-center justify-between">
      <h1
        class="bg-gradient-to-r from-blue-500 to-pink-700 bg-clip-text py-4 text-6xl font-extrabold text-transparent"
      >
        {{ data?.name }}
      </h1>
      <Button
        icon="pi pi-plus"
        class="mr-2 mb-2 rounded-lg !border-none !bg-gradient-to-r from-blue-400 to-pink-800 text-center text-2xl font-medium text-white shadow-lg hover:scale-105 hover:transform"
        :label="`${data?.name} erstellen`"
        @click="openDialog = true"
      />
    </div>
    <Divider />
    <EntityTable
      :show-rows="50"
      :columns="data?.columns"
      :api-service="service"
      :allow-edit="true"
      @edit-row="onEditRow"
    />
    <Dialog
      v-model:visible="openDialog"
      :modal="true"
      :header="`${data?.name} ${isUpdate ? 'updaten' : 'erstellen'}`"
      :draggable="false"
      :breakpoints="{ '960px': '75vw', '640px': '90vw' }"
      :style="{ width: '35vw' }"
      @after-hide="onFormHide"
    >
      <EntityForm
        :data="row"
        :update="isUpdate"
        :columns="data?.columns"
        :api-service="service"
      />
    </Dialog>
  </div>
</template>

<script setup lang="ts">
import EntityTable from "@/components/Entity/EntityTable.vue";
import EntityForm from "@/components/Entity/EntityForm.vue";
import Dialog from "primevue/dialog";
import Divider from "primevue/divider";
import GenericService from "@/api/services/Generic";
import { useRoute, useRouter } from "vue-router";
import { masterdata } from "@/master-data";
import { IMasterData, TGenericService } from "@/types";
import { onMounted, ref } from "vue";

const route = useRoute();
const router = useRouter();
const service = ref<GenericService<TGenericService>>(
  {} as GenericService<TGenericService>,
);
const data = ref<IMasterData>({} as IMasterData);
const row = ref();
const isUpdate = ref(false);
const openDialog = ref(false);

let foo = masterdata.find((x) => x.id === route.params.entity);

if (!foo) {
  router.push("/404");
} else {
  data.value = foo;
  service.value = new GenericService(route.params.entity as string);
}

onMounted(async () => {
  if (!route.params.id) return;

  row.value = await service.value.get(route.params.id as string);
  console.log(row.value);

  if (!row.value) return router.push("/" + route.params.entity);
  isUpdate.value = true;
  openDialog.value = true;
});

const onEditRow = (data: any) => {
  isUpdate.value = true;
  row.value = data;
  openDialog.value = true;
};

const onFormHide = () => {
  row.value = {};
  isUpdate.value = false;

  router.push("/masterdata/" + route.params.entity);
};
</script>

<style scoped></style>
