<template>
  <div class="mx-auto mt-8 flex-1">
    <div
      class="card flex flex-col items-stretch justify-center rounded-xl bg-white p-6 shadow-2xl"
    >
      <h1
        class="bg-gradient-to-l from-blue-500 to-pink-700 bg-clip-text py-4 text-6xl font-extrabold text-transparent"
      >
        Auftrag erfüllen
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
        :opt-params="{ status: 'planned' }"
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

import { IAuftrag } from "@/types";
import { ref } from "vue";
import { useDialog } from "primevue/usedialog";
import disableScroll from "disable-scroll";
import CompleteOrderForm from "@/components/Order/CompleteOrderForm.vue";

const reRender = ref(0);
const dialog = useDialog();

const onButtonClick = (order: IAuftrag) => {
  console.log(order);

  disableScroll.on(document.body);
  dialog.open(CompleteOrderForm, {
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

const columns = [
  {
    name: "Aufnr",
    label: "Auftragsnummer",
    type: "text",
  },
  {
    name: "KunNr",
    label: "Kundennummer",
    type: "text",
  },
  {
    name: "Kunde.KunName",
    label: "Kunde",
    type: "text",
  },
  {
    name: "AufDat",
    label: "Auftragsdatum",
    type: "date",
  },
  {
    name: "ErlDat",
    label: "Erledigungsdatum",
    type: "date",
  },
  {
    name: "Mitarbeiter.MitID",
    label: "Mitarbeiter ID",
    type: "text",
  },
  {
    name: "Mitarbeiter.MitName",
    label: "Mitarbeiter ID",
    type: "text",
  },
];
</script>

<style></style>
