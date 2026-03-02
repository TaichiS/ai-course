<script setup lang="ts">
import { Card, CardHeader, CardTitle, CardDescription, CardContent } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import { ChevronDown, ChevronUp, Server, GitBranch, Webhook, Terminal, Sparkles, Puzzle } from 'lucide-vue-next'
import { ref } from 'vue'
import CodeBlock from '@/components/CodeBlock.vue'
import ExternalLinks from '@/components/ExternalLinks.vue'

// 整個區塊的顯示狀態
const isVisible = ref(true)

const toggleVisibility = () => {
  isVisible.value = !isVisible.value
}

// 各個概念卡片的展開狀態
const expandedConcepts = ref<Record<string, boolean>>({})

const toggleConcept = (id: string) => {
  expandedConcepts.value[id] = !expandedConcepts.value[id]
}

const isConceptExpanded = (id: string) => {
  return expandedConcepts.value[id] !== false // 預設展開
}
</script>

<template>
  <div class="space-y-8">
    <!-- 區塊標題 -->
    <div class="text-center py-6">
      <h2 class="text-3xl font-bold text-gray-900 mb-2">核心概念與進階功能</h2>
      <p class="text-gray-600">了解 Claude Code / Gemini CLI 的擴展功能與術語</p>

      <!-- 一鍵隱藏/顯示按鈕 -->
      <button
        @click="toggleVisibility"
        class="mt-4 inline-flex items-center gap-2 px-4 py-2 bg-gradient-to-r from-purple-100 to-indigo-100 hover:from-purple-200 hover:to-indigo-200 text-purple-700 rounded-lg shadow-sm hover:shadow-md transition-all duration-300 text-sm font-medium"
      >
        <component :is="isVisible ? ChevronUp : ChevronDown" class="h-4 w-4" />
        {{ isVisible ? '隱藏概念說明' : '顯示概念說明' }}
      </button>
    </div>

    <!-- 可收合的內容區塊 -->
    <div
      v-show="isVisible"
      class="space-y-8 transition-all duration-500 ease-in-out"
    >
      <!-- MCP Server -->
      <Card
        id="concept-mcp"
        class="scroll-mt-20 bg-white scroll-animate card-hover group"
      >
        <CardHeader class="cursor-pointer" @click="toggleConcept('mcp')">
          <div class="flex items-center justify-between">
            <div class="flex items-center gap-3">
              <Server class="h-6 w-6 text-blue-600 group-hover:animate-pulse" />
              <CardTitle class="text-2xl text-gray-900">MCP Server</CardTitle>
            </div>
            <span class="text-gray-400">{{ isConceptExpanded('mcp') ? '▼' : '▶' }}</span>
          </div>
          <CardDescription class="text-gray-600">Model Context Protocol - AI 助手的擴展能力</CardDescription>
        </CardHeader>
        <CardContent v-show="isConceptExpanded('mcp')" class="space-y-4">
          <div class="bg-blue-50 p-4 rounded-lg border border-blue-200">
            <p class="text-gray-700 mb-3">
              MCP (Model Context Protocol) 是 Anthropic 開發的開放標準協議，讓 AI 助手能夠安全地連接外部數據源和工具。
            </p>
          </div>

          <div class="space-y-3">
            <h4 class="font-semibold text-gray-900">MCP Server 提供的資源類型：</h4>
            <div class="grid md:grid-cols-3 gap-3">
              <div class="bg-gray-50 p-3 rounded-lg">
                <Badge variant="outline" class="mb-2">數據源</Badge>
                <p class="text-sm text-gray-700">資料庫、文件系統、API 等</p>
              </div>
              <div class="bg-gray-50 p-3 rounded-lg">
                <Badge variant="outline" class="mb-2">工具</Badge>
                <p class="text-sm text-gray-700">執行特定操作的功能</p>
              </div>
              <div class="bg-gray-50 p-3 rounded-lg">
                <Badge variant="outline" class="mb-2">提示詞模板</Badge>
                <p class="text-sm text-gray-700">預定義的互動模式</p>
              </div>
            </div>
          </div>

          <div class="bg-green-50 p-4 rounded-lg border border-green-200">
            <h4 class="font-semibold text-green-800 mb-2">核心優勢</h4>
            <ul class="list-disc list-inside text-sm text-gray-700 space-y-1">
              <li>標準化協議，一個 server 可被多個 AI 應用重複使用</li>
              <li>支援本地運行和遠端連接</li>
              <li>注重安全性和隔離性，只訪問明確授權的資源</li>
              <li>大幅降低整合成本</li>
            </ul>
          </div>

          <div class="space-y-2">
            <h4 class="font-semibold text-gray-900">常用 MCP 指令：</h4>
            <CodeBlock :code="['claude mcp add <name> <command>', 'claude mcp list', 'claude mcp remove <name>']" />
          </div>

          <ExternalLinks
            :links="[
              { label: 'MCP 整合平台', url: 'https://mcp.so/' },
              { label: '精選 MCP 伺服器列表', url: 'https://github.com/punkpeye/awesome-mcp-servers/blob/main/README-zh_TW.md' }
            ]"
          />
        </CardContent>
      </Card>

      <!-- Sub Agent -->
      <Card
        id="concept-subagent"
        class="scroll-mt-20 bg-white scroll-animate card-hover group"
      >
        <CardHeader class="cursor-pointer" @click="toggleConcept('subagent')">
          <div class="flex items-center justify-between">
            <div class="flex items-center gap-3">
              <GitBranch class="h-6 w-6 text-purple-600 group-hover:animate-pulse" />
              <CardTitle class="text-2xl text-gray-900">Sub Agent 子代理</CardTitle>
            </div>
            <span class="text-gray-400">{{ isConceptExpanded('subagent') ? '▼' : '▶' }}</span>
          </div>
          <CardDescription class="text-gray-600">派生專門的子代理處理特定任務</CardDescription>
        </CardHeader>
        <CardContent v-show="isConceptExpanded('subagent')" class="space-y-4">
          <div class="bg-purple-50 p-4 rounded-lg border border-purple-200">
            <p class="text-gray-700">
              Sub Agent 讓主要的 Claude Code agent 能夠派生出專門的子代理來處理特定任務。當面對複雜的編程專案時，主 agent 可以創建多個 sub agents，每個負責不同的子任務。
            </p>
          </div>

          <div class="grid md:grid-cols-2 gap-4">
            <div class="bg-gray-50 p-4 rounded-lg">
              <h4 class="font-semibold text-gray-900 mb-2">應用場景</h4>
              <ul class="list-disc list-inside text-sm text-gray-700 space-y-1">
                <li>一個處理前端開發</li>
                <li>另一個負責後端 API</li>
                <li>還有一個進行測試</li>
              </ul>
            </div>
            <div class="bg-gray-50 p-4 rounded-lg">
              <h4 class="font-semibold text-gray-900 mb-2">核心特點</h4>
              <ul class="list-disc list-inside text-sm text-gray-700 space-y-1">
                <li>可以並行工作，提高效率</li>
                <li>擁有獨立的上下文和工具訪問權限</li>
                <li>主 agent 負責協調和整合工作成果</li>
              </ul>
            </div>
          </div>

          <div class="bg-yellow-50 p-4 rounded-lg border border-yellow-200">
            <p class="text-sm text-gray-700">
              <strong>適用情境：</strong>大型、多模組的開發任務，能夠模擬團隊協作的方式，讓複雜的編程工作變得更加結構化和可管理。
            </p>
          </div>
        </CardContent>
      </Card>

      <!-- Hook -->
      <Card
        id="concept-hook"
        class="scroll-mt-20 bg-white scroll-animate card-hover group"
      >
        <CardHeader class="cursor-pointer" @click="toggleConcept('hook')">
          <div class="flex items-center justify-between">
            <div class="flex items-center gap-3">
              <Webhook class="h-6 w-6 text-orange-600 group-hover:animate-pulse" />
              <CardTitle class="text-2xl text-gray-900">Hook 鉤子</CardTitle>
            </div>
            <span class="text-gray-400">{{ isConceptExpanded('hook') ? '▼' : '▶' }}</span>
          </div>
          <CardDescription class="text-gray-600">在特定時間點插入自定義邏輯的回調機制</CardDescription>
        </CardHeader>
        <CardContent v-show="isConceptExpanded('hook')" class="space-y-4">
          <div class="bg-orange-50 p-4 rounded-lg border border-orange-200">
            <p class="text-gray-700">
              Hook 是一種可自訂的回調機制，讓使用者能夠在 Claude Code 執行流程的特定時間點插入自定義邏輯。
            </p>
          </div>

          <div class="space-y-3">
            <h4 class="font-semibold text-gray-900">Hook 類型：</h4>
            <div class="grid md:grid-cols-3 gap-3">
              <div class="border-l-4 border-green-500 pl-3">
                <p class="font-medium text-gray-900">執行前 Hook</p>
                <p class="text-sm text-gray-600">在命令運行前進行準備工作</p>
              </div>
              <div class="border-l-4 border-blue-500 pl-3">
                <p class="font-medium text-gray-900">執行後 Hook</p>
                <p class="text-sm text-gray-600">任務完成後進行清理、記錄或通知</p>
              </div>
              <div class="border-l-4 border-red-500 pl-3">
                <p class="font-medium text-gray-900">錯誤 Hook</p>
                <p class="text-sm text-gray-600">捕獲錯誤訊息並執行自定義處理</p>
              </div>
            </div>
          </div>

          <div class="bg-gray-100 p-4 rounded-lg">
            <h4 class="font-semibold text-gray-900 mb-2">範例提示詞：</h4>
            <div class="text-sm text-gray-700 bg-white p-3 rounded border italic">
              請為我設計一個 hook，觸發時機是每次任務完成時，使用系統 say 指令進行簡短的報告。例如：「您要求的價格查詢比較的任務，我已經完成了。」
            </div>
          </div>
        </CardContent>
      </Card>

      <!-- Slash Commands -->
      <Card
        id="concept-slash-commands"
        class="scroll-mt-20 bg-white scroll-animate card-hover group"
      >
        <CardHeader class="cursor-pointer" @click="toggleConcept('slash-commands')">
          <div class="flex items-center justify-between">
            <div class="flex items-center gap-3">
              <Terminal class="h-6 w-6 text-cyan-600 group-hover:animate-pulse" />
              <CardTitle class="text-2xl text-gray-900">Slash Commands 自定義斜線命令</CardTitle>
            </div>
            <span class="text-gray-400">{{ isConceptExpanded('slash-commands') ? '▼' : '▶' }}</span>
          </div>
          <CardDescription class="text-gray-600">創建專屬的快捷指令，簡化重複性工作</CardDescription>
        </CardHeader>
        <CardContent v-show="isConceptExpanded('slash-commands')" class="space-y-4">
          <div class="bg-cyan-50 p-4 rounded-lg border border-cyan-200">
            <p class="text-gray-700">
              自定義斜線命令讓使用者能夠創建專屬的快捷指令，將多步驟操作濃縮為一個簡單指令。
            </p>
          </div>

          <div class="grid md:grid-cols-2 gap-4">
            <div>
              <h4 class="font-semibold text-gray-900 mb-2">應用範例：</h4>
              <ul class="list-disc list-inside text-sm text-gray-700 space-y-1">
                <li><code class="bg-gray-100 px-1 rounded">/upload</code> - 自動把文章更新到 Notion</li>
                <li><code class="bg-gray-100 px-1 rounded">/review</code> - 執行代碼審查檢查清單</li>
                <li><code class="bg-gray-100 px-1 rounded">/docs</code> - 生成或更新文件</li>
              </ul>
            </div>
            <div>
              <h4 class="font-semibold text-gray-900 mb-2">命令可包含：</h4>
              <ul class="list-disc list-inside text-sm text-gray-700 space-y-1">
                <li><strong>預設提示詞</strong> - 告訴 Claude 具體要做什麼</li>
                <li><strong>參數設定</strong> - 接收動態輸入</li>
                <li><strong>工作流程</strong> - 串連多個步驟</li>
              </ul>
            </div>
          </div>

          <!-- 檔案格式對比 -->
          <div class="space-y-3">
            <h4 class="font-semibold text-gray-900">檔案格式對比：</h4>
            <div class="overflow-x-auto">
              <table class="w-full text-sm">
                <thead class="bg-gray-100">
                  <tr>
                    <th class="text-left p-3 font-semibold">CLI 工具</th>
                    <th class="text-left p-3 font-semibold">檔案格式</th>
                    <th class="text-left p-3 font-semibold">副檔名</th>
                    <th class="text-left p-3 font-semibold">內容插入</th>
                  </tr>
                </thead>
                <tbody>
                  <tr class="border-b">
                    <td class="p-3 font-mono text-blue-600">Claude Code</td>
                    <td class="p-3">Markdown + YAML</td>
                    <td class="p-3 font-mono">.md</td>
                    <td class="p-3 font-mono text-xs">$ARGUMENTS, !cmd</td>
                  </tr>
                  <tr>
                    <td class="p-3 font-mono text-green-600">Gemini CLI</td>
                    <td class="p-3">TOML (key-value)</td>
                    <td class="p-3 font-mono">.toml</td>
                    <td class="p-3 font-mono text-xs" v-text="'{{args}}, !{cmd}'"></td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>

          <!-- Claude Code 範例 -->
          <div class="space-y-2">
            <h4 class="font-semibold text-gray-900">Claude Code 範例 (.claude/commands/say.md)：</h4>
            <CodeBlock :code="`---
