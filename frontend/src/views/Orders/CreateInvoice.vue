<template>
<div class="card mx-[20%] flex flex-1 flex-col items-stretch justify-center rounded-xl bg-white p-6 shadow-2xl">
    <h1 class="bg-gradient-to-r from-blue-500 to-pink-700 bg-clip-text py-4 text-6xl font-extrabold text-transparent">
      Rechnung erstellen
    </h1>
    <Divider />

    <div class="my-4 flex items-center justify-between">
      <div
        v-if="order.Aufnr"
        class="grid flex-1 grid-cols-2"
      >
      <span>Aufnr: </span><span>{{ order.Aufnr }}</span>
        <span>Kundennummer: </span><span>{{ order.KunNr }}</span>
        <span>MitNR: </span><span>{{ order.MitID }}</span>
        <span>Beschreibung </span><span>{{ order.Beschreibung }}</span>
        <span>AufDat  </span><span>{{ order.AufDat }}</span>
        <span>ErlDat </span><span>{{ order.ErlDat }}</span>

      </div>
      <Button
        type="button"
        icon="pi pi-search"
        :label="'Auftrag wählen'"
        aria-haspopup="true"
        aria-controls="overlay_panel"
        @click="toggle"
      />

      <div>
        <OverlayPanel
          id="overlay_panel2"
          ref="op"
          append-to="body"
          :show-close-icon="true"
          style="margin-top: -28rem;"
          :dismissable="false"
          :breakpoints="{ '960px': '75vw' }"
        >
          <EntityTable

            name="Aufträge"
            primary-key="Aufnr"
            :show-rows="5"
            :columns="columns"
            resource-name="orders"
            :allow-delete="false"
            :opt-params="{ status: 'completed' }"
            :emit-edit-only="true"
            @on-row-select="onSelectOrder"
          />
        </OverlayPanel>
      </div>
    </div>
    <Divider />
    <!-- <div class="my-4 flex items-center justify-between">
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

      
    -- </div> -->
  
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
        type="submit"
        icon="pi pi-check"
        label="Erstellen"
        class="ml-auto"
        :disabled="!order.Beschreibung || !order.Kunde || !order.AufDat"
        @click="createOrder"
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

const onSelectOrder = (newOrder: IAuftrag) => {
  order.value = newOrder;
  op.value.hide()
};

const createOrder = async () => {
  try {
    if (order.value) {
      await orderService.create(order.value);
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



const columns: IMasterDataField[] = [
  {
    label: "Auftragsnummer",
    name: "Aufnr",
    type: "numeric",
    allowCreate: false,
    allowUpdate: false,
  },
  {
    label: "Mitarbeiter ID",
    name: "MitID",
    type: "text",
    allowCreate: false,
    allowUpdate: false,
  },
  {
    label: "Kunden ID",
    name: "KunNr",
    type: "numeric",
    allowCreate: false,
    allowUpdate: false,
  },
//   {
//     label: "Postleitzahl",
//     name: "KunPLZ",
//     type: "text",
//     allowCreate: false,
//     allowUpdate: false,
//   },
//   {
//     label: "Straße",
//     name: "KunStrasse",
//     type: "text",
//     allowCreate: false,
//     allowUpdate: false,
//   },
];
</script>

<style>

</style>
