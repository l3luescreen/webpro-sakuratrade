<template>
  <b-container>
    <b-card title="Card Title" no-body>
      <b-card-header header-tag="nav">
        <b-nav card-header tabs justified>
          <b-nav-item :active="activeCart" :disabled="!activeCart">
            Cart
          </b-nav-item>
          <b-nav-item :active="confirmAddress" :disabled="!confirmAddress"
            >Confirm address</b-nav-item
          >
          <b-nav-item :active="payment" :disabled="!payment"
            >Payment methods</b-nav-item
          >
          <b-nav-item :active="complete" :disabled="!complete"
            >Complete</b-nav-item
          >
        </b-nav>
      </b-card-header>

      <b-card-body class="text-center">
        <b-card-text>
          <cart-component v-if="state === 'cart'"></cart-component>
          <address-component
            v-if="state === 'confirmAddress'"
            :userAddress="user.cus_address"
          ></address-component>
          <payment-component
            v-if="state === 'payment'"
            v-on:addPayment="savePayment"
          ></payment-component>
          <complete-component
            v-if="state === 'complete'"
            :paymentData="paymentData"
          ></complete-component>
        </b-card-text>
        <b-row align-h="between">
          <b-col cols="4">
            <b-button size="lg" variant="primary" @click="backState()">{{
              btnRole
            }}</b-button>
          </b-col>
          <b-col cols="4" v-if="state !== 'complete'">
            <b-button size="lg" variant="primary" @click="nextState()"
              >Next -></b-button
            >
          </b-col>
          <b-col cols="4" v-if="state === 'complete'">
            <b-button size="lg" variant="success" @click="submitPurchase"
              >Complete</b-button
            >
          </b-col>
        </b-row>
      </b-card-body>
    </b-card>
  </b-container>
</template>

<script>
import axios from "@/plugins/axios";
import CartComponent from "../components/CartComponent.vue";
import AddressComponent from "../components/AddressComponent.vue";
import PaymentComponent from "../components/PaymentComponent.vue";
import CompleteComponent from "../components/CompleteComponent.vue";

export default {
  props: ["user"],
  data() {
    return {
      isLogged: false,
      userFname: "",
      cart: [],
      empty: true,
      state: "cart",
      activeCart: true,
      confirmAddress: false,
      payment: false,
      complete: false,
      btnRole: "Back to Shopping",
      paymentData: { type: "", address: "", data: "" },
      paymentCheck: "",
    };
  },
  components: {
    CartComponent,
    AddressComponent,
    PaymentComponent,
    CompleteComponent,
  },
  created: function () {
    this.$emit("purchase");
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
  beforeDestroy: function () {
    this.$emit("purchase");
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
    nextState() {
      if (this.state == "cart") {
        this.state = "confirmAddress";
        this.activeCart = false;
        this.confirmAddress = true;
        this.btnRole = "<- Back";
      } else if (this.state == "confirmAddress") {
        this.state = "payment";
        this.paymentData.address = this.user.cus_address;
        this.confirmAddress = false;
        this.payment = true;
        this.btnRole = "<- Back";
      } else if (this.state == "payment") {
        if (this.paymentCheck) {
          this.state = "complete";
          this.payment = false;
          this.complete = true;
          this.btnRole = "<- Back";
        } else {
          alert("Please enter purchase data");
        }
      }
    },
    backState() {
      if (this.state == "complete") {
        this.state = "payment";
        this.payment = true;
        this.complete = false;
        this.btnRole = "<- Back";
      } else if (this.state == "payment") {
        this.state = "confirmAddress";
        this.payment = false;
        this.confirmAddress = true;
        this.btnRole = "<- Back";
      } else if (this.state == "confirmAddress") {
        this.state = "cart";
        this.confirmAddress = false;
        this.activeCart = true;
        this.btnRole = "Back to Shopping";
      } else if (this.state == "cart") {
        this.$router.push({ path: "/" });
      }
    },
    savePayment(value) {
      this.paymentData.type = value.type;
      this.paymentData.address = this.user.cus_address;
      this.paymentCheck = value.data;
      this.paymentData.data = value.data;

    },
    submitPurchase() {
       const paymentData = {
        user_id: this.user.cus_id,
        totalPrice: this.totalPrice,
        cart: this.cart,
        paymentType: this.user.cus_address,
        payment: {
          type: this.paymentData.type,
        },
      };
      axios.post("/purchase/comfirm", paymentData).then((res) => {
        alert("Purchase success")
        sessionStorage.setItem("cart", "")
        window.location = "/"
      });
    }
  },
};
</script>