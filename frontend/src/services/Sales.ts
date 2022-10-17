import { Kunde } from "../types";

export default class SalesDataService {
  async list() {}
  async get(KunNr: number) {}
  async create(customer: Kunde) {}
  async update(KunNr: number, order: Kunde) {}
  async delete(KunNr: number) {}
}
