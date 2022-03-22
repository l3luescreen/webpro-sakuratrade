const express = require("express");
const path = require("path");
const pool = require("../config");
const fs = require("fs");
const Joi = require('joi')

const { isLogged } = require('../middlewares')

router = express.Router();

router.use(express.json());
router.use(express.urlencoded({ extended: true })) // for parsing application/x-www-form-urlencoded

router.post("/purchase/comfirm", isLogged, async function (req, res, next) {
    var paymentData = req.body
    const conn = await pool.getConnection();
    await conn.beginTransaction();
    try {
        const [rows, _] = await conn.query("SELECT max(order_order_id) from order_item")
        var type = paymentData.payment.type
        type = type.replace("bank", "โอนธนาคาร").replace("credit", "บัตรเครดิต")

        const addOrder = await conn.query("INSERT INTO orders(order_datetime, order_status, payment_type, total_price, customer_cus_id)" + 
        "VALUES(CURRENT_TIMESTAMP, 'กำลังจัดส่ง', ?, ?, ?)", [type, paymentData.totalPrice, paymentData.user_id])

        const order_id = addOrder[0].insertId
        
        for (var i = 0; i < paymentData.cart.length; i++) {
            const id = paymentData.cart[i].p_id
            const total = paymentData.cart[i].price
            const quantity = paymentData.cart[i].amount

            const addOrderItem = await conn.query("INSERT INTO order_item(order_order_id, no, unit_price, quantity, total_price, product_p_id)" + 
            "VALUES(?, ?, ?, ?, ?, ?);",[order_id, i+1, (total / quantity), quantity, total, id])

            const decreaseQuantity = await conn.query("UPDATE product Set quantity = quantity - ? WHERE p_id = ?;", 
            [quantity, id])
        }


        conn.commit()
        res.json(paymentData)
    } catch (err) {
        await conn.rollback();
        console.log(err)
        return res.status(400).json(err.message);
    } finally {
        conn.release();
    }


})

exports.router = router;
