<script setup lang="ts">
import { ref } from 'vue'
import { 
  Download, Terminal, FileText, Globe, AlertTriangle, 
  ArrowLeft, Check, Copy, ChevronDown, ChevronUp 
} from 'lucide-vue-next'
import installationData from '@/data/installation.json'
import CodeBlock from '@/components/CodeBlock.vue'

// 圖標映射
const iconMap: Record<string, any> = {
  Download, Terminal, FileText, Globe, AlertTriangle
}

// 資料
const sections = ref(installationData.sections)

// 展開狀態
const expandedSections = ref<Record<string, boolean>>({})

const toggleSection = (id: string) => {
  expandedSections.value[id] = !expandedSections.value[id]
}

// 獲取圖標組件
const getIcon = (iconName: string) => {
  return iconMap[iconName] || Terminal
}

// 獲取顏色類別
const getColorClass = (color: string, type: 'text' | 'bg' | 'border' | 'gradient' = 'text') => {
  const colorMap: Record<string, Record<string, string>> = {
    indigo: { 
      text: 'text-indigo-400', 
      bg: 'bg-indigo-500/10', 
      border: 'border-indigo-500/30',
      gradient: 'from-indigo-500 to-purple-500'
    },
    green: { 
      text: 'text-emerald-400', 
      bg: 'bg-emerald-500/10', 
      border: 'border-emerald-500/30',
      gradient: 'from-emerald-500 to-teal-500'
    },
    orange: { 
      text: 'text-orange-400', 
      bg: 'bg-orange-500/10', 
      border: 'border-orange-500/30',
      gradient: 'from-orange-500 to-red-500'
    },
    blue: { 
      text: 'text-blue-400', 
      bg: 'bg-blue-500/10', 
      border: 'border-blue-500/30',
      gradient: 'from-blue-500 to-cyan-500'
    },
    purple: { 
      text: 'text-purple-400', 
      bg: 'bg-purple-500/10', 
      border: 'border-purple-500/30',
      gradient: 'from-purple-500 to-pink-500'
    },
    cyan: { 
      text: 'text-cyan-400', 
      bg: 'bg-cyan-500/10', 
      border: 'border-cyan-500/30',
      gradient: 'from-cyan-500 to-blue-500'
    },
    red: { 
      text: 'text-red-400', 
      bg: 'bg-red-500/10', 
      border: 'border-red-500/30',
      gradient: 'from-red-500 to-orange-500'
    }
  }
  return colorMap[color]?.[type] || colorMap.blue[type]
}

// 返回首頁
const goBack = () => {
  window.history.back()
}
</script>

