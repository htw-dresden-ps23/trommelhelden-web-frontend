import { createApp } from "vue";
import App from "./App.vue";
import "./index.css";
import PrimeVue from "primevue/config";

import DataTable from "primevue/datatable";
import Column from "primevue/column";
import ColumnGroup from "primevue/columngroup"; //optional for column grouping
import Row from "primevue/row";

import "primevue/resources/themes/saga-blue/theme.css";
import "primevue/resources/primevue.min.css";
import "primeicons/primeicons.css";

const app = createApp(App);

app.component("DataTable", DataTable);
app.component("Column", Column);
app.component("ColumnGroup", ColumnGroup);
app.component("Row", Row);

app.use(PrimeVue);
app.mount("#app");
