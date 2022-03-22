const express = require("express");
const pool = require("../config");
const Joi = require('joi')

const { isLogged, isEmployee } = require('../middlewares')

router = express.Router();

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

const supplierSchema = Joi.object({
    s_name: Joi.string().required(),
    s_tel: Joi.string().required(),
    s_email: Joi.string().required().email().external(emailValidator)
})

router.get("/supplier", async function (req, res, next) {
    try {
        const [rows, _] = await pool.query("SELECT s_id `value`, s_name `text` FROM supplier")
        res.json(rows)
    } catch (err) {
        return res.status(500).json(err)
    }
})

router.post("/supplier/add", isLogged, isEmployee, async function (req, res, next) {

    try {
        await supplierSchema.validateAsync(req.body, { abortEarly: false })
    } catch (err) {
        console.log(err)
    }
    const s_name = req.body.s_name
    const s_tel = req.body.s_tel
    const s_email = req.body.s_email

    try {
        const [rows, fields1] = await pool.query("SELECT s_email FROM supplier WHERE s_name = ?", [s_name])
        if (rows[0]) {
            res.json({
                error: true,
                errMsg: "This supplier name or email is already exist"
            })
        }
        else {
            await pool.query("INSERT INTO `supplier` (`s_name`, `s_tel`, `s_email`) VALUES(?, ?, ?);",
                [s_name, s_tel, s_email])
            res.json("success")
        }

    } catch (err) {
        console.log(err)
        return res.status(400).json(err);
    } finally {
        console.log("finally");
    }

})


exports.router = router;
