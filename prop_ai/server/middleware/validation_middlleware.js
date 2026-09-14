const { validationResult } = require('express-validator');

const validationMiddlleware = (req,res,next) => {
    const errors = validationResult(req);
    if(!errors.isEmpty()){
        const error = new ApiError(errors.array(),400);
        next(error);
    }
    next();
}

exports.validate = validate;