<script setup lang="ts">
import { ref, computed } from 'vue'
import { useRouter } from 'vue-router'
import {
  Sparkles, Code2, PenTool, Users, TrendingUp, Home,
  GraduationCap, Palette, ShoppingCart, Heart,
  Scale, Brain, GitBranch, Layers, GitCommit,
  Database, Puzzle, X, ArrowRight, ExternalLink
} from 'lucide-vue-next'
import useCasesData from '@/data/openclaw-use-cases.json'

const router = useRouter()

const navigateHome = () => {
  router.push('/')
}

// 圖標映射
const iconMap: Record<string, any> = {
  Sparkles, Code2, PenTool, Users, TrendingUp, Home,
  GraduationCap, Palette, ShoppingCart, Heart,
  Scale, Brain, GitBranch, Layers, GitCommit,
  Database, Puzzle
}

// 顏色映射
const colorMap: Record<string, string> = {
  cyan: 'from-cyan-500 to-blue-400',
  blue: 'from-blue-500 to-cyan-400',
  purple: 'from-purple-500 to-pink-400',
  green: 'from-emerald-500 to-teal-400',
  amber: 'from-amber-500 to-orange-400',
  indigo: 'from-indigo-500 to-purple-400',
  pink: 'from-pink-500 to-rose-400',
  orange: 'from-orange-500 to-red-400',
  rose: 'from-rose-500 to-pink-400',
  slate: 'from-slate-500 to-gray-400'
}

const bgColorMap: Record<string, string> = {
  cyan: 'bg-cyan-500/10 border-cyan-500/20 text-cyan-300',
  blue: 'bg-blue-500/10 border-blue-500/20 text-blue-300',
  purple: 'bg-purple-500/10 border-purple-500/20 text-purple-300',
  green: 'bg-emerald-500/10 border-emerald-500/20 text-emerald-300',
  amber: 'bg-amber-500/10 border-amber-500/20 text-amber-300',
  indigo: 'bg-indigo-500/10 border-indigo-500/20 text-indigo-300',
  pink: 'bg-pink-500/10 border-pink-500/20 text-pink-300',
  orange: 'bg-orange-500/10 border-orange-500/20 text-orange-300',
  rose: 'bg-rose-500/10 border-rose-500/20 text-rose-300',
  slate: 'bg-slate-500/10 border-slate-500/20 text-slate-300'
}

// 數據
const data = ref(useCasesData)
const activeCategory = ref<string | null>(null)
const showDetailPage = ref(false)
const selectedScenario = ref<any>(null)

// 過濾後的分類
const filteredCategories = computed(() => {
  if (!activeCategory.value) return data.value.categories
  return data.value.categories.filter(c => c.id === activeCategory.value)
})

// 所有場景（用於詳情頁導航）
const allScenarios = computed(() => {
  const scenarios: any[] = []
  data.value.categories.forEach(cat => {
    cat.scenarios.forEach(s => {
      scenarios.push({ ...s, category: cat })
    })
  })
  return scenarios.sort((a, b) => parseInt(a.number) - parseInt(b.number))
})

// 切換分類
const toggleCategory = (categoryId: string) => {
  activeCategory.value = activeCategory.value === categoryId ? null : categoryId
}

// 開啟詳情頁
const openDetailPage = (scenario: any, category: any) => {
  selectedScenario.value = { ...scenario, category }
  showDetailPage.value = true
  window.scrollTo({ top: 0, behavior: 'smooth' })
}

// 關閉詳情頁
const closeDetailPage = () => {
  showDetailPage.value = false
  selectedScenario.value = null
}

// 導航到上一個/下一個場景
const navigateScenario = (direction: 'prev' | 'next') => {
  if (!selectedScenario.value) return

  const currentIndex = allScenarios.value.findIndex(s => s.id === selectedScenario.value.id)
  let newIndex = direction === 'prev' ? currentIndex - 1 : currentIndex + 1

  if (newIndex < 0) newIndex = allScenarios.value.length - 1
  if (newIndex >= allScenarios.value.length) newIndex = 0

  selectedScenario.value = allScenarios.value[newIndex]
}

