import GenericService from "@/api/services/Generic";
import { defineStore } from "pinia";

// You can name the return value of `defineStore()` anything you want,
// but it's best to use the name of the store and surround it with `use`
// and `Store` (e.g. `useUserStore`, `useCartStore`, `useProductStore`)
const settingsService = new GenericService("settings");

// the first argument is a unique id of the store across your application
export const useStore = defineStore("main", {
  state: () => ({ sideBarMenuIsOpen: false, settings: {} as any }),
  actions: {
    async startUp() {
      this.settings = (
        await settingsService._axiosInstance.post("/settings")
      ).data;
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
