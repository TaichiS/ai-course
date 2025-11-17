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
  <div :class="cn('text-sm [&_p]:leading-relaxed', props.class)" v-bind="delegatedProps">
    <slot />
  </div>
</template>
