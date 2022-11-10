import { createMasterDataRoutes } from "@/router/masterData";
import { createRouter, createWebHistory } from "vue-router";
import { routes } from "./routes";

export const router = createRouter({
  history: createWebHistory(),
  routes: [...routes, ...createMasterDataRoutes()],
});
