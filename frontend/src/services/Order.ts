import { axiosInstance } from ".";
import { Auftrag } from "../types";

export default class OrderService {
  async list(): Promise<Auftrag[]> {
    return (await axiosInstance.get("/orders")).data;
  }
  async get(id: number): Promise<Auftrag> {
    return (await axiosInstance.get(`/orders/${String(id)}`)).data;
  }
  async create(order: Auftrag): Promise<void> {
    await axiosInstance.post("/orders", order);
  }
  async update(id: number, order: Auftrag): Promise<void> {
    await axiosInstance.patch("/orders", order);
  }
  async delete(id: number): Promise<void> {
    await axiosInstance.delete("/orders", {
      data: { id },
    });
  }
}
