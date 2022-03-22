<template>
  <b-container class="my-auto w-50" fluid="sm">
    <b-img fluid :src="require('../assets/logo.png')"></b-img>
    <b-alert v-model="error" variant="danger"> {{ errMsg }} </b-alert>
    <b-alert v-model="success" variant="success">
      Change Password Successfully
    </b-alert>
    <b-form class="m-5" @submit.stop.prevent>
      <b-form-group
        id="password-group"
        label="Current Password::"
        label-for="password"
      >
        <b-form-input
          id="currPassword"
          type="password"
          placeholder="Enter password"
          v-model="$v.currPassword.$model"
        >
        </b-form-input>
        <template v-if="$v.currPassword.$error">
          <p class="text-danger" v-if="!$v.currPassword.required">
            This Field is required
          </p>
          <p class="text-danger" v-if="!$v.currPassword.minLength">
            password is too short
          </p>
          <p class="text-danger" v-if="!$v.currPassword.complex">
            password is not secure
          </p>
        </template>
      </b-form-group>

      <b-form-group id="password-group" label="Password:" label-for="password">
        <b-form-input
          id="password"
          type="password"
          placeholder="Enter password"
          v-model="$v.password.$model"
        >
        </b-form-input>
        <template v-if="$v.password.$error">
          <p class="text-danger" v-if="!$v.password.required">
            This Field is required
          </p>
          <p class="text-danger" v-if="!$v.password.minLength">
            password is too short
          </p>
          <p class="text-danger" v-if="!$v.password.complex">
            password is not secure
          </p>
          <p class="text-danger" v-if="!$v.password.notSameAs">
            password can not use, maybe you used this before
          </p>
        </template>
      </b-form-group>

      <b-form-group
        id="confirmPassword-group"
        label="Confirm password:"
        label-for="confirmPassword"
      >
        <b-form-input
          id="confirmPassword"
          type="password"
          placeholder="Confirm password"
          v-model="$v.confirmPassword.$model"
        >
        </b-form-input>
        <template v-if="$v.confirmPassword.$error">
          <p class="text-danger" v-if="!$v.confirmPassword.required">
            This Field is required
          </p>
          <p class="text-danger" v-if="!$v.confirmPassword.sameAs">
            password dosen't match
          </p>
        </template>
      </b-form-group>

      <b-form-group id="button-group">
        <b-button block type="submit" @click="changePassword" variant="success"
          >Change password</b-button
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
import { required, minLength, sameAs } from "vuelidate/lib/validators";
import axios from "../plugins/axios";

function complexPassword(value) {
  if (!(value.match(/[a-z]/) && value.match(/[A-Z]/) && value.match(/[0-9]/))) {
    return false;
  }
  return true;
}

function notSameAs(value) {
  return !(value === this.currPassword)
}

export default {
  props: ["user", "userType"],
  data() {
    return {
      username: "",
      currPassword: "",
      password: "",
      confirmPassword: "",
      success: false,
      error: false,
      errMsg: "",
    };
  },
  methods: {
    changePassword() {
      this.$v.$touch();

      if (!this.$v.$invalid) {

        let data = {
          username: this.user.username,
          userType: this.userType,
          currPassword: this.currPassword,
          password: this.password,
          confirmPassword: this.confirmPassword,
        };

        axios
          .put(`/changePassword`, data)
          .then((response) => {
            if (response.data.status === "success") {
              this.success = true
            }
          })
          .catch((error) => {
            console.log(error);
          });
          window.location = "/"
      }
    },
  },
  validations: {
    currPassword: {
      required: required,
      minLength: minLength(8),
      complex: complexPassword,
    },
    password: {
      required: required,
      minLength: minLength(8),
      notSameAs: notSameAs,
      complex: complexPassword,
    },
    confirmPassword: {
      required: required,
      sameAs: sameAs("password"),
    },
  },
};
</script>