<template>
  <div class="container is-widescreen">
    <b-row class="mb-5 mt-5">
      <b-col md="11" sm="11">
        <b-form-input
          v-model="search"
          placeholder="Search name, description or price"
        ></b-form-input>
      </b-col>
      <b-col md="1" sm="1">
        <b-button variant="primary" @click="getProducts">Search</b-button>
      </b-col>
    </b-row>

    <b-row>
      <b-col
        class="mb-2"
        md="3"
        sm="12"
        v-for="product in products"
        :key="product.p_id"
        @click="showModal(product)"
      >
        <b-card
          header-tag="header"
          :title="product.p_name"
          :img-src="imagePath(product.img)"
          img-alt="Product image"
        >
          <b-row no-gutters>
            <b-col md="4"> </b-col>
          </b-row>
          <b-card-text class="float-right">
            {{ product.unit_price + " Bath" }}
          </b-card-text>
        </b-card>
      </b-col>
    </b-row>

    <b-modal ref="product-modal" size="xl" hide-footer :title="modalName">
      <div class="d-block text-center" v-if="!editState">
        <b-img class="img-fluid img-thumbnail" :src="modalImg"></b-img>
        <h4>Description</h4>
        <b-form-textarea
          id="textarea-plaintext"
          class="overflow-hidden"
          plaintext
          :value="modalDesc"
          max-rows="100"
        ></b-form-textarea>
      </div>
      <b-row v-if="!editState">
        <b-col md="10" sm="9" class="text-right">Is Stock : </b-col>
        <b-col md="2" sm="3">
          <b-form-input
            class="text-right"
            :value="modalQuantity"
            disabled
          ></b-form-input>
        </b-col>
      </b-row>
      <b-row v-if="!editState">
        <b-col md="10" sm="9" class="text-right"> Amount: </b-col>
        <b-col>
          <b-form-input
            md="2"
            sm="3"
            class="text-right"
            type="number"
            v-model="modalAmount"
            min="1"
            :max="modalQuantity"
            @change="validateAmount"
          ></b-form-input>
        </b-col>
      </b-row>
      <!-- เปลี่ยนเป็ฯ modal สำหรับอัพเดต -->
      <template v-if="editState">
        <b-form-group id="img-group" label="Product Image:" label-for="img">
          <b-form-checkbox
            id="checkbox-1"
            v-model="status"
            name="checkbox-1"
            :value="!status"
          >
            Do you want to change Product image?
          </b-form-checkbox>
          <b-form-file
            id="img-product"
            accept="image/png, image/jpeg, image/webp"
            @change="selectImages"
            :disabled="!status"
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
                    <img
                      :src="showSelectImage(image)"
                      :model="image"
                      alt="Placeholder image"
                    />
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
                v-model="$v.modalName.$model"
              >
              </b-form-input>
              <template v-if="$v.modalName.$error">
                <p class="text-danger" v-if="!$v.modalName.required">
                  This Field is required
                </p>
                <p class="text-danger" v-if="!$v.modalName.maxLength">
                  Your product name is too long
                </p>
              </template>
            </b-form-group>
            <b-form-group
              id="productDesc-group"
              label="Product description:"
              label-for="productDesc"
            >
              <b-form-textarea
                id="productDesc"
                type="text-area"
                placeholder="Enter Product description"
                v-model="$v.modalDesc.$model"
                rows="3"
                max-rows="6"
              >
              </b-form-textarea>
              <template v-if="$v.modalDesc.$error">
                <p class="text-danger" v-if="!$v.modalDesc.required">
                  This Field is required
                </p>
                <p class="text-danger" v-if="!$v.modalDesc.maxLength">
                  Your product description is too long
                </p>
              </template>
            </b-form-group>
            <b-form-group id="price" label="Price:" label-for="price">
              <b-form-input
                id="price"
                type="number"
                placeholder="Enter your product price"
                v-model="$v.modalPrice.$model"
              >
              </b-form-input>
              <template v-if="$v.modalPrice.$error">
                <p class="text-danger" v-if="!$v.modalPrice.required">
                  This Field is required
                </p>
                <p class="text-danger" v-if="!$v.modalPrice.numeric">
                  Product price must be only number
                </p>
              </template>
            </b-form-group>
          </b-col>
        </b-row>
      </template>
      <b-row v-if="!editState">
        <b-col md="10" sm="9" class="text-right">Total Price: </b-col>
        <b-col md="2" sm="3">
          <b-form-input
            class="text-right"
            :value="modalPrice * modalAmount"
            disabled
          ></b-form-input>
        </b-col>
      </b-row>
      <b-button
        v-if="userType === 'customer' || userType === ''"
        class="mt-3"
        variant="outline-success"
        block
        @click="addProduct"
        >Add to cart</b-button
      >
      <b-button
        v-if="editState"
        class="mt-3"
        variant="outline-success"
        block
        @click="submitEdit"
        >Confirm Edit</b-button
      >
      <b-button
        class="mt-3"
        variant="outline-warning"
        v-if="userType === 'employee'"
        @click="editProduct"
        block
        >Edit Product</b-button
      >
      <b-button
        v-if="userType === 'employee'"
        class="mt-2"
        @click="deleteProduct"
        variant="outline-danger"
        block
        >Delete this product</b-button
      >
      <b-button class="mt-2" @click="closeModal" variant="outline-danger" block
        >close</b-button
      >
    </b-modal>
  </div>
