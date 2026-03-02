<script setup lang="ts">
import { ref, onMounted, onUnmounted } from 'vue'
import { useRouter } from 'vue-router'

const router = useRouter()
const isLoaded = ref(false)
const typedText = ref('')
const fullText = 'Claude Code 與 AI Agent 實作課程'

const navigateHome = () => {
  router.push('/')
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

  // 初始動畫處理
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
  }, 500)
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
      @click="navigateHome"
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

    <!-- 頁面內容 (由 Router 注入) -->
    <router-view v-slot="{ Component }">
      <transition 
        name="fade" 
        mode="out-in"
      >
        <component :is="Component" />
      </transition>
    </router-view>

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

<style>
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.3s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}
</style>
