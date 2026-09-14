const asyncHandler = require('express-async-handler');
const ApiFeatures = require('../utils/api_features');
const ApiError = require('../utils/api_error');

const getOne = (Model, populateOption) => {
    return asyncHandler(async (req, res, next) => {
        let query = Model.findById(req.params.id);

        if (populateOption) {
            query = query.populate(populateOption);
        }

        const document = await query;

        if (!document) {
            return next(
                new ApiError(
                    `No document found with ID ${req.params.id}`,
                    404
                )
            );
        }

        res.status(200).json({
            status: 'success',
            data: document,
        });
    });
};

const getAll = (Model, populateOption) => {
    return asyncHandler(async (req, res, next) => {
        const countDoc = await Model.countDocuments();

        let query = Model.find();

        if (populateOption) {
            query = query.populate(populateOption);
        }

        const features = new ApiFeatures(query, req.query)
            .filter()
            .sort()
            .limitFields()
            .paginate(countDoc);

        const documents = await features.mongooseQuery;

        res.status(200).json({
            status: 'success',
            results: documents.length,
            pagination: features.paginationResult,
            data: documents,
        });
    });
};

const createOne = (Model) => {
    return asyncHandler(async (req, res) => {
        const document = await Model.create(req.body);

        res.status(201).json({
            status: 'success',
            data: document,
        });
    });
};

const updateOne = (Model) => {
    return asyncHandler(async (req, res, next) => {
        const document = await Model.findByIdAndUpdate(
            req.params.id,
            req.body,
            {
                new: true,
                runValidators: true,
            }
        );

        if (!document) {
            return next(
                new ApiError(
                    `No document found with ID ${req.params.id}`,
                    404
                )
            );
        }

        res.status(200).json({
            status: 'success',
            data: document,
        });
    });
};

const deleteOne = (Model) => {
    return asyncHandler(async (req, res, next) => {
        const document = await Model.findByIdAndDelete(req.params.id);

        if (!document) {
            return next(
                new ApiError(
                    `No document found with ID ${req.params.id}`,
                    404
                )
            );
        }

        res.status(204).json({
            status: 'success',
            data: null,
        });
    });
};

module.exports = {
    getOne,
    getAll,
    createOne,
    updateOne,
    deleteOne,
};