<template>
  <div class="min-h-screen bg-gradient-to-br from-slate-950 via-slate-900 to-slate-950">
    <!-- 導航欄 -->
    <nav class="sticky top-0 z-50 border-b border-slate-800/50 bg-slate-950/90 px-6 py-4 backdrop-blur-xl">
      <div class="mx-auto flex max-w-5xl items-center justify-between">
        <button
          @click="goBack"
          class="flex items-center gap-2 text-slate-400 transition-colors hover:text-white"
        >
          <ArrowLeft class="h-5 w-5" />
          <span>返回</span>
        </button>
        
        <div class="text-sm text-slate-500">
          安裝指南
        </div>
      </div>
    </nav>

    <!-- Hero Section -->
    <section class="relative overflow-hidden px-6 py-16 lg:px-8">
      <!-- 背景裝飾 -->
      <div class="absolute inset-0 overflow-hidden">
        <div class="absolute -left-1/4 -top-1/4 h-96 w-96 rounded-full bg-indigo-500/20 blur-3xl"></div>
        <div class="absolute -right-1/4 top-1/2 h-96 w-96 rounded-full bg-cyan-500/20 blur-3xl"></div>
      </div>
      
      <div class="relative mx-auto max-w-4xl text-center">
        <!-- 標籤 -->
        <div class="mb-6 inline-flex items-center gap-2 rounded-full border border-emerald-500/30 bg-emerald-500/10 px-4 py-1.5">
          <Download class="h-4 w-4 text-emerald-400" />
          <span class="text-sm font-medium text-emerald-300">快速開始</span>
        </div>
        
        <!-- 主標題 -->
        <h1 class="mb-6 text-4xl font-bold tracking-tight text-white sm:text-5xl">
          <span class="bg-gradient-to-r from-indigo-400 via-cyan-400 to-emerald-400 bg-clip-text text-transparent">
            Claude Code 安裝指南
          </span>
        </h1>
        
        <!-- 副標題 -->
        <p class="mx-auto max-w-2xl text-lg text-slate-300">
          選擇您的作業系統，跟著步驟快速完成安裝
        </p>
      </div>
    </section>

    <!-- 安裝選項 -->
    <section class="px-6 py-8 lg:px-8">
      <div class="mx-auto max-w-4xl space-y-6">
        <div
          v-for="section in sections"
          :key="section.id"
          class="rounded-2xl border border-slate-800 bg-slate-900/50 overflow-hidden transition-all duration-300 hover:border-slate-700"
        >
          <!-- 標題列 -->
          <button
            @click="toggleSection(section.id)"
            class="flex w-full items-center justify-between p-6 text-left transition-colors hover:bg-slate-800/50"
          >
            <div class="flex items-center gap-4">
              <div :class="`flex h-12 w-12 items-center justify-center rounded-xl bg-gradient-to-br ${getColorClass(section.color, 'gradient')}`">
                <component :is="getIcon(section.icon)" class="h-6 w-6 text-white" />
              </div>
              
              <div>
                <div class="flex items-center gap-3">
                  <h2 class="text-xl font-semibold text-white">{{ section.title }}</h2>
                  <span
                    v-if="section.is_new"
                    class="rounded-full bg-gradient-to-r from-amber-500 to-orange-500 px-2 py-0.5 text-xs font-medium text-white"
                  >
                    NEW
                  </span>
                </div>
                <p class="mt-1 text-sm text-slate-400">{{ section.description }}</p>
              </div>
            </div>
            
            <ChevronDown 
              :class="[
                'h-6 w-6 text-slate-500 transition-transform duration-300',
                expandedSections[section.id] ? 'rotate-180' : ''
              ]" 
            />
          </button>

          <!-- 展開內容 -->
          <div
            v-show="expandedSections[section.id]"
            class="border-t border-slate-800 px-6 py-6"
          >
            <div class="space-y-6">
              <div
                v-for="(step, index) in section.steps"
                :key="index"
                class="space-y-3"
              >
                <!-- 步驟標題 -->
                <div class="flex items-center gap-3">
                  <div :class="`flex h-8 w-8 items-center justify-center rounded-full bg-gradient-to-r ${getColorClass(section.color, 'gradient')} text-sm font-bold text-white`">
                    {{ index + 1 }}
                  </div>
                  <h3 class="text-lg font-medium text-white">{{ step.title }}</h3>
                </div>

                <!-- 步驟說明 -->
                <p class="pl-11 text-slate-300">{{ step.description }}</p>

                <!-- 安裝指令 -->
                <div v-if="step.installCommand" class="pl-11">
                  <div class="mb-2 text-sm text-slate-400">{{ step.installCommandLabel }}</div>
                  <CodeBlock :code="step.installCommand" />
                  <div v-if="step.note" class="mt-2 text-sm text-amber-400">
                    {{ step.note }}
                  </div>
                </div>

                <!-- 指令列表 -->
                <div v-if="step.commands" class="pl-11 space-y-2">
                  <CodeBlock 
                    v-for="(cmd, cmdIndex) in step.commands" 
                    :key="cmdIndex"
                    :code="cmd" 
                  />
                </div>

                <!-- 驗證步驟 -->
                <div v-if="step.verification" class="pl-11">
                  <div class="rounded-lg border border-slate-700 bg-slate-800/50 p-4">
                    <div class="mb-2 flex items-center gap-2 text-emerald-400">
                      <Check class="h-5 w-5" />
                      <span class="font-medium">驗證方式</span>
                    </div>
                    <p class="text-slate-300">{{ step.verification.description }}</p>
                    <CodeBlock v-if="step.verification.command" :code="step.verification.command" />
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- 注意事項 -->
    <section class="border-t border-slate-800/50 px-6 py-12 lg:px-8">
      <div class="mx-auto max-w-4xl">
        <div class="rounded-2xl border border-amber-500/30 bg-amber-500/10 p-6">
          <div class="flex items-start gap-4">
            <AlertTriangle class="h-6 w-6 flex-shrink-0 text-amber-400" />
            <div>
              <h3 class="mb-2 text-lg font-semibold text-amber-300">安裝前注意事項</h3>
              <ul class="space-y-2 text-amber-200/80">
                <li>• 請確保網路連線穩定，安裝過程需要下載多個套件</li>
                <li>• Windows 用戶請以「系統管理員身分」執行 PowerShell</li>
                <li>• macOS/Linux 用戶請確保已安裝 curl 或 wget</li>
                <li>• 安裝過程中若跳出權限請求，請選擇「是」或「允許」</li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Footer -->
    <footer class="border-t border-slate-800/50 px-6 py-8">
      <div class="mx-auto max-w-4xl text-center">
        <p class="text-sm text-slate-500">
          遇到問題？請聯絡課程助教或參考課程文件
        </p>
      </div>
    </footer>
  </div>
</template>
