<script setup lang="ts">
import { cn } from '@/lib/utils'
import { type HTMLAttributes, computed } from 'vue'

const props = defineProps<{
  class?: HTMLAttributes['class']
}>()

const delegatedProps = computed(() => {
  const { class: _, ...delegated } = props
  return delegated
})
</script>

<template>
  <h3
    :class="cn('text-2xl font-semibold leading-none tracking-tight', props.class)"
    v-bind="delegatedProps"
  >
    <slot />
  </h3>
</template>
