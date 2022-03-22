import Vue from 'vue'
import App from './App.vue'
import router from './router'
import Vuelidate from 'vuelidate'
import Vuex from 'vuex'

import { BootstrapVue, IconsPlugin } from 'bootstrap-vue'

import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'


Vue.use(BootstrapVue)

Vue.use(IconsPlugin)

Vue.use(Vuex)

Vue.use(Vuelidate)
Vue.config.productionTip = false

const store = new Vuex.Store({
  state: {
    isLogged: false,
    cart: []
  },
  getters: {
    getTotalPrice(state) {
      let total = 0
      state.cart.forEach((product) => {
        total += product.price
      })
      return total
    },
    getTotalAmount: (state) => (name) => {
      let cartIndex = -1
      state.cart.forEach((product, index) => {
        if (product.p_name === name) {
          cartIndex = index
        }

      })
      if (cartIndex === -1) {
        return 0
      }
      return state.cart[cartIndex].amount
    }
  },
  mutations: {
    logout(state) {
      state.isLogged = false
    },
    login(state) {
      state.isLogged = true
    },
    addProduct(state, product) {
      let cartIndex = -1
      state.cart.forEach((item, index) => {
        if (item.p_name === product.p_name) {
          cartIndex = index
        }
      })
      if (cartIndex === -1) {
        state.cart.push(product)
      } else {
        state.cart[cartIndex].amount = parseInt(state.cart[cartIndex].amount) + parseInt(product.amount)
        state.cart[cartIndex].price = parseInt(state.cart[cartIndex].price) + parseInt(product.price)
        
      }
      sessionStorage.setItem("cart", JSON.stringify(state.cart));
    },
    removeProduct(state, name) {
      let cartIndex = -1
      state.cart.forEach((item, index) => {
        if (item.p_name === name) {
          cartIndex = index
        }
      })
      if (cartIndex != -1) {
        state.cart.splice(cartIndex, 1)
      }
      sessionStorage.setItem("cart", JSON.stringify(state.cart));
    },
    setCart(state, cart) {
      state.cart = cart
    },
  }
})

new Vue({
  store,
  router,
  render: h => h(App)
}).$mount('#app')
