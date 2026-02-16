<script setup lang="ts">
import { ref, computed } from 'vue'
import { 
  Code2, PenTool, Users, TrendingUp, Home, 
  GraduationCap, Palette, ShoppingCart, Heart, 
  Scale, Brain, GitBranch, Layers, GitCommit, 
  Database, Puzzle, X, AlertTriangle, Sparkles,
  ChevronRight, ExternalLink
} from 'lucide-vue-next'
import useCasesData from '@/data/openclaw-use-cases.json'

// 圖標映射
const iconMap: Record<string, any> = {
  Code2, PenTool, Users, TrendingUp, Home,
  GraduationCap, Palette, ShoppingCart, Heart,
  Scale, Brain, GitBranch, Layers, GitCommit,
  Database, Puzzle
}

// 顏色映射
const colorMap: Record<string, string> = {
  blue: 'from-blue-500 to-cyan-400',
  purple: 'from-purple-500 to-pink-400',
  green: 'from-emerald-500 to-teal-400',
  amber: 'from-amber-500 to-orange-400',
  cyan: 'from-cyan-500 to-blue-400',
  indigo: 'from-indigo-500 to-purple-400',
  pink: 'from-pink-500 to-rose-400',
  orange: 'from-orange-500 to-red-400',
  rose: 'from-rose-500 to-pink-400',
  slate: 'from-slate-500 to-gray-400'
}

const bgColorMap: Record<string, string> = {
  blue: 'bg-blue-500/10 border-blue-500/20',
  purple: 'bg-purple-500/10 border-purple-500/20',
  green: 'bg-emerald-500/10 border-emerald-500/20',
  amber: 'bg-amber-500/10 border-amber-500/20',
  cyan: 'bg-cyan-500/10 border-cyan-500/20',
  indigo: 'bg-indigo-500/10 border-indigo-500/20',
  pink: 'bg-pink-500/10 border-pink-500/20',
  orange: 'bg-orange-500/10 border-orange-500/20',
  rose: 'bg-rose-500/10 border-rose-500/20',
  slate: 'bg-slate-500/10 border-slate-500/20'
}

// 數據
const data = ref(useCasesData)
const activeCategory = ref<string | null>(null)
const expandedScenario = ref<string | null>(null)

// 過濾後的分類
const filteredCategories = computed(() => {
  if (!activeCategory.value) return data.value.categories
  return data.value.categories.filter(c => c.id === activeCategory.value)
})

// 切換分類
const toggleCategory = (categoryId: string) => {
  activeCategory.value = activeCategory.value === categoryId ? null : categoryId
}

// 切換場景展開
const toggleScenario = (scenarioId: string) => {
  expandedScenario.value = expandedScenario.value === scenarioId ? null : scenarioId
}
</script>

