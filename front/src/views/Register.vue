<template>
<b-container class="my-auto w-50" fluid="sm">
    <b-img fluid :src="require('../assets/logo.png')"></b-img>
    <b-alert v-model="error" variant="danger"> {{ errMsg }} </b-alert>
    <b-alert v-model="success" variant="success">
      Registeration Successfully
    </b-alert>
    <b-form @submit.stop.prevent>
      <b-form-group id="username-group" label="Username:" label-for="username">
        <b-form-input
          id="username"
          type="text"
          placeholder="Enter username"
          v-model="$v.username.$model"
        >
        </b-form-input>
        <template v-if="$v.username.$error">
          <p class="text-danger" v-if="!$v.username.required">
            This Field is required
          </p>
          <p class="text-danger" v-if="!$v.username.minLength">
            username is too short
          </p>
          <p class="text-danger" v-if="!$v.username.maxLength">
            username is too long
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
            password is too ez
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

      <b-form-group id="fName-group" label="First name:" label-for="fName">
        <b-form-input
          id="fName"
          type="text"
          placeholder="Enter your first name"
          v-model="$v.fName.$model"
        >
        </b-form-input>
        <template v-if="$v.fName.$error">
          <p class="text-danger" v-if="!$v.fName.required">
            This Field is required
          </p>
          <p class="text-danger" v-if="!$v.fName.maxLength">
            Your first name is too long
          </p>
        </template>
      </b-form-group>

      <b-form-group id="lName-group" label="Last name:" label-for="lName">
        <b-form-input
          id="lName"
          type="text"
          placeholder="Enter your last name"
          v-model="$v.lName.$model"
        >
        </b-form-input>
        <template v-if="$v.lName.$error">
          <p class="text-danger" v-if="!$v.lName.required">
            This Field is required
          </p>
          <p class="text-danger" v-if="!$v.lName.maxLength">
            Your last name is too long
          </p>
        </template>
      </b-form-group>

      <b-form-group id="gender-group" label="Gender:" label-for="gender">
        <b-form-select
          id="inline-form-custom-select-pref"
          class="mb-2 mr-sm-2 mb-sm-0"
          :options="[
            { text: 'Choose...', value: null },
            'Male',
            'Female',
            'Other',
          ]"
          :value="null"
          v-model="$v.gender.$model"
        ></b-form-select>
        <template v-if="$v.gender.$error">
          <p class="text-danger" v-if="!$v.gender.required">
            This Field is required
          </p>
        </template>
      </b-form-group>

      <b-form-group id="dob-group" label="Date of Birth:" label-for="dob">
        <b-form-datepicker
          id="dob"
          type="date"
          v-model="$v.dob.$model"
          :max="new Date()"
        >
        </b-form-datepicker>
        <template v-if="$v.dob.$error">
          <p class="text-danger" v-if="!$v.dob.required">
            This Field is required
          </p>
        </template>
      </b-form-group>

      <b-form-group id="email-group" label="Email:" label-for="email">
        <b-form-input
          id="email"
          type="email"
          placeholder="Enter your email"
          v-model="$v.email.$model"
        >
        </b-form-input>
        <template v-if="$v.email.$error">
          <p class="text-danger" v-if="!$v.email.required">
            This Field is required
          </p>
          <p class="text-danger" v-if="!$v.email.email">
            This seem It's not an email
          </p>
        </template>
      </b-form-group>

      <b-form-group id="address-group" label="Address:" label-for="email">
        <b-form-textarea
          id="address"
          type="text-area"
          placeholder="Enter your address"
          v-model="$v.address.$model"
          rows="3"
          max-rows="6"
        >
        </b-form-textarea>
        <template v-if="$v.address.$error">
          <p class="text-danger" v-if="!$v.address.required">
            This Field is required
          </p>
          <p class="text-danger" v-if="!$v.address.maxLength">
            Your address is too long
          </p>
        </template>
      </b-form-group>

      <b-form-group id="tel-group" label="Tel:" label-for="email">
        <b-form-input
          id="tel"
          type="text"
          placeholder="Enter your phone number"
          v-model="$v.tel.$model"
        >
        </b-form-input>
        <template v-if="$v.tel.$error">
          <p class="text-danger" v-if="!$v.tel.required">
            This Field is required
          </p>
          <p class="text-danger" v-if="!$v.tel.mobile">
            This is not phone number
          </p>
        </template>
      </b-form-group>

      <b-form-group id="button-group">
        <b-button block type="submit" @click="register" variant="primary">Register</b-button>
      </b-form-group>
    </b-form>
    <router-link to="/login">
      <b-button block variant="secondary">Back to Login</b-button>
    </router-link>
</b-container>
</template>

<style scoped>
.div-center {
  width: 700px;
  height: 500px;
  background-color: #fff;
  position: absolute;
  left: 0;
  right: 0;
  margin: auto;
  overflow: auto;
  padding: 1em 2em;
  border-bottom: 2px solid #ccc;
  display: table;
}
</style>


<script>
import {
  required,
  minLength,
  maxLength,
  sameAs,
  email,
} from "vuelidate/lib/validators";
import axios from "../plugins/axios";

function mobile(value) {
  return !!value.match(/0[0-9]{9}/);
}

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
      fName: "",
      lName: "",
      gender: null,
      dob: "",
      email: "",
      confirmPassword: "",
      address: "",
      tel: "",
      success: false,
      error: false,
      errMsg: "",
    };
  },
  methods: {
    register() {
      this.$v.$touch();

      if (!this.$v.$invalid) {
        let data = {
          username: this.username,
          password: this.password,
          confirmPassword: this.confirmPassword,
          fName: this.fName,
          lName: this.lName,
          gender: this.gender,
          dob: this.dob,
          email: this.email,
          address: this.address,
          tel: this.tel,
          userType: "customer"
        };

        axios
          .post("/register", data)
          .then((response) => {
            window.location = "#";
            this.success = true;
            this.error = false;
            this.errMsg = "";
            setTimeout(() => {
              window.location = "/login";
            }, 2000);
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
      minLength: minLength(5),
      maxLength: maxLength(25),
    },
    password: {
      required: required,
      minLength: minLength(8),
      complex: complexPassword,
    },
    confirmPassword: {
      required: required,
      sameAs: sameAs("password"),
    },
    fName: {
      required: required,
      maxLength: maxLength(150),
    },
    lName: {
      required: required,
      maxLength: maxLength(150),
    },
    gender: {
      required: required,
    },
    dob: {
      required: required,
    },
    email: {
      required: required,
      email: email,
    },
    address: {
      required: required,
      maxLength: maxLength(255),
    },
    tel: {
      required: required,
      mobile: mobile,
    },
  },
};
</script>
