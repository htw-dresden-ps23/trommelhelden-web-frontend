import { Mitarbeiter } from "../types";

export default class EmployeeService {
  async list() {}
  async get(MitID: number) {}
  async create(employee: Mitarbeiter) {}
  async update(MitID: number, employee: Mitarbeiter) {}
  async delete(MitID: number) {}
}