</template>

<script>
import axios from "../plugins/axios";
import { required, numeric, maxLength } from "vuelidate/lib/validators";

export default {
  props: ["user", "userType"],
  data() {
    return {
      search: "",
      products: "",
      modalName: "",
      modalImg: "",
      modalDesc: "",
      modalPrice: 0,
      modalAmount: 1,
      modalQuantity: 1,
      modal_p_id: "",
      currentInCart: [],
      targetProduct: {},
      product_id: "",
      editState: false,
      images: [],
      p_name: "",
      status: false,
    };
  },
  created: function () {
    this.getProducts();
    if (!sessionStorage.getItem("cart")) {
      sessionStorage.setItem("cart", JSON.stringify(this.currentInCart));
    }
  },
  methods: {
    getProducts() {
      axios
        .get("/product", {
          params: {
            search: this.search,
          },
        })
        .then((response) => {
          this.products = response.data;
        })
        .catch((err) => {
          console.log(err);
        });
    },
    imagePath(file_path) {
      if (file_path) {
        return "http://localhost:3000/" + file_path;
      } else {
        return "https://bulma.io/images/placeholders/640x360.png";
      }
    },
    showModal(target) {
      this.modalAmount = 1;
      this.currentProduct = target;
      this.modalName = target.p_name;
      this.modalImg = this.imagePath(target.img);
      this.modalDesc = target.p_desc;
      this.modalPrice = target.unit_price;
      this.modalQuantity = target.quantity;
      this.modal_p_id = target.p_id;
      this.$refs["product-modal"].show();
    },
    addProduct() {
      let tPrice = this.modalPrice * this.modalAmount;
      this.targetProduct = {
        p_id: this.modal_p_id,
        p_name: this.modalName,
        amount: this.modalAmount,
        img: this.modalImg,
        price: tPrice,
      };
      let cartAmount = parseInt(
        this.$store.getters.getTotalAmount(this.modalName)
      );
      if (cartAmount + parseInt(this.modalAmount) <= this.modalQuantity) {
        this.$store.commit("addProduct", this.targetProduct);
      }

      this.modalAmount = 1;
      this.$refs["product-modal"].hide();
    },
    validateAmount() {
      if (this.modalAmount > this.modalQuantity) {
        this.modalAmount = this.modalQuantity;
      }
    },
    editProduct() {
      this.editState = !this.editState;
    },
    selectImages(event) {
      this.images = event.target.files;
    },
    showSelectImage(image) {
      // for preview only
      return URL.createObjectURL(image);
    },
    closeModal() {
      this.$refs["product-modal"].hide();
    },
    submitEdit() {
      let formData = new FormData();
      formData.append("p_id", this.modal_p_id);
      formData.append("p_name", this.modalName);
      formData.append("p_desc", this.modalDesc);
      formData.append("unit_price", this.modalPrice);
      formData.append("changeImg", this.status);
      if (this.status) {
        this.images.forEach((image) => {
          formData.append("prod_img", image);
        });
      }

      axios
        .put("/product/edit", formData)
        .then((res) => {
          alert("Edit product success")
        })
        .catch((err) => {
          console.log(err);
        });
      window.location = "/";
    },
    deleteProduct() {
      let dataDel = {
        p_id: this.modal_p_id,
      };
      axios
        .delete(`/product/delete/${this.modal_p_id}`)
        .then((res) => {
          alert("Delete success");
          window.location = "/";
        })
        .catch((err) => {
          console.log(err);
        });
    },
  },
  validations: {
    modalName: {
      required: required,
      maxLength: maxLength(150),
    },
    modalDesc: {
      required: required,
      maxLength: maxLength(255),
    },
    modalPrice: {
      required: required,
      numeric,
    },
  },
};
</script>