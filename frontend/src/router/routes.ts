export const routes = [
  // ----------------------------------------------------------------
  // ORDERS
  // ----------------------------------------------------------------
  {
    path: "/orders",
    component: () => import("@/views/Orders/OrderOverview.vue"),
  },
  {
    path: "/orders/create",
    name: "createOrder",
    component: () => import("@/views/Orders/CreateOrder.vue"),
  },
  {
    path: "/orders/complete",
    component: () => import("@/views/Orders/CompleteOrder.vue"),
  },
  {
    path: "/orders/plan",
    component: () => import("@/views/Orders/PlanOrder.vue"),
  },
  {
    path: "/order/:id",
    component: () => import("@/views/Orders/CompleteOrder.vue"),
  },
  //------------------------------------------------------------------
  //Employees
  //------------------------------------------------------------------
  {
    path: "/employees",
    component: () => import("@/views/MasterData/Employees.vue"),
  },
  {
    path: "/employees/:id",
    component: () => import("@/views/MasterData/Employees.vue"),
  },
  //------------------------------------------------------------------
  //Customers
  //------------------------------------------------------------------
  {
    path: "/customers",
    component: () => import("@/views/MasterData/Customers.vue"),
  },
  {
    path: "/customers/:id",
    component: () => import("@/views/MasterData/Customers.vue"),
  },
  //------------------------------------------------------------------
  //Dashboard
  //------------------------------------------------------------------
  {
    path: "/",
    redirect: "/dashboard",
  },
  {
    path: "/dashboard",
    component: () => import("@/views/Dashboard.vue"),
  },
  //------------------------------------------------------------------
  //Products
  //------------------------------------------------------------------
  {
    path: "/timeout",
    component: () => import("@/views/Timeout.vue"),
  },
  //------------------------------------------------------------------
  //Products
  //------------------------------------------------------------------
];
