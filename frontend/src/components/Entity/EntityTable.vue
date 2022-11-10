<template>
  <div>
    <DataTable
      v-model:filters="filters"
      :value="values"
      selection-mode="single"
      removable-sort
      :paginator="true"
      sort-mode="multiple"
      :row-hover="true"
      is-loading="isLoading"
      class="p-datatable-sm"
      :lazy="true"
      :rows="rows"
      :total-records="values ? values.length : 0"
      filter-display="menu"
      show-gridlines
      current-page-report-template="Showing {first} to {last} of {totalRecords}"
      :rows-per-page-options="[5, 10, 20, 50]"
      responsive-layout="scroll"
      @page="onPage($event)"
      @sort="onSort($event)"
      @filter="onFilter($event)"
      @row-select="onProductSelect"
    >
      <template #header>
        <div>
          <Chip
            v-for="filter in activeFilters"
            :key="filter"
            class="mr-2"
            :label="`${filter} ${Object.keys(filterOptions[filter])[0]} ${
              columns.find((c) => c.field === filter)?.type === 'date'
                ? useDateFormat(
                  filterOptions[filter][Object.keys(filterOptions[filter])[0] as string] ,
                  'DD.MM.YYYY'
                ).value
                : filterOptions[filter][Object.keys(filterOptions[filter])[0]]
            }`"
            removable
            @remove="removeFilter(filter)"
          />
          <Chip
            v-if="Object.keys(filterOptions).length > props.showMaxActiveFilter"
            :label="`+ ${
              Object.keys(filterOptions).length - props.showMaxActiveFilter
            } more`"
          />
        </div>
      </template>
      <template #empty> No records found </template>
      <Column
        v-for="cols in columns"
        :key="cols.field"
        :field="cols.field"
        :header="cols.header"
        :show-add-button="false"
        :show-filter-operator="false"
        :data-type="cols.type"
        sortable
      >
        <template #filter="{ filterModel }">
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
            date-format="dd.mm.yy"
            :placeholder="`Search by ${cols.header}`"
          />
          <InputNumber
            v-if="cols.type != 'date' && cols.type != 'text'"
            v-model="filterModel.value"
            class="p-column-filter"
            :use-grouping="false"
            :format="false"
            :placeholder="`Search by ${cols.header}`"
          />
        </template>
        <template #body="{ data }">
          <div v-if="isLoading">
            <Skeleton />
          </div>
          <div v-else>
            <div v-if="data && cols.type === 'date'">
              {{ useDateFormat(data[cols.field], "DD.MM.YYYY").value }}
            </div>
            <div v-if="data && cols.format === 'link'">
              <router-link
                :to="`/${cols.linkRoute}/${data[cols.linkKey as string]}`"
              >
                <Chip
                  :style="`${
                    cols.color ? 'background-color:' + cols.color + ';' : ''
                  }`"
                >
                  {{ data[cols.field] }}
                </Chip>
              </router-link>
            </div>
            <div
              v-if="data && cols.format !== 'link' && cols.type !== 'date'"
              class="truncate"
            >
              {{ data ? data[cols.field] : "" }}
            </div>
          </div>
        </template>
      </Column>
      <Column
        v-if="props.allowEdit"
        field="edit"
      >
        <template #body="slotProps">
          <div v-if="isLoading">
            <Skeleton size="3rem" />
          </div>
          <div v-else>
            <Button
              type="button"
              icon="pi pi-pencil"
              class="p-button-warning"
              @click="onEditButton($event, slotProps.data)"
            />
          </div> </template
      ></Column>
    </DataTable>
  </div>
</template>
<script setup lang="ts">
import Chip from "primevue/chip";
import Calendar from "primevue/calendar";
import { computed, onMounted, PropType, ref } from "vue";
import { FilterMatchMode, FilterOperator } from "primevue/api";
import { useDateFormat } from "@vueuse/core";
import { IFilter, ISort, IEntityTableColumns } from "@/types";
import { useToast } from "primevue/usetoast";
import { convertFilterOperator } from "@/util/FilterOperator";

const isLoading = ref(false);
const page = ref(0);
const sortOptions = ref<ISort[]>([]);
const toast = useToast();
const filterOptions = ref<IFilter>({});
const filters = ref();

const emit = defineEmits(["selectRow", "editRow"]);

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
  showMaxActiveFilter: {
    type: Number,
    default: 3,
  },
  allowEdit: {
    type: Boolean,
    default: false,
  },
});

const activeFilters = computed(() => {
  return Object.keys(filterOptions.value).slice(-props.showMaxActiveFilter);
});

const values = ref(new Array(props.showRows));
const rows = ref(props.showRows);

onMounted(async () => {
  await fetchData();
  createFilters(props.columns);
});

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
    if (col.type === "date") {
      ret[col.field] = {
        operator: FilterOperator.AND,
        constraints: [{ matchMode: FilterMatchMode.DATE_IS, value: null }],
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

const removeFilter = (filterKey: string) => {
  delete filterOptions.value[filterKey];
  filters.value[filterKey].constraints[0].value = null;
  fetchData();
};

const onPage = async (event: any) => {
  page.value = event.first;
  await fetchData();
};

const onEditButton = (event: any, data: any) => {
  emit("editRow", data);
};

const onFilter = async (event: any) => {
  const { filters } = event;

  Object.keys(filters).forEach((x) => {
    console.log(filters[x].constraints[0].value);

    if (filters[x].constraints[0].value) {
      filterOptions.value[x] = {};
      if (filters[x].constraints[0].value instanceof Date) {
        filters[x].constraints[0].value.setUTCHours(0, 0, 0, 0);
      }
      filterOptions.value[x][
        convertFilterOperator(filters[x].constraints[0].matchMode)
      ] = filters[x].constraints[0].value;
    } else {
      Object.prototype.hasOwnProperty.call(filterOptions.value, x)
        ? delete filterOptions.value[x]
        : null;
    }
  });
  await fetchData();
};

const onSort = async (event: any) => {
  const { multiSortMeta } = event;
  console.log(multiSortMeta);

  sortOptions.value = [
    ...multiSortMeta.map((x: any) => {
      const foo: any = {};
      foo[x.field] = x.order > 0 ? "asc" : "desc";
      return foo;
    }),
  ];

  await fetchData();
};

const onProductSelect = (event: any) => {
  emit("selectRow", event.data);
};

const fetchData = async () => {
  try {
    isLoading.value = true;

    values.value = await props.apiService.list(
      sortOptions.value,
      filterOptions.value,
      page.value,
      rows.value,
    );
    isLoading.value = false;
  } catch (e) {
    toast.add({
      severity: "error",
      summary: "Error Fetching Data ",
      detail: e,
      life: 5000,
    });
    values.value = [];
  }
  isLoading.value = false;
};
</script>

<style scoped></style>