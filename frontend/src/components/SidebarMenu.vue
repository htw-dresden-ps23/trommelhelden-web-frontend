<template>
  <Sidebar
    v-model:visible="store.sideBarMenuIsOpen"
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
    <PanelMenu class="" v-model:expandedKeys="openTabs" :model="menuItems">
    </PanelMenu>
    <div
      class="mt-auto flex items-center justify-between border-t-2 bg-slate-50 p-4 shadow-inner"
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
</template>

<script setup lang="ts">
import { useStore } from "@/store";
import PanelMenu from "primevue/panelmenu";
import { ref, watch } from "vue";

const store = useStore();

const openTabs: any = ref({});

const onOpenTab = (key: string) => {
  openTabs.value = {};
  openTabs.value[key] = true;
  store.sideBarMenuIsOpen = false;
};

const menuItems = ref([
  {
    to: "/dashboard",
    label: "Dashboard",
    key: "dashboard",
    command: () => {
      store.sideBarMenuIsOpen = false;
    },
    icon: "pi pi-chart-pie",
  },

  {
    label: "Auftrag",
    icon: "pi pi-fw pi-pencil",
    key: "order",
    items: [
      {
        key: "2_0",
        label: "Übersicht",
        command: () => {
          onOpenTab("order");
        },
        to: "/orders",
        icon: "pi pi-id-card",
      },
      {
        key: "2_0",
        label: "Erstellen",
        command: () => {
          onOpenTab("order");
        },
        to: "/orders/create",
        icon: "pi pi-id-card",
      },
      {
        key: "2_0",
        label: "Planen",
        command: () => {
          onOpenTab("order");
        },
        to: "/orders/plan",
        icon: "pi pi-id-card",
      },
      {
        key: "2_0",
        label: "Erledigen",
        command: () => {
          onOpenTab("order");
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
          onOpenTab("masterData");
        },
        to: "/employees",
        icon: "pi pi-id-card",
      },
      {
        key: "2_1",
        label: "Kunden",
        command: () => {
          onOpenTab("masterData");
        },
        to: "/customers",
        icon: "pi pi-user",
      },
      {
        key: "2_2",
        label: "Produkte",
        command: () => {
          onOpenTab("masterData");
        },
        to: "/products",
        icon: "pi pi-tags",
      },
      {
        key: "2_2",
        command: () => {
          onOpenTab("masterData");
        },
        label: "Ersatzteile",
        to: "/spareparts",
        icon: "pi pi-tag",
      },
      {
        key: "2_2",
        command: () => {
          onOpenTab("masterData");
        },
        label: "Niederlassung",
        to: "/branch",
        icon: "pi pi-home",
      },
    ],
  },
]);
</script>

<style scoped></style>
