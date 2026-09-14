const express = require("express");
const dotenv = require("dotenv");
dotenv.config({ path: "config/.env" });
const morgan = require("morgan");
const { connectDB } = require("./config/db");
const app = express();

if(process.env.NODE_ENV === "development"){
    app.use(morgan("dev"));
}
connectDB();

app.get("/", (req, res) => {
    res.send("Hello World!");
});
app.listen(process.env.PORT || 3000, () => {
    console.log(`Server is running on port ${process.env.PORT} in ${process.env.NODE_ENV} mode`);
});