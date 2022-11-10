import { BaseService } from ".";

export default class GenericService<T> extends BaseService<T> {
  constructor(tableName: string) {
    super(tableName);
  }
}
