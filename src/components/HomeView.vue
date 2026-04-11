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

              <!-- Tagline -->
              <p class="text-slate-500 text-sm leading-relaxed mb-2">
                有人說我是老師，有人說我是老闆，有人叫我理事長，現在又多了一個名字——AI 顧問。
              </p>
              <p class="text-slate-800 font-medium text-sm">
                我說，這些其實是同一件事：
                <span class="text-sky-600">在別人還沒看見的地方，先走一步。</span>
              </p>

              <!-- Core Quote -->
              <blockquote class="mt-6 bg-gradient-to-r from-sky-50 to-indigo-50 border-l-4 border-sky-400 pl-5 pr-5 py-4 rounded-r-xl">
                <p class="text-slate-800 font-semibold text-base leading-relaxed">
                  「不是要你學會寫程式，而是要你學會指揮 AI。」
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

          <h4 class="text-sm font-semibold text-slate-400 uppercase tracking-widest mb-8">講師的故事</h4>

          <div class="grid md:grid-cols-2 gap-x-12 gap-y-5 text-slate-600 text-sm leading-loose">

            <!-- Col 1 -->
            <div class="space-y-5">
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
                楊家老架，一式一式，慢得像在跟時間談判。我是雲林縣楊家老架太極武藝協會的理事長，但我說，打拳教會我的不是招式，是<strong class="text-slate-800">在動與靜之間，保持清醒</strong>。
              </p>
            </div>

            <!-- Col 2 -->
            <div class="space-y-5">
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
              <p class="text-slate-700 font-medium">
                我把這件事叫做「企業的家教課」——因為每一堂都不一樣，因為每一個人都值得被好好看見。
              </p>
            </div>

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
