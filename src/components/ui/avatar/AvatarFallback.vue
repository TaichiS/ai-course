<script setup lang="ts">
import { cn } from '@/lib/utils'
import { AvatarFallback, type AvatarFallbackProps } from 'radix-vue'
import { type HTMLAttributes, computed } from 'vue'

const props = defineProps<AvatarFallbackProps & { class?: HTMLAttributes['class'] }>()

const delegatedProps = computed(() => {
  const { class: _, ...delegated } = props
  return delegated
})
</script>

<template>
  <AvatarFallback
    :class="cn('flex h-full w-full items-center justify-center rounded-full bg-muted', props.class)"
    v-bind="delegatedProps"
  >
    <slot />
  </AvatarFallback>
</template>
