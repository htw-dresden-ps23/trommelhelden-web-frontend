<template>
  <div class="flex max-h-full min-h-screen flex-col bg-[#ffffffe7]">
    <Header />
    <SidebarMenu />
    <div class="container m-auto my-8 flex h-full flex-1 justify-center">
      <router-view />
    </div>
    <Toast />
    <ScrollTop />
  </div>
</template>

<script setup lang="ts">
import Header from "@/components/Header.vue";
import SidebarMenu from "./components/SidebarMenu.vue";
</script>

<style>
body {
  overflow-y: scroll !important;
}

.p-sidebar-content {
  padding: 0 !important;
  margin: 0 !important;
  display: flex;
  flex-direction: column;
  height: 100%;
  box-shadow: inset 0 2px 4px 0 rgb(0 0 0 / 0.05);
}

.p-panelmenu {
  background-color: #f6f6f6;
}

.p-sidebar-header {
  justify-content: space-between !important;
}
</style>
