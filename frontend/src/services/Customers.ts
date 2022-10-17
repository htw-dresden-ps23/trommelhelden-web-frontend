import { axiosInstance } from ".";
import { Kunde } from "../types";

export default class CustomerService {
  async list(): Promise<Kunde[]> {
    return (await axiosInstance.get("/customers")).data;
  }
  async get(KunNr: number) {}
  async create(customer: Kunde) {}
  async update(KunNr: number, customer: Kunde) {}
  async delete(KunNr: number) {}
}
