import { IRechnung } from "@/types";
import { BaseService } from ".";

export default class InvoiceService extends BaseService<IRechnung> {
  static tableName = "invoices";
  constructor() {
    super(InvoiceService.tableName);
  }
  async getInvoice(AufNr: string, KunNr: string): Promise<IRechnung> {
    return (
      await this._axiosInstance.get(`${InvoiceService.tableName}`, {
        params: {
          AufNr,
          KunNr,
        },
      })
    ).data;
  }
}
