<template>
  <header class="sticky top-0 z-[1000]">
    <div
      class="flex h-10 items-center bg-gradient-to-r from-blue-400 to-pink-600 shadow"
    >
      <div class="m-4 mr-auto flex">
        <Button
          @click="store.sideBarMenuIsOpen = !store.sideBarMenuIsOpen"
          icon="pi pi-align-justify"
          iconClass="text-[#f6f6f6]"
          class="p-button-rounded p-button-text p-button-plain"
        ></Button>
      </div>
    </div>
  </header>
</template>

<script setup lang="ts">
import { useStore } from "@/store";

const store = useStore();
</script>

<style scoped></style>
