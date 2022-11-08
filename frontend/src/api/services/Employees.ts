import { IMitarbeiter } from "@/types";
import { BaseService } from ".";

export default class EmployeesService extends BaseService<IMitarbeiter> {
  static tableName = "employees";
  constructor() {
    super(EmployeesService.tableName);
  }
}
