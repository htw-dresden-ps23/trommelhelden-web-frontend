<template>
  <div class="flex max-h-full min-h-screen flex-col bg-[#ffffffe7]">
    <!-- HEADER -->
    <header class="sticky top-0 z-[1000]">
      <div
        class="flex h-10 items-center bg-gradient-to-r from-blue-400 to-pink-600 shadow"
      >
        <div class="m-4 mr-auto flex">
          <Button
            @click="menuIsOpen = !menuIsOpen"
            icon="pi pi-align-justify"
            iconClass="text-[#f6f6f6]"
            class="p-button-rounded p-button-text p-button-plain"
          ></Button>
        </div>
      </div>
    </header>
    <!-- SIDEMENU -->
    <Sidebar
      v-model:visible="menuIsOpen"
      class="shadow-inner"
      style="'overflow': 'scroll'"
    >
      <template #header>
        <div class="flex items-center justify-center">
          <div
            class="bg-gradient-to-r from-blue-500 to-pink-700 bg-clip-text text-2xl font-extrabold text-transparent"
          >
            Trommelhelden DB
          </div>
        </div>
      </template>
      <PanelMenu class="" :model="menuItems"> </PanelMenu>
      <div
        class="mt-auto flex items-center justify-between border-t-2 bg-slate-50 p-4 shadow-xl shadow-inner"
      >
        <div class="flex items-center">
          <Avatar
            label="A"
            class="mr-2 bg-white bg-gradient-to-r from-blue-500 to-pink-600 text-white shadow-2xl"
            size="large"
          />
          <div class="text-lg">Admin</div>
        </div>
        <Button
          class="p-button-rounded p-button-lg p-button-text !text-slate-500"
          icon="pi pi-cog"
        />
        <!-- USER -->
      </div>
    </Sidebar>
    <!-- MAIN CONTENT -->
    <div class="container m-auto my-8 h-full">
      <router-view></router-view>
    </div>

    <Toast />
    <ScrollTop />
  </div>
</template>

<script setup lang="ts">
import { ref } from "vue";
import PanelMenu from "primevue/panelmenu";

const menuIsOpen = ref(false);
const menuItems = ref([
  {
    to: "/dashboard",
    label: "Dashboard",
    command: () => {
      menuIsOpen.value = false;
    },
    icon: "pi pi-chart-pie",
  },
  {
    label: "Auftrag",
    key: "order",
    icon: "pi pi-fw pi-pencil",
    items: [
      {
        key: "2_0",
        label: "Übersicht",
        command: () => {
          menuIsOpen.value = false;
        },
        to: "/orders",
        icon: "pi pi-id-card",
      },
      {
        key: "2_0",
        label: "Erstellen",
        command: () => {
          menuIsOpen.value = false;
        },
        to: "/orders/create",
        icon: "pi pi-id-card",
      },
      {
        key: "2_0",
        label: "Planen",
        command: () => {
          menuIsOpen.value = false;
        },
        to: "/orders/plan",
        icon: "pi pi-id-card",
      },
      {
        key: "2_0",
        label: "Erledigen",
        command: () => {
          menuIsOpen.value = false;
        },
        to: "/orders/complete",
        icon: "pi pi-id-card",
      },
    ],
  },
  {
    label: "Stammdaten",
    icon: "pi pi-database",
    key: "masterData",
    items: [
      {
        key: "2_0",
        label: "Mitarbeiter",
        command: () => {
          menuIsOpen.value = false;
        },
        to: "/employees",
        icon: "pi pi-id-card",
      },
      {
        key: "2_1",
        label: "Kunden",
        command: () => {
          menuIsOpen.value = false;
        },
        to: "/customers",
        icon: "pi pi-user",
      },
      {
        key: "2_2",
        label: "Produkte",
        command: () => {
          menuIsOpen.value = false;
        },
        to: "/products",
        icon: "pi pi-tags",
      },
      {
        key: "2_2",
        command: () => {
          menuIsOpen.value = false;
        },
        label: "Ersatzteile",
        to: "/spareparts",
        icon: "pi pi-tag",
      },
      {
        key: "2_2",
        command: () => {
          menuIsOpen.value = false;
        },
        label: "Niederlassung",
        to: "/branch",
        icon: "pi pi-home",
      },
    ],
  },
]);
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
