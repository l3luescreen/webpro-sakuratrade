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
    <h3 class="text-center" v-if="!!(employees.length === 0)">Not found</h3>
    <b-table
      hover
      head-variant="light"
      :items="employees"
      :fields="fields"
    ></b-table>
  </b-container>
</template>

<script>
import axios from "../plugins/axios";
function dateTimeFormatter(dateTime) {
  return new Date(dateTime).toDateString();
}

export default {
  props: ["user"],
  data() {
    return {
      fields: [
        { key: "Employee ID", sortable: true },
        { key: "First name", sortable: true },
        { key: "Last name", sortable: true },
        { key: "gender", sortable: true },
        { key: "Date of birth", sortable: true },
        { key: "Email", sortable: true },
      ],
      employees: [],
      search: "",
      length: 0,
    };
  },
  created() {
    const data = {
      search: this.search,
    };
    axios
      .post("/employees", data)
      .then((res) => {
        this.employees = res.data;
        this.employees.forEach((employee) => {
          employee["Date of birth"] = dateTimeFormatter(employee["Date of birth"]);
          return employee;
        });
        this.length = this.employees.length;
      })
      .catch((err) => {
        console.log(err);
      });
  },
  methods: {
    searchData() {
      const data = {
        search: this.search,
      };
      axios
        .post("/employees", data)
        .then((res) => {
          this.employees = res.data;
          this.length = this.employees.length;
        })
        .catch((err) => {
          console.log(err);
        });
    },
  },
};
</script>