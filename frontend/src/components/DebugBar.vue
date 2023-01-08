<template>
    <div
        class=" absolute bottom-0 w-full h-14 bg-gradient-to-l from-blue-400 to-pink-600 shadow flex items-center justify-around z-10 sticky">
        <span class="text-lg font-bold text-white"> DEBUGBAR</span>



        <span class="text-lg font-bold text-white ">Ladezeit: {{ parseFloat(store.loadingTime).toFixed(2) }} ms</span>
        <span class="text-lg font-bold text-white">Berechnungsart: {{ store.settings.calcType }}</span>

    </div>
</template>

<script setup lang="ts">import { useStore } from '@/store';


const store = useStore()

</script>

<style scoped>

</style>