<template>
  <b-container fluid>
    <h1>Choose payment</h1>
    <b-form-group v-slot="{ ariaDescribedby }" class="text-left">
      <b-form-radio
        :aria-describedby="ariaDescribedby"
        name="some-radios"
        v-model="payMethod"
        :disabled="saved"
        value="bank"
        >Mobile banking</b-form-radio
      >
      <b-form-group
        id="input-group-3"
        label-for="bank"
        v-if="payMethod === 'bank'"
        class="m-3"
      >
        <b-form-select
          v-model="selectedBank"
          :value="null"
          :options="[
            { text: 'select bank....', value: null },
            { text: 'Kasikorn Bank', value: 'Kasikorn Bank' },
            { text: 'Siam Commercial Bank', value: 'Siam Commercial Bank' },
            { text: 'Krung Thai Bankk', value: 'Krung Thai Bankk' },
            { text: 'Government Savings Bank', value: 'Government Savings Bank' },
          ]"
          required
          id="bank"
          :disabled="saved"
        ></b-form-select>
      </b-form-group>
      <b-form-radio
        :aria-describedby="ariaDescribedby"
        name="some-radios"
        v-model="payMethod"
        value="credit"
        :disabled="saved"
        >Credit card</b-form-radio
      >
      <b-form v-if="payMethod === 'credit'" class="p-5" @submit.stop.prevent>
        <b-form-group label-for="credit-name">
          <b-form-input
            id="credit-name"
            v-model="$v.name.$model"
            type="text"
            placeholder="Name the appeared on your card"
            :disabled="saved"
            required
          ></b-form-input>
          <template v-if="$v.name.$error">
            <p class="text-danger" v-if="!$v.name.required">
              This Field is required
            </p>
            <p class="text-danger" v-if="!$v.name.maxLength">
              This field is too long
            </p>
          </template>
        </b-form-group>

        <b-form-group label-for="credit-number">
          <b-form-input
            id="credit-number"
            v-model="$v.number.$model"
            type="text"
            placeholder="Credit card number"
            :disabled="saved"
            required
          ></b-form-input>
          <template v-if="$v.number.$error">
            <p class="text-danger" v-if="!$v.number.required">
              This Field is required
            </p>
            <p class="text-danger" v-if="!$v.number.credit">
              This field is not correct
            </p>
            <p class="text-danger" v-if="!$v.number.maxLength">
              This field is too long
            </p>
          </template>
        </b-form-group>
        <b-row>
          <b-col>
            <b-form-group label-for="credit-expire" label="Expired date">
              <b-form-input
                id="credit-expire"
                v-model="$v.expire.$model"
                type="text"
                placeholder="MM/YY"
                :disabled="saved"
                required
              ></b-form-input>
              <template v-if="$v.expire.$error">
                <p class="text-danger" v-if="!$v.expire.required">
                  This Field is required
                </p>
                <p class="text-danger" v-if="!$v.expire.expire">
                  format is not correct Example: 09/22
                </p>
              </template>
            </b-form-group>
          </b-col>
          <b-col>
            <b-form-group label-for="credit-cvv" label="CVV">
              <b-form-input
                id="credit-cvv"
                v-model="$v.cvv.$model"
                type="text"
                placeholder="000"
                :disabled="saved"
                required
              ></b-form-input>
              <template v-if="$v.cvv.$error">
                <p class="text-danger" v-if="!$v.cvv.required">
                  This Field is required
                </p>
                <p class="text-danger" v-if="!$v.cvv.cvv">
                  format is not correct. Must be 3 number
                </p>
              </template>
            </b-form-group>
          </b-col>
        </b-row>

        <b-form-group label-for="credit-address">
          <b-form-input
            id="credit-adress"
            v-model="$v.address.$model"
            type="text"
            placeholder="Billing address"
            :disabled="saved"
            required
          ></b-form-input>
          <template v-if="$v.address.$error">
            <p class="text-danger" v-if="!$v.address.required">
              This Field is required
            </p>
            <p class="text-danger" v-if="!$v.address.maxLength">
              This field is too long
            </p>
          </template>
        </b-form-group>

        <b-form-group label-for="credit-postal">
          <b-form-input
            id="credit-postal"
            v-model="$v.postal.$model"
            type="text"
            placeholder="Postal code"
            :disabled="saved"
            required
          ></b-form-input>
          <template v-if="$v.postal.$error">
            <p class="text-danger" v-if="!$v.postal.required">
              This Field is required
            </p>
            <p
              class="text-danger"
              v-if="!$v.postal.postalCode || !$v.postal.maxLength"
            >
              Postal code must be 5 numbers
            </p>
          </template>
        </b-form-group>
      </b-form>
    </b-form-group>
    <b-button class="mt-3" id="show-btn" variant="success" @click="saveData"
      >Save</b-button
    >
  </b-container>
</template>

<script>
import { required, minLength, maxLength } from "vuelidate/lib/validators";

function credit(value) {
  return !!value.match(/[0-9]{16}/);
}

function expire(value) {
  return !!value.match(/[0-9]{2}[/][0-9]{2}/);
}

function cvv(value) {
  return !!value.match(/[0-9]{3}/);
}

function postalCode(value) {
  return !!value.match(/[0-9]{5}/);
}

export default {
  data() {
    return {
      isLogged: false,
      userFname: "",
      cart: [],
      empty: true,
      payMethod: "bank",
      selectedBank: null,
      saved: false,
      name: "",
      number: "",
      expire: "",
      cvv: "",
      address: "",
      postal: "",
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
    showModal() {
      this.$refs["creditModal"].show();
    },
    saveData() {
      if (this.payMethod === "bank") {
        if (!this.selectedBank) {
          alert("please choose bank");
        } else {
          //  this.selectedBank
          this.$emit('addPayment', {type: this.payMethod ,data : this.selectedBank})
          this.saved = !this.saved;
        }
      } else if (this.payMethod === "credit") {
        this.$v.$touch();

        if (!this.$v.$invalid) {
          let paymentData = {
            name: this.name,
            number: this.number,
            expire: this.expire,
            cvv: this.cvv,
            address: this.address,
            postal: this.postal,
          };

          this.$emit('addPayment', {type: this.payMethod ,data : paymentData})
          this.saved = !this.saved;
        }
      }
    },
  },
  validations: {
    name: {
      required: required,
      maxLength: maxLength(50),
    },
    number: {
      required: required,
      creditNumber: credit,
      maxLength: maxLength(16),
    },
    expire: {
      required: required,
      expire: expire,
    },
    cvv: {
      required: required,
      cvv: cvv,
    },
    address: {
      required: required,
      maxLength: maxLength(100),
    },
    postal: {
      required: required,
      postal: postalCode,
      maxLength: maxLength(5),
    },
  },
};
</script>