import { IUmsatzdaten } from "@/types";
import { BaseService } from ".";

export default class SalesService extends BaseService<IUmsatzdaten> {
  static tableName = "sales";
  constructor() {
    super(SalesService.tableName);
  }

  //CUSTOM FUNCTIONS:
  /*

  getAggregatedData(){
    return this._axiosInstance.get(`/${this._tableName}/aggregated`);
  }

  */
}
