<template>
  <header class="sticky top-0 z-[1000]">
    <div
      class="flex h-10 items-center bg-gradient-to-r from-blue-400 to-pink-600 shadow"
    >
      <div class="headerbar m-4 mr-auto flex justify-between" style="width: 98%">
        <Button
          icon="pi pi-align-justify"
          icon-class="text-[#f6f6f6]"
          class="p-button-rounded p-button-text p-button-plain"
          @click="store.sideBarMenuIsOpen = !store.sideBarMenuIsOpen"
        />
        <Button
        class="p-button-rounded p-button-lg  p-button-text !text-slate-100"
        icon="pi pi-cog"
      />
      </div>
    </div>
  </header>
</template>

<script setup lang="ts">
import { useStore } from "@/store";

const store = useStore();
</script>

<style scoped></style>
