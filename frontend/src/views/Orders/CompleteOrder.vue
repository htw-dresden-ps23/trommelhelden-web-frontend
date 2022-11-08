<template>
  <div class="mx-auto mt-8 flex-1">
    <div
      class="card mx-[20%] flex flex-col items-stretch justify-center rounded-xl bg-white p-6 shadow-2xl"
    >
      <h1
        class="bg-gradient-to-l from-blue-500 to-pink-700 bg-clip-text py-4 text-6xl font-extrabold text-transparent"
      >
        Auftrag erledigen
      </h1>
      <Divider />
      <DataTable
        :value="orders"
        show-gridlines
        :row-hover="true"
        current-page-report-template="Showing {first} to {last} of {totalRecords}"
        :rows-per-page-options="[5, 10, 20, 50]"
        :paginator="true"
        :rows="rows"
        :total-records="orders ? orders.length : 0"
        responsive-layout="scroll"
      >
        <Column
          v-for="col in columns"
          :key="col.field"
          :field="col.field"
          :header="col.header"
        >
          <template #body="{ data }">
            <div v-if="isLoading">
              <Skeleton />
            </div>
            <div v-else>
              <div v-if="data && col.type === 'date'">
                {{ useDateFormat(data[col.field], "DD.MM.YYYY").value }}
              </div>
              <div v-else>
                {{ data ? data[col.field] : "" }}
              </div>
            </div>
          </template>
        </Column>
        <Column
          field="edit"
          header=""
        >
          <template #body="slotProps">
            <div v-if="isLoading">
              <Skeleton size="3rem" />
            </div>
            <div v-else>
              <Button
                type="button"
                icon="pi pi-pencil"
                class="p-button-warning"
                @click="onButtonClick($event, slotProps.data)"
              />
            </div>
          </template>
        </Column>
      </DataTable>
      <DynamicDialog
        id="test"
        :draggable="false"
        content-class="test"
      />
      <div />
    </div>
  </div>
</template>

<script setup lang="ts">
import { useDateFormat } from "@vueuse/core";

import OrderService from "@/api/services/Order";
import { IAuftrag } from "@/types";
import { onMounted, ref } from "vue";
import { useDialog } from "primevue/usedialog";
import { flatten } from "flat";
import disableScroll from "disable-scroll";
import CompleteOrderForm from "@/components/Order/CompleteOrderForm.vue";

const orderService = new OrderService();
const orders = ref<IAuftrag[]>(new Array(20));
const dialog = useDialog();
const isLoading = ref(false);
const rows = ref(10);

const onButtonClick = (event: any, order: IAuftrag) => {
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
    },
  });
};

onMounted(async () => {
  isLoading.value = true;
  orders.value = await orderService.list({}, {});
  orders.value = orders.value.map((value) => flatten(value));

  isLoading.value = false;
});

const columns = [
  {
    field: "Aufnr",
    header: "Auftragsnummer",
    type: "text",
  },
  {
    field: "KunNr",
    header: "Kundennummer",
    type: "text",
  },
  {
    field: "Kunde.KunName",
    header: "Kunde",
    type: "text",
  },
  {
    field: "AufDat",
    header: "Auftragsdatum",
    type: "date",
  },
];
</script>

<style></style>