// 滑動手勢
let touchStartX = 0
const slideDirection = ref<'left' | 'right'>('left')

const onTouchStart = (e: TouchEvent) => {
  touchStartX = e.touches[0].clientX
}

const onTouchEnd = (e: TouchEvent) => {
  const diff = touchStartX - e.changedTouches[0].clientX
  if (Math.abs(diff) < 50) return
  slideDirection.value = diff > 0 ? 'left' : 'right'
  navigateScenario(diff > 0 ? 'next' : 'prev')
}

const handleNavigate = (direction: 'prev' | 'next') => {
  slideDirection.value = direction === 'next' ? 'left' : 'right'
  navigateScenario(direction)
}
</script>

<template>
  <div class="min-h-screen bg-gradient-to-br from-slate-950 via-slate-900 to-slate-950">
    <!-- 詳情頁 -->
    <transition
      enter-active-class="transition duration-300 ease-out"
      enter-from-class="opacity-0 translate-y-4"
      enter-to-class="opacity-100 translate-y-0"
      leave-active-class="transition duration-200 ease-in"
      leave-from-class="opacity-100 translate-y-0"
      leave-to-class="opacity-0 translate-y-4"
    >
      <div
        v-if="showDetailPage && selectedScenario"
        class="fixed inset-0 z-50 overflow-y-auto bg-slate-950"
        @touchstart="onTouchStart"
        @touchend="onTouchEnd"
      >
        <!-- 詳情頁導航欄 -->
        <nav class="sticky top-0 z-10 border-b border-slate-800 bg-slate-950/90 px-6 py-4 backdrop-blur-xl">
          <div class="mx-auto flex max-w-4xl items-center justify-between">
            <button
              @click="closeDetailPage"
              class="flex items-center gap-2 text-slate-400 transition-colors hover:text-white"
            >
              <ArrowRight class="h-5 w-5 rotate-180" />
              <span>返回列表</span>
            </button>
            
            <div class="flex items-center gap-4">
              <button
                @click="handleNavigate('prev')"
                class="rounded-lg border border-slate-700 px-3 py-1.5 text-sm text-slate-400 transition-colors hover:border-slate-600 hover:text-white"
              >
                上一個
              </button>
              <span class="text-sm text-slate-500">
                {{ selectedScenario.number }} / 41
              </span>
              <button
                @click="handleNavigate('next')"
                class="rounded-lg border border-slate-700 px-3 py-1.5 text-sm text-slate-400 transition-colors hover:border-slate-600 hover:text-white"
              >
                下一個
              </button>
            </div>
          </div>
        </nav>

        <!-- 詳情內容 -->
        <div class="overflow-hidden">
          <Transition :name="slideDirection === 'left' ? 'slide-left' : 'slide-right'" mode="out-in">
            <div :key="selectedScenario.id" class="px-6 py-12">
              <div class="mx-auto max-w-4xl">
                <!-- 場景標題 -->
                <div class="mb-8">
                  <div class="mb-4 flex items-center gap-3">
                    <span :class="`text-5xl font-bold bg-gradient-to-r ${colorMap[selectedScenario.category.color]} bg-clip-text text-transparent`">
                      {{ selectedScenario.number }}
                    </span>
                    <div :class="`rounded-full px-3 py-1 text-xs font-medium ${bgColorMap[selectedScenario.category.color]}`">
                      {{ selectedScenario.category.title }}
                    </div>
                  </div>
                  <h1 class="mb-4 text-3xl font-bold text-white md:text-4xl">
                    {{ selectedScenario.title }}
                  </h1>
                  <p class="text-lg text-slate-300">
                    {{ selectedScenario.description }}
                  </p>
                </div>

                <!-- 特性標籤 -->
                <div class="mb-12">
                  <h2 class="mb-4 text-sm font-semibold uppercase tracking-wider text-slate-500">
                    OpenClaw 核心能力
                  </h2>
                  <div class="flex flex-wrap gap-3">
                    <span
                      v-for="feature in selectedScenario.features"
                      :key="feature"
                      :class="`rounded-full px-4 py-2 text-sm font-medium border ${bgColorMap[selectedScenario.category.color]}`"
                    >
                      {{ feature }}
                    </span>
                  </div>
                </div>

                <!-- 詳細說明區塊 -->
                <div class="space-y-6">
                  <div class="rounded-2xl border border-slate-800 bg-slate-900/50 p-6">
                    <h2 class="mb-4 text-xl font-semibold text-white">應用說明</h2>
                    <p class="leading-relaxed text-slate-300">
                      {{ selectedScenario.description }}
                    </p>
                  </div>

                  <div class="rounded-2xl border border-slate-800 bg-slate-900/50 p-6">
                    <h2 class="mb-4 text-xl font-semibold text-white">為什麼需要 OpenClaw？</h2>
                    <ul class="space-y-3">
                      <li
                        v-for="(feature, idx) in selectedScenario.features"
                        :key="idx"
                        class="flex items-start gap-3 text-slate-300"
                      >
                        <span :class="`mt-1.5 h-2 w-2 rounded-full bg-gradient-to-r ${colorMap[selectedScenario.category.color]}`"></span>
                        <span>{{ feature }}</span>
                      </li>
                    </ul>
                  </div>
                </div>
              </div>
            </div>
          </Transition>
        </div>
      </div>
    </transition>

    <!-- 主列表頁 -->
    <div v-show="!showDetailPage">
      <!-- 返回首頁導覽列 -->
      <nav class="border-b border-slate-800 bg-slate-950/90 px-6 py-4 backdrop-blur-xl">
        <button
          @click="navigateHome"
          class="flex items-center gap-2 text-slate-400 transition-colors hover:text-white"
        >
          <ArrowRight class="h-5 w-5 rotate-180" />
          <span>返回首頁</span>
        </button>
      </nav>

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

          <!-- 安裝指南按鈕 -->
          <div class="mt-10 flex flex-wrap justify-center gap-4">
            <a
              href="/ai-course/openclaw-install.html"
              target="_blank"
              class="inline-flex items-center gap-2 rounded-full bg-gradient-to-r from-cyan-500 to-blue-500 px-6 py-3 text-sm font-semibold text-white shadow-lg shadow-cyan-500/25 transition-all hover:scale-105 hover:shadow-cyan-500/40"
            >
              <ArrowRight class="h-4 w-4" />
              安裝指南（WSL 方式）
            </a>
            <a
              href="/ai-course/openclaw-multipass-setup.html"
              target="_blank"
              class="inline-flex items-center gap-2 rounded-full bg-gradient-to-r from-indigo-500 to-purple-500 px-6 py-3 text-sm font-semibold text-white shadow-lg shadow-indigo-500/25 transition-all hover:scale-105 hover:shadow-indigo-500/40"
            >
              <ArrowRight class="h-4 w-4" />
              安裝指南（Multipass 虛擬機方式）
            </a>
          </div>
        </div>
      </section>

      <!-- 分類過濾器 -->
      <section class="sticky top-0 z-40 border-b border-slate-800/50 bg-slate-950/80 px-6 py-4 backdrop-blur-xl">
        <div class="mx-auto max-w-7xl">
          <div class="flex items-center gap-2 overflow-x-auto pb-1 scrollbar-none" style="flex-wrap: nowrap">
            <button
              @click="activeCategory = null"
              :class="[
                'rounded-full px-4 py-2 text-sm font-medium transition-all duration-300 whitespace-nowrap shrink-0',
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
                'rounded-full px-4 py-2 text-sm font-medium transition-all duration-300 whitespace-nowrap shrink-0',
                activeCategory === category.id
                  ? `bg-gradient-to-r ${colorMap[category.color]} text-white shadow-lg`
                  : 'border border-slate-700 bg-slate-900/50 text-slate-400 hover:border-slate-600 hover:text-slate-200'
              ]"
            >
              <span class="flex items-center gap-2 whitespace-nowrap">
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
                <p v-if="category.warning" class="mt-1 flex items-center gap-2 text-sm text-amber-400"
                >
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
                @click="openDetailPage(scenario, category)"
                class="group cursor-pointer rounded-2xl border border-slate-800 bg-slate-900/50 p-5 transition-all duration-300 hover:scale-[1.02] hover:border-slate-700 hover:shadow-xl"
              >
                <!-- 場景編號和標題 -->
                <div class="mb-3 flex items-start justify-between">
                  <span :class="`text-2xl font-bold bg-gradient-to-r ${colorMap[category.color]} bg-clip-text text-transparent`">
                    {{ scenario.number }}
                  </span>
                  <ExternalLink class="h-5 w-5 text-slate-500 opacity-0 transition-all group-hover:opacity-100" />
                </div>
                
                <h3 class="mb-2 text-lg font-semibold text-white group-hover:text-cyan-300 transition-colors"
                >
                  {{ scenario.title }}
                </h3>
                
                <p class="mb-4 text-sm text-slate-400 line-clamp-2"
                >
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
      <footer class="border-t border-slate-800/50 px-6 py-16 lg:px-8">
        <div class="mx-auto max-w-4xl">
          <!-- 更多資源 CTA -->
          <div class="mb-10 rounded-2xl border border-slate-800 bg-gradient-to-br from-slate-900/80 to-slate-900/30 p-8 text-center">
            <p class="mb-1.5 text-sm text-slate-500">想探索更多應用案例？</p>
            <h3 class="mb-6 text-lg font-semibold text-slate-200">社群持續整理更多 OpenClaw 使用場景</h3>
            <a
              href="https://github.com/hesamsheikh/awesome-openclaw-usecases"
              target="_blank"
              rel="noopener noreferrer"
              class="group inline-flex items-center gap-2.5 rounded-full border border-cyan-500/30 bg-cyan-500/10 px-6 py-3 text-sm font-semibold text-cyan-300 transition-all hover:border-cyan-400/50 hover:bg-cyan-500/20 hover:text-cyan-200 hover:shadow-lg hover:shadow-cyan-500/15"
            >
              <ExternalLink class="h-4 w-4 transition-transform group-hover:-translate-y-0.5 group-hover:translate-x-0.5" />
              awesome-openclaw-usecases
            </a>
          </div>

          <!-- 元資訊 -->
          <div class="flex flex-wrap items-center justify-center gap-x-4 gap-y-2">
            <div class="flex items-center gap-1.5">
              <Database class="h-3.5 w-3.5 text-slate-600" />
              <span class="text-xs text-slate-500">資料來源：社群整理「41 個 OpenClaw 應用場景彙整」</span>
            </div>
            <span class="text-slate-700 text-xs">·</span>
            <span class="text-xs text-slate-600">整理時間：2026-02-17</span>
          </div>
        </div>
      </footer>
    </div>
  </div>
</template>

<style scoped>
.line-clamp-2 {
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.scrollbar-none {
  scrollbar-width: none;
  -ms-overflow-style: none;
}
.scrollbar-none::-webkit-scrollbar {
  display: none;
}

/* 向左滑動（下一個）*/
.slide-left-enter-active,
.slide-left-leave-active {
  transition: transform 0.3s ease, opacity 0.3s ease;
}
.slide-left-enter-from {
  transform: translateX(60px);
  opacity: 0;
}
.slide-left-leave-to {
  transform: translateX(-60px);
  opacity: 0;
}

/* 向右滑動（上一個）*/
.slide-right-enter-active,
.slide-right-leave-active {
  transition: transform 0.3s ease, opacity 0.3s ease;
}
.slide-right-enter-from {
  transform: translateX(-60px);
  opacity: 0;
}
.slide-right-leave-to {
  transform: translateX(60px);
  opacity: 0;
}
</style>
