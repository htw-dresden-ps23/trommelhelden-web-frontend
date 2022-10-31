import { IAuftrag } from "@/types";
import { BaseService } from ".";

export default class OrderService extends BaseService<IAuftrag> {
  static tableName: string = "orders";
  constructor() {
    super(OrderService.tableName);
  }
}
