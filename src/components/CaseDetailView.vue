<script setup lang="ts">
import { Card, CardHeader, CardTitle, CardDescription, CardContent } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import { Button } from '@/components/ui/button'
import { 
  ArrowLeft, 
  Terminal, 
  Download, 
  FileText, 
  FolderOpen, 
  Globe, 
  BookOpen, 
  Star, 
  FileEdit, 
  Presentation, 
  TrendingUp, 
  Image, 
  Lightbulb 
} from 'lucide-vue-next'
import { ref, computed, onMounted, nextTick } from 'vue'
import { useRouter } from 'vue-router'
import coursesData from '@/data/courses.json'
import CodeBlock from '@/components/CodeBlock.vue'
import ExternalLinks from '@/components/ExternalLinks.vue'

const props = defineProps<{
  caseId: string
}>()

const router = useRouter()

// 圖標映射
const iconMap: Record<string, any> = {
  Terminal,
  Download,
  FileText,
  FolderOpen,
  Globe,
  BookOpen,
  Star,
  FileEdit,
  Presentation,
  TrendingUp,
  Image,
  Lightbulb
}

const cases = ref(coursesData.cases)

const caseItem = computed(() => {
  return cases.value.find(c => c.id === props.caseId)
})

const caseIndex = computed(() => {
  return cases.value.findIndex(c => c.id === props.caseId)
})

const prevCase = computed(() => {
  if (caseIndex.value > 0) {
    return cases.value[caseIndex.value - 1]
  }
  return null
})

const nextCase = computed(() => {
  if (caseIndex.value < cases.value.length - 1) {
    return cases.value[caseIndex.value + 1]
  }
  return null
})

const getIcon = (iconName: string) => {
  return iconMap[iconName] || Terminal
}

const getColorClass = (color: string, type: 'text' | 'bg' | 'border' = 'text') => {
  const colorMap: Record<string, Record<string, string>> = {
    blue: { text: 'text-blue-600', bg: 'bg-blue-50', border: 'border-blue-500' },
    green: { text: 'text-green-600', bg: 'bg-green-50', border: 'border-green-500' },
    purple: { text: 'text-purple-600', bg: 'bg-purple-50', border: 'border-purple-500' },
    orange: { text: 'text-orange-600', bg: 'bg-orange-50', border: 'border-orange-500' },
    indigo: { text: 'text-indigo-600', bg: 'bg-indigo-50', border: 'border-indigo-500' },
    teal: { text: 'text-teal-600', bg: 'bg-teal-50', border: 'border-teal-500' },
    cyan: { text: 'text-cyan-600', bg: 'bg-cyan-50', border: 'border-cyan-500' },
    amber: { text: 'text-amber-600', bg: 'bg-amber-50', border: 'border-amber-500' },
    emerald: { text: 'text-emerald-600', bg: 'bg-emerald-50', border: 'border-emerald-500' },
    pink: { text: 'text-pink-600', bg: 'bg-pink-50', border: 'border-pink-500' },
    red: { text: 'text-red-600', bg: 'bg-red-50', border: 'border-red-500' }
  }
  return colorMap[color]?.[type] || (type === 'text' ? 'text-gray-600' : type === 'bg' ? 'bg-gray-50' : 'border-gray-500')
}

const getDifficultyStars = (level: number) => '⭐'.repeat(level)

const goBack = () => {
  router.push('/courses')
}

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
</script>

