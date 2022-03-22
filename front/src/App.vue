<template>
  <html>
    <body>
      <div id="app">
        <b-navbar toggleable="sm" type="light" variant="light">
          <b-navbar-toggle target="nav-text-collapse"></b-navbar-toggle>

          <b-navbar-brand
            ><img
              src="./assets/miniLogo.jpg"
              class="d-inline-block align-top"
              width="50px"
              height="50px"
          /></b-navbar-brand>

          <b-collapse id="nav-text-collapse" is-nav>
            <b-navbar-nav>
              <router-link to="/">
                <b-nav-item href="/">Home</b-nav-item>
              </router-link>
            </b-navbar-nav>

            <b-navbar-nav class="ml-auto" right>
              <b-nav-item-dropdown
                text="Cart"
                right
                menu-class="text-wrap nav-kanz-min-width"
                v-if="!hideCartDD && type === 'customer'"
              >
                <b-card>
                  <b-card-text class="text-right">
                    <b-row class="w-100 col-12">
                      <b-col md="3" sm="6"> Total Price : </b-col>
                      <b-col md="5" sm="6">
                        <b-input
                          class="text-right"
                          v-model="totalPrice"
                          disabled
                        ></b-input>
                      </b-col>
                      <b-col md="4" sm="12">
                        <b-button
                          class="w-100"
                          @click="toPurchase"
                          variant="primary"
                          >Purchase</b-button
                        >
                      </b-col>
                    </b-row>
                  </b-card-text>
                </b-card>

                <b-nav-item v-show="empty" class="text-center">
                  Your cart is empty
                </b-nav-item>
                <template v-for="item in cart">
                  <b-card :key="item.p_name">
                    <b-row class="w-100">
                      <b-col md="2">
                        <b-card-img
                          :src="item.img"
                          left
                          width="100"
                        ></b-card-img>
                      </b-col>
                      <b-col md="10">
                        <b-card-body class="text-right">
                          <h1>
                            <b>{{ item.p_name }}</b>
                          </h1>
                          {{ item.amount }} ea. / {{ item.price }} Bath.
                        </b-card-body>
                        <b-card-body class="text-right">
                          <b-button
                            variant="danger"
                            @click="removeProduct(item.p_name)"
                            >Remove from cart</b-button
                          >
                        </b-card-body>
                      </b-col>
                    </b-row>
                  </b-card>
                </template>
              </b-nav-item-dropdown>
              <template v-if="!user">
                <router-link to="/login">
                  <b-nav-item href="/login">Login</b-nav-item>
                </router-link>

                <router-link to="/register">
                  <b-nav-item href="/register">Register</b-nav-item>
                </router-link>
              </template>

              <template v-if="user">
                <b-nav-item-dropdown
                  text="User"
                  right
                  menu-class="maxw-none text-nowrap"
                >
                  <router-link to="/profile">
                    <b-dropdown-item href="/profile">Profile</b-dropdown-item>
                  </router-link>
                  <router-link to="/order">
                    <b-dropdown-item href="/order"
                      >Order History</b-dropdown-item
                    >
                  </router-link>
                  <router-link to="/addProduct">
                    <b-dropdown-item
                      href="/addProduct"
                      v-if="type === 'employee'"
                      >Add Product</b-dropdown-item
                    >
                  </router-link>
                  <router-link to="/employees">
                    <b-dropdown-item
                      href="/employees"
                      v-if="type === 'employee'"
                      >All Employee</b-dropdown-item
                    >
                  </router-link>
                  <router-link to="/addEmployee">
                    <b-dropdown-item
                      href="/addEmployee"
                      v-if="type === 'employee'"
                      >Add Employee</b-dropdown-item
                    >
                  </router-link>
                  <router-link to="/addSupplier">
                    <b-dropdown-item
                      href="/addSupplier"
                      v-if="type === 'employee'"
                      >Add Supplier</b-dropdown-item
                    >
                  </router-link>

                  <router-link to="/changePass">
                    <b-dropdown-item href="/changePass"
                      >Change password</b-dropdown-item
                    >
                  </router-link>

                  <b-dropdown-item @click="logout">Log out</b-dropdown-item>
                </b-nav-item-dropdown>
              </template>
            </b-navbar-nav>
          </b-collapse>
        </b-navbar>
        <router-view
          :key="$route.fullPath"
          @auth-change="onAuthChange"
          @purchase="toggleCart"
          :user="user"
          :userType="type"
        />
      </div>
    </body>
  </html>
</template>

<style>
.nav-kanz-min-width {
  min-width: 50rem !important;
  /* white-space: nowrap; */
}
@font-face {
  font-family: "Bankai Demo Version";
  src: local("Bankai Demo Version"),
    url(./fonts/BankaiDemoVersion-lglxd.ttf) format("truetype");
}

body {
  font-family: "Bankai Demo Version" !important;
}
</style>

<script>
import axios from "./plugins/axios";
export default {
  data() {
    return {
      user: null,
      userFname: "",
      cart: [],
      empty: true,
      type: "",
      hideCartDD: false,
    };
  },
  mounted() {
    this.onAuthChange();
    this.hideCartDD = false;
  },
  created: function () {
    this.hideCartDD = false;
    if (sessionStorage.getItem("cart")) {
      let getCart = sessionStorage.getItem("cart");
      this.$store.commit("setCart", JSON.parse(getCart));
      if (this.cart == {}) {
        this.empty = true;
      } else {
        this.empty = false;
      }
    }
  },
  computed: {
    showCart() {
      return this.$store.getters.getProduct;
    },
    updateCart() {
      return this.$store.state.cart;
    },
    totalPrice() {
      return this.$store.getters.getTotalPrice;
    },
  },
  watch: {
    updateCart: {
      deep: true,
      handler(cart) {
        this.cart = cart;
      },
    },
  },
  methods: {
    logout() {
      sessionStorage.removeItem("state");
      this.user = null;
      if (this.$router.history.current.path !== "/") {
        this.$router.push({ path: "/" });
      }
    },
    imagePath(file_path) {
      if (file_path) {
        return "http://localhost:3000/" + file_path;
      } else {
        return "https://bulma.io/images/placeholders/640x360.png";
      }
    },
    removeProduct(target) {
      this.$store.commit("removeProduct", target);
    },
    toPurchase() {
      if (!this.$store.getters.getTotalPrice) {
        alert("Cart is empty");
      } else {
        this.$router.push({ path: "/purchase" });
      }
    },
    onAuthChange() {
      const token = sessionStorage.getItem("state");
      if (token) {
        this.type = JSON.parse(token).userType;
        this.getUser();
      }
    },
    getUser() {
      axios.get("/user/me").then((res) => {
        this.user = res.data;
      });
    },
    toggleCart() {
      this.hideCartDD = !this.hideCartDD;
    },
  },
};
</script>
