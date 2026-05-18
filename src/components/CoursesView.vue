<script setup lang="ts">
import { Card, CardHeader, CardTitle, CardDescription, CardContent } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import { 
  BookOpen, 
  Download, 
  Terminal, 
  AlertTriangle, 
  FileText, 
  FolderOpen, 
  Globe, 
  Star, 
  MapPin, 
  FileEdit, 
  Presentation, 
  TrendingUp, 
  Image, 
  Lightbulb,
  ArrowRight
} from 'lucide-vue-next'
import { ref, onMounted, onUnmounted, nextTick } from 'vue'
import { useRouter } from 'vue-router'
import coursesData from '@/data/courses.json'
import ConceptsSection from '@/components/ConceptsSection.vue'
import ExternalLinks from '@/components/ExternalLinks.vue'

const router = useRouter()

// 圖標映射
const iconMap: Record<string, any> = {
  Terminal,
  Download,
  AlertTriangle,
  FileText,
  FolderOpen,
  Globe,
  BookOpen,
  Star,
  MapPin,
  FileEdit,
  Presentation,
  TrendingUp,
  Image,
  Lightbulb
}

const modules = ref(coursesData.modules)
const cases = ref(coursesData.cases)

const getIcon = (iconName: string) => {
  return iconMap[iconName] || Terminal
}

const getColorClass = (color: string, type: 'text' | 'bg' = 'text') => {
  const colorMap: Record<string, Record<string, string>> = {
    blue: { text: 'text-blue-600', bg: 'bg-blue-50' },
    green: { text: 'text-green-600', bg: 'bg-green-50' },
    purple: { text: 'text-purple-600', bg: 'bg-purple-50' },
    orange: { text: 'text-orange-600', bg: 'bg-orange-50' },
    indigo: { text: 'text-indigo-600', bg: 'bg-indigo-50' },
    teal: { text: 'text-teal-600', bg: 'bg-teal-50' },
    cyan: { text: 'text-cyan-600', bg: 'bg-cyan-50' },
    amber: { text: 'text-amber-600', bg: 'bg-amber-50' },
    emerald: { text: 'text-emerald-600', bg: 'bg-emerald-50' },
    pink: { text: 'text-pink-600', bg: 'bg-pink-50' },
    red: { text: 'text-red-600', bg: 'bg-red-50' }
  }
  return colorMap[color]?.[type] || (type === 'text' ? 'text-gray-600' : 'bg-gray-50')
}

const getDifficultyStars = (level: number) => '⭐'.repeat(level)

const goToCase = (caseId: string) => {
  router.push(`/courses/${caseId}`)
}

let observer: IntersectionObserver | null = null

onMounted(async () => {
  await nextTick()
  observer = new IntersectionObserver(
    (entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) entry.target.classList.add('animate-in')
      })
    },
    { threshold: 0.05, rootMargin: '50px 0px 0px 0px' }
  )
  const elements = document.querySelectorAll('.scroll-animate')
  elements.forEach((el, index) => {
    observer?.observe(el)
    setTimeout(() => {
      const rect = el.getBoundingClientRect()
      if (rect.top < window.innerHeight) el.classList.add('animate-in')
    }, index * 100)
  })
})

onUnmounted(() => {
  observer?.disconnect()
})
</script>

