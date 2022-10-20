<template>
  <div class="container mx-auto mt-8">
    <div
      class="card mx-[20%] flex flex-col items-stretch justify-center rounded-xl p-6 shadow-2xl"
    >
      <h2 class="my-4 mb-4 text-3xl">Auftrag planen</h2>
      <Divider />
      <DataTable
        :value="orders"
        showGridlines
        :rowHover="true"
        responsiveLayout="scroll"
      >
        <Column
          v-for="cols in columns"
          :field="cols.field"
          :header="cols.header"
          :key="cols.field"
        ></Column>
        <Column field="edit" header="">
          <template #body="slotProps">
            <Button
              type="button"
              icon="pi pi-pencil"
              class="p-button-warning"
              @click="onButtonClick($event, slotProps.data)"
            ></Button> </template
        ></Column>
      </DataTable>
      <DynamicDialog />
      <div></div>
    </div>
  </div>
</template>

<script setup lang="ts">
import OrderService from "@/services/Order";
import { Auftrag } from "@/types";
import { onMounted, ref } from "vue";
import { useDialog } from "primevue/usedialog";
import PlanOrderForm from "@/components/Order/PlanOrderForm.vue";

const orderService = new OrderService();
const orders = ref<Auftrag[]>();
const dialog = useDialog();

const onButtonClick = (event: any, order: Auftrag) => {
  dialog.open(PlanOrderForm, {
    props: {
      header: "Product List",
      style: {
        width: "50vw",
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
  });
};

onMounted(async () => {
  orders.value = await orderService.list();
  console.log(orders);
});

const columns = [
  {
    field: "Aufnr",
    header: "Auftragsnummer",
  },
  {
    field: "KunNr",
    header: "Kundennummer",
  },
  {
    field: "Kunde.KunName",
    header: "Kunde",
  },
  {
    field: "AufDat",
    header: "Auftragsdatum",
  },
];
</script>

<style></style>
