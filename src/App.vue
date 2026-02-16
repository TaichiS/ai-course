<script setup lang="ts">
import { Card, CardHeader, CardTitle, CardDescription, CardContent } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import { BookOpen, Download, Terminal, AlertTriangle, FileText, FolderOpen, Globe, Star, MapPin, FileEdit, Presentation, TrendingUp, Image, Lightbulb } from 'lucide-vue-next'
import { ref, onMounted, onUnmounted, computed } from 'vue'
import coursesData from '@/data/courses.json'
import InstallationSection from '@/components/InstallationSection.vue'
import CodeBlock from '@/components/CodeBlock.vue'
import ConceptsSection from '@/components/ConceptsSection.vue'
import ExternalLinks from '@/components/ExternalLinks.vue'
import OpenClawUseCases from '@/components/OpenClawUseCases.vue'

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

// 課程資料
const modules = ref(coursesData.modules)
const cases = ref(coursesData.cases)

// 頁面載入狀態
const isLoaded = ref(false)
const typedText = ref('')
const fullText = 'Claude Code 與 AI Agent 實作課程'

// 打字機效果
const typeWriter = () => {
  let i = 0
  const typing = setInterval(() => {
    if (i < fullText.length) {
      typedText.value += fullText.charAt(i)
      i++
    } else {
      clearInterval(typing)
    }
  }, 100)
}

// 獲取圖標組件
const getIcon = (iconName: string) => {
  return iconMap[iconName] || Terminal
}

// 獲取顏色類別
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
    pink: { text: 'text-pink-600', bg: 'bg-pink-50' }
  }
  return colorMap[color]?.[type] || (type === 'text' ? 'text-gray-600' : 'bg-gray-50')
}

// 生成難度星星
const getDifficultyStars = (level: number) => {
  return '⭐'.repeat(level)
}

// 滾動動畫觀察器
let observer: IntersectionObserver | null = null

onMounted(() => {
  // 頁面載入動畫
  setTimeout(() => {
    isLoaded.value = true
    typeWriter()
  }, 300)

  // 設置滾動動畫
  observer = new IntersectionObserver(
    (entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          entry.target.classList.add('animate-in')
        }
      })
    },
    { threshold: 0.1, rootMargin: '50px 0px 0px 0px' }
  )

  // 觀察所有卡片，並立即觸發已在視口中的元素
  setTimeout(() => {
    const elements = document.querySelectorAll('.scroll-animate')
    elements.forEach((el, index) => {
      observer?.observe(el)
      // 為已在視口中的元素添加延遲動畫
      setTimeout(() => {
        const rect = el.getBoundingClientRect()
        if (rect.top < window.innerHeight) {
          el.classList.add('animate-in')
        }
      }, index * 150) // 每個卡片延遲 150ms 進場
    })
  }, 100)
})

onUnmounted(() => {
  observer?.disconnect()
})
</script>

