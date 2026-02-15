<script setup lang="ts">
import { Card, CardHeader, CardTitle, CardDescription, CardContent } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import { Download, Terminal, FileText, Globe, AlertTriangle, ChevronDown, ChevronUp, Clipboard, Check } from 'lucide-vue-next'
import { ref, computed } from 'vue'
import installationData from '@/data/installation.json'
import CodeBlock from '@/components/CodeBlock.vue'

// 圖標映射
const iconMap: Record<string, any> = {
  Download,
  Terminal,
  FileText,
  Globe,
  AlertTriangle
}

// 資料
const sections = ref(installationData.sections)

// 整個區塊的顯示狀態
const isInstallationVisible = ref(true)

const toggleInstallationVisibility = () => {
  isInstallationVisible.value = !isInstallationVisible.value
}

// 獲取圖標組件
const getIcon = (iconName: string) => {
  return iconMap[iconName] || Terminal
}

// 獲取顏色類別
const getColorClass = (color: string, type: 'text' | 'bg' | 'border' = 'text') => {
  const colorMap: Record<string, Record<string, string>> = {
    green: { text: 'text-green-600', bg: 'bg-green-50', border: 'border-green-500' },
    blue: { text: 'text-blue-600', bg: 'bg-blue-50', border: 'border-blue-500' },
    purple: { text: 'text-purple-600', bg: 'bg-purple-50', border: 'border-purple-500' },
    cyan: { text: 'text-cyan-600', bg: 'bg-cyan-50', border: 'border-cyan-500' },
    indigo: { text: 'text-indigo-600', bg: 'bg-indigo-50', border: 'border-indigo-500' },
    orange: { text: 'text-orange-600', bg: 'bg-orange-50', border: 'border-orange-500' },
    red: { text: 'text-red-600', bg: 'bg-red-50', border: 'border-red-500' }
  }
  return colorMap[color]?.[type] || (type === 'text' ? 'text-gray-600' : type === 'bg' ? 'bg-gray-50' : 'border-gray-500')
}

// 展開狀態
const expandedSections = ref<Record<string, boolean>>({})

const toggleSection = (id: string) => {
  expandedSections.value[id] = !expandedSections.value[id]
}

const isExpanded = (id: string) => {
  return expandedSections.value[id] !== false // 預設展開
}

// 複製功能
const copied = ref(false)
const copyToClipboard = async (text: string) => {
  try {
    await navigator.clipboard.writeText(text)
    copied.value = true
    setTimeout(() => {
      copied.value = false
    }, 2000)
  } catch (err) {
    console.error('Failed to copy text: ', err)
  }
}
</script>