description: &quot;這是一個使用系統發出語音的簡單命令測試&quot;
allowed-tools: Bash(say:*)
---

使用 shell script 執行
say &quot;語音測試成功&quot;`" />
          </div>

          <!-- Gemini CLI 範例 -->
          <div class="space-y-2">
            <h4 class="font-semibold text-gray-900">Gemini CLI 範例 (.gemini/commands/say.toml)：</h4>
            <CodeBlock :code="`description = &quot;語音測試&quot;
prompt = &quot;請使用 shell 指令，執行 say '語音測試成功&quot;`" />
          </div>
        </CardContent>
      </Card>

      <!-- Skills -->
      <Card
        id="concept-skills"
        class="scroll-mt-20 bg-white scroll-animate card-hover group"
      >
        <CardHeader class="cursor-pointer" @click="toggleConcept('skills')">
          <div class="flex items-center justify-between">
            <div class="flex items-center gap-3">
              <Sparkles class="h-6 w-6 text-yellow-600 group-hover:animate-pulse" />
              <CardTitle class="text-2xl text-gray-900">Skills 技能</CardTitle>
            </div>
            <span class="text-gray-400">{{ isConceptExpanded('skills') ? '▼' : '▶' }}</span>
          </div>
          <CardDescription class="text-gray-600">讓你的 AI 增加特定的技能</CardDescription>
        </CardHeader>
        <CardContent v-show="isConceptExpanded('skills')" class="space-y-4">
          <div class="bg-yellow-50 p-4 rounded-lg border border-yellow-200">
            <p class="text-gray-700">
              <a href="https://github.com/anthropics/skills" target="_blank" class="text-blue-600 hover:underline">Claude Code Skills</a> 是一套預先定義的最佳實踐指南，幫助 Claude Code 在處理特定類型任務時產出更高品質的結果。
            </p>
          </div>

          <!-- Skills 特點 -->
          <div class="grid md:grid-cols-2 gap-4">
            <div class="bg-gray-50 p-4 rounded-lg">
              <h4 class="font-semibold text-gray-900 mb-2">Skills 的特點：</h4>
              <ul class="list-disc list-inside text-sm text-gray-700 space-y-1">
                <li><strong>專業化知識庫</strong> - 針對不同檔案類型提供專門處理技巧</li>
                <li><strong>最佳實踐集合</strong> - 濃縮大量測試和優化後的經驗</li>
                <li><strong>自動載入</strong> - 處理相關任務時自動讀取 SKILL.md</li>
                <li><strong>節省 tokens</strong> - 相較 MCP 可能耗用 5-6 倍以上的 token</li>
              </ul>
            </div>
            <div class="bg-gray-50 p-4 rounded-lg">
              <h4 class="font-semibold text-gray-900 mb-2">適合使用 Skills：</h4>
              <ul class="list-disc list-inside text-sm text-gray-700 space-y-1">
                <li>結構化、可重複的任務（文件處理、程式碼審查）</li>
                <li>需要遵循固定流程的工作（合規檢查、報告生成）</li>
                <li>需要團隊協作的場景（企業標準、品牌規範）</li>
              </ul>
            </div>
          </div>

          <!-- 判斷準則 -->
          <div class="bg-amber-50 p-4 rounded-lg border border-amber-200">
            <h4 class="font-semibold text-amber-800 mb-2">🎯 判斷準則：什麼時候該做成 Skill？</h4>
            <p class="text-gray-700 font-medium mb-2">
              「如果有一件事，你每週會重複做一次，每次你會做超過 30 分鐘。那你就該把它做成 skill。」
            </p>
            <p class="text-sm text-gray-600">
              這個簡單的判斷標準能幫助你識別哪些工作值得投資時間做成 Skill，讓 AI 助理自動化處理。
            </p>
          </div>

          <!-- 不適合 Skills -->
          <div class="bg-red-50 p-4 rounded-lg border border-red-200">
            <h4 class="font-semibold text-red-800 mb-2">Skills 不適合：</h4>
            <ul class="list-disc list-inside text-sm text-gray-700 space-y-1">
              <li>一次性的創意任務（如寫一篇獨特的文章）</li>
              <li>高度靈活的探索性工作（如頭腦風暴）</li>
              <li>簡單的日常對話（如閒聊、答疑）</li>
            </ul>
          </div>

          <!-- 安裝官方 Skills -->
          <div class="space-y-3">
            <h4 class="font-semibold text-gray-900">安裝官方 Skills（使用 Claude Plugins）：</h4>
            <CodeBlock :code="['/plugin marketplace add anthropics/skills', '/plugin', 'Browse and install plugins', '選取 document-skills', 'Select Install now']" />
          </div>

          <!-- 創建自己的 Skills -->
          <div class="space-y-3">
            <h4 class="font-semibold text-gray-900">創建自己的 Skills：</h4>
            <div class="grid md:grid-cols-2 gap-3">
              <div class="border-l-4 border-blue-500 pl-3">
                <p class="font-medium text-gray-900">個人 Skills（全域）</p>
                <code class="text-xs bg-gray-100 px-2 py-1 rounded block mt-1">~/.claude/skills/</code>
              </div>
              <div class="border-l-4 border-green-500 pl-3">
                <p class="font-medium text-gray-900">項目 Skills（當前資料夾）</p>
                <code class="text-xs bg-gray-100 px-2 py-1 rounded block mt-1">.claude/skills/</code>
              </div>
            </div>
          </div>

          <!-- SKILL.md 範例 -->
          <div class="space-y-2">
            <h4 class="font-semibold text-gray-900">SKILL.md 範例結構：</h4>
            <CodeBlock :code="`---
