<template>
  <header>
    <div class="flex h-10 items-center bg-[#3A3A3A]">
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
  <Sidebar v-model:visible="menuIsOpen" class="">
    <template #header><h4>Trommelhelden DB</h4></template>
    <PanelMenu class="flex-1" :model="menuItems"></PanelMenu>
    <div class="mt-auto">
      <Avatar label="P" class="mr-2" size="large" />
      <!-- USER -->
    </div>
  </Sidebar>
  <vue-progress-bar></vue-progress-bar>
  <router-view></router-view>
</template>

<script setup lang="ts">
import Editor from "primevue/editor";

// This starter template is using Vue 3 <script setup> SFCs
// Check out https://v3.vuejs.org/api/sfc-script-setup.html#sfc-script-setup
import { onMounted, ref } from "vue";
import HelloWorld from "./components/HelloWorld.vue";
import { getEmployees } from "./services/db";

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
    to: "/order",
    label: "Auftrag",
    command: () => {
      menuIsOpen.value = false;
    },
    icon: "pi pi-fw pi-pencil",
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

// const data = await getEmployees();
const values = ref();
onMounted(async () => {
  const { data } = await getEmployees();
  values.value = data;
});
</script>

<style>
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
