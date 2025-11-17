<script setup lang="ts">
import { cn } from '@/lib/utils'
import { alertVariants, type AlertVariants } from '.'
import { type HTMLAttributes, computed } from 'vue'

const props = defineProps<{
  variant?: AlertVariants['variant']
  class?: HTMLAttributes['class']
}>()

const delegatedProps = computed(() => {
  const { class: _, variant: __, ...delegated } = props
  return delegated
})
</script>

<template>
  <div :class="cn(alertVariants({ variant }), props.class)" v-bind="delegatedProps" role="alert">
    <slot />
  </div>
</template>
