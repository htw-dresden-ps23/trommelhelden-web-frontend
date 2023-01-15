<template>
    <div
        class="h-screen w-full bg-gradient-to-l from-blue-500 to-pink-700 flex justify-center items-center flex-col gap-y-12 justify-end">
        <h2
            v-if="!first"
            class="text-8xl font-semibold text-white tracking-wide hover:scale-105 !transition !duration-500"
        >
            Trommelhelden DB</h2>
        <div
            v-if="!first"
            class="animate-bounce "
        >
            <Button
                label="Start"
                class="p-button-raised  !px-12 !text-2xl  hover:scale-125 !transition !duration-500 "
                @click="first = true"
            />
        </div>

        <div
            v-show="first"
            class="rounded-xl bg-white px-16 py-8 shadow-2xl  h-3/4 w-3/4 flex flex-col gap-y-8  justify-center "
        >
            <div v-if="!isLoading">
                <h1
                    class="bg-gradient-to-r from-blue-400 to-pink-800 bg-clip-text py-4 text-6xl font-extrabold text-transparent">
                    Daten erstellen
                </h1>

                <div class="grid grid-cols-2 py-4 gap-x-12 gap-y-24">
                    <div>
                        <h5 class="font-bold text-lg mb-4">Mitarbeiter: {{ settings.employees }}</h5>
                        <div class="flex w-full">
                            <Slider
                                v-model="settings.employees"
                                :step="10"
                                :min="0"
                                :max="1000"
                                class="flex-1"
                            />
                        </div>
                    </div>
                    <div>
                        <h5 class="font-bold text-lg mb-4">Kunden: {{ settings.customers }}</h5>
                        <div class="flex w-full">
                            <Slider
                                v-model="settings.customers"
                                :step="50"
                                :min="0"
                                :max="10000"
                                class="flex-1"
                            />
                        </div>
                    </div>
                    <div>
                        <h5 class="font-bold text-lg mb-4">Niederlassungen: {{ settings.branches }}</h5>
                        <div class="flex w-full">
                            <Slider
                                v-model="settings.branches"
                                :step="5"
                                :min="0"
                                :max="100"
                                class="flex-1"
                            />
                        </div>
                    </div>
                    <div>
                        <h5 class="font-bold text-lg mb-4">Aufträge: {{ settings.orders }}</h5>
                        <div class="flex w-full">
                            <Slider
                                v-model="settings.orders"
                                :step="100"
                                :min="0"
                                :max="100000"
                                class="flex-1"
                            />
                        </div>
                    </div>
                    <div>
                        <h5 class="font-bold text-lg mb-4">Ersatzteile: {{ settings.spareparts }}</h5>
                        <div class="flex w-full">
                            <Slider
                                v-model="settings.spareparts"
                                :step="10"
                                :min="0"
                                :max="1000"
                                class="flex-1"
                            />
                        </div>
                    </div>

                </div>
                <div class="flex justify-end">
                    <Button
                        label="Start"
                        class="p-button-raised  !px-12 !text-2xl  mt-4  ml-auto w-fit"
                        @click="onButtonClick"
                    />
                </div>
            </div>
            <div
                v-else
                class="flex justify-center items-center flex-col"
            >

                <ProgressSpinner aria-label="Basic ProgressSpinner" />
                <h1
                    class="bg-gradient-to-r from-blue-400 to-pink-800 bg-clip-text py-4 text-4xl font-extrabold text-transparent">
                    Daten erstellen
                </h1>

            </div>
        </div>


    </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import ProgressSpinner from 'primevue/progressspinner';
import Slider from 'primevue/slider';
import { useStore } from '@/store';
import { useRouter } from 'vue-router';
import GenericService from '@/api/services/Generic';
import Button from 'primevue/button';

const store = useStore();
const router = useRouter()


const first = ref(false)
const isLoading = ref(false)
const startUpService = new GenericService("startup");

const onButtonClick = async () => {

    isLoading.value = true
    await startUpService._axiosInstance.post("/startUp", {
        ...settings.value
    })
    isLoading.value = false


    store.firstStartUp = false
    router.push("/")

}

const settings = ref({
    customers: 500,
    employees: 50,
    orders: 1000,
    branches: 10,
    spareparts: 200,


})


</script>

<style >
.p-slider .p-slider-range {
    background-image: linear-gradient(to right, #3b82f6, #be185d) !important;

}


@keyframes p-progress-spinner-color {

    100%,
    0% {
        stroke: #3b82f6;
    }


    90% {
        stroke: #be185d;
    }
}
</style>