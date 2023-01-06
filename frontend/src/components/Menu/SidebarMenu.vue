<template>
  <Sidebar
    v-model:visible="store.sideBarMenuIsOpen"
    class="shadow-inner"
    style="'overflow': 'scroll'"
  >
    <template #header>
      <div class="flex items-center justify-center">
        <div class="bg-gradient-to-r from-blue-500 to-pink-700 bg-clip-text text-2xl font-extrabold text-transparent">
          Trommelhelden DB
        </div>
      </div>
    </template>
    <PanelMenu
      v-model:expandedKeys="openTabs"
      class=""
      :model="menuItems"
    />
    <div class="mt-auto flex items-center justify-between border-t-2 bg-slate-50 p-4 shadow-inner">
      <div class="flex items-center">
        <Avatar
          label="A"
          class="mr-2 bg-white bg-gradient-to-r from-blue-500 to-pink-600 text-white shadow-2xl"
          size="large"
        />
        <div class="text-lg">Admin</div>
      </div>
      <router-link :to="{ name: 'Settings' }">
        <Button
          class="p-button-rounded p-button-lg p-button-text !text-slate-500"
          icon="pi pi-cog"
          @click="store.sideBarMenuIsOpen = false"
        />
      </router-link>
      <!-- USER -->
    </div>
  </Sidebar>
</template>

<script setup lang="ts">
import { useStore } from "@/store";
import { MenuItem } from "primevue/menuitem";
import PanelMenu from "primevue/panelmenu";
import { ref } from "vue";

const store = useStore();

const openTabs: any = ref({});

const onOpenTab = (key: string) => {
  openTabs.value = {};
  openTabs.value[key] = true;
  store.sideBarMenuIsOpen = false;
};

const menuItems: MenuItem[] = [
  {
    to: "/dashboard",
    label: "Dashboard",
    key: "dashboard",
    command: () => {
      store.sideBarMenuIsOpen = false;
    },
    icon: "pi pi-chart-bar",
  },

  {
    to: "/invoices",
    label: "Rechnungen",
    key: "invoices",
    command: () => {
      store.sideBarMenuIsOpen = false;
    },
    icon: "pi pi-book",
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
        to: "/masterdata/employees",
        icon: "pi pi-id-card",
      },
      {
        key: "2_1",
        label: "Kunden",
        command: () => {
          onOpenTab("masterData");
        },
        to: "/masterdata/customers",
        icon: "pi pi-user",
      },

      {
        key: "2_2",
        command: () => {
          onOpenTab("masterData");
        },
        label: "Ersatzteile",
        to: "/masterdata/spareparts",
        icon: "pi pi-tags",
      },
      {
        key: "2_2",
        command: () => {
          onOpenTab("masterData");
        },
        label: "Niederlassung",
        to: "/masterdata/branches",
        icon: "pi pi-home",
      },
    ],
  },
];
</script>

<style scoped>

</style>