<template>
  <div class="min-h-screen bg-gradient-to-br from-slate-950 via-slate-900 to-slate-950">
    <!-- Hero Section -->
    <section class="relative overflow-hidden px-6 py-24 lg:px-8">
      <!-- 背景裝飾 -->
      <div class="absolute inset-0 overflow-hidden">
        <div class="absolute -left-1/4 -top-1/4 h-96 w-96 rounded-full bg-blue-500/20 blur-3xl"></div>
        <div class="absolute -right-1/4 top-1/2 h-96 w-96 rounded-full bg-purple-500/20 blur-3xl"></div>
        <div class="absolute bottom-0 left-1/2 h-96 w-96 -translate-x-1/2 rounded-full bg-cyan-500/10 blur-3xl"></div>
      </div>
      
      <div class="relative mx-auto max-w-5xl text-center">
        <!-- 標籤 -->
        <div class="mb-6 inline-flex items-center gap-2 rounded-full border border-cyan-500/30 bg-cyan-500/10 px-4 py-1.5">
          <Sparkles class="h-4 w-4 text-cyan-400" />
          <span class="text-sm font-medium text-cyan-300">AI 自動化應用案例</span>
        </div>
        
        <!-- 主標題 -->
        <h1 class="mb-6 text-4xl font-bold tracking-tight text-white sm:text-5xl lg:text-6xl">
          <span class="bg-gradient-to-r from-cyan-400 via-blue-400 to-purple-400 bg-clip-text text-transparent">
            {{ data.title }}
          </span>
        </h1>
        
        <!-- 副標題 -->
        <p class="mx-auto mb-4 max-w-2xl text-xl text-slate-300">
          {{ data.subtitle }}
        </p>
        <p class="mx-auto max-w-xl text-slate-400">
          {{ data.description }}
        </p>
        
        <!-- 統計數字 -->
        <div class="mt-12 grid grid-cols-3 gap-8">
          <div class="text-center">
            <div class="text-3xl font-bold text-cyan-400">41</div>
            <div class="text-sm text-slate-400">應用場景</div>
          </div>
          <div class="text-center">
            <div class="text-3xl font-bold text-purple-400">13</div>
            <div class="text-sm text-slate-400">應用領域</div>
          </div>
          <div class="text-center">
            <div class="text-3xl font-bold text-pink-400">∞</div>
            <div class="text-sm text-slate-400">可能性</div>
          </div>
        </div>
      </div>
    </section>

    <!-- 分類過濾器 -->
    <section class="sticky top-0 z-40 border-b border-slate-800/50 bg-slate-950/80 px-6 py-4 backdrop-blur-xl">
      <div class="mx-auto max-w-7xl">
        <div class="flex flex-wrap items-center justify-center gap-2">
          <button
            @click="activeCategory = null"
            :class="[
              'rounded-full px-4 py-2 text-sm font-medium transition-all duration-300',
              activeCategory === null
                ? 'bg-gradient-to-r from-cyan-500 to-blue-500 text-white shadow-lg shadow-cyan-500/25'
                : 'border border-slate-700 bg-slate-900/50 text-slate-400 hover:border-slate-600 hover:text-slate-200'
            ]"
          >
            全部場景
          </button>
          <button
            v-for="category in data.categories"
            :key="category.id"
            @click="toggleCategory(category.id)"
            :class="[
              'rounded-full px-4 py-2 text-sm font-medium transition-all duration-300',
              activeCategory === category.id
                ? `bg-gradient-to-r ${colorMap[category.color]} text-white shadow-lg`
                : 'border border-slate-700 bg-slate-900/50 text-slate-400 hover:border-slate-600 hover:text-slate-200'
            ]"
          >
            <span class="flex items-center gap-2">
              <component :is="iconMap[category.icon]" class="h-4 w-4" />
              {{ category.title }}
            </span>
          </button>
        </div>
      </div>
    </section>

    <!-- 應用場景列表 -->
    <section class="px-6 py-16 lg:px-8">
      <div class="mx-auto max-w-7xl space-y-16">
        <div
          v-for="category in filteredCategories"
          :key="category.id"
          class="space-y-6"
        >
          <!-- 分類標題 -->
          <div class="flex items-center gap-4">
            <div :class="`flex h-12 w-12 items-center justify-center rounded-xl bg-gradient-to-br ${colorMap[category.color]}`">
              <component :is="iconMap[category.icon]" class="h-6 w-6 text-white" />
            </div>
            <div>
              <h2 class="text-2xl font-bold text-white">{{ category.title }}</h2>
              <p v-if="category.warning" class="mt-1 flex items-center gap-2 text-sm text-amber-400">
                <AlertTriangle class="h-4 w-4" />
                {{ category.warning }}
              </p>
            </div>
          </div>

          <!-- 場景卡片網格 -->
          <div class="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
            <div
              v-for="scenario in category.scenarios"
              :key="scenario.id"
              @click="toggleScenario(scenario.id)"
              :class="[
                'group cursor-pointer rounded-2xl border p-5 transition-all duration-300',
                'hover:scale-[1.02] hover:shadow-xl',
                expandedScenario === scenario.id
                  ? `${bgColorMap[category.color]} border-opacity-50`
                  : 'border-slate-800 bg-slate-900/50 hover:border-slate-700'
              ]"
            >
              <!-- 場景編號和標題 -->
              <div class="mb-3 flex items-start justify-between">
                <span :class="`text-2xl font-bold bg-gradient-to-r ${colorMap[category.color]} bg-clip-text text-transparent`">
                  {{ scenario.number }}
                </span>
                <ChevronRight 
                  :class="[
                    'h-5 w-5 text-slate-500 transition-transform duration-300',
                    expandedScenario === scenario.id ? 'rotate-90' : 'group-hover:translate-x-1'
                  ]" 
                />
              </div>
              
              <h3 class="mb-2 text-lg font-semibold text-white group-hover:text-cyan-300 transition-colors">
                {{ scenario.title }}
              </h3>
              
              <p class="mb-4 text-sm text-slate-400 line-clamp-2">
                {{ scenario.description }}
              </p>

              <!-- 特性標籤 -->
              <div class="flex flex-wrap gap-2">
                <span
                  v-for="feature in scenario.features"
                  :key="feature"
                  :class="`rounded-full px-2.5 py-1 text-xs font-medium border ${bgColorMap[category.color]}`"
                >
                  {{ feature }}
                </span>
              </div>

              <!-- 展開的詳細內容 -->
              <div
                v-if="expandedScenario === scenario.id"
                class="mt-4 border-t border-slate-700/50 pt-4"
              >
                <p class="text-sm text-slate-300 leading-relaxed">
                  {{ scenario.description }}
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- 核心特性區塊 -->
    <section class="border-t border-slate-800/50 bg-slate-900/30 px-6 py-20 lg:px-8">
      <div class="mx-auto max-w-5xl">
        <div class="mb-12 text-center">
          <h2 class="mb-4 text-3xl font-bold text-white">
            <span class="bg-gradient-to-r from-cyan-400 to-purple-400 bg-clip-text text-transparent">
              OpenClaw 核心特性
            </span>
          </h2>
          <p class="text-slate-400">真正需要 OpenClaw 的場景具備以下特性</p>
        </div>

        <div class="grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
          <div
            v-for="feature in data.coreFeatures"
            :key="feature.title"
            class="group rounded-2xl border border-slate-800 bg-slate-900/50 p-6 transition-all duration-300 hover:border-cyan-500/30 hover:bg-slate-800/50"
          >
            <div class="mb-4 flex h-12 w-12 items-center justify-center rounded-xl bg-gradient-to-br from-cyan-500 to-blue-500">
              <component :is="iconMap[feature.icon]" class="h-6 w-6 text-white" />
            </div>
            <h3 class="mb-2 text-lg font-semibold text-white">{{ feature.title }}</h3>
            <p class="text-sm text-slate-400">{{ feature.description }}</p>
          </div>
        </div>
      </div>
    </section>

    <!-- 不適用場景 -->
    <section class="border-t border-slate-800/50 px-6 py-16 lg:px-8">
      <div class="mx-auto max-w-3xl text-center">
        <div class="mb-6 inline-flex items-center gap-2 rounded-full border border-red-500/30 bg-red-500/10 px-4 py-2">
          <X class="h-5 w-5 text-red-400" />
          <span class="font-medium text-red-300">不適合使用 OpenClaw 的場景</span>
        </div>
        
        <div class="flex flex-wrap justify-center gap-3">
          <span
            v-for="item in data.notSuitable"
            :key="item"
            class="rounded-full border border-slate-700 bg-slate-900/50 px-4 py-2 text-sm text-slate-400"
          >
            {{ item }}
          </span>
        </div>
      </div>
    </section>

    <!-- Footer -->
    <footer class="border-t border-slate-800/50 px-6 py-8">
      <div class="mx-auto max-w-7xl text-center">
        <p class="text-sm text-slate-500">
          資料來源：小紅書筆記「首发！全网41个Openclaw应用场景汇总」by 小馬ai
        </p>
        <p class="mt-2 text-xs text-slate-600">
          整理時間：2026-02-17 | 處理工具：Jarvis (Kimi K2.5)
        </p>
      </div>
    </footer>
  </div>
</template>

<style scoped>
.line-clamp-2 {
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}
</style>