<template>
  <div class="space-y-8">
    <!-- 區塊標題 -->
    <div class="text-center py-6">
      <h2 class="text-3xl font-bold text-gray-900 mb-2">環境安裝設定</h2>
      <p class="text-gray-600">在開始課程之前，請先完成以下軟體安裝</p>

      <!-- 一鍵隱藏/顯示按鈕 -->
      <button
        @click="toggleInstallationVisibility"
        class="mt-4 inline-flex items-center gap-2 px-4 py-2 bg-gradient-to-r from-gray-100 to-gray-200 hover:from-gray-200 hover:to-gray-300 text-gray-700 rounded-lg shadow-sm hover:shadow-md transition-all duration-300 text-sm font-medium"
      >
        <component :is="isInstallationVisible ? ChevronUp : ChevronDown" class="h-4 w-4" />
        {{ isInstallationVisible ? '隱藏安裝設定' : '顯示安裝設定' }}
      </button>
    </div>

    <!-- 可收合的內容區塊 -->
    <div
      v-show="isInstallationVisible"
      class="space-y-8 transition-all duration-500 ease-in-out"
    >
      <!-- 一鍵自動安裝（Windows / macOS / Linux 共用模板） -->
      <Card
        v-for="section in sections.filter(s => s.id.startsWith('one-click'))"
        :key="section.id"
        :id="`install-${section.id}`"
        :class="[
          'scroll-mt-20 scroll-animate card-hover group',
          getColorClass(section.color, 'bg') === 'bg-indigo-50' ? 'bg-gradient-to-br from-indigo-50 to-white border-indigo-200' :
          getColorClass(section.color, 'bg') === 'bg-green-50'  ? 'bg-gradient-to-br from-green-50 to-white border-green-200' :
          getColorClass(section.color, 'bg') === 'bg-orange-50' ? 'bg-gradient-to-br from-orange-50 to-white border-orange-200' :
          'bg-gradient-to-br from-gray-50 to-white border-gray-200'
        ]"
      >
        <CardHeader class="cursor-pointer" @click="toggleSection(section.id)">
          <div class="flex items-center justify-between">
            <div class="flex items-center gap-3">
              <div :class="['p-2 rounded-lg text-white group-hover:scale-110 transition-transform', `bg-${section.color}-600`]">
                <component :is="getIcon(section.icon)" class="h-6 w-6" />
              </div>
              <div>
                <div class="flex items-center gap-2">
                  <CardTitle class="text-2xl text-gray-900">{{ section.title }}</CardTitle>
                  <Badge v-if="section.is_new" :class="`bg-${section.color}-600 animate-pulse`">NEW</Badge>
                </div>
                <CardDescription :class="[getColorClass(section.color), 'font-medium']">{{ section.description }}</CardDescription>
              </div>
            </div>
            <span class="text-gray-400">{{ isExpanded(section.id) ? '▼' : '▶' }}</span>
          </div>
        </CardHeader>
        <CardContent v-show="isExpanded(section.id)" class="space-y-6">
          <div v-for="(step, idx) in section.steps" :key="idx" class="relative pl-8 pb-4 last:pb-0">
            <!-- 步數裝飾 -->
            <div :class="['absolute left-0 top-0 w-6 h-6 rounded-full flex items-center justify-center text-xs font-bold border', `bg-${section.color}-100`, `text-${section.color}-600`, `border-${section.color}-200`]">
              {{ idx + 1 }}
            </div>
            <div v-if="idx < section.steps.length - 1" :class="['absolute left-3 top-6 bottom-0 w-0.5', `bg-${section.color}-100`]"></div>

            <h4 class="font-semibold text-gray-900 mb-2">{{ step.title }}</h4>
            <p class="text-sm text-gray-700 mb-3">{{ step.description }}</p>

            <!-- 一鍵安裝指令區塊 -->
            <div v-if="step.installCommand" class="bg-gray-50/50 p-4 rounded-lg border border-dashed border-gray-200 mb-3">
              <p :class="['text-xs font-semibold mb-2', getColorClass(section.color)]">{{ step.installCommandLabel }}</p>
              <div class="flex items-center gap-2 bg-gray-100 rounded border p-1 pr-2 w-full">
                <code class="text-xs px-2 py-1 font-mono flex-1 overflow-x-auto whitespace-nowrap bg-transparent border-none">
                  {{ step.installCommand }}
                </code>
                <button
                  @click="copyToClipboard(step.installCommand)"
                  class="p-1.5 hover:bg-white rounded-md transition-colors text-gray-500 hover:text-gray-700 relative group/btn flex-shrink-0"
                  :title="copied ? '已複製' : '複製指令'"
                >
                  <component :is="copied ? Check : Clipboard" class="h-4 w-4" :class="copied ? 'text-green-600' : ''" />
                  <span v-if="copied" class="absolute -top-8 left-1/2 -translate-x-1/2 bg-black text-white text-xs px-2 py-1 rounded opacity-0 animate-fade-in-up">已複製!</span>
                </button>
              </div>
            </div>

            <CodeBlock v-if="step.commands" :code="step.commands" prefix="$" />
            <p v-if="step.note" class="text-xs text-orange-600 bg-orange-50 p-2 rounded mt-2 border border-orange-100">{{ step.note }}</p>
          </div>
        </CardContent>
      </Card>

      <!-- Node.js 安裝 -->
      <Card
      v-if="sections.find(s => s.id === 'nodejs')"
      id="install-nodejs"
      class="scroll-mt-20 bg-white scroll-animate card-hover group"
    >
      <CardHeader class="cursor-pointer" @click="toggleSection('nodejs')">
        <div class="flex items-center justify-between">
          <div class="flex items-center gap-3">
            <component :is="getIcon('Download')" class="h-6 w-6 text-green-600 group-hover:animate-bounce" />
            <CardTitle class="text-2xl text-gray-900">{{ sections.find(s => s.id === 'nodejs')?.title }}</CardTitle>
          </div>
          <span class="text-gray-400">{{ isExpanded('nodejs') ? '▼' : '▶' }}</span>
        </div>
        <CardDescription class="text-gray-600">{{ sections.find(s => s.id === 'nodejs')?.description }}</CardDescription>
      </CardHeader>
      <CardContent v-show="isExpanded('nodejs')" class="space-y-6">
        <template v-for="(step, idx) in sections.find(s => s.id === 'nodejs')?.steps" :key="idx">
          <div class="border-l-4 border-green-500 pl-4">
            <h4 class="font-semibold text-gray-900 mb-2">步驟 {{ idx + 1 }}：{{ step.title }}</h4>
            <p v-if="step.description" class="text-sm text-gray-700 mb-2">{{ step.description }}</p>
            <a
              v-if="step.url"
              :href="step.url"
              target="_blank"
              class="text-blue-600 hover:underline font-medium block mb-2"
            >
              {{ step.url }}
            </a>
            <p v-if="step.note" class="text-xs text-gray-500 bg-yellow-50 p-2 rounded">{{ step.note }}</p>
            <CodeBlock v-if="step.commands" :code="step.commands" prefix="$" />
          </div>
        </template>

        <!-- Tips -->
        <div v-if="sections.find(s => s.id === 'nodejs')?.tips" class="bg-green-50 p-4 rounded-lg">
          <h4 class="font-semibold text-green-800 mb-2">NPX 使用提示</h4>
          <ul class="list-disc list-inside text-sm text-gray-700 space-y-1">
            <li
              v-for="(tip, idx) in sections.find(s => s.id === 'nodejs')?.tips"
              :key="idx"
            >
              {{ tip }}
            </li>
          </ul>
        </div>
      </CardContent>
    </Card>

    <!-- Python 與 UV/UVX 安裝 -->
    <Card
      v-if="sections.find(s => s.id === 'python')"
      id="install-python"
      class="scroll-mt-20 bg-white scroll-animate card-hover group"
    >
      <CardHeader class="cursor-pointer" @click="toggleSection('python')">
        <div class="flex items-center justify-between">
          <div class="flex items-center gap-3">
            <component :is="getIcon('Terminal')" class="h-6 w-6 text-blue-600 group-hover:animate-spin-slow" />
            <CardTitle class="text-2xl text-gray-900">{{ sections.find(s => s.id === 'python')?.title }}</CardTitle>
          </div>
          <span class="text-gray-400">{{ isExpanded('python') ? '▼' : '▶' }}</span>
        </div>
        <CardDescription class="text-gray-600">{{ sections.find(s => s.id === 'python')?.description }}</CardDescription>
      </CardHeader>
      <CardContent v-show="isExpanded('python')" class="space-y-6">
        <!-- UV 說明 -->
        <div v-if="sections.find(s => s.id === 'python')?.info" class="bg-blue-50 p-4 rounded-lg border border-blue-200">
          <p class="text-sm text-gray-700">{{ sections.find(s => s.id === 'python')?.info }}</p>
        </div>

        <template v-for="(step, idx) in sections.find(s => s.id === 'python')?.steps" :key="idx">
          <div class="border-l-4 border-blue-500 pl-4">
            <h4 class="font-semibold text-gray-900 mb-2">{{ step.title }}</h4>
            <CodeBlock v-if="step.commands" :code="step.commands" prefix="$" />
          </div>
        </template>
      </CardContent>
    </Card>

    <!-- Claude Code 安裝 -->
    <Card
      v-if="sections.find(s => s.id === 'claude-code')"
      id="install-claude-code"
      class="scroll-mt-20 bg-white scroll-animate card-hover group"
    >
      <CardHeader class="cursor-pointer" @click="toggleSection('claude-code')">
        <div class="flex items-center justify-between">
          <div class="flex items-center gap-3">
            <component :is="getIcon('Terminal')" class="h-6 w-6 text-purple-600 group-hover:animate-pulse" />
            <CardTitle class="text-2xl text-gray-900">{{ sections.find(s => s.id === 'claude-code')?.title }}</CardTitle>
          </div>
          <span class="text-gray-400">{{ isExpanded('claude-code') ? '▼' : '▶' }}</span>
        </div>
        <CardDescription class="text-gray-600">{{ sections.find(s => s.id === 'claude-code')?.description }}</CardDescription>
      </CardHeader>
      <CardContent v-show="isExpanded('claude-code')" class="space-y-6">
        <!-- 新式安裝方法 -->
        <div v-if="sections.find(s => s.id === 'claude-code')?.methods?.new" class="bg-purple-50 p-4 rounded-lg border border-purple-200">
          <h4 class="font-semibold text-purple-800 mb-3">{{ sections.find(s => s.id === 'claude-code')?.methods?.new?.title }}</h4>
          <div class="space-y-3">
            <div v-if="sections.find(s => s.id === 'claude-code')?.methods?.new?.platforms?.macos">
              <p class="text-xs text-gray-600 mb-1">MacOS (Homebrew)：</p>
              <CodeBlock :code="sections.find(s => s.id === 'claude-code')?.methods?.new?.platforms?.macos" prefix="$" />
            </div>
            <div v-if="sections.find(s => s.id === 'claude-code')?.methods?.new?.platforms?.windows_powershell">
              <p class="text-xs text-gray-600 mb-1">Windows PowerShell：</p>
              <CodeBlock :code="sections.find(s => s.id === 'claude-code')?.methods?.new?.platforms?.windows_powershell" />
            </div>
            <div v-if="sections.find(s => s.id === 'claude-code')?.methods?.new?.platforms?.windows_cmd">
              <p class="text-xs text-gray-600 mb-1">Windows CMD：</p>
              <CodeBlock :code="sections.find(s => s.id === 'claude-code')?.methods?.new?.platforms?.windows_cmd" />
            </div>
          </div>
        </div>

        <!-- 舊式安裝方法 -->
        <div v-if="sections.find(s => s.id === 'claude-code')?.methods?.old">
          <h4 class="font-semibold text-gray-800 mb-3">{{ sections.find(s => s.id === 'claude-code')?.methods?.old?.title }}</h4>
          <CodeBlock :code="sections.find(s => s.id === 'claude-code')?.methods?.old?.commands" prefix="$" />
        </div>

        <!-- Windows 必要配置 -->
        <div v-if="sections.find(s => s.id === 'claude-code')?.windows_setup" class="bg-yellow-50 p-4 rounded-lg border border-yellow-300">
          <h4 class="font-semibold text-yellow-800 mb-2">{{ sections.find(s => s.id === 'claude-code')?.windows_setup?.title }}</h4>
          <p class="text-sm text-gray-700 mb-3">{{ sections.find(s => s.id === 'claude-code')?.windows_setup?.description }}</p>
          <ol class="list-decimal list-inside text-sm text-gray-700 space-y-1 mb-3">
            <li v-for="(step, idx) in sections.find(s => s.id === 'claude-code')?.windows_setup?.steps" :key="idx">
              {{ step }}
            </li>
          </ol>
          <CodeBlock :code="sections.find(s => s.id === 'claude-code')?.windows_setup?.command" color="yellow" />
        </div>

        <!-- PATH 環境變數設定 -->
        <div v-if="sections.find(s => s.id === 'claude-code')?.path_setup" class="bg-orange-50 p-4 rounded-lg border border-orange-300">
          <h4 class="font-semibold text-orange-800 mb-2">{{ sections.find(s => s.id === 'claude-code')?.path_setup?.title }}</h4>
          <p class="text-sm text-gray-700 mb-3">{{ sections.find(s => s.id === 'claude-code')?.path_setup?.description }}</p>
          <CodeBlock :code="sections.find(s => s.id === 'claude-code')?.path_setup?.command" color="orange" />
          <p class="text-xs text-red-600 mt-2 font-medium">{{ sections.find(s => s.id === 'claude-code')?.path_setup?.note }}</p>
        </div>

        <!-- 管理指令 -->
        <div v-if="sections.find(s => s.id === 'claude-code')?.management" class="bg-gray-100 p-4 rounded-lg">
          <h4 class="font-semibold text-gray-800 mb-3">管理指令</h4>
          <div class="space-y-2 text-sm">
            <div class="flex items-center gap-2">
              <Badge variant="outline">更新</Badge>
              <code class="bg-gray-200 px-2 py-1 rounded text-xs">{{ sections.find(s => s.id === 'claude-code')?.management?.update }}</code>
            </div>
            <div class="flex items-center gap-2">
              <Badge variant="outline">移除</Badge>
              <code class="bg-gray-200 px-2 py-1 rounded text-xs">{{ sections.find(s => s.id === 'claude-code')?.management?.uninstall }}</code>
            </div>
            <div class="flex items-center gap-2">
              <Badge variant="outline">設定檔</Badge>
              <code class="bg-gray-200 px-2 py-1 rounded text-xs">{{ sections.find(s => s.id === 'claude-code')?.management?.config_path }}</code>
            </div>
          </div>
        </div>
      </CardContent>
    </Card>

    <!-- Gemini CLI 安裝 -->
    <Card
      v-if="sections.find(s => s.id === 'gemini-cli')"
      id="install-gemini-cli"
      class="scroll-mt-20 bg-white scroll-animate card-hover group"
    >
      <CardHeader class="cursor-pointer" @click="toggleSection('gemini-cli')">
        <div class="flex items-center justify-between">
          <div class="flex items-center gap-3">
            <component :is="getIcon('Terminal')" class="h-6 w-6 text-cyan-600 group-hover:animate-pulse" />
            <CardTitle class="text-2xl text-gray-900">{{ sections.find(s => s.id === 'gemini-cli')?.title }}</CardTitle>
          </div>
          <span class="text-gray-400">{{ isExpanded('gemini-cli') ? '▼' : '▶' }}</span>
        </div>
        <CardDescription class="text-gray-600">{{ sections.find(s => s.id === 'gemini-cli')?.description }}</CardDescription>
      </CardHeader>
      <CardContent v-show="isExpanded('gemini-cli')" class="space-y-6">
        <div class="border-l-4 border-cyan-500 pl-4">
          <h4 class="font-semibold text-gray-900 mb-2">安裝指令</h4>
          <CodeBlock :code="sections.find(s => s.id === 'gemini-cli')?.commands" prefix="$" />
        </div>

        <!-- 使用限制 -->
        <div v-if="sections.find(s => s.id === 'gemini-cli')?.limits" class="bg-cyan-50 p-4 rounded-lg border border-cyan-200">
          <h4 class="font-semibold text-cyan-800 mb-2">免費版使用限制</h4>
          <div class="grid grid-cols-2 gap-4 text-sm">
            <div class="text-center">
              <p class="text-2xl font-bold text-cyan-600">{{ sections.find(s => s.id === 'gemini-cli')?.limits?.free?.per_minute }}</p>
              <p class="text-gray-600">次/分鐘</p>
            </div>
            <div class="text-center">
              <p class="text-2xl font-bold text-cyan-600">{{ sections.find(s => s.id === 'gemini-cli')?.limits?.free?.per_day }}</p>
              <p class="text-gray-600">次/天</p>
            </div>
          </div>
          <p class="text-xs text-gray-500 mt-2 text-center">{{ sections.find(s => s.id === 'gemini-cli')?.note }}</p>
        </div>
      </CardContent>
    </Card>

    <!-- 常用命令速查表 -->
    <Card
      v-if="sections.find(s => s.id === 'commands')"
      id="command-reference"
      class="scroll-mt-20 bg-white scroll-animate card-hover group"
    >
      <CardHeader class="cursor-pointer" @click="toggleSection('commands')">
        <div class="flex items-center justify-between">
          <div class="flex items-center gap-3">
            <component :is="getIcon('FileText')" class="h-6 w-6 text-indigo-600 group-hover:animate-pulse" />
            <CardTitle class="text-2xl text-gray-900">{{ sections.find(s => s.id === 'commands')?.title }}</CardTitle>
          </div>
          <span class="text-gray-400">{{ isExpanded('commands') ? '▼' : '▶' }}</span>
        </div>
        <CardDescription class="text-gray-600">{{ sections.find(s => s.id === 'commands')?.description }}</CardDescription>
      </CardHeader>
      <CardContent v-show="isExpanded('commands')" class="space-y-6">
        <!-- 基本命令表格 -->
        <div>
          <h4 class="font-semibold text-gray-900 mb-3">基本命令</h4>
          <div class="overflow-x-auto">
            <table class="w-full text-sm">
              <thead class="bg-gray-100">
                <tr>
                  <th class="text-left p-3 font-semibold">命令</th>
                  <th class="text-left p-3 font-semibold">說明</th>
                  <th class="text-left p-3 font-semibold">範例</th>
                </tr>
              </thead>
              <tbody>
                <tr
                  v-for="(cmd, idx) in sections.find(s => s.id === 'commands')?.commands"
                  :key="idx"
                  class="border-b hover:bg-gray-50 transition-colors"
                >
                  <td class="p-3 font-mono text-blue-600">{{ cmd.command }}</td>
                  <td class="p-3">{{ cmd.description }}</td>
                  <td class="p-3 font-mono text-xs text-gray-600">{{ cmd.example }}</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>

        <!-- 快捷鍵 -->
        <div v-if="sections.find(s => s.id === 'commands')?.shortcuts">
          <h4 class="font-semibold text-gray-900 mb-3">快捷鍵</h4>
          <div class="grid md:grid-cols-2 gap-3">
            <div
              v-for="(shortcut, idx) in sections.find(s => s.id === 'commands')?.shortcuts"
              :key="idx"
              class="flex items-center gap-3 bg-gray-50 p-3 rounded hover:bg-gray-100 transition-colors"
            >
              <kbd class="bg-white px-3 py-1 rounded border shadow-sm font-mono text-sm">{{ shortcut.key }}</kbd>
              <span class="text-sm text-gray-700">{{ shortcut.description }}</span>
            </div>
          </div>
        </div>

        <!-- 危險模式 -->
        <div v-if="sections.find(s => s.id === 'commands')?.danger_mode" class="bg-red-50 p-4 rounded-lg border border-red-300">
          <h4 class="font-semibold text-red-800 mb-2">{{ sections.find(s => s.id === 'commands')?.danger_mode?.title }}</h4>
          <p class="text-sm text-red-700 mb-3">{{ sections.find(s => s.id === 'commands')?.danger_mode?.warning }}</p>
          <div class="space-y-3">
            <div
              v-for="(cmd, idx) in sections.find(s => s.id === 'commands')?.danger_mode?.commands"
              :key="idx"
              class="border-l-4 border-red-500 pl-3"
            >
              <p class="text-xs text-gray-600 mb-1">{{ cmd.tool }} - {{ cmd.description }}</p>
              <CodeBlock :code="cmd.command" prefix="$" color="red" />
            </div>
          </div>
        </div>
      </CardContent>
    </Card>

    <!-- 常見問題與錯誤排解 -->
    <Card
      v-if="sections.find(s => s.id === 'troubleshooting')"
      id="troubleshooting"
      class="scroll-mt-20 bg-white scroll-animate card-hover group"
    >
      <CardHeader class="cursor-pointer" @click="toggleSection('troubleshooting')">
        <div class="flex items-center justify-between">
          <div class="flex items-center gap-3">
            <component :is="getIcon('AlertTriangle')" class="h-6 w-6 text-red-600 group-hover:animate-wiggle" />
            <CardTitle class="text-2xl text-gray-900">{{ sections.find(s => s.id === 'troubleshooting')?.title }}</CardTitle>
          </div>
          <span class="text-gray-400">{{ isExpanded('troubleshooting') ? '▼' : '▶' }}</span>
        </div>
        <CardDescription class="text-gray-600">{{ sections.find(s => s.id === 'troubleshooting')?.description }}</CardDescription>
      </CardHeader>
      <CardContent v-show="isExpanded('troubleshooting')" class="space-y-4">
        <div
          v-for="(issue, idx) in sections.find(s => s.id === 'troubleshooting')?.issues"
          :key="idx"
          class="border-l-4 border-red-500 pl-4 hover:border-l-8 transition-all duration-300"
        >
          <h4 class="font-semibold text-red-700">問題：{{ issue.problem }}</h4>
          <p class="text-sm text-gray-700 mt-1">解決方案：{{ issue.solution }}</p>
          <div v-if="issue.command" class="bg-gray-100 p-3 rounded mt-2 font-mono text-sm text-gray-900 hover:bg-gray-200 transition-colors">
            {{ issue.command }}
          </div>
        </div>
      </CardContent>
    </Card>

    <!-- 必要網站註冊 -->
    <Card
      v-if="sections.find(s => s.id === 'registrations')"
      id="site-registrations"
      class="scroll-mt-20 bg-white scroll-animate card-hover group"
    >
      <CardHeader class="cursor-pointer" @click="toggleSection('registrations')">
        <div class="flex items-center justify-between">
          <div class="flex items-center gap-3">
            <component :is="getIcon('Globe')" class="h-6 w-6 text-orange-600 group-hover:animate-spin-slow" />
            <CardTitle class="text-2xl text-gray-900">{{ sections.find(s => s.id === 'registrations')?.title }}</CardTitle>
          </div>
          <span class="text-gray-400">{{ isExpanded('registrations') ? '▼' : '▶' }}</span>
        </div>
        <CardDescription class="text-gray-600">{{ sections.find(s => s.id === 'registrations')?.description }}</CardDescription>
      </CardHeader>
      <CardContent v-show="isExpanded('registrations')" class="space-y-6">
        <!-- 必要註冊 -->
        <div v-if="sections.find(s => s.id === 'registrations')?.required">
          <h4 class="font-semibold text-red-700 mb-3">必要註冊</h4>
          <div class="space-y-3">
            <div
              v-for="(site, idx) in sections.find(s => s.id === 'registrations')?.required"
              :key="idx"
              class="bg-red-50 p-4 rounded-lg border border-red-200 hover:shadow-md transition-shadow"
            >
              <div class="flex items-center justify-between">
                <div>
                  <h5 class="font-semibold text-gray-900">{{ site.name }}</h5>
                  <p class="text-sm text-gray-600">{{ site.description }}</p>
                </div>
                <a
                  :href="site.url"
                  target="_blank"
                  class="bg-red-600 text-white px-4 py-2 rounded hover:bg-red-700 transition-colors text-sm"
                >
                  前往註冊
                </a>
              </div>
            </div>
          </div>
        </div>

        <!-- 建議註冊 -->
        <div v-if="sections.find(s => s.id === 'registrations')?.recommended">
          <h4 class="font-semibold text-yellow-700 mb-3">建議註冊</h4>
          <div class="grid md:grid-cols-2 gap-3">
            <div
              v-for="(site, idx) in sections.find(s => s.id === 'registrations')?.recommended"
              :key="idx"
              class="bg-yellow-50 p-4 rounded-lg border border-yellow-200 hover:shadow-md transition-shadow"
            >
              <h5 class="font-semibold text-gray-900">{{ site.name }}</h5>
              <p class="text-sm text-gray-600 mb-2">{{ site.description }}</p>
              <a
                :href="site.url"
                target="_blank"
                class="text-blue-600 hover:underline text-sm"
              >
                {{ site.url }}
              </a>
            </div>
          </div>
        </div>

        <!-- 選用工具 -->
        <div v-if="sections.find(s => s.id === 'registrations')?.optional">
          <h4 class="font-semibold text-gray-700 mb-3">選用工具</h4>
          <div class="space-y-2">
            <div
              v-for="(site, idx) in sections.find(s => s.id === 'registrations')?.optional"
              :key="idx"
              class="bg-gray-50 p-3 rounded-lg hover:bg-gray-100 transition-colors"
            >
              <div class="flex items-center justify-between">
                <div>
                  <h5 class="font-medium text-gray-900">{{ site.name }}</h5>
                  <p class="text-xs text-gray-600">{{ site.description }}</p>
                </div>
                <a
                  :href="site.url"
                  target="_blank"
                  class="text-blue-600 hover:underline text-sm"
                >
                  前往
                </a>
              </div>
            </div>
          </div>
        </div>
      </CardContent>
    </Card>
    </div>
  </div>
</template>
