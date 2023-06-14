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

    <div
      v-if="employee"
      class="grid grid-cols-2"
    >
      <span>Name : </span> <span>{{ employee.MitName }}</span>
      <span>Mitarbeiter Vorname :</span>
      <span>{{ employee.MitVorname }}</span>
      <span>Mitarbeiter ID : </span><span>{{ employee.MitID }}</span>
      <span>Mitarbeiter Beruf : </span>
      <span>{{ employee.MitJob }}</span>
    </div>

    <Divider />
    <div class="grid col-span-2 row-span-2 gap-4 mb-4">
      <InputNumber
        v-model="order.Anfahrt"
        class="col-start-1 col-end-1"
        placeholder="Anfahrt in km"
      ></InputNumber>


      <InputNumber
        v-model="order.Dauer"
        class="col-start-2 col-end-2 "
        placeholder="Dauer in h"
      ></InputNumber>

      <!-- <Dropdown
        v-model="selectedSpareParts"
        :options="spareparts"
        option-label="EtBezeichnung"
        :filter="true"
        placeholder="Ersatzteile auswählen"
        :show-clear="true"
      >
        <template #option="slotProps">

          <div class="flex justify-between">
            <Chip>{{ slotProps.option?.EtPreis }} €</Chip>
            <span>{{
              slotProps.option?.EtBezeichnung
            }}</span>
          </div>


        </template>

      </Dropdown> -->

      <!-- Ersatz für DropDown: -->
      <MultiSelect
        filter
        v-model="selectedSpareParts"
        :options="spareparts"
        option-label="EtBezeichnung"
        placeholder="Ersatzteil(e) auswählen"
      >
        <template #option="slotProps">

          <div class="flex justify-between">
            <Chip>{{ slotProps.option?.EtPreis }} €</Chip>
            <span>{{
              slotProps.option?.EtBezeichnung
            }}</span>
          </div>

        </template>
      </MultiSelect>
    
    </div>
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
import Chip from 'primevue/chip';
import Listbox from 'primevue/listbox';
import { useDateFormat } from "@vueuse/core";
import { inject, onMounted, ref } from "vue";
import { IAuftrag, IErsatzteil, IMitarbeiter } from "@/types";
import EmployeesService from "@/api/services/Employees";
import OrderService from "@/api/services/Order";
import { useToast } from "primevue/usetoast";
import { unflatten } from "flat";
import Divider from "primevue/divider";

import GenericService from '@/api/services/Generic';

import MultiSelect from "primevue/multiselect"

const sparepartsService = new GenericService<IErsatzteil>("spareparts");

const dialogRef: any = inject("dialogRef");
const selectedSpareParts = ref<IErsatzteil[]>([] as IErsatzteil[]);
const toast = useToast();
const employee = ref<IMitarbeiter>({} as IMitarbeiter);
const orderService = new OrderService();
const employeesSevice = new EmployeesService();
const order = ref<IAuftrag>({} as IAuftrag);
const spareparts = ref<IErsatzteil[]>([] as IErsatzteil[]);


onMounted(async () => {
  console.log(order.value);

  spareparts.value = await sparepartsService.list([], {}, 0, 1000);
  order.value = unflatten(dialogRef.value.data.order);
  console.log(order.value);

  employee.value = await employeesSevice.get(order?.value?.MitID as string);
});

// Ersetzt durch Array (siehe unten)
// const planOrder = async () => {
//   try {
//     let { Aufnr, MitID, Kunde, Mitarbeiter, Rechnung, ...x }: any = order.value;

//     console.log(x);
//     if (selectedSpareParts.value.EtID) {
//       x.Montage = {
//         create: {

//           EtID: selectedSpareParts.value.EtID,
//           Anzahl: 1,


//         }
//       }
//     }
//     await orderService.update(String(Aufnr), {
//       ...x,
//     });
//     toast.add({
//       severity: "success",
//       summary: "Auftrag geplant",
//       detail: "Der Auftrag wurde erfolgreich erledigt",
//       life: 3000,
//     });
//     dialogRef.value.close();
//   } catch (e) {
//     toast.add({
//       severity: "error",
//       summary: "Fehler",
//       detail: "Der Auftrag konnte nicht geplant werden",
//       life: 3000,
//     });
//   }
// };

const planOrder = async () => {
  try {
    let { Aufnr, MitID, Kunde, Mitarbeiter, Rechnung, ...x }: any = order.value;

    console.log(x);

    // Überprüfe, ob ausgewählte Ersatzteile vorhanden sind
    if (selectedSpareParts.value.length > 0) {
      x.Montage = {
        create: selectedSpareParts.value.map((sparePart) => {
          return {
            EtID: sparePart.EtID,
            Anzahl: 1,
          };
        }),
      };
    }

    await orderService.update(String(Aufnr), {
      ...x,
    });

    toast.add({
      severity: "success",
      summary: "Auftrag erledigt.",
      detail: "Der Auftrag wurde erfolgreich erledigt.",
      life: 3000,
    });

    dialogRef.value.close();
  } catch (e) {
    toast.add({
      severity: "error",
      summary: "Fehler!",
      detail: e,
      life: 3000,
    });
  }
};

</script>
