<template>
  <div>
    <DataTable
      :value="data"
      selectionMode="single"
      :paginator="true"
      :rowHover="true"
      isLoading="isLoading"
      class="p-datatable-sm"
      @page="onPage($event)"
      @sort="onSort($event)"
      @filter="onFilter($event)"
      :lazy="true"
      :rows="rows"
      :totalRecords="data ? data.length : 0"
      filterDisplay="menu"
      @rowSelect="onProductSelect"
      showGridlines
      currentPageReportTemplate="Showing {first} to {last} of {totalRecords}"
      :rowsPerPageOptions="[5, 10, 20, 50]"
      v-model:filters="filters"
      responsiveLayout="scroll"
    >
      <template #empty> No records found </template>
      <Column
        v-for="cols in columns"
        :field="cols.field"
        :header="cols.header"
        :showAddButton="false"
        :showFilterOperator="false"
        :dataType="cols.type"
        sortable
        ><template #filter="{ filterModel }">
          <InputText
            v-if="cols.type === 'text'"
            v-model="filterModel.value"
            class="p-column-filter"
            :placeholder="`Search by s${cols.header}`"
          />
          <Calendar
            v-if="cols.type === 'date'"
            v-model="filterModel.value"
            class="p-column-filter"
            :placeholder="`Search by ${cols.header}`"
          />
          <InputNumber
            v-model="filterModel.value"
            class="p-column-filter"
            :useGrouping="false"
            :format="false"
            :placeholder="`Search by ${cols.header}`"
            v-if="cols.type != 'date' && cols.type != 'text'"
          ></InputNumber>
        </template>
        <template #body="{ data }">
          <div v-if="isLoading"><Skeleton></Skeleton></div>
          <div v-else>
            <div v-if="data && cols.type === 'date'">
              {{ useDateFormat(data[cols.field], "DD.MM.YYYY").value }}
            </div>
            <div v-if="data && cols.format === 'link'">
              <router-link
                :to="`/${cols.linkRoute}/${data[cols.linkKey as string]}`"
                ><Chip
                  :style="`${
                    cols.color ? 'background-color:' + cols.color + ';' : ''
                  }`"
                >
                  {{ data[cols.field] }}
                </Chip></router-link
              >
            </div>
            <div v-if="data && cols.format !== 'link' && cols.type !== 'date'">
              {{ data ? data[cols.field] : "" }}
            </div>
          </div>
        </template>
      </Column>
    </DataTable>
  </div>
</template>
<script setup lang="ts">
import Chip from "primevue/chip";
import Calendar from "primevue/calendar";
import { onMounted, PropType, ref } from "vue";
import { FilterMatchMode, FilterOperator } from "primevue/api";
import { useDateFormat } from "@vueuse/core";
import { IFilter, ISort, IEntityTableColumns } from "@/types";
import { useToast } from "primevue/usetoast";

const isLoading = ref(false);

const page = ref(0);
const sortOptions = ref<ISort>({});
const toast = useToast();
const filterOptions = ref<IFilter>({});
const filters = ref();

const emit = defineEmits(["selectRow"]);
const props = defineProps({
  columns: {
    type: Object as PropType<IEntityTableColumns[]>,
    required: true,
  },
  apiService: {
    type: Object,
    required: true,
  },
  showRows: {
    type: Number,
    default: 20,
  },
});

const data = ref(new Array(props.showRows));
const rows = ref(props.showRows);

const createFilters = (columns: any) => {
  const ret: any = {};

  columns.forEach((col: any) => {
    if (col.type === "text") {
      ret[col.field] = {
        operator: FilterOperator.AND,
        constraints: [{ matchMode: FilterMatchMode.CONTAINS, value: null }],
      };
    }
    if (col.type === "numeric") {
      ret[col.field] = {
        operator: FilterOperator.AND,
        constraints: [{ matchMode: FilterMatchMode.EQUALS, value: null }],
      };
    }

    if (!Object.hasOwn(col, "type")) {
      ret[col.field] = {
        operator: FilterOperator.AND,
        constraints: [{ matchMode: FilterMatchMode.CONTAINS, value: null }],
      };
    }
  });

  filters.value = ret;
};

onMounted(async () => {
  await fetchData();
  createFilters(props.columns);
});

const onPage = async (event: any) => {
  page.value = event.first;
  await fetchData();
};

const onFilter = async (event: any) => {
  const { filters } = event;
  Object.keys(filters).forEach((x) => {
    if (filters[x].constraints[0].value) {
      filterOptions.value[x] = {
        value: filters[x].constraints[0].value,
        matchMode: filters[x].constraints[0].matchMode,
      };
    } else {
      filterOptions.value.hasOwnProperty(x)
        ? delete filterOptions.value[x]
        : null;
    }
  });
  await fetchData();
};

const onSort = async (event: any) => {
  const { sortField, sortOrder } = event;
  if (sortField) {
    sortOptions.value[sortField] = sortOrder === 1 ? "asc" : "desc";
  } else {
    sortOptions.value = {};
  }
  await fetchData();
};

const fetchData = async () => {
  try {
    isLoading.value = true;

    data.value = await props.apiService.list(
      sortOptions.value,
      filterOptions.value,
      page.value,
      rows.value
    );
    isLoading.value = false;
  } catch (e) {
    console.log(e);

    toast.add({
      severity: "error",
      summary: "Error Fetching Data ",
      detail: e,
      life: 5000,
    });
    data.value = [];
  }
  isLoading.value = false;
};

const onProductSelect = (event: any) => {
  emit("selectRow", event.data);
};
</script>

<style scoped></style>
