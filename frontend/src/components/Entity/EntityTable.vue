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
      class="p-datatable-sm p-datatable-customers"
      :lazy="true"
      :rows="rows"
      :total-records="totalCount"
      filter-display="menu"
      paginator-template="FirstPageLink PrevPageLink PageLinks NextPageLink LastPageLink CurrentPageReport RowsPerPageDropdown"
      :rows-per-page-options="[5, 10, 25, 50]"
      current-page-report-template="Showing {first} to {last} of {totalRecords} entries"
      responsive-layout="scroll"
      @page="onPage($event)"
      @sort="onSort($event)"
      @filter="onFilter($event)"
      @rowSelect="onRowSelect($event)"
    >
      <template
        v-if="activeFilters.length"
        #header
      >
        <div>
          <Chip
            v-for="filter in activeFilters"
            :key="filter"
            class="mr-2"
            :label="`${filter} ${Object.keys(filterOptions[filter])[0]} ${columns.find((c) => c.name === filter)?.type === 'date'
            ? useDateFormat(
              filterOptions[filter][Object.keys(filterOptions[filter])[0] as string],
              'DD.MM.YYYY'
            ).value
            : filterOptions[filter][Object.keys(filterOptions[filter])[0]]
            }`"
            removable
            @remove="removeFilter(filter)"
          />
          <Chip
            v-if="Object.keys(filterOptions).length > props.showMaxActiveFilter"
            :label="`+ ${Object.keys(filterOptions).length - props.showMaxActiveFilter
            } more`"
          />
        </div>
      </template>
      <template #empty> No records found </template>
      <Column
        v-for="cols in props.columns"
        :key="cols.name"
        :field="cols.name"
        :header="cols.label"
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
            :placeholder="`Search by s${cols.label}`"
          />
          <Calendar
            v-if="cols.type === 'date'"
            v-model="filterModel.value"
            class="p-column-filter"
            date-format="dd.mm.yy"
            :placeholder="`Search by ${cols.label}`"
          />
          <InputNumber
            v-if="cols.type != 'date' && cols.type != 'text'"
            v-model="filterModel.value"
            class="p-column-filter"
            :use-grouping="false"
            :format="false"
            :placeholder="`Search by ${cols.label}`"
          />
        </template>
        <template #body="{ data }">
          <div v-if="isLoading">
            <Skeleton />
          </div>
          <div v-else-if="!isLoading && data">
            <div v-if="cols.type === 'date'">
              {{
  data && data[cols.name]
  ? useDateFormat(data[cols.name], "DD.MM.YYYY", {
    locales: "de-DE",
  }).value
  : ""
              }}
            </div>
            <div v-if="cols.type === 'money'">{{ data[cols.name] }} €</div>
            <div v-if="cols.type === 'numeric'">
              {{ data[cols.name] }}
            </div>
            <div v-if="cols.type === 'relation'">
              <RouterLink :to="`/${cols.relation?.resourceName}/${data[cols.relation?.primaryKey as string]}`">
                <Chip>{{ data[cols.name] }}</Chip>
              </RouterLink>
            </div>
            <div
              v-if="cols.type === 'text'"
              class="truncate"
            >
              {{ data[cols.name] }}
            </div>
          </div>
        </template>
      </Column>
      <Column
        v-if="props.allowEdit || props.allowDelete"
        field="edit"
      >
        <template #body="slotProps">
          <div
            v-if="isLoading"
            class="flex justify-around gap-x-4"
          >
            <Skeleton size="3rem" />
            <Skeleton size="3rem" />
          </div>
          <div
            v-else
            class="flex justify-around gap-x-4"
          >
            <Button
              v-if="props.allowEdit"
              type="button"
              icon="pi pi-pencil"
              class="p-button-warning"
              @click="onEditButton($event, slotProps.data)"
            />
            <Button
              v-if="props.allowDelete"
              type="button"
              icon="pi pi-trash"
              class="p-button-danger"
              @click="onDelete($event, slotProps.data)"
            />
          </div>
        </template>
      </Column>
    </DataTable>
    <ConfirmDialog></ConfirmDialog>
  </div>
</template>
<script setup lang="ts">
import ConfirmDialog from "primevue/confirmdialog";

import Chip from "primevue/chip";
import Calendar from "primevue/calendar";
import { computed, onMounted, PropType, ref } from "vue";
import { FilterMatchMode, FilterOperator } from "primevue/api";
import { useDateFormat } from "@vueuse/core";
import { IFilter, ISort, TGenericService, IMasterDataField } from "@/types";
import { useToast } from "primevue/usetoast";
import { convertFilterOperator } from "@/util/FilterOperator";
import GenericService from "@/api/services/Generic";
import Button from "primevue/button";
import Column from "primevue/column";
import DataTable from "primevue/datatable";
import InputNumber from "primevue/inputnumber";
import InputText from "primevue/inputtext";
import Skeleton from "primevue/skeleton";
import { router } from "@/router";
import { flatten } from "flat";
import { useConfirm } from "primevue/useconfirm";

const confirm = useConfirm();
const totalCount = ref(0);
const isLoading = ref(false);
const page = ref(0);
const sortOptions = ref<ISort[]>([]);
const toast = useToast();
const filterOptions = ref<IFilter>({});
const filters = ref();

const emit = defineEmits(["editRow", "onRowSelect"]);

const onRowSelect = (event: any) => {
  emit("onRowSelect", event.data);
};

const props = defineProps({
  columns: {
    type: Object as PropType<IMasterDataField[]>,
    required: true,
  },
  resourceName: {
    type: String,
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
  allowDelete: {
    type: Boolean,
    default: false,
  },
  primaryKey: {
    type: String,
    required: true,
  },
  name: {
    type: String,
    required: true,
  },
  optParams: {
    type: Object,
    required: false,
    default: null,
  },
  emitEditOnly: {
    type: Boolean,
    required: false,
    default: false,
  },
});

const service = new GenericService<TGenericService>(
  props.resourceName as string,
);

const values = ref(new Array(props.showRows));
const rows = ref(props.showRows);

const activeFilters = computed(() => {
  return Object.keys(filterOptions.value).slice(-props.showMaxActiveFilter);
});

onMounted(async () => {
  await fetchData(true);
  createFilters(props.columns);
});

const createFilters = (columns: any) => {
  const ret: any = {};

  columns.forEach((col: any) => {
    if (col.type === "text") {
      ret[col.name] = {
        operator: FilterOperator.AND,
        constraints: [{ matchMode: FilterMatchMode.CONTAINS, value: null }],
      };
    }
    if (col.type === "numeric") {
      ret[col.name] = {
        operator: FilterOperator.AND,
        constraints: [{ matchMode: FilterMatchMode.EQUALS, value: null }],
      };
    }
    if (col.type === "date") {
      ret[col.name] = {
        operator: FilterOperator.AND,
        constraints: [{ matchMode: FilterMatchMode.DATE_IS, value: null }],
      };
    }

    if (!Object.hasOwn(col, "type")) {
      ret[col.name] = {
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
  fetchData(true);
};

const onPage = async (event: any) => {
  page.value = event.first;
  await fetchData(false);
};

const onEditButton = (event: any, data: any) => {
  if (props.emitEditOnly) {
    return emit("editRow", data);
  }
  console.log(data);
  console.log(props.primaryKey);
  router.push({
    name: "Single" + props.name,
    params: { id: data[props.primaryKey] },
  });
};

const onDelete = async ($event: Event, data: any) => {
  confirm.require({
    message: `Are you sure you want to delete the item?`,
    header: "Confirmation",
    icon: "pi pi-exclamation-triangle",
    accept: async () => {
      await service.delete(data[props.primaryKey]);
      await fetchData(true);
      toast.add({
        severity: "success",
        summary: "Success",
        detail: `Data deleted successfully Value with ${props.primaryKey}: ${data[props.primaryKey]
          }`,
        life: 3000,
      });
    },
  });
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
  await fetchData(false);
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

  await fetchData(false);
};



const fetchData = async (isInitial: boolean) => {
  try {
    isLoading.value = true;
    if (isInitial) {
      const { data, count } = await service.listAndCount(
        sortOptions.value,
        filterOptions.value,
        page.value,
        rows.value,
        props.optParams,
      );
      values.value = data.map((x) => flatten(x));
      totalCount.value = count;
    } else {
      values.value = (
        await service.list(
          sortOptions.value,
          filterOptions.value,
          page.value,
          rows.value,
          props.optParams,
        )
      ).map((x) => flatten(x));
    }

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

<style scoped>

</style>
