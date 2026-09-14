const { check } = require('express-validator');

const { validationMiddlleware } = require('../middleware/validation_middlleware');

const validateUserRegistration = () => {
  return [
    ...userRegistrationSchema,
    validationMiddlleware,
  ];
};

const validateUserLogin = () => {
  return [
    ...userLoginSchema,
    validationMiddlleware,
  ];
};

const userLoginSchema = [
  // =========================
  // Email
  // =========================
  check('email')
    .trim()
    .notEmpty()
    .withMessage('Email is required')
    .isEmail()
    .withMessage('Invalid email format')
    .normalizeEmail(),

  // =========================
  // Password
  // =========================
  check('password')
    .notEmpty()
    .withMessage('Password is required')
    .isLength({ min: 8 })
    .withMessage('Password must be at least 8 characters'),
];


const userRegistrationSchema = [
  // =========================
  // Name
  // =========================
  check('name')
    .trim()
    .notEmpty()
    .withMessage('Name is required')
    .isLength({ min: 2, max: 50 })
    .withMessage('Name must be between 2 and 50 characters'),

  // =========================
  // Email
  // =========================
  check('email')
    .trim()
    .notEmpty()
    .withMessage('Email is required')
    .isEmail()
    .withMessage('Invalid email format')
    .normalizeEmail(),

  // =========================
  // Password
  // =========================
  check('password')
    .notEmpty()
    .withMessage('Password is required')
    .isLength({ min: 8 })
    .withMessage('Password must be at least 8 characters')
    .matches(/[a-z]/)
    .withMessage(
      'Password must contain at least one lowercase letter',
    )
    .matches(/[A-Z]/)
    .withMessage(
      'Password must contain at least one uppercase letter',
    )
    .matches(/\d/)
    .withMessage(
      'Password must contain at least one number',
    ),

  // =========================
  // Confirm Password
  // =========================
  check('confirmPassword')
    .notEmpty()
    .withMessage('Confirm password is required')
    .custom((value, { req }) => {
      if (value !== req.body.password) {
        throw new Error('Passwords do not match');
      }

      return true;
    }),

  // =========================
  // Phone
  // =========================
  check('phone')
    .optional()
    .trim()
    .matches(/^\d{8,15}$/)
    .withMessage('Phone must be 8-15 digits'),

  // =========================
  // Role
  // =========================
  // IMPORTANT:
  // Do NOT allow role from public registration.
  //
  // If the client sends:
  // {
  //   "role": "admin"
  // }
  //
  // reject it.
  check('role')
    .not()
    .exists()
    .withMessage(
      'Role cannot be specified during registration',
    ),

  // =========================
  // Preferences
  // =========================
  check('preferences')
    .optional()
    .isObject()
    .withMessage('Preferences must be an object'),

  // =========================
  // Preferred Locations
  // =========================
  check('preferences.locations')
    .optional()
    .isArray()
    .withMessage('Locations must be an array'),

  check('preferences.locations.*')
    .optional()
    .isString()
    .withMessage('Each location must be a string')
    .trim(),

  // =========================
  // Minimum Price
  // =========================
  check('preferences.minPrice')
    .optional()
    .isNumeric()
    .withMessage('Min price must be a number')
    .custom((value) => {
      if (Number(value) < 0) {
        throw new Error('Min price cannot be negative');
      }

      return true;
    }),

  // =========================
  // Maximum Price
  // =========================
  check('preferences.maxPrice')
    .optional()
    .isNumeric()
    .withMessage('Max price must be a number')
    .custom((value, { req }) => {
      const maxPrice = Number(value);

      if (maxPrice < 0) {
        throw new Error('Max price cannot be negative');
      }

      const minPrice = req.body.preferences?.minPrice;

      if (
        minPrice !== undefined &&
        maxPrice < Number(minPrice)
      ) {
        throw new Error(
          'Max price must be greater than or equal to min price',
        );
      }

      return true;
    }),

  // =========================
  // Bedrooms
  // =========================
  check('preferences.bedrooms')
    .optional()
    .isNumeric()
    .withMessage('Bedrooms must be a number')
    .custom((value) => {
      if (Number(value) < 0) {
        throw new Error('Bedrooms cannot be negative');
      }

      return true;
    }),
];

module.exports = {
  validateUserRegistration,
  userRegistrationSchema,
};