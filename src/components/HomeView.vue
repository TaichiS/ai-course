<script setup lang="ts">
import { Download, BookOpen, Sparkles, ArrowRight, Presentation } from 'lucide-vue-next'
</script>

<template>
  <main class="max-w-6xl mx-auto px-8 py-16">
    <div class="text-center mb-14">
      <h2 class="text-3xl font-bold text-gray-900 mb-3">選擇學習主題</h2>
      <p class="text-gray-500 text-lg">從以下主題開始你的 AI Agent 學習之旅</p>
    </div>

    <div class="grid md:grid-cols-2 lg:grid-cols-4 gap-8">
      <!-- 環境安裝 -->
      <router-link
        to="/installation"
        class="group text-left bg-white rounded-2xl border border-gray-200 shadow-sm hover:shadow-xl hover:-translate-y-1 transition-all duration-300 overflow-hidden"
      >
        <div class="h-2 bg-gradient-to-r from-green-400 to-blue-400"></div>
        <div class="p-8">
          <div class="w-14 h-14 bg-green-50 rounded-xl flex items-center justify-center mb-6 group-hover:scale-110 transition-transform duration-300">
            <Download class="h-7 w-7 text-green-600" />
          </div>
          <h3 class="text-xl font-bold text-gray-900 mb-3">環境安裝</h3>
          <p class="text-gray-500 text-sm leading-relaxed mb-6">
            安裝 Claude Code、Gemini CLI 及相關開發環境，並完成所有必要的設定與驗證步驟。
          </p>
          <span class="inline-flex items-center gap-2 text-green-600 font-semibold text-sm group-hover:gap-3 transition-all duration-300">
            開始設定
            <ArrowRight class="h-4 w-4" />
          </span>
        </div>
      </router-link>

      <!-- 課程模組 -->
      <router-link
        to="/courses"
        class="group text-left bg-white rounded-2xl border border-gray-200 shadow-sm hover:shadow-xl hover:-translate-y-1 transition-all duration-300 overflow-hidden"
      >
        <div class="h-2 bg-gradient-to-r from-purple-400 to-indigo-400"></div>
        <div class="p-8">
          <div class="w-14 h-14 bg-purple-50 rounded-xl flex items-center justify-center mb-6 group-hover:scale-110 transition-transform duration-300">
            <BookOpen class="h-7 w-7 text-purple-600" />
          </div>
          <h3 class="text-xl font-bold text-gray-900 mb-3">課程模組</h3>
          <p class="text-gray-500 text-sm leading-relaxed mb-6">
            涵蓋工具簡介、Markdown 格式、核心概念（MCP、Sub Agent、Hook）以及實作案例。
          </p>
          <span class="inline-flex items-center gap-2 text-purple-600 font-semibold text-sm group-hover:gap-3 transition-all duration-300">
            開始學習
            <ArrowRight class="h-4 w-4" />
          </span>
        </div>
      </router-link>

      <!-- OpenClaw 應用場景 -->
      <router-link
        to="/openclaw"
        class="group text-left bg-white rounded-2xl border border-gray-200 shadow-sm hover:shadow-xl hover:-translate-y-1 transition-all duration-300 overflow-hidden"
      >
        <div class="h-2 bg-gradient-to-r from-cyan-400 to-blue-500"></div>
        <div class="p-8">
          <div class="w-14 h-14 bg-cyan-50 rounded-xl flex items-center justify-center mb-6 group-hover:scale-110 transition-transform duration-300">
            <Sparkles class="h-7 w-7 text-cyan-600" />
          </div>
          <h3 class="text-xl font-bold text-gray-900 mb-3">OpenClaw 應用場景</h3>
          <p class="text-gray-500 text-sm leading-relaxed mb-6">
            探索 41 個 AI 自動化應用場景，橫跨 13 個領域，發現 AI Agent 的無限可能。
          </p>
          <span class="inline-flex items-center gap-2 text-cyan-600 font-semibold text-sm group-hover:gap-3 transition-all duration-300">
            探索場景
            <ArrowRight class="h-4 w-4" />
          </span>
        </div>
      </router-link>

      <!-- Agent Skills 簡報 -->
      <a
        href="/ai-course/slides.html"
        class="group text-left bg-white rounded-2xl border border-gray-200 shadow-sm hover:shadow-xl hover:-translate-y-1 transition-all duration-300 overflow-hidden"
      >
        <div class="h-2 bg-gradient-to-r from-orange-400 to-pink-500"></div>
        <div class="p-8">
          <div class="w-14 h-14 bg-orange-50 rounded-xl flex items-center justify-center mb-6 group-hover:scale-110 transition-transform duration-300">
            <Presentation class="h-7 w-7 text-orange-600" />
          </div>
          <h3 class="text-xl font-bold text-gray-900 mb-3">Agent Skills 簡報</h3>
          <p class="text-gray-500 text-sm leading-relaxed mb-6">
            互動式投影片教學，17 頁完整內容，了解如何讓 AI 記住你的工作方式。
          </p>
          <span class="inline-flex items-center gap-2 text-orange-600 font-semibold text-sm group-hover:gap-3 transition-all duration-300">
            觀看簡報
            <ArrowRight class="h-4 w-4" />
          </span>
        </div>
      </a>
    </div>
  </main>
</template>
