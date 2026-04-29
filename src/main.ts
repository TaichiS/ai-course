import { createApp } from 'vue'
import './style.css'
import App from './App.vue'
import router from './router'

const params = new URLSearchParams(window.location.search)
const restorePath = params.get('path')
if (restorePath) {
  const url = new URL(window.location.href)
  url.searchParams.delete('path')
  url.pathname = url.pathname + restorePath
  window.history.replaceState(null, '', url.toString())
}

const app = createApp(App)
app.use(router)
app.mount('#app')