<template>
  <div>
    <!-- 頁面頂部導覽 -->
    <div class="bg-white/80 backdrop-blur-md border-b border-gray-200 sticky top-0 z-10 shadow-sm">
      <div class="max-w-6xl mx-auto px-8 py-4">
        <div class="flex flex-wrap gap-3">
          <router-link
            to="/"
            class="px-4 py-2 bg-gray-100 rounded-md shadow-sm hover:shadow-md hover:-translate-y-0.5 transition-all duration-300 text-sm font-medium border border-gray-200"
          >
            ← 返回首頁
          </router-link>
          <a href="#concepts-section" class="nav-link px-4 py-2 bg-gradient-to-r from-purple-50 to-indigo-50 rounded-md shadow-sm hover:shadow-md hover:-translate-y-0.5 transition-all duration-300 text-sm font-medium border border-purple-200">
            核心概念說明
          </a>
          <a
            v-for="module in modules"
            :key="module.id"
            :href="`#${module.id}`"
            class="nav-link px-4 py-2 bg-white rounded-md shadow-sm hover:shadow-md hover:-translate-y-0.5 transition-all duration-300 text-sm font-medium border"
          >
            {{ module.title }}
          </a>
        </div>
      </div>
    </div>

    <main class="max-w-6xl mx-auto px-8 py-8 space-y-12">
      <!-- 課程案例清單區塊 -->
      <section id="cases-grid" class="scroll-mt-20">
        <div class="text-center mb-10">
          <h2 class="text-3xl font-bold text-gray-900 mb-2">實作案例挑戰</h2>
          <p class="text-gray-600">從入門到進階，掌握 8 個核心應用場景</p>
        </div>

        <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
          <Card
            v-for="(caseItem, index) in cases"
            :key="caseItem.id"
            @click="goToCase(caseItem.id)"
            class="scroll-animate bg-white card-hover group cursor-pointer border-t-4"
            :class="getColorClass(caseItem.color, 'border').replace('border-', 'border-t-')"
          >
            <CardHeader>
              <div class="flex items-center justify-between mb-2">
                <Badge variant="outline" class="font-mono text-xs">Case {{ index + 1 }}</Badge>
                <div class="flex gap-1">
                  <Badge v-if="caseItem.tools.claudeCode" variant="secondary" class="bg-blue-50 text-blue-700 text-[10px] px-1.5 py-0">Claude</Badge>
                  <Badge v-if="caseItem.tools.geminiCLI" variant="secondary" class="bg-green-50 text-green-700 text-[10px] px-1.5 py-0">Gemini</Badge>
                </div>
              </div>
              <div class="flex items-center gap-3">
                <component :is="getIcon(caseItem.icon)" :class="['h-6 w-6', getColorClass(caseItem.color), 'group-hover:scale-110 transition-transform']" />
                <CardTitle class="text-xl text-gray-900">{{ caseItem.title }}</CardTitle>
              </div>
            </CardHeader>
            <CardContent>
              <p class="text-sm text-gray-600 mb-4 line-clamp-2 h-10">{{ caseItem.description }}</p>
              <div class="flex justify-between items-center text-xs text-gray-500">
                <span>{{ getDifficultyStars(caseItem.difficulty) }}</span>
                <span class="flex items-center gap-1 group-hover:text-blue-600 font-medium transition-colors">
                  查看詳情 <ArrowRight class="h-3 w-3" />
                </span>
              </div>
            </CardContent>
          </Card>
        </div>
      </section>

      <hr class="border-gray-200" />

      <!-- 核心概念與進階功能區塊 -->
      <section id="concepts-section" class="scroll-mt-20">
        <ConceptsSection />
      </section>

      <!-- 基礎模組區塊 -->
      <div class="grid md:grid-cols-2 gap-8">
        <!-- 工具簡介模組 -->
        <Card
          v-if="modules.find(m => m.id === 'intro')"
          :id="modules.find(m => m.id === 'intro')?.id"
          class="scroll-mt-20 bg-white scroll-animate card-hover group h-full"
        >
          <CardHeader>
            <div class="flex items-center gap-3">
              <component :is="getIcon(modules.find(m => m.id === 'intro')?.icon || 'Terminal')" :class="['h-6 w-6', getColorClass(modules.find(m => m.id === 'intro')?.color || 'blue')]" />
              <CardTitle class="text-xl text-gray-900">{{ modules.find(m => m.id === 'intro')?.title }}</CardTitle>
            </div>
          </CardHeader>
          <CardContent class="prose prose-sm max-w-none">
            <template v-for="(section, idx) in modules.find(m => m.id === 'intro')?.content.sections" :key="idx">
              <h4 class="text-base font-semibold mb-2 text-gray-900">{{ section.title }}</h4>
              <p class="text-gray-700 mb-4">{{ section.text }}</p>
            </template>
          </CardContent>
        </Card>

        <!-- Markdown 格式模組 -->
        <Card
          v-if="modules.find(m => m.id === 'markdown')"
          :id="modules.find(m => m.id === 'markdown')?.id"
          class="scroll-mt-20 bg-white scroll-animate card-hover group h-full"
        >
          <CardHeader>
            <div class="flex items-center gap-3">
              <component :is="getIcon(modules.find(m => m.id === 'markdown')?.icon || 'FileText')" :class="['h-6 w-6', getColorClass(modules.find(m => m.id === 'markdown')?.color || 'indigo')]" />
              <CardTitle class="text-xl text-gray-900">{{ modules.find(m => m.id === 'markdown')?.title }}</CardTitle>
            </div>
          </CardHeader>
          <CardContent class="prose prose-sm max-w-none">
             <div class="bg-gray-100 p-4 rounded-lg font-mono text-xs space-y-1 text-gray-900">
                <p v-for="(syntax, idx) in modules.find(m => m.id === 'markdown')?.content.syntax" :key="idx">
                  {{ syntax }}
                </p>
              </div>
          </CardContent>
        </Card>
      </div>
    </main>
  </div>
</template>
