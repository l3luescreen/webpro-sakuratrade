const express = require("express");
const jwt = require("jsonwebtoken")
const bcrypt = require("bcrypt")
const pool = require("../config");
const Joi = require('joi')

const { isLogged, isEmployee } = require('../middlewares')

router = express.Router();
router.use(express.urlencoded({ extended: true })) // for parsing application/x-www-form-urlencoded
router.use(express.json());

const usernameValidator = async (value, helpers) => {
  const [rows1, field1] = await pool.query(
    "SELECT username FROM customer WHERE username = ?",
    [value])
  const [rows2, field2] = await pool.query(
    "SELECT username FROM employee WHERE username = ?",
    [value])
  if (rows1.length > 0 || rows2.length > 0) {
    const message = 'This user is already taken'
    throw new Joi.ValidationError(message, { message })
  }
  return value
}

const passwordValidator = (value, helpers) => {
  if (value.length < 8) {
    throw new Joi.ValidationError('Password must contain at least 8 characters')
  }
  if (!(value.match(/[a-z]/) && value.match(/[A-Z]/) && value.match(/[0-9]/))) {
    throw new Joi.ValidationError('Password must be harder')
  }
  return value
}

const emailValidator = async (value, helpers) => {
  const [rows1, field1] = await pool.query(
    "SELECT email FROM customer WHERE email = ?",
    [value])

  const [rows2, field2] = await pool.query(
    "SELECT email FROM employee WHERE email = ?",
    [value])
  if (rows1.length > 0 || rows2.length > 0) {
    const message = 'This email is already taken'
    throw new Joi.ValidationError(message, { message })
  }
  return value
}


const loginSchema = Joi.object({
  username: Joi.string().required(),
  password: Joi.string().required(),
  userType: Joi.string().allow("customer", "employee").required()
})

const RegisterSchema = Joi.object({
  username: Joi.string().required().min(5).max(25).external(usernameValidator),
  fName: Joi.string().required().max(150),
  lName: Joi.string().required().max(150),
  gender: Joi.string().required().allow('Male', 'Female', 'Other'),
  dob: Joi.date().required(),
  email: Joi.string().required().email().external(emailValidator),
  password: Joi.string().required().custom(passwordValidator),
  confirmPassword: Joi.string().required().valid(Joi.ref('password')),
  userType: Joi.string().required().valid('customer', 'employee'),
})

const RegisterCusSchema = Joi.object({
  username: Joi.string().required().min(5).max(25).external(usernameValidator),
  fName: Joi.string().required().max(150),
  lName: Joi.string().required().max(150),
  gender: Joi.string().required().allow('Male', 'Female', 'Other'),
  dob: Joi.date().required(),
  email: Joi.string().required().email().external(emailValidator),
  password: Joi.string().required().custom(passwordValidator),
  confirmPassword: Joi.string().required().valid(Joi.ref('password')),
  userType: Joi.string().required().valid('customer', 'employee'),
  address: Joi.string().required().max(255),
  tel: Joi.string().required().pattern(/0[0-9]{9}/),
})

const editCusSchema = Joi.object({
  username: Joi.string().required(),
  fName: Joi.string().required().max(150),
  lName: Joi.string().required().max(150),
  email: Joi.string().required().email(),
  dob: Joi.date().required(),
  address: Joi.string().required().max(255),
  tel: Joi.string().required().pattern(/0[0-9]{9}/),
  userType: Joi.string().required().valid("customer", "employee")
})

const editEmpSchema = Joi.object({
  username: Joi.string().required(),
  fName: Joi.string().required().max(150),
  lName: Joi.string().required().max(150),
  email: Joi.string().required().email(),
  dob: Joi.date().required(),
  userType: Joi.string().required().valid("customer", "employee")
})

const channgePassSchema = Joi.object({
  username: Joi.string().required().min(5).max(25),
  currPassword: Joi.string().required().required().custom(passwordValidator),
  password: Joi.string().required().disallow(Joi.ref('currPassword')).custom(passwordValidator),
  confirmPassword: Joi.string().required().valid(Joi.ref('password')),
  userType: Joi.string().required().valid('customer', 'employee'),
})

router.post("/login", async function (req, res, next) {
  try {
    await loginSchema.validateAsync(req.body, { abortEarly: false })
  } catch (err) {
    console.log(err)
    res.json({
      "username": req.body.username,
      "error": true,
      "errMsg": err.message
    })
  }

  try {

    if (req.body.userType === "customer") {
      var [rows, _] = await pool.query("SELECT username, f_name, password FROM customer WHERE username = ?",
        [req.body.username])
    } else if (req.body.userType === "employee") {
      var [rows, _] = await pool.query("SELECT username, f_name, password FROM employee WHERE username = ?",
        [req.body.username])
    }
    if (rows[0]) {
      const rawPass = req.body.password
      const dbPass = rows[0].password

      const result = await bcrypt.compare(rawPass, dbPass)

      if (result) {
        // generate token
        const payload = {
          username: rows[0].username,
          fName: rows[0].f_name,
          userType: req.body.userType
        }

        const key = "sakuraKey"
        const token = jwt.sign(payload, key, { expiresIn: 60 * 1000 })
        res.json({
          "username": req.body.username,
          "fName": rows[0].f_name,
          "error": false,
          "errMsg": "",
          "userType": req.body.userType,
          "token": token,
        })
      }

    } else {
      res.json({
        "username": req.body.username,
        "error": true,
        "errMsg": "Username or Password is incorrect"
      })
    }
  } catch (err) {
    return res.status(400).send(err);
  } finally {
    console.log("finally");
  }
});

