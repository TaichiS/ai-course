<script setup lang="ts">
import { ExternalLink, MousePointerClick } from 'lucide-vue-next'

interface Link {
  label: string
  url: string
  description?: string
}

interface Props {
  links: Link[]
  layout?: 'horizontal' | 'vertical' | 'compact'
  showIcon?: boolean
}

const props = withDefaults(defineProps<Props>(), {
  layout: 'horizontal',
  showIcon: true
})
</script>

<template>
  <!-- 單一連結時的樣式 -->
  <div v-if="links.length === 1" class="inline-flex items-center gap-2 group">
    <MousePointerClick
      v-if="showIcon"
      class="h-5 w-5 text-blue-500 animate-bounce group-hover:text-blue-600 transition-colors"
    />
    <a
      :href="links[0].url"
      target="_blank"
      class="inline-flex items-center gap-1.5 px-3 py-1.5 bg-gradient-to-r from-blue-50 to-indigo-50 hover:from-blue-100 hover:to-indigo-100 text-blue-700 rounded-full shadow-sm hover:shadow-md transition-all duration-300 text-sm font-medium border border-blue-200 hover:border-blue-300"
    >
      {{ links[0].label }}
      <ExternalLink class="h-3.5 w-3.5 opacity-70" />
    </a>
  </div>

  <!-- 多個連結時的水平佈局 -->
  <div
    v-else-if="layout === 'horizontal'"
    class="flex flex-wrap items-center gap-3"
  >
    <div class="flex items-center gap-1.5 text-gray-500">
      <MousePointerClick
        v-if="showIcon"
        class="h-5 w-5 text-blue-500 animate-bounce"
      />
      <span class="text-xs font-medium">相關連結：</span>
    </div>
    <div class="flex flex-wrap gap-2">
      <a
        v-for="link in links"
        :key="link.url"
        :href="link.url"
        target="_blank"
        :title="link.description"
        class="inline-flex items-center gap-1 px-2.5 py-1 bg-gradient-to-r from-blue-50 to-indigo-50 hover:from-blue-100 hover:to-indigo-100 text-blue-700 rounded-full shadow-sm hover:shadow-md transition-all duration-300 text-xs font-medium border border-blue-200 hover:border-blue-300 hover:-translate-y-0.5"
      >
        {{ link.label }}
        <ExternalLink class="h-3 w-3 opacity-70" />
      </a>
    </div>
  </div>

  <!-- 垂直佈局（帶描述） -->
  <div
    v-else-if="layout === 'vertical'"
    class="space-y-2"
  >
    <div class="flex items-center gap-1.5 text-gray-500 mb-3">
      <MousePointerClick
        v-if="showIcon"
        class="h-5 w-5 text-blue-500 animate-bounce"
      />
      <span class="text-sm font-medium">相關資源</span>
    </div>
    <div class="grid gap-2">
      <a
        v-for="link in links"
        :key="link.url"
        :href="link.url"
        target="_blank"
        class="flex items-center justify-between p-3 bg-gradient-to-r from-blue-50 to-indigo-50 hover:from-blue-100 hover:to-indigo-100 rounded-lg border border-blue-200 hover:border-blue-300 transition-all duration-300 hover:shadow-md hover:-translate-y-0.5 group"
      >
        <div>
          <span class="text-sm font-medium text-blue-700">{{ link.label }}</span>
          <p v-if="link.description" class="text-xs text-gray-600 mt-0.5">{{ link.description }}</p>
        </div>
        <ExternalLink class="h-4 w-4 text-blue-500 group-hover:text-blue-600 transition-colors" />
      </a>
    </div>
  </div>

  <!-- 緊湊佈局 -->
  <div
    v-else-if="layout === 'compact'"
    class="inline-flex items-center gap-2 flex-wrap"
  >
    <MousePointerClick
      v-if="showIcon"
      class="h-4 w-4 text-blue-500 animate-bounce"
    />
    <template v-for="(link, index) in links" :key="link.url">
      <a
        :href="link.url"
        target="_blank"
        :title="link.description"
        class="inline-flex items-center gap-1 text-blue-600 hover:text-blue-800 text-sm font-medium hover:underline transition-colors"
      >
        {{ link.label }}
        <ExternalLink class="h-3 w-3 opacity-70" />
      </a>
      <span v-if="index < links.length - 1" class="text-gray-300">•</span>
    </template>
  </div>
</template>