name: &quot;行銷文案專家&quot;
description: &quot;專業行銷內容助理，協助撰寫廣告文案、社群貼文、產品說明等...&quot;
---

底下開始詳細描述這個行銷助理需要遵守的規範

文案風格規範：
- 目標受眾：25-45 歲的職場專業人士
- 語調：專業但不失親和，避免過度使用術語
- 每則社群貼文長度控制在 150 字以內
...`" />
          </div>

          <!-- 教師應用範例 -->
          <div class="bg-indigo-50 p-4 rounded-lg border border-indigo-200">
            <h4 class="font-semibold text-indigo-800 mb-2">各種角色都可以創建的 Skills：</h4>
            <ul class="list-disc list-inside text-sm text-gray-700 space-y-1">
              <li><strong>企業主</strong> - 客服回覆規範、品牌語調標準、報價單格式</li>
              <li><strong>創作者</strong> - 內容風格指南、發文頻率模板、受眾定位規範</li>
              <li><strong>專業工作者</strong> - 文件格式標準、工作流程規範、報告撰寫模板</li>
            </ul>
          </div>

          <!-- 自我進化提示詞 -->
          <div class="bg-emerald-50 p-4 rounded-lg border border-emerald-200">
            <h4 class="font-semibold text-emerald-800 mb-3">🌱 進階技巧：為 Skill 新增「自我進化」能力</h4>
            <p class="text-sm text-gray-700 mb-3">
              將以下提示詞加入 SKILL.md 末尾，讓你的 Skill 具備持續學習與自我完善的能力：
            </p>
            <CodeBlock :code="`## 自我進化機制

