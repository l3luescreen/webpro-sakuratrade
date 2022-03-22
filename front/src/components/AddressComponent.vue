<template>
  <b-container fluid class="p-5">
    <h1>Comfirm address</h1>
    <b-form-textarea
      id="textarea"
      class="overflow-hidden"
      v-model="address"
      rows="3"
      max-rows="6"
      disabled
    ></b-form-textarea>
    <!-- <b-row>
      <b-col>
        <b-button class="m-2" @click="editAddress" v-if="change">Change</b-button>
        <b-button class="m-2" @click="editAddress" v-if="!change">Ok</b-button>
      </b-col>
    </b-row> -->
  </b-container>
</template>

<script>
import axios from "@/plugins/axios";
export default {
  props: ["userAddress"],
  data() {
    return {
      isLogged: false,
      userFname: "",
      cart: [],
      empty: true,
      address: this.userAddress,
      change: false,
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
  }
};
</script>