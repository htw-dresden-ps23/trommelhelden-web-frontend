import { createRouter, createWebHistory } from "vue-router";

const routes = [
  {
    path: "/order",
    component: () => import("../views/Order.vue"),
  },
  {
    path: "/",
    redirect: "/dashboard",
  },
  {
    path: "/dashboard",
    component: () => import("../views/dashboard.vue"),
  },
];

export const router = createRouter({
  history: createWebHistory(),
  routes,
});
