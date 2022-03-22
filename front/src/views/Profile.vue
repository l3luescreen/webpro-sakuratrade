<template>
  <b-container class="my-auto w-50" fluid="sm">
    <b-button class="edit-btn" @click="editState = !editState"
      >Edit Profile</b-button
    >
    <b-img fluid :src="require('../assets/logo.png')"></b-img>
    <b-alert v-model="error" variant="danger"> {{ errMsg }} </b-alert>
    <b-alert v-model="success" variant="success">
      Change profile Successfully
    </b-alert>
    <b-form @submit.stop.prevent>
      <b-row>
        <b-col>
          <b-form-group
            id="username-group"
            label="Username:"
            label-for="username"
          >
            <b-form-input
              id="username"
              type="text"
              placeholder="Enter username"
              v-model="username"
              disabled
            >
            </b-form-input>
          </b-form-group>
        </b-col>
      </b-row>
      <b-row>
        <b-col md="6" sm="12">
          <b-form-group id="fName-group" label="First name:" label-for="fName">
            <b-form-input
              id="fName"
              type="text"
              placeholder="Enter your first name"
              v-model="$v.fName.$model"
              :disabled="!editState"
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
        </b-col>
        <b-col md="6" sm="12">
          <b-form-group id="lName-group" label="Last name:" label-for="lName">
            <b-form-input
              id="lName"
              type="text"
              placeholder="Enter your last name"
              v-model="$v.lName.$model"
              :disabled="!editState"
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
        </b-col>
      </b-row>

      <b-form-group id="dob-group" label="Date of Birth:" label-for="dob">
        <b-form-datepicker
          id="dob"
          type="date"
          v-model="$v.dob.$model"
          :max="new Date()"
          :disabled="!editState"
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
          :disabled="!editState"
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

      <b-form-group
        id="address-group"
        label="Address:"
        label-for="address"
        v-show="type === 'customer'"
      >
        <b-form-textarea
          id="address"
          type="text-area"
          placeholder="Enter your address"
          v-model="$v.address.$model"
          rows="3"
          max-rows="6"
          :disabled="!editState"
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

      <b-form-group
        id="tel-group"
        label="Tel:"
        label-for="tel"
        v-show="type === 'customer'"
      >
        <b-form-input
          id="tel"
          type="text"
          placeholder="Enter your phone number"
          v-model="$v.tel.$model"
          :disabled="!editState"
        >
        </b-form-input>
        <template v-if="$v.tel.$error">
          <p class="text-danger" v-if="!$v.tel.required">
            This Field is required
          </p>
          <p class="text-danger" v-if="!$v.tel.mobile">
            This is not phone number
          </p>
          <p class="text-danger" v-if="!$v.tel.max">
            Your phone number is too long
          </p>
        </template>
      </b-form-group>

      <b-form-group id="button-group">
        <b-button
          block
          type="submit"
          variant="success"
          v-show="editState"
          @click="ChangeData"
          >Submit</b-button 
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
import axios from "../plugins/axios";
import { required, maxLength, email, requiredIf } from "vuelidate/lib/validators";

export default {
  props: ["user"],
  data() {
    return {
      username: "",
      fName: "",
      lName: "",
      dob: "",
      email: "",
      address: "",
      tel: "",
      success: false,
      error: false,
      errMsg: "",
      type: "",
      editState: false,
    };
  },
  created() {
    const userType = JSON.parse(sessionStorage.getItem('state'))
    this.type = userType.userType
    this.username = this.user.username;
    this.fName = this.user.f_name;
    this.lName = this.user.l_name;
    this.dob = this.user.dob;
    this.email = this.user.email;
    this.address = this.user.cus_address;
    this.tel = this.user.cus_tel;
  },
  methods: {
    ChangeData() {
      this.$v.$touch();

      if (!this.$v.$invalid) {
        if (this.type === "customer"){
          var data = {
            username: this.user.username,
            fName: this.fName,
            lName: this.lName,
            dob: this.dob,
            email: this.email,
            address: this.address,
            tel: this.tel,
            userType: this.type
          };
        } else if (this.type === "employee"){
          var data = {
            username: this.user.username,
            fName: this.fName,
            lName: this.lName,
            dob: this.dob,
            email: this.email,
            userType: this.type
          };
        }

        axios
          .put(`/editProfile`, data)
          .then((response) => {
            // this.fName = response.data.f_name;
            // this.lName = response.data.l_name;
            // this.dob = response.data.dob;
            // this.email = response.data.email;
            // this.address = response.data.address;
            // this.tel = response.data.tel;
            this.editState = false;

           
          })
          .catch((error) => {
            console.log(error);
          });
      }
    },
  },
  validations: {
    fName: {
      required: required,
      maxLength: maxLength(150),
    },
    lName: {
      required: required,
      maxLength: maxLength(150),
    },
    dob: {
      required: required,
    },
    email: {
      required: required,
      email: email,
    },
    address: {
      required: requiredIf((type) => {return type === "customer"}),
      maxLength: maxLength(255),
    },
    tel: {
      required: requiredIf((type) => {return type === "customer"}),
      max: maxLength(10),
    },
  },
};
</script>