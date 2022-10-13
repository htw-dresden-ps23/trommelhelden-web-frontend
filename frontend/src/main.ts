import { createApp } from "vue";
import App from "./App.vue";
import "./index.css";
import PrimeVue from "primevue/config";
import VueProgressBar from "@aacassandra/vue3-progressbar";

import DataTable from "primevue/datatable";
import Column from "primevue/column";
import ColumnGroup from "primevue/columngroup"; //optional for column grouping
import Row from "primevue/row";

import "primevue/resources/themes/saga-blue/theme.css";
import "primevue/resources/primevue.min.css";
import "primeicons/primeicons.css";
import Sidebar from "primevue/sidebar";
import Button from "primevue/button";
import PanelMenu from "primevue/panelmenu";
import Avatar from "primevue/avatar";
import AvatarGroup from "primevue/avatargroup";

import { router } from "./router";

const options = {
  color: "#bffaf3",
  failedColor: "#874b4b",
  thickness: "5px",
  transition: {
    speed: "0.2s",
    opacity: "0.6s",
    termination: 300,
  },
  autoRevert: true,
  location: "top",
  inverse: false,
};

const app = createApp(App);

app.component("DataTable", DataTable);
app.component("Avatar", Avatar);
app.component("AvatarGroup", AvatarGroup);

app.component("Button", Button);

app.component("Sidebar", Sidebar);
app.component("PanelMenu", PanelMenu);

app.component("Column", Column);
app.component("ColumnGroup", ColumnGroup);
app.component("Row", Row);
app.use(VueProgressBar, options);
app.use(router);
app.use(PrimeVue);
app.mount("#app");
