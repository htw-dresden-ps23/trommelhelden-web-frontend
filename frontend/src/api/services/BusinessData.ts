import axios, { AxiosInstance } from "axios";

export default class BusinessDataService {
  entity: string;
  axios: AxiosInstance;
  constructor(entity: string) {
    this.entity = entity;
    this.axios = axios.create({
      baseURL: `http://localhost:5000/business-data/sales`,
    });
  }
  getStats = async (
    startDate: string,
    endDate: string,
    orderBy: string,
    orderByDirection: "desc" | "asc",
  ) => {
    return (
      await this.axios.post(`/${this.entity}`, {
        startDate,
        endDate,
        orderBy,
        orderByDirection,
        calcType: "database",
      })
    ).data;
  };
}