自即日起，在執行任務的過程中，該 Skill 應具備持續學習與自我完善的意識。

當出現以下情況時，請將相關內容記錄至該 Skill 目錄下的 knowledge/ 資料夾中：
- 遇到現有知識無法解決的問題
- 使用者提供了修正或更佳的建議
- 發現值得記錄與複用的成功經驗
- 遭遇原有指令未涵蓋的特殊情境

每次開始新任務時，請先讀取該資料夾中既有的知識；每次完成任務後，將新學到的內容追加進去。

若你判斷該 Skill 的核心指令有優化空間，請主動向使用者提出你的建議。

透過此機制，該 Skill 將隨著使用次數的累積，持續變得更強大且更精準。`" />
            <p class="text-xs text-gray-500 mt-2">
              💡 使用方式：將以上內容新增至 SKILL.md 檔案末尾，並建立 knowledge/ 資料夾即可。
            </p>
          </div>

          <ExternalLinks
            :links="[
              { label: 'Skills 整合平台', url: 'https://www.skillsclaude.com/' }
            ]"
          />
        </CardContent>
      </Card>

      <!-- Plugins -->
      <Card
        id="concept-plugins"
        class="scroll-mt-20 bg-white scroll-animate card-hover group"
      >
        <CardHeader class="cursor-pointer" @click="toggleConcept('plugins')">
          <div class="flex items-center justify-between">
            <div class="flex items-center gap-3">
              <Puzzle class="h-6 w-6 text-green-600 group-hover:animate-pulse" />
              <CardTitle class="text-2xl text-gray-900">Plugins 擴充套件</CardTitle>
            </div>
            <span class="text-gray-400">{{ isConceptExpanded('plugins') ? '▼' : '▶' }}</span>
          </div>
          <CardDescription class="text-gray-600">一次配置 Sub Agent、MCP Server、Hook 的打包服務</CardDescription>
        </CardHeader>
        <CardContent v-show="isConceptExpanded('plugins')" class="space-y-4">
          <div class="bg-green-50 p-4 rounded-lg border border-green-200">
            <p class="text-gray-700">
              <a href="https://docs.claude.com/zh-TW/docs/claude-code/plugin-marketplaces" target="_blank" class="text-blue-600 hover:underline">Claude Plugins</a> 幫你一次配置 Sub Agent、MCP Server、Hook，等於是打包好的服務。就像是一個大禮包，可以直接安裝所有其他人已經預先設定好的功能。
            </p>
          </div>

          <div class="bg-gray-50 p-4 rounded-lg">
            <h4 class="font-semibold text-gray-900 mb-2">包含內容：</h4>
            <div class="flex flex-wrap gap-2">
              <Badge class="bg-blue-100 text-blue-800">MCP Server</Badge>
              <Badge class="bg-purple-100 text-purple-800">Skills</Badge>
              <Badge class="bg-orange-100 text-orange-800">Sub Agent</Badge>
              <Badge class="bg-yellow-100 text-yellow-800">Hook</Badge>
            </div>
          </div>

          <div class="space-y-2">
            <h4 class="font-semibold text-gray-900">安裝 Playwright Skill 範例：</h4>
            <CodeBlock :code="['# 安裝市場', '/plugin marketplace add lackeyjb/playwright-skill', '', '# 安裝套件', '/plugin install playwright-skill@playwright-skill', '', '# 後續設定', 'cd ~/.claude/plugins/marketplaces/playwright-skill/skills/playwright-skill', 'npm run setup']" />
          </div>

          <ExternalLinks
            :links="[
              { label: 'Claude Plugins 市場', url: 'https://claudecodemarketplace.com/' }
            ]"
          />
        </CardContent>
      </Card>
    </div>
  </div>
</template>
