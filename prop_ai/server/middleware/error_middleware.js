const express = require("express");
const dotenv = require("dotenv");
dotenv.config({ path: "config/.env" });
const morgan = require("morgan");
const { connectDB } = require("./config/db");
const { ApiError } = require("./utils/api_error");
const { globalErrorHandler } = require("./middleware/error_middleware");
const app = express();

if(process.env.NODE_ENV === "development"){
    app.use(morgan("dev"));
}
connectDB();


app.all('',(req,res,next)=>{
  const error = new ApiError(`Can't find ${req.originalUrl} on this server!`,404);
  next(error);
})

app.use(globalErrorHandler );



app.listen(process.env.PORT || 3000, () => {
    console.log(`Server is running on port ${process.env.PORT} in ${process.env.NODE_ENV} mode`);
});