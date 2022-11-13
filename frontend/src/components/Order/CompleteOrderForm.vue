<template>
  <div
    id="co"
    ref="el"
  >
    <Divider />
    <div>Beschreibung:</div>
    <div>{{ order?.Beschreibung }}</div>
    <Divider />
    <div class="grid grid-cols-2">
      <span>Auftragsnummer : </span> <span>{{ order?.Aufnr }}</span>
      <span>Kundennummer : </span> <span>{{ order?.KunNr }}</span>
      <span>Auftragsdatum : </span>
      <span>{{ useDateFormat(order?.AufDat, "DD.MM.YYYY").value }}</span>
    </div>
    <Divider />

    <div class="grid grid-cols-2">
      <span>Name : </span> <span>{{ employee.MitName }}</span>
      <span>Mitarbeiter Vorname :</span>
      <span>{{ employee.MitVorname }}</span>
      <span>Mitarbeiter ID : </span><span>{{ employee.MitID }}</span>
      <span>Mitarbeiter Beruf : </span>
      <span>{{ employee.MitJob }}</span>
    </div>

    <Divider />
    <InputNumber
      v-model="order.Anfahrt"
      placeholder="Anfahrt"
    ></InputNumber>
    <Divider />

    <InputNumber
      v-model="order.Dauer"
      placeholder="Dauer"
    ></InputNumber>
    <Divider />

    <div />
    <Button
      type="submit"
      icon="pi pi-check"
      label="Auftrag erledigen"
      class="w-full"
      @click="planOrder"
    />
  </div>
</template>
<script setup lang="ts">
import { useDateFormat } from "@vueuse/core";
import { inject, onMounted, ref } from "vue";
import { IAuftrag, IMitarbeiter } from "@/types";
import EmployeesService from "@/api/services/Employees";
import OrderService from "@/api/services/Order";
import { useToast } from "primevue/usetoast";

const dialogRef: any = inject("dialogRef");

const toast = useToast();
const employee = ref<IMitarbeiter>({} as IMitarbeiter);
const orderService = new OrderService();
const employeesSevice = new EmployeesService();
const order = ref<IAuftrag>({} as IAuftrag);

onMounted(async () => {
  order.value = dialogRef.value.data.order;
  employee.value = await employeesSevice.get(order?.value?.MitID as string);
});

const planOrder = async () => {
  try {
    let { Aufnr, ...x }: any = order.value;

    await orderService.update(String(Aufnr), {
      ...x,
    });
    toast.add({
      severity: "success",
      summary: "Auftrag geplant",
      detail: "Der Auftrag wurde erfolgreich geplant",
      life: 3000,
    });
    dialogRef.value.close();
  } catch (e) {
    toast.add({
      severity: "error",
      summary: "Fehler",
      detail: "Der Auftrag konnte nicht geplant werden",
      life: 3000,
    });
  }
};
</script>
