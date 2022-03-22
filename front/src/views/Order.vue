<template>
  <b-container class="text-center">
    <h1>Order History</h1>
    <b-row class="mb-5 mt-5">
      <b-col md="11" sm="11">
        <b-form-input
          v-model="search"
          placeholder="Search Order History by Customer ID or Customer name"
        ></b-form-input>
      </b-col>
      <b-col md="1" sm="1">
        <b-button variant="primary" @click="searchData">Search</b-button>
      </b-col>
    </b-row>
    <h3 class="text-center" v-if="!!(orders.length === 0)">Not found</h3>
    <b-table
      hover
      head-variant="light"
      :items="orders"
      :fields="fields"
      :tbody-tr-class="orderStatus"
    ></b-table>
  </b-container>
</template>

<script>
import axios from "../plugins/axios";
function dateTimeFormatter(dateTime) {
  return new Date(dateTime).toGMTString().replace(" GMT", "");
}

export default {
  props: ["user", "userType"],
  data() {
    return {
      fields: [
        { key: "order_datetime", sortable: true },
        { key: "order_status", sortable: true },
        { key: "payment_type" },
        { key: "total_price", sortable: true },
      ],
      orders: [],
      state: "customer",
      search: "",
      length: 0,
    };
  },
  created() {
    if (this.userType === "customer") {
      const data = {
        cus_id: this.user.cus_id,
        userType: this.userType,
      };
      axios
        .post("/order", data)
        .then((res) => {
          var orders = res.data;
          orders.forEach((order) => {
            order.order_datetime = dateTimeFormatter(order.order_datetime);
            return order;
          });
          this.orders = orders;
        })
        .catch((err) => {
          console.log(err);
        });
    } else if (this.userType === "employee") {
      const data = {
        search: this.search,
      };
      axios
        .post("/orderAll", data)
        .then((res) => {
          var orders = res.data;
          this.length = this.orders.length;
          orders.forEach((order) => {
            order.order_datetime = dateTimeFormatter(order.order_datetime);
            return order;
          });
          this.orders = orders;
        })
        .catch((err) => {
          console.log(err);
        });
    }
  },
  methods: {
    orderStatus(item) {
      if (item.order_status === "Delivering") return "table-warning";
      else if (item.order_status === "Complete") return "table-success";
      else if (item.order_status === "Incomplete") return "table-danger";
    },
    searchData() {
      const data = {
        search: this.search,
      };
      axios
        .post("/orderAll", data)
        .then((res) => {
          var orders = res.data;
          orders.forEach((order) => {
            order.order_datetime = dateTimeFormatter(order.order_datetime);
            return order;
          });
          this.orders = orders;
          this.length = this.orders.length;
        })
        .catch((err) => {
          console.log(err);
        });
    },
  },
};
</script>