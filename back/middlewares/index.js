const jwt = require("jsonwebtoken")
const pool = require("../config");

async function logger(req, res, next) {
    const timeStamp = new Date().toString().substring(0, 19)
    console.log(`${timeStamp} | ${req.method}, ${req.originalUrl}`)
    next()
}

async function isLogged(req, res, next) {
    let authorization = req.headers.authorization

    jwt.verify(authorization, 'sakuraKey', async function (err, decoded) {
        if (decoded) {
            if (decoded.userType === "customer") {
                var [user] = await pool.query("SELECT username, cus_id, f_name, l_name, gender, dob, email, cus_address, cus_tel FROM customer WHERE username = ?",
                    [decoded.username])
            } else if (decoded.userType === "employee") {
                var [user] = await pool.query("SELECT username, f_name, l_name, gender, dob, email FROM employee WHERE username = ?",
                    [decoded.username])
            }
            req.user = user[0]
            next()
        } else {
            res.status(401).send("Please login first.")
        }
    });
}

async function isEmployee(req, res, next) {
    let authorization = req.headers.authorization

    jwt.verify(authorization, 'sakuraKey', function (err, decoded) {
        if (decoded.userType === "employee") {
            next()
        } else {
            res.status(403).send("You don't have permission to do this.")
        }
    });
}

module.exports = {
    logger,
    isLogged,
    isEmployee
}