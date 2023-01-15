<template>
    <div class="mx-auto mt-8 flex-1">
        <div class="card flex flex-col items-stretch justify-center rounded-xl bg-white p-6 shadow-2xl">
            <h1
                class="bg-gradient-to-r from-blue-400 to-pink-800 bg-clip-text py-4 text-7xl font-extrabold text-transparent">
                Auftrag {{ order.Aufnr }}
            </h1>
            <div class="grid grid-cols-2 mt-8 gap-8">
                <div class="flex grid grid-cols-2 card rounded-xl bg-white p-6 shadow-xl">
                    <span class="text-xl font-bold"> Auftragsdatum </span><span>{{ order.AufDat }}</span>
                    <span class="text-xl font-bold"> Anfahrt </span><span>{{ order.Anfahrt }}</span>
                    <span class="text-xl font-bold"> Beschreibung </span><span>{{ order.Beschreibung }}</span>
                    <span class="text-xl font-bold"> Dauer </span><span>{{ order.Dauer }}</span>




                </div>
                <div class=" card rounded-xl bg-white p-6 shadow-xl">
                    <Timeline :value="createStatus()">
                        <template #opposite="slotProps">
                            <small class="p-text-secondary">{{ slotProps.item.date }}</small>
                        </template>
                        <template #content="slotProps">
                            {{ slotProps.item.status }}
                        </template>
                    </Timeline>
                </div>
                <div class="flex flex-col gap-y-2 col-span-2">
                    <Panel
                        v-if="order.Kunde"
                        header="Kunde"
                        :toggleable="true"
                    >
                        <div
                            v-for="kunde in Object.keys(order?.Kunde)"
                            :key="kunde"
                            class="flex justify-between"
                        >
                            <span class="">{{ kunde }}</span>
                            <span>{{ order.Kunde[kunde as keyof IKunde] }}</span>

                        </div>

                    </Panel>
                    <Panel
                        v-if="order.MitID"
                        header="Mitarbeiter"
                        :toggleable="true"
                    >
                        <div
                            v-for="mitarbeiter in Object.keys(order?.Mitarbeiter)"
                            :key="mitarbeiter"
                            class="flex justify-between"
                        >
                            <span class="">{{ mitarbeiter }}</span>
                            <span>{{ order.Mitarbeiter[mitarbeiter as keyof IMitarbeiter] }}</span>

                        </div>
                    </Panel>
                    <Panel
                        header="Ersatzteile"
                        :toggleable="true"
                    >
                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut
                            labore et dolore magna aliqua.
                            Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea
                            commodo consequat.
                            Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla
                            pariatur. Excepteur sint occaecat
                            cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
                    </Panel>




                </div>


            </div>
        </div>
    </div>
</template>

<script setup lang="ts">
import { useDateFormat } from '@vueuse/shared';
import Panel from 'primevue/panel';
import Timeline from 'primevue/timeline';
import GenericService from '@/api/services/Generic';
import { IAuftrag, IKunde, IMitarbeiter } from '@/types';
import { onMounted, ref } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import OrderService from '@/api/services/Order';



const route = useRoute()
const router = useRouter()
const order = ref<IAuftrag>({} as IAuftrag)
const orderService = new GenericService<IAuftrag>('orders')





onMounted(async () => {

    order.value = await orderService.get(route.params.id as string)

    if (order.value === null) {
        return router.push("/404")
    }

})

const createStatus = () => {
    let ret = []

    ret.push({
        status: 'Erstellt', date: useDateFormat(order.value.AufDat, 'DD.MM.YYYY').value
    })
    if (order.value.ErlDat)
        ret.push({ status: 'Erledigt', date: useDateFormat(order.value.ErlDat, 'DD.MM.YYYY').value })

    return ret

}

</script>

<style scoped>

</style>