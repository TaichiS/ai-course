import { createApp } from 'vue'
import './style.css'
import App from './App.vue'
import router from './router'

const app = createApp(App)
app.use(router)

const params = new URLSearchParams(window.location.search)
const restorePath = params.get('path')
if (restorePath) {
  router.replace('/' + restorePath).then(() => app.mount('#app'))
} else {
  router.isReady().then(() => app.mount('#app'))
}
