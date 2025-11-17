<script setup lang="ts">
import { cn } from '@/lib/utils'
import { badgeVariants, type BadgeVariants } from '.'
import { type HTMLAttributes, computed } from 'vue'

const props = defineProps<{
  variant?: BadgeVariants['variant']
  class?: HTMLAttributes['class']
}>()

const delegatedProps = computed(() => {
  const { class: _, variant: __, ...delegated } = props
  return delegated
})
</script>

<template>
  <div :class="cn(badgeVariants({ variant }), props.class)" v-bind="delegatedProps">
    <slot />
  </div>
</template>
