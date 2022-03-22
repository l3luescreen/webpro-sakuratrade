const express = require("express")
var cors = require('cors')
const path = require("path")

const app = express();
app.use(cors())
// Statics
app.use(express.static('static'))

const { logger } = require('./middlewares')

app.use(logger);

app.use(express.json()) // for parsing application/json
app.use(express.urlencoded({ extended: true })) // for parsing application/x-www-form-urlencoded

// routers
const userRouter = require('./routes/user')
const productRouter = require('./routes/product')
const purchaseRouter = require('./routes/purchase')
const supplierRouter = require('./routes/supplier')
const orderRouter = require('./routes/order')



app.use(userRouter.router)
app.use(productRouter.router)
app.use(purchaseRouter.router)
app.use(supplierRouter.router)
app.use(orderRouter.router)




app.listen(3000, () => {
  console.log(`app listening at http://localhost:3000`)
})