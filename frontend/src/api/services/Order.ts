import { IAuftrag } from "@/types";
import { BaseService } from ".";

export default class OrderService extends BaseService<IAuftrag> {
  static tableName = "orders";
  constructor() {
    super(OrderService.tableName);
  }
  async getOrder(AufNr: string, KunNr: string): Promise<IAuftrag> {
    return (
      await this._axiosInstance.get(`${OrderService.tableName}`, {
        params: {
          AufNr,
          KunNr,
        },
      })
    ).data;
  }
}
