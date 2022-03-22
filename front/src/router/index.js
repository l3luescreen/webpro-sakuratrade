import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'Home',
    component: () => import('../views/Home.vue')
  },
  {
    path: '/login',
    name: 'Login',
    meta: { guess: true },
    component: () => import('../views/Login.vue')
  },
  {
    path: '/register',
    name: 'Register',
    meta: { guess: true },
    component: () => import('../views/Register.vue')
  },
  {
    path: '/Profile',
    name: 'Profile',
    meta: { login: true },
    component: () => import('../views/Profile.vue')
  },
  {
    path: '/changePass',
    name: 'ChangePassword',
    meta: { login: true },
    component: () => import('../views/ChangePassword.vue')
  },
  {
    path: '/purchase',
    name: 'purchase',
    meta: { login: true, customer: true, cart: true },
    component: () => import('../views/Purchase.vue')
  },
  {
    path: '/addProduct',
    name: 'addProduct',
    meta: { login: true, employee: true },
    component: () => import('../views/AddProduct.vue')
  },
  {
    path: '/addSupplier',
    name: 'addSupplier',
    meta: { login: true, employee: true },
    component: () => import('../views/AddSupplier.vue')
  },
  {
    path: '/addEmployee',
    name: 'addEmployee',
    meta: { login: true, employee: true },
    component: () => import('../views/AddEmployee.vue')
  },
  {
    path: '/employees',
    name: 'employees',
    meta: { login: true, employee: true },
    component: () => import('../views/Employees.vue')
  },
  {
    path: '/order',
    name: 'order',
    meta: { login: true },
    component: () => import('../views/Order.vue')
  },

]

const router = new VueRouter({ routes })


router.beforeEach((to, from, next) => {
  const isLoggedIn = !!sessionStorage.getItem('state')
  const role = JSON.parse(sessionStorage.getItem('state'))

  const cart = sessionStorage.getItem('cart') !== "[]"

  if (to.meta.login && !isLoggedIn) {
    alert('Please login first!')
    next({ path: '/login' })
  }

  if (to.meta.guess && isLoggedIn) {
    alert("You've already logged in")
    next({ path: '/' })
  }

  if (to.meta.employee && role.userType !== "employee") {
    alert("You don't have permission to do this")
    next({ path: '/' })
  }

  if (to.meta.customer && role.userType !== "customer") {
    alert("You don't have permission to do this")
    next({ path: '/' })
  }

  if (to.meta.customer && !cart) {
    alert("Your cart is empty")
    next({ path: '/' })
  }
  next()
})

export default router