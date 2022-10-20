import { axiosInstance } from ".";
import { Kunde } from "../types";

export default class CustomerService {
  async list(
    sort: any,
    filter: any,
    page: any = 0,
    rows: any = 5
  ): Promise<Kunde[]> {
    return (
      await axiosInstance.post("/customers", {
        sort,
        filter,
        page,
        rows,
      })
    ).data;
  }
  async get(KunNr: number) {}
  async create(customer: Kunde) {}
  async update(KunNr: number, customer: Kunde) {}
  async delete(KunNr: number) {}
}
