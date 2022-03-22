<template>
  <b-container fluid>
    <b-card>
      <b-card-text class="text-right">
        <b-row class="w-100 col-12">
          <b-col md="6" sm="6"> Total Price : </b-col>
          <b-col md="6" sm="6">
            <b-input class="text-right" v-model="totalPrice" disabled></b-input>
          </b-col>
        </b-row>
      </b-card-text>
    </b-card>

    <template v-for="item in cart">
      <b-card :key="item.p_name">
        <b-row class="w-100">
          <b-col md="5">
            <b-card-img :src="item.img" left width="200"></b-card-img>
          </b-col>
          <b-col md="7">
            <b-card-body class="text-right">
              <h1>
                <b>{{ item.p_name }}</b>
              </h1>
              {{ item.amount }} ea. / {{ item.price }} Bath.
            </b-card-body>
            <b-card-body class="text-right"> </b-card-body>
          </b-col>
        </b-row>
      </b-card>
    </template>
  </b-container>
</template>

<script>
module.exports = {
  props: ["user"],
  data() {
    return {
      isLogged: false,
      userFname: "",
      cart: [],
      empty: true,
    };
  },
  created: function () {
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
  watch: {
    updateCart: {
      deep: true,
      handler(cart) {
        this.cart = cart;
      },
    },
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
  methods: {
    imagePath(file_path) {
      if (file_path) {
        return "http://localhost:3000/" + file_path;
      } else {
        return "https://bulma.io/images/placeholders/640x360.png";
      }
    },
  },
};
</script>