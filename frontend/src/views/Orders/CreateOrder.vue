<template>
  <div class="card mx-[20%] flex flex-1 flex-col items-stretch justify-center rounded-xl bg-white p-6 shadow-2xl">
    <h1 class="bg-gradient-to-r from-blue-500 to-pink-700 bg-clip-text py-4 text-6xl font-extrabold text-transparent">
      Auftrag erstellen
    </h1>
    <Divider />
    <div class="my-4">
      <span class="p-float-label flex flex-row">
        <Textarea
          id="order-description"
          v-model="order.Beschreibung"
          :auto-resize="true"
          rows="5"
          class="w-3/4"
        />
        <label for="order-description">Auftragsbeschreibung*</label>
      </span>

      <span class="ml-4 text-sm">{{ order.Beschreibung ? order.Beschreibung.length : 0 }}/500</span>
    </div>
    <Divider />
    <div class="my-4 flex items-center justify-between">
      <div
        v-if="order.Kunde"
        class="grid flex-1 grid-cols-2"
      >
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
        aria-haspopup="true"
        aria-controls="overlay_panel"
        @click="toggle"
      />

      <div>
        <OverlayPanel
          id="overlay_panel"
          ref="op"
          append-to="body"
          :show-close-icon="true"
          style="margin-top: -28rem;"
          :dismissable="false"
          :breakpoints="{ '960px': '75vw' }"
        >
          <EntityTable
            :show-rows="5"
            :primary-key="'KunNr'"
            :resource-name="'customers'"
            :columns="columns"
            :name="'Kunden'"
            @on-row-select="onSelectCustomer"
          />
        </OverlayPanel>
      </div>
    </div>
    <Divider />
    <div>
      <span class="p-float-label my-4">
        <Calendar
          id="order-calendar"
          v-model="order.AufDat"
          :show-icon="true"
        />
        <label for="order-calendar">Auftragsdatum</label>
      </span>
    </div>
    <Divider />
    <div class="flex justify-between">
      <Button
        style="background-color: #d92979"
        label="Zurück"
        icon="pi pi-backward"
        @click="$router.go(-1)"
      />
      <Button
        type="submit"
        icon="pi pi-check"
        label="Erstellen"
        class="ml-auto"
        :disabled="!order.Beschreibung || !order.Kunde || !order.AufDat"
        @click="createOrder"
      />

    </div>
  </div>
</template>

<script setup lang="ts">
import EntityTable from "@/components/Entity/EntityTable.vue";
import Calendar from "primevue/calendar";
import CustomerService from "@/api/services/Customers";
import { IKunde, IAuftrag, IEntityTableColumns, IMasterDataField } from "@/types";
import { ref } from "vue";
import { useToast } from "primevue/usetoast";
import { useRouter } from "vue-router";
import OrderService from "@/api/services/Order";

const router = useRouter();
const toast = useToast();

const customerService = new CustomerService();
const orderService = new OrderService();
const op = ref();
const order = ref<IAuftrag>({} as IAuftrag);

const toggle = async (event: Event) => {
  op.value.toggle(event);
};

const onSelectCustomer = (customer: IKunde) => {
  console.log(2);
  order.value.Kunde = customer;
  order.value.KunNr = customer.KunNr;
  op.value.hide();
};

const createOrder = async () => {
  try {
    if (order.value) {
      await orderService.create(order.value);
      toast.add({
        severity: "success",
        summary: "Auftrag erstellt.",
        detail: "Der Auftrag wurde erfolgreich erstellt.",
        life: 5000,
      });
      router.push("/orders");
    }
  } catch (e) {
    toast.add({
      severity: "error",
      summary: "Fehler!",
      detail: e,
      life: 5000,
    });
    // order.value = {} as IAuftrag;
  }
};

const columns: IMasterDataField[] = [
  {
    label: "Name",
    name: "KunName",
    type: "text",
    allowCreate: false,
    allowUpdate: false,
  },
  {
    label: "Kunden Nr.",
    name: "KunNr",
    type: "numeric",
    allowCreate: false,
    allowUpdate: false,
  },
  {
    label: "Ort",
    name: "KunOrt",
    type: "text",
    allowCreate: false,
    allowUpdate: false,
  },
  {
    label: "Postleitzahl",
    name: "KunPLZ",
    type: "text",
    allowCreate: false,
    allowUpdate: false,
  },
  {
    label: "Straße",
    name: "KunStrasse",
    type: "text",
    allowCreate: false,
    allowUpdate: false,
  },
];
</script>

<style>

</style>
