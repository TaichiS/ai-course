<script setup lang="ts">
import { Download, BookOpen, Sparkles, ArrowRight, Presentation } from 'lucide-vue-next'

const instructorImg = `${import.meta.env.BASE_URL}instructor.png`
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

    <!-- 講師介紹 -->
    <div class="mt-20 bg-white rounded-2xl border border-gray-200 shadow-sm overflow-hidden">
      <div class="h-2 bg-gradient-to-r from-blue-400 via-purple-400 to-indigo-400"></div>
      <div class="p-10">

        <!-- 上半：照片 + 基本資訊 + Hero 文字 -->
        <div class="md:flex gap-10 items-start mb-10">
          <div class="flex-shrink-0 mb-6 md:mb-0">
            <img
              :src="instructorImg"
              alt="詹嘉隆"
              class="w-36 rounded-2xl object-cover shadow-md"
            />
          </div>
          <div class="flex-1">
            <h3 class="text-2xl font-bold text-gray-900">詹嘉隆</h3>
            <p class="text-blue-600 font-semibold mt-1">AI 工具導入與培訓顧問</p>

            <!-- 身份標籤 -->
            <div class="flex flex-wrap gap-2 mt-3 mb-5">
              <span class="px-3 py-1 bg-blue-50 text-blue-700 text-xs font-medium rounded-full border border-blue-100">台灣人工智慧發展學會 顧問</span>
              <span class="px-3 py-1 bg-purple-50 text-purple-700 text-xs font-medium rounded-full border border-purple-100">雲林縣楊家老架太極武藝協會 理事長</span>
              <span class="px-3 py-1 bg-gray-50 text-gray-600 text-xs font-medium rounded-full border border-gray-200">前正心高中特教組長・資訊組長</span>
            </div>

            <!-- Hero 文字 -->
            <p class="text-gray-500 text-sm leading-relaxed">
              有人說我是老師，有人說我是老闆，有人叫我理事長，現在又多了一個名字——AI 顧問。
            </p>
            <p class="text-gray-800 font-medium text-sm mt-2">
              我說，這些其實是同一件事：<span class="text-blue-600">在別人還沒看見的地方，先走一步。</span>
            </p>
          </div>
        </div>

        <!-- 分隔線 -->
        <div class="border-t border-gray-100 mb-8"></div>

        <!-- 故事段落 -->
        <div class="space-y-5 text-gray-600 text-sm leading-loose max-w-3xl">
          <p>我在教室裡待了十五年。</p>
          <p>
            當老師的那些年，我學會不用「標準答案」看人。每一個學生都有自己的節奏，教育的本質不是灌輸，而是陪著對方找到自己走得動的那條路。後來轉任特教組長、資訊組長，我開始和技術打交道，但我始終記得：工具是手段，人才是核心。
          </p>
          <p>學校之外，我回到家裡那間開了二十年的餐廳。</p>
          <p>
            一間老店的日常，從來不輕鬆。食材、人事、帳目、客人的臉色——每一天都在考驗判斷力。我在其中學到的，是如何在資源有限的現實裡，找到剛好夠用的解法。不浪費，不將就。
          </p>
          <p>閒暇，我打太極拳。</p>
          <p>
            楊家老架，一式一式，慢得像在跟時間談判。我是雲林縣楊家老架太極武藝協會的理事長，但我說，打拳教會我的不是招式，是<strong class="text-gray-800">在動與靜之間，保持清醒</strong>。
          </p>
          <p>我也是一間智慧眼鏡代理公司的董事長。</p>
          <p>
            公司成立至今，一支眼鏡都還沒進口。不是因為懈怠，而是因為還沒找到那個值得帶進來的產品。我不急。賣一個自己不相信的東西，比什麼都還不進口更可惜。
          </p>
          <p>
            AI 時代來了，我看到很多陷入困難的中小企業主——那些沒有資訊部門、沒有預算請顧問、每天忙到沒空想未來的中小企業主。我發現，市面上八成的 AI 課程，對這群人來說幾乎是無用的。內容太遠、工具太抽象、沒有人告訴他們「這跟你每天做的事，到底有什麼關係」。
          </p>
          <p>於是我換了一種方式。</p>
          <p>
            我走進電商倉庫，坐在成衣工廠的辦公室，站在門窗建材行的展示間。我先工作，再教學。我把 AI 工具拆解成對方聽得懂的語言，組裝進他們原本的工作流裡。不是讓人去適應工具，而是讓工具去配合人。
          </p>
          <p class="text-gray-700 font-medium">
            我把這件事叫做「企業的家教課」——因為每一堂都不一樣，因為每一個人都值得被好好看見。
          </p>
        </div>

        <!-- 核心理念 -->
        <blockquote class="mt-8 border-l-4 border-blue-400 pl-5 py-3 bg-blue-50 rounded-r-xl">
          <p class="text-gray-800 font-medium text-sm leading-relaxed">
            「不是要你學會寫程式，而是要你學會指揮 AI。」
          </p>
        </blockquote>

        <!-- 聯絡 -->
        <div class="mt-8 pt-6 border-t border-gray-100 flex items-center justify-between flex-wrap gap-4">
          <p class="text-gray-400 text-xs">服務對象涵蓋中小企業、學校教育機構與企業內部培訓，課程後持續提供線上支援。</p>
          <a
            href="mailto:luuung@gmail.com"
            class="inline-flex items-center gap-2 text-sm text-gray-500 hover:text-blue-600 transition-colors duration-200 font-medium"
          >
            📧 luuung@gmail.com
          </a>
        </div>

      </div>
    </div>
  </main>
</template>
