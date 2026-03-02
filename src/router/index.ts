import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '@/components/HomeView.vue'
import CoursesView from '@/components/CoursesView.vue'
import CaseDetailView from '@/components/CaseDetailView.vue'
import InstallationSection from '@/components/InstallationSection.vue'
import OpenClawUseCases from '@/components/OpenClawUseCases.vue'

const routes = [
  {
    path: '/',
    name: 'home',
    component: HomeView
  },
  {
    path: '/courses',
    name: 'courses',
    component: CoursesView
  },
  {
    path: '/courses/:caseId',
    name: 'case-detail',
    component: CaseDetailView,
    props: true
  },
  {
    path: '/installation',
    name: 'installation',
    component: InstallationSection
  },
  {
    path: '/openclaw',
    name: 'openclaw',
    component: OpenClawUseCases
  }
]

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL || '/'),
  routes,
  scrollBehavior(to, from, savedPosition) {
    if (savedPosition) {
      return savedPosition
    } else if (to.hash) {
      return { el: to.hash, behavior: 'smooth' }
    } else {
      return { top: 0, behavior: 'smooth' }
    }
  }
})

export default router
