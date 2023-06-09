import { useStore } from "@/store";
import axios, { AxiosInstance } from "axios";

export default class BusinessDataService {
  entity: string;
  axios: AxiosInstance;
  constructor(entity: string) {
    this.entity = entity;
    this.axios = axios.create({
      baseURL: `http://localhost:5001/business-data/sales`,
    });
  }
  getStats = async (
    startDate: Date,
    endDate: Date,
    orderBy: string,
    orderByDirection: "desc" | "asc",
  ) => {
    const store = useStore();
    const ret = (
      await this.axios.post(`/${this.entity}`, {
        startDate,
        endDate,
        orderBy,
        orderByDirection,
        calcType: store.settings.calcType,
      })
    ).data;
    if (store.firstLoadingTimeStamp === 0) {
      store.firstLoadingTimeStamp = new Date().getTime();
    } else {
      store.lastLoadingTimeStamp = new Date().getTime();
    }
    return ret;
  };
}
