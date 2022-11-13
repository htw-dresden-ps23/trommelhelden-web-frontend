import { createPinia } from "pinia";
import PrimeVue from "primevue/config";
import { createApp } from "vue";
import App from "./App.vue";
import "./index.css";

import Column from "primevue/column";
import ColumnGroup from "primevue/columngroup"; //optional for column grouping
import ConfirmationService from "primevue/confirmationservice";
import DataTable from "primevue/datatable";
import Row from "primevue/row";
// import "./assets/_theme.css";

import "primevue/resources/primevue.min.css";
import "primevue/resources/themes/tailwind-light/theme.css";

import "primeicons/primeicons.css";
import Avatar from "primevue/avatar";
import Dropdown from "primevue/dropdown";

import AvatarGroup from "primevue/avatargroup";
import Button from "primevue/button";
import Calendar from "primevue/calendar";
import Card from "primevue/card";
import Chip from "primevue/chip";
import Divider from "primevue/divider";
import DynamicDialog from "primevue/dynamicdialog";
import InputNumber from "primevue/inputnumber";
import InputText from "primevue/inputtext";
import PanelMenu from "primevue/panelmenu";
import ScrollTop from "primevue/scrolltop";
import Sidebar from "primevue/sidebar";
import Skeleton from "primevue/skeleton";
import Textarea from "primevue/textarea";
import Toast from "primevue/toast";
import ToastService from "primevue/toastservice";

import DialogService from "primevue/dialogservice";
import OverlayPanel from "primevue/overlaypanel";
import { router } from "./router";

console.log(router.getRoutes());

const app = createApp(App);
const pinia = createPinia();

app.use(pinia);
app.component("DataTable", DataTable);
app.component("Avatar", Avatar);
app.component("AvatarGroup", AvatarGroup);
app.component("Divider", Divider);
app.component("ScrollTop", ScrollTop);
app.component("Skeleton", Skeleton);
app.component("Dropdown", Dropdown);
app.component("Button", Button);
app.component("Sidebar", Sidebar);
app.component("PanelMenu", PanelMenu);
app.component("InputText", InputText);
app.component("InputNumber", InputNumber);
app.component("DynamicDialog", DynamicDialog);
app.component("Toast", Toast);
app.component("Card", Card);

app.component("Column", Column);
app.component("ColumnGroup", ColumnGroup);
app.component("Row", Row);
app.component("Textarea", Textarea);
app.component("OverlayPanel", OverlayPanel);
app.component("Calendar ", Calendar);
app.component("Chip ", Chip);

app.use(ConfirmationService);
app.use(router);
app.use(PrimeVue, { ripple: true });
app.use(DialogService);
app.use(ToastService);
app.mount("#app");
