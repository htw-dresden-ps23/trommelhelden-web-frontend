export const routes = [
  {
    path: "/orders",
    component: () => import("@/views/Orders/OrderOverview.vue"),
  },
  {
    // UserProfile will be rendered inside User's <router-view>
    // when /user/:id/profile is matched
    path: "/orders/create",
    name: "createOrder",
    component: () => import("@/views/Orders/CreateOrder.vue"),
  },
  {
    // UserProfile will be rendered inside User's <router-view>
    // when /user/:id/profile is matched
    path: "/orders/plan",
    component: () => import("@/views/Orders/PlanOrder.vue"),
  },
  {
    path: "/",
    redirect: "/dashboard",
  },
  {
    path: "/dashboard",
    component: () => import("@/views/Dashboard.vue"),
  },
  {
    path: "/employees",
    component: () => import("@/views/MasterData/Employees.vue"),
  },
  {
    path: "/customers",
    component: () => import("@/views/MasterData/Customers.vue"),
  },
  {
    path: "/products",
    component: () => import("@/views/MasterData/Customers.vue"),
  },
  {
    path: "/orders/complete",
    component: () => import("@/views/Orders/CompleteOrder.vue"),
  },
];
