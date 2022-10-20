<template>
  <div></div>
</template>
<script setup lang="ts">
import { Auftrag } from "@/types";
import { inject, onMounted, ref } from "vue";
const dialogRef = inject("dialogRef");

console.log(dialogRef);

const order = ref<Auftrag>();

onMounted(() => {
  order.value = dialogRef.value.data.order;
});
</script>

<style scoped></style>
