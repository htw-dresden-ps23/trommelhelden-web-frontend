import axios from "axios";

export const getEmployees = async () => {
  return axios.get("http://localhost:5000/tables/employees");
};

export const listOrders = async () => {
  return axios.get("http://localhost:5000/tables/orders");
};

export const getAssignments = async () => {
  return axios.get("http://localhost:5000/tables/assignments");
};

export const getCustomers = async () => {
  return axios.get("http://localhost:5000/tables/customers");
};

export const getSalesData = async () => {
  return axios.get("http://localhost:5000/tables/salesdata");
};
