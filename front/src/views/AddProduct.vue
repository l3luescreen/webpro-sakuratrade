<template>
  <b-container class="my-auto w-50" fluid="sm">
    <b-img class="mb-3" fluid :src="require('../assets/logo.png')"></b-img>
    <b-alert v-model="error" variant="danger"> {{ errMsg }} </b-alert>
    <b-alert v-model="success" variant="success">
      Change profile Successfully
    </b-alert>
    <b-form @submit.stop.prevent>
      <b-form-group id="img-group" label="Product Image:" label-for="img">
        <b-form-file
          id="img-product"
          accept="image/png, image/jpeg, image/webp"
          @change="selectImages"
        >
        </b-form-file>
        <div v-if="images" class="columns is-multiline">
          <div
            v-for="image in images"
            :key="image.id"
            class="column is-one-quarter"
          >
            <div class="card">
              <div class="card-image">
                <figure class="image is-4by3">
                  <img :src="showSelectImage(image)" alt="Placeholder image" />
                </figure>
              </div>
            </div>
          </div>
        </div>
      </b-form-group>

      <b-row>
        <b-col>
          <b-form-group
            id="p_name-group"
            label="Product name:"
            label-for="p_name"
          >
            <b-form-input
              id="p_name"
              type="text"
              placeholder="Enter p_name"
              v-model="$v.p_name.$model"
            >
            </b-form-input>
            <template v-if="$v.p_name.$error">
              <p class="text-danger" v-if="!$v.p_name.required">
                This Field is required
              </p>
              <p class="text-danger" v-if="!$v.p_name.maxLength">
                Your product name is too long
              </p>
            </template>
          </b-form-group>
        </b-col>
      </b-row>
      <!-- ------------------------------------------------ -->

      <b-form-group
        id="productDesc-group"
        label="Product description:"
        label-for="productDesc"
      >
        <b-form-textarea
          id="productDesc"
          type="text-area"
          placeholder="Enter Product description"
          v-model="$v.p_desc.$model"
          rows="3"
          max-rows="6"
        >
        </b-form-textarea>
        <template v-if="$v.p_desc.$error">
          <p class="text-danger" v-if="!$v.p_desc.required">
            This Field is required
          </p>
          <p class="text-danger" v-if="!$v.p_desc.maxLength">
            Your product description is too long
          </p>
        </template>
      </b-form-group>
      <b-form-group
        id="productType-group"
        label="Product type:"
        label-for="productType"
      >
        <b-form-select
          id="inline-form-custom-select-pref"
          class="mb-2 mr-sm-2 mb-sm-0"
          :options="[
            { text: 'Choose...', value: null },
            { text: 'Clothing', value: 1 } ,
            { text: 'Accesseries', value: 2 },
            { text: 'Bag', value: 3 },
          ]"
          v-model="$v.p_type.$model"
        ></b-form-select>
        <template v-if="$v.p_type.$error">
          <p class="text-danger" v-if="!$v.p_type.required">
            This Field is required
          </p>
        </template>
      </b-form-group>

      <b-form-group id="price" label="Price:" label-for="price">
        <b-form-input
          id="price"
          type="number"
          placeholder="Enter your product price"
          v-model="$v.unit_price.$model"
        >
        </b-form-input>
        <template v-if="$v.unit_price.$error">
          <p class="text-danger" v-if="!$v.unit_price.required">
            This Field is required
          </p>
          <p class="text-danger" v-if="!$v.unit_price.numeric">
            Product price must be only number
          </p>
        </template>
      </b-form-group>

      <b-form-group id="quantity-group" label="Quantity:" label-for="quantity">
        <b-form-input
          id="quantity"
          type="number"
          placeholder="Enter your quantity of your product"
          v-model="$v.quantity.$model"
        >
        </b-form-input>
        <template v-if="$v.quantity.$error">
          <p class="text-danger" v-if="!$v.quantity.required">
            This Field is required
          </p>
          <p class="text-danger" v-if="!$v.quantity.numeric">
            Product price must be only number
          </p>
        </template>
      </b-form-group>

      <b-form-group
        label="Supplier:"
        label-for="productType"
      >
        <b-form-select
          class="mb-2 mr-sm-2 mb-sm-0"
          :options="supplier"
          v-model="$v.selected.$model"
        ></b-form-select>
        <template v-if="$v.selected.$error">
          <p class="text-danger" v-if="!$v.selected.required">
            This Field is required
          </p>
        </template>
      </b-form-group>

      <b-form-group id="button-group">
        <b-button block type="submit" variant="success" @click="submitProduct">Add product</b-button>
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
import { required, numeric, maxLength } from "vuelidate/lib/validators";
import axios from "../plugins/axios";

export default {
  data() {
    return {
      p_name: "",
      p_type: null,
      quantity: "",
      p_desc: "",
      unit_price: "",
      success: false,
      error: false,
      errMsg: "",
      type: "",
      images: [],
      supplier: [],
      selected: ""
    };
  },
  created() {
    axios.get("/supplier").then((res) => {
      this.supplier = res.data
    }).catch((err) => {
      console.log(err)
    })
  },
  methods: {
    selectImages(event) {
      this.images = event.target.files;
    },
    showSelectImage(image) {
      // for preview only
      return URL.createObjectURL(image);
    },
    submitProduct() {
      this.$v.$touch();

      if (!this.$v.$invalid) {
      }
      let formData = new FormData();
      formData.append("p_name", this.p_name);
      formData.append("p_desc", this.p_desc);
      formData.append("type", this.p_type);
      formData.append("unit_price", this.unit_price);
      formData.append("quantity", this.quantity);
      this.images.forEach((image) => {
        formData.append("prod_img", image);
      });
      formData.append("s_id", this.selected);

      axios
        .post(`/product/add`, formData)
        .then((response) => {
          this.$router.push({ path: "/" });
        })
        .catch((error) => {
          console.log(error);
        });
    },
  },
  validations: {
    p_name: {
      required: required,
      maxLength: maxLength(150),
    },
    p_type: {
      required: required,
    },
    p_desc: {
      required: required,
      maxLength: maxLength(255),
    },
    unit_price: {
      required: required,
      numeric,
    },
    quantity: {
      required: required,
      numeric,
    },
    selected: {
      required: required
    }
  },
};
</script>