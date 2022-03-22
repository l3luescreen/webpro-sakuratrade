<template>
  <b-container class="my-auto w-50" fluid="sm">
    <b-img fluid :src="require('../assets/logo.png')"></b-img>
    <b-form class="m-5" @submit.stop.prevent>
    <b-alert v-model="error" variant="danger"> {{ errMsg }} </b-alert>
    <b-alert v-model="success" variant="success">
      Add supplier Successfully
    </b-alert>
      <b-form-group id="supplier-name-group" label="Supplier name:" label-for="supplier-name">
        <b-form-input
          id="supplier-name"
          type="text"
          placeholder="Supplier name"
          v-model="$v.s_name.$model"
        >
        </b-form-input>
        <template v-if="$v.s_name.$error">
          <p class="text-danger" v-if="!$v.s_name.required">
            This Field is required
          </p>
        </template>
      </b-form-group>

      <b-form-group
        id="supplier-tel-group"
        label="Supplier phone number:"
        label-for="supplier-tel-"
      >
        <b-form-input
          id="supplier-tel-"
          type="text"
          placeholder="Phone number"
          v-model="$v.s_tel.$model"
        >
        </b-form-input>
        <template v-if="$v.s_tel.$error">
          <p class="text-danger" v-if="!$v.s_tel.required">
            This Field is required
          </p>
        </template>
      </b-form-group>

      <b-form-group id="supplier-email-group" label="Supplier email:" label-for="supplier-email">
        <b-form-input
          id="supplier-email"
          type="email"
          placeholder="Supplier email"
          v-model="$v.s_email.$model"
        >
        </b-form-input>
        <template v-if="$v.s_email.$error">
          <p class="text-danger" v-if="!$v.s_email.required">
            This Field is required
          </p>
        </template>
      </b-form-group>
      <b-form-group id="button-group">
        <b-button block type="submit" @click="submit" variant="success"
          >Add supplier</b-button
        >
      </b-form-group>
    </b-form>
  </b-container>
</template>

<style scoped>
.edit-btn {
  position: absolute;
  right: 0;
}
</style>

<script>
import { required } from "vuelidate/lib/validators";
import axios from "../plugins/axios";

export default {
  props: ["user"],
  data() {
    return {
      username: "",
      s_name: "",
      s_tel: "",
      s_email: "",
      success: false,
      error: false,
      errMsg: "",
    };
  },
  methods: {
    submit() {
      this.$v.$touch();

      if (!this.$v.$invalid) {
        let data = {
          s_name: this.s_name,
          s_tel: this.s_tel,
          s_email: this.s_email,
        };

        axios
          .post(
            `/supplier/add`,
            data
          )
          .then((response) => {
            if (response.data.error) {
              this.error = true
              this.success = false
              this.errMsg = response.data.errMsg
            } else {
              window.location = "/"
              this.error = false
              this.success = true
            }
          })
          .catch((error) => {
            console.log(error);
          });
      }
    }
  },
  validations: {
    s_name: {
      required: required,
    },
    s_tel: {
      required: required,
    },
    s_email: {
      required: required,
    },
  },
};
</script>