<template>
  <div v-if="caseItem" class="min-h-screen bg-gray-50">
    <!-- 頁面頂部導覽 -->
    <div class="bg-white/80 backdrop-blur-md border-b border-gray-200 sticky top-0 z-10 shadow-sm">
      <div class="max-w-6xl mx-auto px-8 py-4">
        <div class="flex items-center justify-between">
          <Button @click="goBack" variant="outline" class="gap-2">
            <ArrowLeft class="h-4 w-4" />
            返回案例列表
          </Button>
          <div class="flex gap-2">
            <Button 
              v-if="prevCase" 
              @click="goToCase(prevCase.id)" 
              variant="ghost" 
              size="sm"
            >
              ← 上一個案例
            </Button>
            <span class="text-sm text-gray-500 self-center">
              案例 {{ caseIndex + 1 }} / {{ cases.length }}
            </span>
            <Button 
              v-if="nextCase" 
              @click="goToCase(nextCase.id)" 
              variant="ghost" 
              size="sm"
            >
              下一個案例 →
            </Button>
          </div>
        </div>
      </div>
    </div>

    <main class="max-w-6xl mx-auto px-8 py-8 space-y-8">
      <!-- 案例標題卡片 -->
      <Card class="scroll-mt-20 bg-white scroll-animate card-hover">
        <CardHeader>
          <div class="flex items-center gap-3">
            <component :is="getIcon(caseItem.icon)" :class="['h-8 w-8', getColorClass(caseItem.color)]" />
            <div>
              <CardTitle class="text-3xl text-gray-900">{{ caseItem.fullTitle }}</CardTitle>
              <CardDescription class="text-lg text-gray-600 mt-2">{{ caseItem.description }}</CardDescription>
            </div>
          </div>
        </CardHeader>
        <CardContent>
          <div class="flex flex-wrap gap-4 text-sm mb-4">
            <span class="text-gray-600">
              <strong>難度：</strong>{{ getDifficultyStars(caseItem.difficulty) }} {{ caseItem.difficultyLabel }}
            </span>
            <span class="text-gray-600">
              <strong>時間：</strong>{{ caseItem.duration }}
            </span>
            <span class="text-gray-600">
              <strong>平台：</strong>{{ caseItem.platforms.join(', ') }}
            </span>
          </div>

          <div class="flex gap-2">
            <Badge v-if="caseItem.tools.claudeCode" class="bg-blue-100 text-blue-800">Claude Code ✓</Badge>
            <Badge v-if="caseItem.tools.geminiCLI" class="bg-green-100 text-green-800">Gemini CLI ✓</Badge>
          </div>
        </CardContent>
      </Card>

      <!-- 學習目標 -->
      <Card class="scroll-animate bg-white">
        <CardHeader>
          <CardTitle class="text-xl">🎯 學習目標</CardTitle>
        </CardHeader>
        <CardContent>
          <ul class="list-disc list-inside text-gray-800 space-y-2">
            <li v-for="(objective, idx) in caseItem.objectives" :key="idx">
              {{ objective }}
            </li>
          </ul>
        </CardContent>
      </Card>

      <!-- 需要的工具 -->
      <Card v-if="caseItem.requiredMCP" class="scroll-animate bg-white">
        <CardHeader>
          <CardTitle class="text-xl">📦 需要的工具</CardTitle>
        </CardHeader>
        <CardContent>
          <p class="text-gray-800 mb-2">
            <strong>{{ caseItem.requiredMCP.name }}</strong> - {{ caseItem.requiredMCP.description }}
          </p>
          <p class="text-xs text-gray-500 font-mono">Package: {{ caseItem.requiredMCP.package }}</p>
        </CardContent>
      </Card>

      <!-- 安裝步驟 -->
      <Card v-if="caseItem.installation" class="scroll-animate bg-white">
        <CardHeader>
          <CardTitle class="text-xl">🛠️ 安裝步驟</CardTitle>
        </CardHeader>
        <CardContent class="space-y-6">
          <!-- Claude Code 安裝 -->
          <div v-if="caseItem.tools.claudeCode && caseItem.installation.claudeCode" class="border-l-4 border-blue-500 pl-4">
            <h5 class="font-semibold text-blue-700 mb-3">Claude Code 安裝方式</h5>
            <div v-if="caseItem.installation.claudeCode.envSetup" class="mb-3">
              <p class="text-xs text-gray-600 mb-1">1. 設定環境變數：</p>
              <CodeBlock :code="caseItem.installation.claudeCode.envSetup" color="yellow" />
            </div>
            <p class="text-xs text-gray-600 mb-1">{{ caseItem.installation.claudeCode.envSetup ? '2.' : '1.' }} 安裝指令：</p>
            <CodeBlock :code="caseItem.installation.claudeCode.install" />
            <p class="text-xs text-gray-600 mt-2 mb-1">{{ caseItem.installation.claudeCode.envSetup ? '3.' : '2.' }} 確認安裝：</p>
            <div class="bg-gray-100 p-3 rounded font-mono text-xs text-gray-800">
              {{ caseItem.installation.claudeCode.verify }}
            </div>
          </div>

          <!-- Gemini CLI 安裝 -->
          <div v-if="caseItem.tools.geminiCLI && caseItem.installation.geminiCLI" class="border-l-4 border-green-500 pl-4">
            <h5 class="font-semibold text-green-700 mb-3">Gemini CLI 安裝方式</h5>
            <div v-if="caseItem.installation.geminiCLI.envSetup" class="mb-3">
              <p class="text-xs text-gray-600 mb-1">1. 設定環境變數：</p>
              <CodeBlock :code="caseItem.installation.geminiCLI.envSetup" color="yellow" />
            </div>
            <template v-if="caseItem.installation.geminiCLI.install && !caseItem.installation.geminiCLI.install.startsWith('（')">
              <p class="text-xs text-gray-600 mb-1">{{ caseItem.installation.geminiCLI.envSetup ? '2.' : '1.' }} 安裝指令：</p>
              <CodeBlock :code="caseItem.installation.geminiCLI.install" />
              <p class="text-xs text-gray-600 mt-2 mb-1">{{ caseItem.installation.geminiCLI.envSetup ? '3.' : '2.' }} 確認安裝：</p>
              <div class="bg-gray-100 p-3 rounded font-mono text-xs text-gray-800">
                {{ caseItem.installation.geminiCLI.verify }}
              </div>
            </template>
            <template v-else>
              <p class="text-sm text-gray-600 italic">{{ caseItem.installation.geminiCLI.install }}</p>
            </template>
          </div>
        </CardContent>
      </Card>

      <!-- 操作步驟 -->
      <Card v-if="caseItem.steps && caseItem.steps.length > 0" class="scroll-animate bg-white">
        <CardHeader>
          <CardTitle class="text-xl">📋 操作步驟</CardTitle>
        </CardHeader>
        <CardContent>
          <div class="space-y-4">
            <div
              v-for="(step, idx) in caseItem.steps"
              :key="idx"
              class="border-l-4 border-indigo-500 pl-4 py-2"
            >
              <h5 class="font-semibold text-indigo-700">步驟 {{ idx + 1 }}：{{ step.title }}</h5>
              <p v-if="step.description" class="text-sm text-gray-700 mt-1">{{ step.description }}</p>
              <div v-if="step.command" class="mt-2">
                <CodeBlock :code="step.command" />
              </div>
            </div>
          </div>
        </CardContent>
      </Card>

      <!-- 範例提示詞 -->
      <Card class="scroll-animate bg-white">
        <CardHeader>
          <CardTitle class="text-xl">💬 範例提示詞</CardTitle>
        </CardHeader>
        <CardContent>
          <div class="space-y-4">
            <div v-for="(example, idx) in caseItem.examplePrompts" :key="idx">
              <p class="text-xs text-gray-600 mb-1 font-medium">{{ example.title }}：</p>
              <CodeBlock :code="example.prompt" />
            </div>
          </div>
        </CardContent>
      </Card>

      <!-- 疑難排解 -->
      <Card v-if="caseItem.troubleshooting && caseItem.troubleshooting.length > 0" class="scroll-animate bg-white">
        <CardHeader>
          <CardTitle class="text-xl">🔧 疑難排解</CardTitle>
        </CardHeader>
        <CardContent>
          <div class="space-y-3">
            <div v-for="(issue, idx) in caseItem.troubleshooting" :key="idx" class="text-sm">
              <p class="text-red-700 font-medium">問題：{{ issue.problem }}</p>
              <p class="text-gray-700">解決方案：{{ issue.solution }}</p>
            </div>
          </div>
        </CardContent>
      </Card>

      <!-- 溫馨提示 -->
      <Card v-if="caseItem.tips && caseItem.tips.length > 0" class="scroll-animate bg-white">
        <CardHeader>
          <CardTitle class="text-xl flex items-center gap-2">
            <Lightbulb class="h-5 w-5" />
            溫馨提示
          </CardTitle>
        </CardHeader>
        <CardContent>
          <ul class="list-disc list-inside text-sm text-gray-800 space-y-2">
            <li v-for="(tip, idx) in caseItem.tips" :key="idx">
              {{ tip }}
            </li>
          </ul>
        </CardContent>
      </Card>

      <!-- 參考連結 -->
      <Card v-if="caseItem.referenceLinks && caseItem.referenceLinks.length > 0" class="scroll-animate bg-white">
        <CardHeader>
          <CardTitle class="text-xl">📚 參考連結</CardTitle>
        </CardHeader>
        <CardContent>
          <ExternalLinks :links="caseItem.referenceLinks" layout="vertical" />
        </CardContent>
      </Card>

      <!-- 底部導航 -->
      <div class="flex justify-between pt-8">
        <Button 
          v-if="prevCase" 
          @click="goToCase(prevCase.id)" 
          variant="outline"
          class="gap-2"
        >
          <ArrowLeft class="h-4 w-4" />
          ← {{ prevCase.title }}
        </Button>
        <div v-else></div>
        <Button 
          v-if="nextCase" 
          @click="goToCase(nextCase.id)" 
          variant="default"
          class="gap-2"
        >
          {{ nextCase.title }} →
        </Button>
      </div>
    </main>
  </div>

  <!-- 案例不存在 -->
  <div v-else class="min-h-screen flex items-center justify-center">
    <div class="text-center">
      <h1 class="text-2xl font-bold text-gray-900 mb-4">案例不存在</h1>
      <p class="text-gray-600 mb-6">找不到您要查看的案例。</p>
      <Button @click="goBack" variant="default">
        返回案例列表
      </Button>
    </div>
  </div>
</template>
