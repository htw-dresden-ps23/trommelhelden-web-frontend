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
    <div class="my-4 flex items-center justify-between">
      <div
        v-show="employee"
        class="grid w-full grid-cols-2"
      >
        <span>Name : </span> <span>{{ employee?.MitName }}</span>
        <span>Mitarbeiter Vorname :</span>
        <span>{{ employee?.MitVorname }}</span> <span>Mitarbeiter ID : </span
        ><span>{{ employee?.MitID }}</span> <span>Mitarbeiter Beruf : </span>
        <span>{{ employee?.MitJob }}</span>
      </div>

      <Button
        type="button"
        icon="pi pi-search"
        :label="'Mitarbeiter wählen'"
        aria-haspopup="true"
        aria-controls="overlay_panel"
        @click="toggle"
      />
      <OverlayPanel
        ref="op"
        :show-close-icon="true"
        style="width: 1000px"
        :auto-z-index="false"
        :dismissable="false"
        class="z-[2102]"
        :breakpoints="{ '960px': '75vw' }"
      >
        <EntityTable
          :api-service="employeesService"
          :columns="columns"
          :show-rows="5"
          @select-row="onSelectEmployee"
        />
      </OverlayPanel>
    </div>
    <Divider />
    <Button
      type="submit"
      icon="pi pi-check"
      label="Auftrag planen"
      class="w-full"
      @click="planOrder"
    />
  </div>
</template>
<script setup lang="ts">
  import { useDateFormat } from "@vueuse/core";
  import EmployeesService from "@/api/services/Employees";
  import { inject, onMounted, ref } from "vue";
  import EntityTable from "@/components/Entity/EntityTable.vue";
  import { IAuftrag, IEntityTableColumns, IMitarbeiter } from "@/types";

  const employeesService = new EmployeesService();
  const dialogRef: any = inject("dialogRef");
  const employee = ref<IMitarbeiter>();

  console.log(useDateFormat(new Date(), "DD.MM.YYYY").value);

  const op = ref();

  const order = ref<IAuftrag>();

  const columns: IEntityTableColumns[] = [
    {
      header: "ID",
      field: "MitID",
      type: "text",
    },
    {
      header: "Vorname",
      field: "MitVorname",
      type: "text",
    },
    {
      header: "Nachname",
      field: "MitName",
      type: "text",
    },
    {
      header: "Stelle",
      field: "MitJob",
      type: "text",
    },
    {
      header: "Niederlassung",
      field: "NLNr",
      type: "text",
    },
    {
      header: "Stundensatz",
      field: "MitStundensatz",
      type: "numeric",
    },
  ];

  const toggle = async (event: Event) => {
    // customers.value = await customerService.list();
    op.value.toggle(event);
  };

  onMounted(() => {
    order.value = dialogRef.value.data.order;
  });

  const onSelectEmployee = (employeeP: IMitarbeiter) => {
    op.value.hide();
    employee.value = employeeP;
  };

  const planOrder = async () => {
    // TODO IMPLEMENT
  };
</script>

<style></style>
