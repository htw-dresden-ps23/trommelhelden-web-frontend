<template>
  <div
    class="card mx-[20%] flex flex-col items-stretch justify-center rounded-xl bg-white p-6 shadow-2xl"
  >
    <h1
      class="bg-gradient-to-r from-blue-500 to-pink-700 bg-clip-text py-4 text-6xl font-extrabold text-transparent"
    >
      Auftrag erstellen
    </h1>
    <Divider />
    <div class="my-4">
      <span class="p-float-label flex flex-row">
        <Textarea
          id="order-description"
          v-model="order.Beschreibung"
          :autoResize="true"
          rows="5"
          class="w-3/4"
        />
        <label for="order-description">Auftragsbeschreibung*</label>
      </span>

      <span class="ml-4 text-sm"
        >{{ order.Beschreibung ? order.Beschreibung.length : 0 }}/500</span
      >
    </div>
    <Divider />
    <div class="my-4 flex items-center justify-between">
      <div v-if="order.Kunde" class="grid flex-1 grid-cols-2">
        <span>Name: </span><span>{{ order.Kunde.KunName }}</span>
        <span>Kundennummer: </span><span>{{ order.Kunde.KunNr }}</span>
        <span>Ort: </span><span>{{ order.Kunde.KunOrt }}</span>
        <span>PLZ: </span><span>{{ order.Kunde.KunPLZ }}</span>
        <span>Straße: </span><span>{{ order.Kunde.KunStrasse }}</span>
      </div>
      <Button
        type="button"
        icon="pi pi-search"
        :label="'Kunde wählen'"
        @click="toggle"
        aria-haspopup="true"
        aria-controls="overlay_panel"
      />

      <div>
        <OverlayPanel
          ref="op"
          appendTo="body"
          :showCloseIcon="true"
          id="overlay_panel"
          style="width: 900px"
          :dismissable="false"
          :breakpoints="{ '960px': '75vw' }"
        >
          <EntityTable
            :show-rows="5"
            @selectRow="onSelectCustomer"
            :api-service="customerService"
            :columns="columns"
          />
        </OverlayPanel>
      </div>
    </div>
    <Divider />
    <div>
      <span class="p-float-label my-4">
        <Calendar id="order-calendar" v-model="order.AufDat" :showIcon="true" />
        <label for="order-calendar">Auftragsdatum</label>
      </span>
    </div>
    <Divider />
    <Button
      type="submit"
      icon="pi pi-check"
      label="Erstellen"
      class="ml-auto"
      @click="createOrder"
      :disabled="!order.Beschreibung || !order.Kunde || !order.AufDat"
    />
  </div>
</template>

<script setup lang="ts">
import EntityTable from "@/components/EntityTable.vue";
import Calendar from "primevue/calendar";
import CustomerService from "@/api/services/Customers";
import { IKunde, IAuftrag, IEntityTableColumns } from "@/types";
import { ref } from "vue";
import { useToast } from "primevue/usetoast";
import { useRouter } from "vue-router";

const router = useRouter();
const toast = useToast();

const customerService = new CustomerService();
const op = ref();
const order = ref<IAuftrag>({} as IAuftrag);

const toggle = async (event: Event) => {
  op.value.toggle(event);
};

const onSelectCustomer = (customer: IKunde) => {
  console.log();
  order.value.Kunde = customer;
  op.value.hide();
};

const createOrder = async () => {
  try {
    if (order.value) {
      await customerService.create(order.value);
      toast.add({
        severity: "success",
        summary: "Order Created ",
        detail: "",
        life: 5000,
      });
      router.push("/orders");
    }
  } catch (e) {
    toast.add({
      severity: "error",
      summary: "Error while creating Order ",
      detail: e,
      life: 5000,
    });
    // order.value = {} as IAuftrag;
  }
};

const columns: IEntityTableColumns[] = [
  {
    header: "Name",
    field: "KunName",
    type: "text",
  },
  {
    header: "Kunden Nr.",
    field: "KunNr",
    type: "numeric",
  },
  {
    header: "Ort",
    field: "KunOrt",
    type: "text",
  },
  {
    header: "Postleitzahl",
    field: "KunPLZ",
    type: "text",
  },
  {
    header: "Straße",
    field: "KunStrasse",
    type: "text",
  },
];
</script>

<style></style>
