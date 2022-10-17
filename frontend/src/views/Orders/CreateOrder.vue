<template>
  <div class="container mx-auto mt-14">
    <div
      class="card mx-[20%] flex flex-col items-stretch justify-center rounded-xl p-6 shadow-2xl"
    >
      <h2 class="my-4 mb-4 text-3xl">Auftrag erstellen</h2>
      <Divider />
      <div class="my-4">
        <span class="p-float-label flex flex-row">
          <Textarea
            id="order-description"
            v-model="order.Beschreibung"
            :autoResize="true"
            rows="5"
            cols="100"
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
            style="width: 800px"
            :breakpoints="{ '960px': '75vw' }"
          >
            <CustomerTable @selectRow="onSelectCustomer" />
          </OverlayPanel>
        </div>
      </div>
      <Divider />
      <div>
        <span class="p-float-label my-4">
          <Calendar
            id="order-calendar"
            v-model="order.AufDat"
            :showIcon="true"
          />
          <label for="order-calendar">Auftragsdatum</label>
        </span>
      </div>
      <Divider />
      <Button
        type="submit"
        icon="pi pi-check"
        label="Erstellen"
        class="ml-auto"
        :disabled="!order.Beschreibung || !order.Kunde || !order.AufDat"
      />
    </div>
  </div>
</template>

<script setup lang="ts">
// import { Auftrag, Kunde } from "@/types";
import { onMounted, ref } from "vue";
import { useRouter } from "vue-router";
import Calendar from "primevue/calendar";
import { useVuelidate } from "@vuelidate/core";
import { required } from "@vuelidate/validators";
import CustomerService from "@/services/Customers";
import CustomerTable from "../../components/CustomerTable.vue";
const router = useRouter();
const customers = ref<Kunde[]>();
const isLoading = ref(false);
const customerService = new CustomerService();
const op = ref();
const order = ref<Auftrag>({} as Auftrag);

const toggle = async (event: Event) => {
  // customers.value = await customerService.list();
  op.value.toggle(event);
};

const onSelectCustomer = (customer: Kunde) => {
  console.log();
  order.value.Kunde = customer;
  op.value.hide();
};
</script>

<style></style>
