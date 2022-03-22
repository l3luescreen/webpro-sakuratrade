<template>
  <b-container class="my-auto w-50" fluid="sm">
    <b-img class="mb-2" fluid :src="require('../assets/logo.png')"></b-img>
    <!-- <h2 class="display-2 text-center">Login</h2> -->
    <b-form @submit.stop.prevent>
      <b-alert v-model="error" variant="danger"> {{ errMsg }} </b-alert>
      <b-form-group id="username-group" label="Username:" label-for="username">
        <b-form-input
          id="username"
          type="text"
          placeholder="Enter your username"
          v-model="$v.username.$model"
        >
        </b-form-input>
        <template v-if="$v.username.$error">
          <p class="text-danger" v-if="!$v.username.required">
            This username is required
          </p>
        </template>
      </b-form-group>

      <b-form-group id="password-group" label="Password:" label-for="password">
        <b-form-input
          id="password"
          type="password"
          placeholder="Enter your password"
          v-model="$v.password.$model"
        >
        </b-form-input>
        <template v-if="$v.password.$error">
          <p class="text-danger" v-if="!$v.password.required">
            This password is required
          </p>
        </template>
      </b-form-group>
      <b-form-group>
        <b-button block @click="login" variant="primary"
          >Log in as {{ state }}</b-button
        >
      </b-form-group>
      <router-link to="/register">
        <b-button block variant="secondary">Register</b-button>
      </router-link>
    </b-form>

    <b-button
      class="secret-btn"
      v-show="state === 'customer'"
      @click="state = 'employee'"
      >For Employee</b-button
    >
    <b-button
      class="secret-btn"
      v-show="state === 'employee'"
      @click="state = 'customer'"
      >For Customer</b-button
    >
  </b-container>
</template>

<style scoped>
.secret-btn {
  position: absolute;
  right: 0;
  bottom: 0;
}
</style>

<script>
import { required, minLength, maxLength } from "vuelidate/lib/validators";
import axios from "axios";

function complexPassword(value) {
  if (!(value.match(/[a-z]/) && value.match(/[A-Z]/) && value.match(/[0-9]/))) {
    return false;
  }
  return true;
}

export default {
  data() {
    return {
      username: "",
      password: "",
      error: false,
      errMsg: "",
      state: "customer",
    };
  },
  methods: {
    login() {
      this.$v.$touch();

      if (!this.$v.$invalid) {
        let data = {
          username: this.username,
          password: this.password,
          userType: this.state,
        };
        axios
          .post("http://localhost:3000/login", data)
          .then((response) => {
            this.errMsg = "";
            this.error = false;
            var sessionLocal = {
              username: response.data.username,
              fName: response.data.fName,
              userType: response.data.userType,
              token: response.data.token,
            };
            if (!response.data.error) {
              sessionStorage.setItem("state", JSON.stringify(sessionLocal));
              this.$emit("auth-change");
              this.$router.push({ path: "/" });
            } else {
              this.error = true
              this.errMsg = response.data.errMsg
            }
          })
          .catch((error) => {
            console.log(error);
          });
      }
    },
  },
  validations: {
    username: {
      required: required,
    },
    password: {
      required: required,
    },
  },
};
</script>
