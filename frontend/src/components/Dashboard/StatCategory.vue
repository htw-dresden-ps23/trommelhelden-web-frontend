<template>
    <div>
        <h1
            class="bg-gradient-to-l from-blue-500 to-pink-700 bg-clip-text py-4 text-4xl font-extrabold text-transparent">
            {{ name }}
        </h1>
        <div class="grid grid-cols-4 gap-x-8">

            <StatsCard
                v-for="stat in data"
                :key="stat?.name"
                :entity="stat?.entity"
                :order-by="stat?.orderBy"
                :order-by-direction="stat?.orderByDirection"
                :chart-type="stat?.chartType"
                :name="stat?.name"
                :label="
                stat?.label"
                :label-key="stat?.labelKey"
            ></StatsCard>
        </div>



    </div>
</template>

<script setup lang="ts">
import StatsCard from "@/components/Dashboard/StatsCard.vue";

const props = defineProps<{
    name: string;
    data: any;
    startDate: string;
    endDate: string
}>();

</script>

<style scoped>

</style>