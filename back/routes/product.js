const express = require("express");
const path = require("path");
const pool = require("../config");
const fs = require("fs");
const Joi = require('joi')

const { isLogged, isEmployee } = require('../middlewares')

router = express.Router();
router.use(express.urlencoded({ extended: true })) // for parsing application/x-www-form-urlencoded
router.use(express.json());

// Require multer for file upload
const multer = require("multer");
var storage = multer.diskStorage({
  destination: function (req, file, callback) {
    callback(null, "./static/uploads");
  },
  filename: function (req, file, callback) {
    callback(
      null,
      file.fieldname + "-" + Date.now() + path.extname(file.originalname)
    );
  },
});
const upload = multer({ storage: storage });
// const upload = multer({ dest: './static/uploads' });

const productSchema = Joi.object({
  p_name: Joi.string().required(),
  p_desc: Joi.string().required(),
  unit_price: Joi.string().required(),
  type: Joi.number().required(),
  quantity: Joi.number().integer().required(),
  s_id: Joi.string().required(),

  // changeImg: Joi.boolean().required(),
})

const productEditSchema = Joi.object({
  p_id: Joi.string().required(),
  p_name: Joi.string().required(),
  p_desc: Joi.string().required(),
  unit_price: Joi.string().required(),
  changeImg: Joi.boolean().required(),
})

router.get("/product", async function (req, res, next) {
  const [rows, fields] = await pool.query("SELECT * FROM Product")
  try {
    const search = req.query.search || ''
    let sql = 'SELECT * FROM product'
    let cond = []

    if (search.length > 0) {
      sql = 'SELECT * FROM product WHERE p_name LIKE ? OR p_desc LIKE ? OR unit_price LIKE ?;'
      cond = [`%${search}%`, `%${search}%`, `%${search}%`]
    }
    const [rows, fields] = await pool.query(sql, cond);
    return res.json(rows);
  } catch (err) {
    return res.status(500).json(err)
  }
})

router.post("/product/add", isLogged, isEmployee, upload.single('prod_img'), async function (req, res, next) {

  try {
    await productSchema.validateAsync(req.body, { abortEarly: false })
  } catch (err) {
    return console.log(err)
  }

  const file = req.file;

  if (!file) {
    return res.status(400).json({ message: "Please upload a file" });
  }
  let img = file.path;

  const p_name = req.body.p_name
  const p_desc = req.body.p_desc
  const unit_price = parseInt(req.body.unit_price)
  const quantity = parseInt(req.body.quantity)
  const type = parseInt(req.body.type)
  const s_id = req.body.s_id


  const conn = await pool.getConnection();
  await conn.beginTransaction();
  try {
    const [rows1, fields1] = await conn.query("SELECT p_id FROM Product WHERE p_name = ?", [p_name])
    if (rows1[0]) {
      res.json({
        error: true,
        errMsg: "This product is already exist"
      })
    }
    else {
      const addProduct = await conn.query("INSERT INTO `Product` (`p_name`, `p_desc`, `unit_price`, `quantity`, `img`, `product_type_type_id`) VALUES(?, ?, ?, ?, ?, ?);",
        [p_name, p_desc, unit_price, quantity, img.substring(6), type])
      const product_id = addProduct[0].insertId
      await conn.query("INSERT INTO `product_supplier` (`p_id`, `s_id`, `unit_price`, `update_date`) VALUES(?, ?, ?, CURRENT_TIMESTAMP);",
        [product_id, s_id, unit_price])
    }
    conn.commit()
    res.send("success")
  } catch (err) {
    await conn.rollback();
    console.log(err)
    return res.status(400).json(err.message);
  } finally {
    conn.release();
  }

})

router.put("/product/edit", isLogged, isEmployee, upload.single('prod_img'), async function (req, res, next) {
  try {
    await productEditSchema.validateAsync(req.body, { abortEarly: false })
  } catch (err) {
    console.log(err)
  }
  var changeImg = req.body.changeImg

  const p_id = req.body.p_id
  const p_name = req.body.p_name
  const p_desc = req.body.p_desc
  const unit_price = req.body.unit_price

  try {
    // const [rows1, fields1] = await pool.query("SELECT * FROM Product WHERE p_id = ?", [p_id])
    if (JSON.parse(changeImg)) {
      const file = req.file;
      if (!file) {
        return res.status(400).json({ message: "Please upload a file" });
      }
      let img = file.path;
      await pool.query("UPDATE Product SET p_name = ?, p_desc = ?, unit_price = ?, img = ? WHERE p_id = ?",
        [p_name, p_desc, unit_price, img.substring(6), p_id])
    } else {
      await pool.query("UPDATE Product SET p_name = ?, p_desc = ?, unit_price = ? WHERE p_id = ?",
        [p_name, p_desc, unit_price, p_id])
    }

    res.send("success")
  } catch (err) {
    console.log(err)
    return res.status(400).json(err);
  } finally {
    console.log("finally");
  }
})

router.delete(`/product/delete/:del`, isLogged, isEmployee, async function (req, res, next) {
  const conn = await pool.getConnection();
  await conn.beginTransaction();
  try {
    await conn.query("DELETE FROM product_supplier WHERE(p_id = ?)",
      [req.params.del])

    await conn.query("DELETE FROM product WHERE(p_id = ?)",
      [req.params.del])

    conn.commit()
    res.send("success")

  } catch (err) {
    await conn.rollback();
    console.log(err)
    return res.status(400).json(err.message);
  } finally {
    conn.release();
  }
})
exports.router = router;