<template>
  <div class="min-h-screen bg-white text-gray-900">
    <!-- Header with animated gradient -->
    <header class="relative overflow-hidden bg-gradient-to-r from-blue-600 via-purple-600 to-cyan-600 bg-[length:200%_200%] animate-gradient text-white py-12 shadow-2xl">
      <!-- Animated particles background -->
      <div class="absolute inset-0 overflow-hidden">
        <div class="particle particle-1"></div>
        <div class="particle particle-2"></div>
        <div class="particle particle-3"></div>
        <div class="particle particle-4"></div>
        <div class="particle particle-5"></div>
      </div>

      <div class="relative max-w-6xl mx-auto px-8">
        <h1
          :class="['text-4xl md:text-5xl font-bold tracking-tight transition-all duration-1000 transform',
                   isLoaded ? 'translate-y-0 opacity-100' : '-translate-y-10 opacity-0']"
        >
          詹嘉隆 AI Agent 實作工作坊
        </h1>
        <p class="text-blue-100 mt-3 text-lg font-mono">
          <span class="text-cyan-300">&gt;</span> {{ typedText }}<span class="animate-blink">|</span>
        </p>
      </div>
    </header>

    <!-- Navigation with glass effect -->
    <nav class="bg-white/80 backdrop-blur-md border-b border-gray-200 sticky top-0 z-10 shadow-sm">
      <div class="max-w-6xl mx-auto px-8 py-4">
        <div class="flex flex-wrap gap-3">
          <!-- 安裝設定導航 -->
          <a
            href="#installation-section"
            class="nav-link px-4 py-2 bg-gradient-to-r from-green-50 to-blue-50 rounded-md shadow-sm hover:shadow-md hover:-translate-y-0.5 transition-all duration-300 text-sm font-medium border border-green-200"
          >
            環境安裝
          </a>
          <!-- 核心概念導航 -->
          <a
            href="#concepts-section"
            class="nav-link px-4 py-2 bg-gradient-to-r from-purple-50 to-indigo-50 rounded-md shadow-sm hover:shadow-md hover:-translate-y-0.5 transition-all duration-300 text-sm font-medium border border-purple-200"
          >
            核心概念
          </a>
          <!-- 動態生成模組導航 -->
          <a
            v-for="module in modules"
            :key="module.id"
            :href="`#${module.id}`"
            :class="[
              'nav-link px-4 py-2 bg-white rounded-md shadow-sm hover:shadow-md hover:-translate-y-0.5 transition-all duration-300 text-sm font-medium',
              `hover:${getColorClass(module.color, 'bg')}`
            ]"
          >
            {{ module.title.split(' ')[0] }}
          </a>
          <!-- 動態生成案例導航 -->
          <a
            v-for="(caseItem, index) in cases"
            :key="caseItem.id"
            :href="`#${caseItem.id}`"
            :class="[
              'nav-link px-4 py-2 bg-white rounded-md shadow-sm hover:shadow-md hover:-translate-y-0.5 transition-all duration-300 text-sm font-medium',
              `hover:${getColorClass(caseItem.color, 'bg')}`
            ]"
          >
            案例 {{ index + 1 }}
          </a>
        </div>
      </div>
    </nav>

    <!-- Main Content -->
    <main class="max-w-6xl mx-auto px-8 py-8 space-y-8">
      <!-- 安裝設定區塊 -->
      <section id="installation-section" class="scroll-mt-20">
        <InstallationSection />
      </section>

      <!-- 工具簡介模組 -->
      <Card
        v-if="modules.find(m => m.id === 'intro')"
        :id="modules.find(m => m.id === 'intro')?.id"
        class="scroll-mt-20 bg-white scroll-animate card-hover group"
      >
        <CardHeader>
          <div class="flex items-center gap-3">
            <component :is="getIcon(modules.find(m => m.id === 'intro')?.icon || 'Terminal')" :class="['h-6 w-6', getColorClass(modules.find(m => m.id === 'intro')?.color || 'blue'), 'group-hover:animate-pulse']" />
            <CardTitle class="text-2xl text-gray-900">{{ modules.find(m => m.id === 'intro')?.title }}</CardTitle>
          </div>
          <CardDescription class="text-gray-600">{{ modules.find(m => m.id === 'intro')?.description }}</CardDescription>
        </CardHeader>
        <CardContent class="prose max-w-none">
          <template v-for="(section, idx) in modules.find(m => m.id === 'intro')?.content.sections" :key="idx">
            <h3 class="text-lg font-semibold mb-3 text-gray-900">{{ section.title }}</h3>
            <p class="text-gray-800 mb-4">{{ section.text }}</p>
          </template>
          <div class="flex gap-2 mt-4">
            <Badge
              v-for="(tag, idx) in modules.find(m => m.id === 'intro')?.content.tags"
              :key="idx"
              :variant="idx === 0 ? 'default' : idx === 1 ? 'secondary' : 'outline'"
              class="hover:scale-110 transition-transform duration-300"
            >
              {{ tag }}
            </Badge>
          </div>
        </CardContent>
      </Card>

      <!-- Markdown 格式模組 -->
      <Card
        v-if="modules.find(m => m.id === 'markdown')"
        :id="modules.find(m => m.id === 'markdown')?.id"
        class="scroll-mt-20 bg-white scroll-animate card-hover group"
      >
        <CardHeader>
          <div class="flex items-center gap-3">
            <component :is="getIcon(modules.find(m => m.id === 'markdown')?.icon || 'FileText')" :class="['h-6 w-6', getColorClass(modules.find(m => m.id === 'markdown')?.color || 'green'), 'group-hover:animate-pulse']" />
            <CardTitle class="text-2xl text-gray-900">{{ modules.find(m => m.id === 'markdown')?.title }}</CardTitle>
          </div>
          <CardDescription class="text-gray-600">{{ modules.find(m => m.id === 'markdown')?.description }}</CardDescription>
        </CardHeader>
        <CardContent>
          <div class="grid md:grid-cols-2 gap-6">
            <div>
              <h3 class="text-lg font-semibold mb-3">Markdown 語法</h3>
              <div class="bg-gray-100 p-4 rounded-lg font-mono text-sm space-y-2 text-gray-900 hover:shadow-inner transition-shadow duration-300">
                <p v-for="(syntax, idx) in modules.find(m => m.id === 'markdown')?.content.syntax" :key="idx" class="hover:text-blue-600 transition-colors">
                  {{ syntax }}
                </p>
              </div>
            </div>
            <div>
              <h3 class="text-lg font-semibold mb-3">程式碼區塊</h3>
              <div class="bg-gray-100 p-4 rounded-lg font-mono text-sm text-gray-900 hover:shadow-inner transition-shadow duration-300">
                <p class="text-purple-600">```{{ modules.find(m => m.id === 'markdown')?.content.codeExample.language }}</p>
                <p v-for="(line, idx) in modules.find(m => m.id === 'markdown')?.content.codeExample.code.split('\n')" :key="idx" :class="idx === 0 ? 'text-blue-600' : 'text-green-600'">
                  {{ line.replace(/  /g, '\u00A0\u00A0') }}
                </p>
                  <p class="text-purple-600">```</p>
                </div>
              </div>
            </div>
          </CardContent>
        </Card>

      <!-- 課程投影片模組 -->
      <Card
        v-if="modules.find(m => m.id === 'lecture-slides')"
        :id="modules.find(m => m.id === 'lecture-slides')?.id"
        class="scroll-mt-20 bg-white scroll-animate card-hover group"
      >
        <CardHeader>
          <div class="flex items-center gap-3">
            <component :is="getIcon(modules.find(m => m.id === 'lecture-slides')?.icon || 'Presentation')" :class="['h-6 w-6', getColorClass(modules.find(m => m.id === 'lecture-slides')?.color || 'pink'), 'group-hover:animate-pulse']" />
            <CardTitle class="text-2xl text-gray-900">{{ modules.find(m => m.id === 'lecture-slides')?.title }}</CardTitle>
          </div>
          <CardDescription class="text-gray-600">{{ modules.find(m => m.id === 'lecture-slides')?.description }}</CardDescription>
        </CardHeader>
        <CardContent class="prose max-w-none">
          <template v-for="(section, idx) in modules.find(m => m.id === 'lecture-slides')?.content.sections" :key="idx">
            <h3 class="text-lg font-semibold mb-3 text-gray-900">{{ section.title }}</h3>
            <p class="text-gray-800 mb-4">{{ section.text }}</p>
          </template>
          <div v-if="modules.find(m => m.id === 'lecture-slides')?.content.links" class="mt-6">
            <ExternalLinks :links="modules.find(m => m.id === 'lecture-slides')?.content.links" layout="vertical" />
          </div>
          <div class="flex gap-2 mt-4">
            <Badge
              v-for="(tag, idx) in modules.find(m => m.id === 'lecture-slides')?.content.tags"
              :key="idx"
              variant="outline"
              class="hover:scale-110 transition-transform duration-300"
            >
              {{ tag }}
            </Badge>
          </div>
        </CardContent>
      </Card>

      <!-- 核心概念與進階功能區塊 -->
      <section id="concepts-section" class="scroll-mt-20">
        <ConceptsSection />
      </section>

      <!-- 動態渲染課程案例 -->
      <Card
        v-for="caseItem in cases"
        :key="caseItem.id"
        :id="caseItem.id"
        class="scroll-mt-20 bg-white scroll-animate card-hover group"
      >
        <CardHeader>
          <div class="flex items-center gap-3">
            <component :is="getIcon(caseItem.icon)" :class="['h-6 w-6', getColorClass(caseItem.color), 'group-hover:animate-pulse']" />
            <CardTitle class="text-2xl text-gray-900">{{ caseItem.fullTitle }}</CardTitle>
          </div>
          <CardDescription class="text-gray-600">{{ caseItem.description }}</CardDescription>
        </CardHeader>
        <CardContent class="space-y-6">
          <!-- 難度與時間資訊 -->
          <div class="flex flex-wrap gap-4 text-sm">
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

          <!-- 工具支援 -->
          <div class="flex gap-2">
            <Badge v-if="caseItem.tools.claudeCode" class="bg-blue-100 text-blue-800">Claude Code ✓</Badge>
            <Badge v-if="caseItem.tools.geminiCLI" class="bg-green-100 text-green-800">Gemini CLI ✓</Badge>
          </div>

          <!-- 學習目標 -->
          <div :class="[getColorClass(caseItem.color, 'bg'), 'p-4 rounded-lg hover:opacity-90 transition-opacity duration-300']">
            <h4 class="font-semibold mb-2 text-gray-900">學習目標</h4>
            <ul class="list-disc list-inside text-sm text-gray-800 space-y-1">
              <li
                v-for="(objective, idx) in caseItem.objectives"
                :key="idx"
                class="hover:translate-x-2 transition-transform duration-300"
              >
                {{ objective }}
              </li>
            </ul>
          </div>

          <!-- 需要的 MCP -->
          <div v-if="caseItem.requiredMCP" class="bg-purple-50 p-4 rounded-lg border border-purple-200">
            <h4 class="font-semibold mb-2 text-purple-900">📦 需要的工具</h4>
            <p class="text-sm text-gray-800">
              <strong>{{ caseItem.requiredMCP.name }}</strong> - {{ caseItem.requiredMCP.description }}
            </p>
            <p class="text-xs text-gray-500 mt-1 font-mono">Package: {{ caseItem.requiredMCP.package }}</p>
          </div>

          <!-- 安裝指令 -->
          <div v-if="caseItem.installation" class="space-y-4">
            <h4 class="font-semibold text-gray-900">🛠️ 安裝步驟</h4>

            <!-- Claude Code 安裝 -->
            <div v-if="caseItem.tools.claudeCode && caseItem.installation.claudeCode" class="border-l-4 border-blue-500 pl-4">
              <h5 class="font-semibold text-blue-700 mb-2">Claude Code 安裝方式</h5>

              <!-- 環境變數設定（如果需要） -->
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

              <div v-if="caseItem.installation.claudeCode.expectedOutput" class="mt-2">
                <p class="text-xs text-gray-600 mb-1">預期輸出：</p>
                <div class="bg-gray-50 p-3 rounded font-mono text-xs text-gray-700 whitespace-pre-line border">
                  {{ caseItem.installation.claudeCode.expectedOutput }}
                </div>
              </div>
            </div>

            <!-- Gemini CLI 安裝 -->
            <div v-if="caseItem.tools.geminiCLI && caseItem.installation.geminiCLI" class="border-l-4 border-green-500 pl-4">
              <h5 class="font-semibold text-green-700 mb-2">Gemini CLI 安裝方式</h5>

              <!-- 環境變數設定（如果需要） -->
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

                <div v-if="caseItem.installation.geminiCLI.expectedOutput" class="mt-2">
                  <p class="text-xs text-gray-600 mb-1">預期輸出：</p>
                  <div class="bg-gray-50 p-3 rounded font-mono text-xs text-gray-700 whitespace-pre-line border">
                    {{ caseItem.installation.geminiCLI.expectedOutput }}
                  </div>
                </div>
              </template>
              <template v-else>
                <p class="text-sm text-gray-600 italic">{{ caseItem.installation.geminiCLI.install }}</p>
              </template>
            </div>
          </div>

          <!-- 操作步驟 -->
          <div v-if="caseItem.steps && caseItem.steps.length > 0" class="space-y-3">
            <h4 class="font-semibold text-gray-900">📋 操作步驟</h4>
            <div class="space-y-2">
              <div
                v-for="(step, idx) in caseItem.steps"
                :key="idx"
                class="border-l-4 border-indigo-500 pl-4 py-2 hover:bg-indigo-50 transition-colors duration-300 rounded-r"
              >
                <h5 class="font-semibold text-indigo-700">步驟 {{ idx + 1 }}：{{ step.title }}</h5>
                <p v-if="step.description" class="text-sm text-gray-700 mt-1">{{ step.description }}</p>
                <div v-if="step.command" class="mt-2">
                  <CodeBlock :code="step.command" />
                </div>
                <div v-if="step.claudeCode" class="mt-2">
                  <p class="text-xs text-gray-600 mb-1">Claude Code：</p>
                  <code class="bg-gray-100 px-2 py-1 rounded text-xs text-gray-800">{{ step.claudeCode }}</code>
                </div>
                <div v-if="step.geminiCLI" class="mt-2">
                  <p class="text-xs text-gray-600 mb-1">Gemini CLI：</p>
                  <code class="bg-gray-100 px-2 py-1 rounded text-xs text-gray-800">{{ step.geminiCLI }}</code>
                </div>
              </div>
            </div>
          </div>

          <!-- 範例指令 -->
          <div>
            <h4 class="font-semibold mb-3 text-gray-900">💬 範例提示詞</h4>
            <div class="space-y-3">
              <div v-for="(example, idx) in caseItem.examplePrompts" :key="idx">
                <p class="text-xs text-gray-600 mb-1 font-medium">{{ example.title }}：</p>
                <CodeBlock :code="example.prompt" />
              </div>
            </div>
          </div>

          <!-- 疑難排解 -->
          <div v-if="caseItem.troubleshooting && caseItem.troubleshooting.length > 0" class="bg-orange-50 p-4 rounded-lg border border-orange-200">
            <h4 class="font-semibold mb-3 text-orange-900">🔧 疑難排解</h4>
            <div class="space-y-2">
              <div v-for="(issue, idx) in caseItem.troubleshooting" :key="idx" class="text-sm">
                <p class="text-red-700 font-medium">問題：{{ issue.problem }}</p>
                <p class="text-gray-700">解決方案：{{ issue.solution }}</p>
              </div>
            </div>
          </div>

          <!-- 溫馨提示 -->
          <div v-if="caseItem.tips && caseItem.tips.length > 0" class="bg-yellow-50 p-4 rounded-lg border border-yellow-200">
            <h4 class="font-semibold mb-3 text-yellow-900 flex items-center gap-2">
              <Lightbulb class="h-5 w-5" />
              溫馨提示
            </h4>
            <ul class="list-disc list-inside text-sm text-gray-800 space-y-2">
              <li
                v-for="(tip, idx) in caseItem.tips"
                :key="idx"
                class="hover:translate-x-1 transition-transform duration-300"
              >
                {{ tip }}
              </li>
            </ul>
          </div>

          <!-- 參考連結 -->
          <div v-if="caseItem.referenceLinks && caseItem.referenceLinks.length > 0">
            <h4 class="font-semibold mb-3 text-gray-900">📚 參考連結</h4>
            <ExternalLinks :links="caseItem.referenceLinks" layout="vertical" />
          </div>
        </CardContent>
      </Card>
    </main>

    <!-- OpenClaw 應用場景 -->
    <OpenClawUseCases />

    <!-- Footer with gradient border -->
    <footer class="relative bg-gray-100 border-t border-gray-200 py-8 mt-12 overflow-hidden">
      <div class="absolute top-0 left-0 right-0 h-1 bg-gradient-to-r from-blue-600 via-purple-600 to-cyan-600 animate-gradient bg-[length:200%_200%]"></div>
      <div class="max-w-6xl mx-auto px-8 text-center">
        <p class="text-gray-600 hover:text-gray-900 transition-colors duration-300">
          &copy; 2026 詹嘉隆 AI Agent 實作工作坊
        </p>
        <p class="text-sm text-gray-400 mt-2">
          Powered by Vue 3 + Tailwind CSS
        </p>
      </div>
    </footer>
  </div>
</template>
