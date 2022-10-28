<template>
  <div class="flex max-h-full min-h-screen flex-col bg-[#ffffffe7]">
    <header>
      <div
        class="flex h-10 items-center bg-gradient-to-r from-blue-400 to-pink-600 shadow-2xl"
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
    <Sidebar v-model:visible="menuIsOpen" class="" style="'overflow': 'scroll'">
      <template #header><div>Trommelhelden DB</div></template>
      <PanelMenu class="flex-1" :model="menuItems"> </PanelMenu>
      <div class="mt-auto">
        <Avatar label="P" class="mr-2" size="large" />
        <!-- USER -->
      </div>
    </Sidebar>
    <!-- MAIN CONTENT -->
    <div class="container m-auto h-full">
      <router-view></router-view>
    </div>

    <Toast />
    <ScrollTop />
  </div>
</template>

<script setup lang="ts">
import Editor from "primevue/editor";

// This starter template is using Vue 3 <script setup> SFCs
// Check out https://v3.vuejs.org/api/sfc-script-setup.html#sfc-script-setup
import { onMounted, ref } from "vue";
import HelloWorld from "./components/HelloWorld.vue";

const menuIsOpen = ref(false);
const menuItems = ref([
  {
    key: "0",
    to: "/dashboard",
    label: "Dashboard",
    command: () => {
      menuIsOpen.value = false;
    },
    icon: "pi pi-chart-pie",
  },
  {
    key: "1",
    label: "Auftrag",
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
        label: "Bearbeiten",
        command: () => {
          menuIsOpen.value = false;
        },
        to: "/orders/edit",
        icon: "pi pi-id-card",
      },
    ],
  },
  {
    key: "2",
    label: "Stammdaten",
    icon: "pi pi-database",
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
        to: "/customer",
        icon: "pi pi-user",
      },
      {
        key: "2_2",
        label: "Produkte",
        command: () => {
          menuIsOpen.value = false;
        },
        to: "/produkte",
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
        to: "/niederlassung",
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
}

.p-panelmenu {
  background-color: #f6f6f6;
}

.p-sidebar-header {
  justify-content: space-between !important;
}
</style>
