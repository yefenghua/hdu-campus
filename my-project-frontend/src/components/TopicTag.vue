<script setup>
import {useStore} from "@/store";

const store=useStore()

defineProps({
    type:Number
})
</script>

<template>
    <div class="topic-type" :style="{
        color: store.findTypeByID(type)?.color+'EE',
        borderColor: store.findTypeByID(type)?.color+'77',
        backgroundColor: store.findTypeByID(type)?.color+'30',
        }">
        {{ store.findTypeByID(type)?.name }}
    </div>
</template>

<style scoped>
.topic-type{
    display: inline-block;
    border: solid 0.5px grey;
    border-radius: 5px;
    font-size: 12px;
    padding: 0 5px;
    height: 18px;
    translate: 0 -1px;
}
</style>