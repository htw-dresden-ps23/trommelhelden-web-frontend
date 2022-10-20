import { createRouter, createWebHistory } from "vue-router";

const routes = [
  {
    path: "/orders",
    component: () => import("@/views/Orders/OrderOverview.vue"),
  },
  {
    // UserProfile will be rendered inside User's <router-view>
    // when /user/:id/profile is matched
    path: "/orders/create",
    component: () => import("@/views/Orders/CreateOrder.vue"),
  },
  {
    path: "/",
    redirect: "/dashboard",
  },
  {
    path: "/dashboard",
    component: () => import("@/views/Dashboard.vue"),
  },
];

export const router = createRouter({
  history: createWebHistory(),
  routes,
});
