<template>
  <div class="mx-auto mt-8 flex-1">
    <div class="card mx-[20%] flex flex-col items-stretch justify-center rounded-xl bg-white p-6 shadow-2xl">
      <h1 class="bg-gradient-to-l from-blue-500 to-pink-700 bg-clip-text py-4 text-6xl font-extrabold text-transparent">
        Auftrag planen
      </h1>
      <Divider />
      <EntityTable
        :key="reRender"
        name="Aufträge"
        primary-key="Aufnr"
        :show-rows="50"
        :columns="columns"
        resource-name="orders"
        :allow-edit="true"
        :allow-delete="false"
        :opt-params="{ status: 'created' }"
        :emit-edit-only="true"
        @edit-row="onButtonClick"
      />
      <DynamicDialog
        id="test"
        :draggable="false"
        content-class="test"
      />
    </div>
  </div>
</template>

<script setup lang="ts">
import EntityTable from "@/components/Entity/EntityTable.vue";

import { IAuftrag, IMasterDataField } from "@/types";
import { onMounted, ref } from "vue";
import { useDialog } from "primevue/usedialog";
import PlanOrderForm from "@/components/Order/PlanOrderForm.vue";
import disableScroll from "disable-scroll";

const reRender = ref(0);
const dialog = useDialog();
const isLoading = ref(false);

const onButtonClick = (order: IAuftrag) => {
  console.log(order);

  disableScroll.on(document.body);
  dialog.open(PlanOrderForm, {
    props: {
      header: "Auftrag: " + order.Aufnr,
      style: {
        width: "40vw",
      },
      breakpoints: {
        "960px": "75vw",
        "640px": "90vw",
      },
      modal: true,
    },
    data: {
      order,
    },
    onClose: () => {
      disableScroll.off();
      reRender.value++;
    },
  });
};

onMounted(async () => {
  isLoading.value = true;

  isLoading.value = false;
});

const columns: IMasterDataField[] = [
  {
    name: "Aufnr",
    label: "Auftragsnummer",
    type: "text",
    allowCreate: false,
    allowUpdate: false,
  },
  {
    name: "KunNr",
    label: "Kundennummer",
    type: "text",
    allowCreate: false,
    allowUpdate: false,
  },
  {
    name: "Kunde.KunName",
    label: "Kunde",
    type: "text",
    allowCreate: false,
    allowUpdate: false,
  },
  {
    name: "AufDat",
    label: "Auftragsdatum",
    type: "date",
    allowCreate: false,
    allowUpdate: false,
  },
];
</script>

<style>

</style>
