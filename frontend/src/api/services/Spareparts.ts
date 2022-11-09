import { IErsatzteil } from "@/types";
import { BaseService } from ".";

export default class SparepartsService extends BaseService<IErsatzteil> {
  static tableName = "spareparts";
  constructor() {
    super(SparepartsService.tableName);
  }
}
