<script setup lang="ts">
import { cn } from '@/lib/utils'
import { Label, type LabelProps } from 'radix-vue'
import { type HTMLAttributes, computed } from 'vue'

const props = defineProps<LabelProps & { class?: HTMLAttributes['class'] }>()

const delegatedProps = computed(() => {
  const { class: _, ...delegated } = props
  return delegated
})
</script>

<template>
  <Label
    :class="
      cn(
        'text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70',
        props.class
      )
    "
    v-bind="delegatedProps"
  >
    <slot />
  </Label>
</template>
