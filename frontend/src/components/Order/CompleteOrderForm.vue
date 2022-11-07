<template>
  <div id="co" ref="el">
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
    <div></div>
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
import { IAuftrag } from "@/types";

const dialogRef: any = inject("dialogRef");

const order = ref<IAuftrag>();

onMounted(() => {
  order.value = dialogRef.value.data.order;
});

const planOrder = async () => {};
</script>
