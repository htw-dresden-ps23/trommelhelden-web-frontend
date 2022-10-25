import { IKunde } from "@/types";
import { BaseService } from ".";

export default class CustomerService extends BaseService<IKunde> {
  static tableName: string = "customers";
  constructor() {
    super(CustomerService.tableName);
  }
}
