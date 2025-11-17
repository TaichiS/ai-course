<script setup lang="ts">
import { cn } from '@/lib/utils'
import { buttonVariants, type ButtonVariants } from '.'
import { Primitive, type PrimitiveProps } from 'radix-vue'
import { type HTMLAttributes, computed } from 'vue'

interface Props extends PrimitiveProps {
  variant?: ButtonVariants['variant']
  size?: ButtonVariants['size']
  class?: HTMLAttributes['class']
}

const props = withDefaults(defineProps<Props>(), {
  as: 'button',
})

const delegatedProps = computed(() => {
  const { class: _, size: __, variant: ___, ...delegated } = props
  return delegated
})
</script>

<template>
  <Primitive
    :as="as"
    :as-child="asChild"
    :class="cn(buttonVariants({ variant, size }), props.class)"
    v-bind="delegatedProps"
  >
    <slot />
  </Primitive>
</template>
