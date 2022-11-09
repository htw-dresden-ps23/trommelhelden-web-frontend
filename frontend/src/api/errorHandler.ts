import { router } from "@/router";
import { AxiosError } from "axios";
export const timeOutErrorHandler = (error: AxiosError) => {
  console.log(error);

  if (error.code === "ERR_NETWORK") {
    router.push("/timeout");
    return Promise.reject(error);
  }
  if (error.response?.status === 404) {
    // router.push("/404");
    return Promise.reject(error);
  }

  return Promise.reject(error);
};
