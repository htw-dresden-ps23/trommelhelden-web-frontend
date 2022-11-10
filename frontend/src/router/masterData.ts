import masterData from "@/master-data.json";

import CreateMasterdata from "@/views/MasterData/CreateMasterdata.vue";
import ListMasterdata from "@/views/MasterData/ListMasterdata.vue";
import SingleMasterdata from "@/views/MasterData/SingleMasterData.vue";

export const createMasterDataRoutes = () => {
  const ret: any = [];
  masterData.entities.forEach((entity: any) => {
    const props = {
      primaryKey: entity.primaryKey,
      resourceName: entity.resourceName,
      fields: entity.fields,
      label: entity.label,
      name: entity.name,
    };
    ret.push(
      ...[
        {
          name: entity.name,
          path: `/masterdata/${entity.resourceName}`,
          component: ListMasterdata,
          props,
        },
        {
          path: `/masterdata/${entity.resourceName}/:id`,
          component: SingleMasterdata,
          name: "Single" + entity.name,
          props,
        },
        {
          name: "Create" + entity.name,
          path: `/masterdata/${entity.resourceName}/create`,
          component: CreateMasterdata,
          props,
        },
      ],
    );
  });
  return ret;
};
