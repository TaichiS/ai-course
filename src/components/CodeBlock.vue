<script setup lang="ts">
import { ref } from 'vue'
import { Copy, Check } from 'lucide-vue-next'

interface Props {
  code: string | string[]
  prefix?: string
  color?: 'green' | 'yellow' | 'red' | 'orange' | 'cyan'
}

const props = withDefaults(defineProps<Props>(), {
  prefix: '',
  color: 'green'
})

const copied = ref(false)

const colorClasses: Record<string, string> = {
  green: 'text-green-400',
  yellow: 'text-yellow-400',
  red: 'text-red-400',
  orange: 'text-orange-400',
  cyan: 'text-cyan-400'
}

const getTextColor = () => colorClasses[props.color] || colorClasses.green

const getCodeText = () => {
  if (Array.isArray(props.code)) {
    return props.code.map(line => props.prefix ? `${props.prefix} ${line}` : line).join('\n')
  }
  return props.prefix ? `${props.prefix} ${props.code}` : props.code
}

const copyToClipboard = async () => {
  try {
    // 複製時不包含 prefix（如 $）
    const textToCopy = Array.isArray(props.code) ? props.code.join('\n') : props.code
    await navigator.clipboard.writeText(textToCopy)
    copied.value = true
    setTimeout(() => {
      copied.value = false
    }, 2000)
  } catch (err) {
    console.error('Failed to copy:', err)
  }
}
</script>

<template>
  <div class="code-block bg-gray-900 p-3 rounded font-mono text-sm relative overflow-hidden group">
    <div class="code-glow"></div>

    <!-- 複製按鈕 -->
    <button
      @click="copyToClipboard"
      class="absolute top-2 right-2 z-20 p-1.5 rounded bg-gray-700 hover:bg-gray-600 text-gray-300 hover:text-white transition-all duration-200 opacity-0 group-hover:opacity-100"
      :title="copied ? '已複製！' : '複製到剪貼簿'"
    >
      <Check v-if="copied" class="h-4 w-4 text-green-400" />
      <Copy v-else class="h-4 w-4" />
    </button>

    <!-- 程式碼內容 -->
    <div :class="['relative z-10', getTextColor()]">
      <template v-if="Array.isArray(code)">
        <p v-for="(line, idx) in code" :key="idx">
          {{ prefix ? `${prefix} ${line}` : line }}
        </p>
      </template>
      <template v-else>
        <p v-for="(line, idx) in code.split('\n')" :key="idx">
          {{ prefix && idx === 0 ? `${prefix} ${line}` : line }}
        </p>
      </template>
    </div>
  </div>
</template>
