const express = require("express");
const dotenv = require("dotenv");
dotenv.config({ path: "config/.env" });
const morgan = require("morgan");
const mongoose = require("mongoose");
const app = express();

const PORT = process.env.PORT||3000;
if(process.env.NODE_ENV === "development"){
    app.use(morgan("dev"));
    console.log(`Server is running on port ${PORT} in development mode`);
}
mongoose
  .connect(process.env.MONGODB_URI)
  .then(() => {
    
    console.log('MongoDB connected successfully');
  })
  .catch((error) => {
    console.error('MongoDB connection error:', error);
  });
app.get("/", (req, res) => {
    res.send("Hello World!");
});
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});