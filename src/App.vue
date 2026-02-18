<script setup lang="ts">
import { ref, onMounted, onUnmounted } from 'vue'
import HomeView from '@/components/HomeView.vue'
import CoursesView from '@/components/CoursesView.vue'
import InstallationSection from '@/components/InstallationSection.vue'
import OpenClawUseCases from '@/components/OpenClawUseCases.vue'

type Page = 'home' | 'installation' | 'courses' | 'openclaw'

const currentPage = ref<Page>('home')
const isLoaded = ref(false)
const typedText = ref('')
const fullText = 'Claude Code 與 AI Agent 實作課程'

const navigateTo = (page: Page) => {
  currentPage.value = page
  window.scrollTo({ top: 0, behavior: 'smooth' })
}

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

let observer: IntersectionObserver | null = null

onMounted(() => {
  setTimeout(() => {
    isLoaded.value = true
    typeWriter()
  }, 300)

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

  setTimeout(() => {
    const elements = document.querySelectorAll('.scroll-animate')
    elements.forEach((el, index) => {
      observer?.observe(el)
      setTimeout(() => {
        const rect = el.getBoundingClientRect()
        if (rect.top < window.innerHeight) {
          el.classList.add('animate-in')
        }
      }, index * 150)
    })
  }, 100)
})

onUnmounted(() => {
  observer?.disconnect()
})
</script>

<template>
  <div class="min-h-screen bg-white text-gray-900">
    <!-- Header -->
    <header
      class="relative overflow-hidden bg-gradient-to-r from-blue-600 via-purple-600 to-cyan-600 bg-[length:200%_200%] animate-gradient text-white py-12 shadow-2xl cursor-pointer"
      @click="navigateTo('home')"
    >
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

    <!-- 頁面內容 -->
    <HomeView
      v-if="currentPage === 'home'"
      @navigate="navigateTo"
    />

    <div v-else-if="currentPage === 'installation'">
      <!-- 安裝頁導覽列 -->
      <nav class="bg-white/80 backdrop-blur-md border-b border-gray-200 sticky top-0 z-10 shadow-sm">
        <div class="max-w-6xl mx-auto px-8 py-4">
          <button
            @click="navigateTo('home')"
            class="px-4 py-2 bg-gray-100 rounded-md shadow-sm hover:shadow-md hover:-translate-y-0.5 transition-all duration-300 text-sm font-medium border border-gray-200"
          >
            ← 返回首頁
          </button>
        </div>
      </nav>
      <main class="max-w-6xl mx-auto px-8 py-8">
        <InstallationSection />
      </main>
    </div>

    <CoursesView
      v-else-if="currentPage === 'courses'"
      @navigate="navigateTo"
    />

    <OpenClawUseCases
      v-else-if="currentPage === 'openclaw'"
      @navigate="navigateTo"
    />

    <!-- Footer -->
    <footer class="relative bg-gray-100 border-t border-gray-200 py-8 mt-12 overflow-hidden">
      <div class="absolute top-0 left-0 right-0 h-1 bg-gradient-to-r from-blue-600 via-purple-600 to-cyan-600 animate-gradient bg-[length:200%_200%]"></div>
      <div class="max-w-6xl mx-auto px-8 text-center">
        <p class="text-gray-600 hover:text-gray-900 transition-colors duration-300">
          &copy; 2026 詹嘉隆 AI Agent 實作工作坊
        </p>
      </div>
    </footer>
  </div>
</template>
