import { createApp } from "vue";
import App from "./App.vue";
import "./index.css";
import PrimeVue from "primevue/config";

import DataTable from "primevue/datatable";
import Column from "primevue/column";
import ColumnGroup from "primevue/columngroup"; //optional for column grouping
import Row from "primevue/row";
import "./assets/_theme.css";
import "primevue/resources/primevue.min.css";
import "primeicons/primeicons.css";
import Sidebar from "primevue/sidebar";
import Button from "primevue/button";
import PanelMenu from "primevue/panelmenu";
import Avatar from "primevue/avatar";
import AvatarGroup from "primevue/avatargroup";
import Textarea from "primevue/textarea";
import Divider from "primevue/divider";
import Calendar from "primevue/calendar";
import Chip from "primevue/chip";

import OverlayPanel from "primevue/overlaypanel";
import { router } from "./router";

const app = createApp(App);

app.component("DataTable", DataTable);
app.component("Avatar", Avatar);
app.component("AvatarGroup", AvatarGroup);
app.component("Divider", Divider);

app.component("Button", Button);

app.component("Sidebar", Sidebar);
app.component("PanelMenu", PanelMenu);

app.component("Column", Column);
app.component("ColumnGroup", ColumnGroup);
app.component("Row", Row);
app.component("Textarea", Textarea);
app.component("OverlayPanel", OverlayPanel);
app.component("Calendar ", Calendar);
app.component("Chip ", Chip);

app.use(router);
app.use(PrimeVue, { ripple: true });
app.mount("#app");
