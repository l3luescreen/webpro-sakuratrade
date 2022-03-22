const express = require("express");
const pool = require("../config");

router = express.Router();

const { isLogged } = require('../middlewares')

router.get("/", async function (req, res, next) {
  const [rows, fields] = await pool.query("SELECT username FROM customer")
  res.json(rows)
});

exports.router = router;