router.post("/register", async function (req, res, next) {
  let type = req.body.userType
  const fName = req.body.fName
  const lName = req.body.lName
  const gender = req.body.gender
  const dob = req.body.dob
  const email = req.body.email
  const username = req.body.username
  const password = await bcrypt.hashSync(req.body.password, 10)
  const address = req.body.address
  const tel = req.body.tel

  if (type === "customer") {
    try {
      await RegisterCusSchema.validateAsync(req.body, { abortEarly: false })
      await pool.query("INSERT INTO `customer` (`f_name`, `l_name`, `gender`, `dob`, `email`, `username`, `password`, `cus_address`, `cus_tel`) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?);",
        [fName, lName, gender, dob, email, username, password, address, tel])
      res.send("success")

    } catch (err) {
      res.status(400).json(err)
    }
  } else if (type === "employee") {
    try {
      await RegisterSchema.validateAsync(req.body, { abortEarly: false })
      await pool.query("INSERT INTO `employee` (`f_name`, `l_name`, `gender`, `dob`, `email`, `username`, `password`) VALUES(?, ?, ?, ?, ?, ?, ?);",
        [fName, lName, gender, dob, email, username, password])
      res.send("success")
    } catch (err) {
      res.status(400).json(err)
    } finally {
      console.log("finally");
    }
  }
})

router.get("/profile", isLogged, async function (req, res, next) {
  try {
    res.json(req.user)
  } catch (err) {
    return res.status(400).json(err);
  } finally {
    console.log("finally");
  }
}
)

router.put("/editProfile/", isLogged, async function (req, res, next) {
  let type = req.body.userType
  try {
    if (type === "customer") {
      await editCusSchema.validateAsync(req.body, { abortEarly: false })
    } else if (type === "employee") {
      await editEmpSchema.validateAsync(req.body, { abortEarly: false })
    }
  } catch (err) {
    return res.status(400).json(err)
  }
  const f_name = req.body.fName
  const l_name = req.body.lName
  const email = req.body.email
  const dob = req.body.dob

  try {
    if (type == "customer") {
      const address = req.body.address
      const tel = req.body.tel
      await pool.query("UPDATE customer SET f_name = ?, l_name = ?, email = ?, dob = ?, cus_address = ?, cus_tel = ? WHERE username = ?",
        [f_name, l_name, email, dob, address, tel, req.body.username])
    } else if (type == "employee") {
      await pool.query("UPDATE employee SET f_name = ?, l_name = ?, email = ?, dob = ? WHERE username = ?",
        [f_name, l_name, email, dob, req.body.username])
    }
    res.send("success")
  } catch (err) {
    return res.status(400).json(err);
  } finally {
    console.log("finally");
  }
})

router.put("/changePassword", isLogged, async function (req, res, next) {
  const type = req.body.userType
  try {
    await channgePassSchema.validateAsync(req.body, { abortEarly: false })
  } catch (err) {
    res.status(400).json(err)
  }
  const username = req.body.username
  if (type === "employee") {
    var [rows, _] = await pool.query("SELECT password FROM employee WHERE username = ?",
      [username])
  } else if (type === "customer") {
    var [rows, _] = await pool.query("SELECT password FROM customer WHERE username = ?",
      [username])
  }
  try {
    const result = await bcrypt.compare(req.body.currPassword, rows[0].password)
    if (result) {
      var password = await bcrypt.hash(req.body.password, 10)
      if (type === "employee") {
        await pool.query("UPDATE employee SET password = ? WHERE username = ?",
          [password, username])
      } else if (type === "customer") {
        await pool.query("UPDATE customer SET password = ? WHERE username = ?",
          [password, username])
      }
    }
    res.send({ status: "succss" })
  } catch (err) {
    return res.status(400).json(err);
  } finally {
    console.log("finally");
  }
})

function isNumeric(str) {
  if (typeof str != "string") return false // we only process strings!  
  return !isNaN(str) && // use type coercion to parse the _entirety_ of the string (`parseFloat` alone does not do this)...
         !isNaN(parseFloat(str)) // ...and ensure strings of whitespace fail
}

router.post("/employees", isLogged, isEmployee, async function (req, res, next) {
  const search = req.body.search
  var sql = "SELECT emp_id `Employee ID`, f_name `First name`, l_name `Last name`, gender, dob `Date of birth`, email `Email` FROM employee"
  try {
    if (search === "") {
      var [rows, field] = await pool.query(sql)
    } else if (isNumeric(search)) {
      var [rows, field] = await pool.query(sql + " WHERE emp_id = ?;",
        [search])
    } else {
      var [rows, field] = await pool.query(sql + " WHERE f_name LIKE ?;",
        `%${search}%`)
    }
    res.json(rows);
  } catch (err) {
    console.log(err)
    return res.status(400).json(err)
  }
})
router.get("/user/me", isLogged, async function (req, res, next) {
  res.json(req.user)
})

exports.router = router;
