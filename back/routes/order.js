const express = require("express");
const pool = require("../config");

const { isLogged, isEmployee } = require('../middlewares')

router = express.Router();
router.use(express.urlencoded({ extended: true })) // for parsing application/x-www-form-urlencoded
router.use(express.json());


router.post("/order", isLogged, async function (req, res, next) {
    try {
        const [rows, field] = await pool.query("SELECT order_datetime, order_status, payment_type, total_price FROM orders WHERE customer_cus_id = ?;",
            [req.body.cus_id])
        res.json(rows);
    } catch (err) {
        console.log(err)
        return res.status(400).json(err)
    }
})

function isNumeric(str) {
    if (typeof str != "string") return false // we only process strings!  
    return !isNaN(str) && // use type coercion to parse the _entirety_ of the string (`parseFloat` alone does not do this)...
        !isNaN(parseFloat(str)) // ...and ensure strings of whitespace fail
}

router.post("/orderAll", isLogged, isEmployee, async function (req, res, next) {
    const search = req.body.search
    var sql = "SELECT f_name, order_datetime, order_status, payment_type, total_price FROM orders o JOIN customer c ON (c.cus_id = o.customer_cus_id)"
    try {
        if (search === "") {
            var [rows, field] = await pool.query(sql)
        } else if (isNumeric(search)) {
            var [rows, field] = await pool.query(sql + "WHERE customer_cus_id = ?;",
                [search])
        } else {
            var [rows, field] = await pool.query(sql + "WHERE f_name LIKE ?;",
                `%${search}%`)
        }
        rows.forEach((order) => {
            order.order_status = order.order_status.replace("จัดส่งสำเร็จ", "Complete").replace("จัดส่งไม่สำเร็จ", "Incomplete").replace("กำลังจัดส่ง", "Delivering")
            order.payment_type = order.payment_type.replace("โอนธนาคาร", "Bank").replace("บัตรเครดิต", "Credit Cards")
        })
            res.json(rows);
        } catch (err) {
            console.log(err)
            return res.status(400).json(err)
        }
    })


exports.router = router;