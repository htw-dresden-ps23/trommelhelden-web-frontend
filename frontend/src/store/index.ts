import GenericService from "@/api/services/Generic";
import { calculateOrderStats } from "@/api/webworker/business-data";
import { defineStore } from "pinia";

// You can name the return value of `defineStore()` anything you want,
// but it's best to use the name of the store and surround it with `use`
// and `Store` (e.g. `useUserStore`, `useCartStore`, `useProductStore`)
const settingsService = new GenericService("settings");

// the first argument is a unique id of the store across your application
export const useStore = defineStore("main", {
  state: () => ({
    firstStartUp: false,
    showHeader: true,
    sideBarMenuIsOpen: false,
    settings: {
      useTrigger: null,
      calcType: "database",
    } as any,
    showDebugBar: false,
    firstLoadingTimeStamp: 0,
    lastLoadingTimeStamp: 0,
  }),
  getters: {
    getDashboardTimeSeconds(): any {
      return this.lastLoadingTimeStamp - this.firstLoadingTimeStamp;
    },
  },
  actions: {
    async startUp() {
      const { workerFn } = calculateOrderStats;
      console.time("Execution Time");
      const fet = await workerFn();
      console.timeEnd("Execution Time");
      this.firstStartUp = (
        await settingsService._axiosInstance.get("/startUp")
      ).data.isStartUp;

      this.settings = (
        await settingsService._axiosInstance.post("/settings")
      ).data;
      this.settings.calcType = "database";
    },
    async updateSettings(key: string, value: any) {
      const foo = {} as any;

      foo[key] = value;

      await settingsService._axiosInstance.patch("/settings", {
        ...foo,
      });
      this.settings[key] = value;
    },
  },
});
