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
  //Timeout
  //------------------------------------------------------------------
  {
    path: "/timeout",
    component: () => import("@/views/Timeout.vue"),
  },
  //------------------------------------------------------------------
  //404
  //------------------------------------------------------------------
  {
    path: "/404",
    name: "404",
    component: () => import("@/views/404.vue"),
  },
  //------------------------------------------------------------------
  //Masterdata
  //------------------------------------------------------------------

  // {
  //   path: "/masterdata/:entity/:id?",
  //   component: () => import("@/views/MasterData.vue"),
  // },
];
