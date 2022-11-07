import { AxiosError } from "axios";
import { router } from "@/router";
export const timeOutErrorHandler = (error: AxiosError) => {
  if (error.code === "ERR_NETWORK") {
    router.push("/timeout");
    return Promise.reject(error);
  }

  return Promise.reject(error);
};
