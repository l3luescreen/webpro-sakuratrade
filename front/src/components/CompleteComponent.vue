<template>
  <b-container fluid>
    <b-container fluid>
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
    <b-container fluid>
      <b-form-textarea
        id="textarea"
        class="overflow-hidden"
        v-model="paymentData.address"
        rows="3"
        max-rows="6"
        disabled
      ></b-form-textarea>
    </b-container>
    <!-- <b-row>
      <b-col align-self="center"> -->
        <b-row>
          <b-col class="text-center">
            <label for="payment-type">Payment type:</label>
            {{ paymentData.type }} 
          </b-col>
        </b-row>
        <b-row>
          <b-col v-if="paymentData.type === 'bank'" class="text-center">
            Pay by {{ paymentData.data }}
          </b-col>
        </b-row>
      <!-- </b-col>
    </b-row> -->
  </b-container>
</template>

<script>
module.exports = {
  props: ["paymentData"],
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
  },
};
</script>