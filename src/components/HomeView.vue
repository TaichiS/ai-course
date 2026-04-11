<script setup lang="ts">
import { onMounted, onUnmounted } from 'vue'
import { Download, BookOpen, Sparkles, ArrowRight, Presentation, Mail } from 'lucide-vue-next'

const instructorImg = `${import.meta.env.BASE_URL}instructor.jpg`

let observer: IntersectionObserver | null = null

onMounted(() => {
  observer = new IntersectionObserver(
    (entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) entry.target.classList.add('animate-in')
      })
    },
    { threshold: 0.08, rootMargin: '0px 0px -40px 0px' }
  )
  setTimeout(() => {
    document.querySelectorAll('.home-animate').forEach((el, i) => {
      setTimeout(() => observer?.observe(el), i * 80)
    })
  }, 200)
})

onUnmounted(() => observer?.disconnect())
</script>

<template>
  <main class="bg-slate-50 min-h-screen">

    <!-- ═══════════════════════════════════════
         Hero Section
    ════════════════════════════════════════════ -->
    <section class="pt-12 pb-8 px-6 max-w-6xl mx-auto">
      <div class="home-animate opacity-0 translate-y-4 transition-all duration-700">
        <p class="text-sky-600 font-semibold text-sm tracking-widest uppercase mb-3">
          AI Agent 實戰培訓
        </p>
        <h2 class="text-4xl md:text-5xl font-bold text-slate-900 leading-tight mb-4">
          選擇你的<br class="md:hidden" />
          <span class="text-transparent bg-clip-text bg-gradient-to-r from-sky-500 to-indigo-500">學習起點</span>
        </h2>
        <p class="text-slate-500 text-lg max-w-xl leading-relaxed">
          從環境安裝到實戰應用，帶你用 AI Agent 處理真實工作場景。
        </p>
      </div>

      <!-- Stats Bar -->
      <div class="home-animate opacity-0 translate-y-4 transition-all duration-700 mt-8 flex flex-wrap gap-x-8 gap-y-3">
        <div class="flex items-center gap-2">
          <span class="text-2xl font-bold text-slate-800">41</span>
          <span class="text-slate-500 text-sm">個應用場景</span>
        </div>
        <div class="w-px h-6 bg-slate-300 self-center hidden sm:block"></div>
        <div class="flex items-center gap-2">
          <span class="text-2xl font-bold text-slate-800">13</span>
          <span class="text-slate-500 text-sm">個領域分類</span>
        </div>
        <div class="w-px h-6 bg-slate-300 self-center hidden sm:block"></div>
        <div class="flex items-center gap-2">
          <span class="text-2xl font-bold text-slate-800">5</span>
          <span class="text-slate-500 text-sm">種平台支援</span>
        </div>
        <div class="w-px h-6 bg-slate-300 self-center hidden sm:block"></div>
        <div class="flex items-center gap-2">
          <span class="text-2xl font-bold text-slate-800">15</span>
          <span class="text-slate-500 text-sm">年教學實戰</span>
        </div>
      </div>
    </section>

    <!-- ═══════════════════════════════════════
         Navigation Cards (2 × 2)
    ════════════════════════════════════════════ -->
    <section class="px-6 pb-12 max-w-6xl mx-auto">
      <div class="grid sm:grid-cols-2 gap-5">

        <!-- 環境安裝 -->
        <router-link
          to="/installation"
          class="home-animate opacity-0 translate-y-4 transition-all duration-700 group bg-white rounded-2xl border border-slate-200 shadow-sm hover:shadow-lg hover:-translate-y-1 overflow-hidden cursor-pointer block"
        >
          <div class="h-1.5 bg-gradient-to-r from-emerald-400 to-teal-400"></div>
          <div class="p-7 flex gap-5 items-start">
            <div class="flex-shrink-0 w-12 h-12 bg-emerald-50 rounded-xl flex items-center justify-center group-hover:bg-emerald-100 transition-colors duration-200">
              <Download class="h-6 w-6 text-emerald-600" />
            </div>
            <div class="flex-1 min-w-0">
              <h3 class="text-lg font-bold text-slate-900 mb-1.5">環境安裝</h3>
              <p class="text-slate-500 text-sm leading-relaxed mb-4">
                安裝 Claude Code、Gemini CLI 及相關開發環境，完成所有必要設定與驗證步驟。
              </p>
              <span class="inline-flex items-center gap-1.5 text-emerald-600 font-semibold text-sm group-hover:gap-2.5 transition-all duration-200">
                開始設定
                <ArrowRight class="h-4 w-4" />
              </span>
            </div>
          </div>
        </router-link>

        <!-- 課程模組 -->
        <router-link
          to="/courses"
          class="home-animate opacity-0 translate-y-4 transition-all duration-700 group bg-white rounded-2xl border border-slate-200 shadow-sm hover:shadow-lg hover:-translate-y-1 overflow-hidden cursor-pointer block"
        >
          <div class="h-1.5 bg-gradient-to-r from-violet-400 to-indigo-500"></div>
          <div class="p-7 flex gap-5 items-start">
            <div class="flex-shrink-0 w-12 h-12 bg-violet-50 rounded-xl flex items-center justify-center group-hover:bg-violet-100 transition-colors duration-200">
              <BookOpen class="h-6 w-6 text-violet-600" />
            </div>
            <div class="flex-1 min-w-0">
              <h3 class="text-lg font-bold text-slate-900 mb-1.5">課程模組</h3>
              <p class="text-slate-500 text-sm leading-relaxed mb-4">
                涵蓋工具簡介、Markdown 格式、核心概念（MCP、Sub Agent、Hook）以及實作案例。
              </p>
              <span class="inline-flex items-center gap-1.5 text-violet-600 font-semibold text-sm group-hover:gap-2.5 transition-all duration-200">
                開始學習
                <ArrowRight class="h-4 w-4" />
              </span>
            </div>
          </div>
        </router-link>

        <!-- OpenClaw 應用場景 -->
        <router-link
          to="/openclaw"
          class="home-animate opacity-0 translate-y-4 transition-all duration-700 group bg-white rounded-2xl border border-slate-200 shadow-sm hover:shadow-lg hover:-translate-y-1 overflow-hidden cursor-pointer block"
        >
          <div class="h-1.5 bg-gradient-to-r from-sky-400 to-cyan-400"></div>
          <div class="p-7 flex gap-5 items-start">
            <div class="flex-shrink-0 w-12 h-12 bg-sky-50 rounded-xl flex items-center justify-center group-hover:bg-sky-100 transition-colors duration-200">
              <Sparkles class="h-6 w-6 text-sky-600" />
            </div>
            <div class="flex-1 min-w-0">
              <h3 class="text-lg font-bold text-slate-900 mb-1.5">OpenClaw 應用場景</h3>
              <p class="text-slate-500 text-sm leading-relaxed mb-4">
                探索 41 個 AI 自動化應用場景，橫跨 13 個領域，發現 AI Agent 的無限可能。
              </p>
              <span class="inline-flex items-center gap-1.5 text-sky-600 font-semibold text-sm group-hover:gap-2.5 transition-all duration-200">
                探索場景
                <ArrowRight class="h-4 w-4" />
              </span>
            </div>
          </div>
        </router-link>

        <!-- Agent Skills 簡報 -->
        <a
          href="/ai-course/slides.html"
          class="home-animate opacity-0 translate-y-4 transition-all duration-700 group bg-white rounded-2xl border border-slate-200 shadow-sm hover:shadow-lg hover:-translate-y-1 overflow-hidden cursor-pointer block"
        >
          <div class="h-1.5 bg-gradient-to-r from-orange-400 to-rose-400"></div>
          <div class="p-7 flex gap-5 items-start">
            <div class="flex-shrink-0 w-12 h-12 bg-orange-50 rounded-xl flex items-center justify-center group-hover:bg-orange-100 transition-colors duration-200">
              <Presentation class="h-6 w-6 text-orange-500" />
            </div>
            <div class="flex-1 min-w-0">
              <h3 class="text-lg font-bold text-slate-900 mb-1.5">Agent Skills 簡報</h3>
              <p class="text-slate-500 text-sm leading-relaxed mb-4">
                互動式投影片教學，17 頁完整內容，了解如何讓 AI 記住你的工作方式。
              </p>
              <span class="inline-flex items-center gap-1.5 text-orange-500 font-semibold text-sm group-hover:gap-2.5 transition-all duration-200">
                觀看簡報
                <ArrowRight class="h-4 w-4" />
              </span>
            </div>
          </div>
        </a>

      </div>
    </section>

    <!-- ═══════════════════════════════════════
         Instructor Section
    ════════════════════════════════════════════ -->
    <section class="px-6 pb-16 max-w-6xl mx-auto">

      <!-- Identity Card -->
      <div class="home-animate opacity-0 translate-y-4 transition-all duration-700 bg-white rounded-2xl border border-slate-200 shadow-sm overflow-hidden">
        <div class="h-1.5 bg-gradient-to-r from-sky-400 via-indigo-400 to-violet-400"></div>

        <div class="p-8 md:p-10">
          <div class="flex flex-col md:flex-row gap-8 md:gap-10">

            <!-- Left: Photo -->
            <div class="flex-shrink-0 flex flex-col items-center md:items-start gap-4">
              <img
                :src="instructorImg"
                alt="詹嘉隆"
                class="w-36 md:w-44 rounded-full object-cover shadow-md aspect-square"
              />
              <a
                href="mailto:luuung@gmail.com"
                class="inline-flex items-center gap-2 text-slate-400 hover:text-sky-600 transition-colors duration-200 text-sm font-medium cursor-pointer"
              >
                <Mail class="h-4 w-4" />
                luuung@gmail.com
              </a>
            </div>

            <!-- Right: Info -->
            <div class="flex-1 min-w-0">
              <!-- Name + Title -->
              <div class="mb-5">
                <h3 class="text-3xl font-bold text-slate-900">詹嘉隆</h3>
                <p class="text-sky-600 font-semibold mt-1 text-base">AI 工具導入與培訓顧問</p>
              </div>

              <!-- Badges -->
              <div class="flex flex-wrap gap-2 mb-6">
                <span class="px-3 py-1 bg-sky-50 text-sky-700 text-xs font-medium rounded-full border border-sky-100">
                  台灣人工智慧發展學會 顧問
                </span>
                <span class="px-3 py-1 bg-violet-50 text-violet-700 text-xs font-medium rounded-full border border-violet-100">
                  雲林縣楊家老架太極武藝協會 理事長
                </span>
                <span class="px-3 py-1 bg-slate-100 text-slate-600 text-xs font-medium rounded-full border border-slate-200">
                  前正心高中特教組長・資訊組長
                </span>
              </div>

              <!-- Core Quote -->
              <blockquote class="mt-2 bg-gradient-to-r from-sky-50 to-indigo-50 border-l-4 border-sky-400 pl-5 pr-5 py-4 rounded-r-xl">
                <p class="text-slate-800 font-semibold text-base leading-relaxed">
                  「Claude Code 是中小企業行政效率的秘密武器，也是一般人適合擁有的數位助理。」
                </p>
              </blockquote>

              <!-- Service Scope -->
              <p class="text-slate-400 text-xs mt-5 leading-relaxed">
                服務對象涵蓋中小企業、學校教育機構與企業內部培訓，課程後持續提供線上支援。
              </p>
            </div>

          </div>
        </div>
      </div>

      <!-- Story Section -->
      <div class="home-animate opacity-0 translate-y-4 transition-all duration-700 mt-5 bg-white rounded-2xl border border-slate-200 shadow-sm overflow-hidden">
        <div class="p-8 md:p-10">

          <h4 class="text-sm font-semibold text-slate-400 uppercase tracking-widest mb-6">關於講師</h4>

          <div class="text-slate-600 text-sm leading-loose space-y-4 max-w-2xl">
            <p>在學校待了十五年，從特教組長到資訊組長，主要的工作是想辦法讓人學會不熟悉的事。</p>
            <p>家裡有一間開了二十年的餐廳，也代理智慧眼鏡產品。平日打太極拳。</p>
            <p>現在主要幫中小企業、學校與機構導入 AI 工具，根據實際的工作流程設計培訓內容。</p>
          </div>
        </div>
      </div>

    </section>

  </main>
</template>

<style scoped>
.home-animate {
  transition-property: opacity, transform;
  transition-timing-function: cubic-bezier(0.4, 0, 0.2, 1);
}

.home-animate.animate-in {
  opacity: 1 !important;
  transform: translateY(0) !important;
}
</style>
