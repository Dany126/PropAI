const mongoose = require('mongoose');

const sellerProfileSchema = new mongoose.Schema(
  {
    averageRating: {
      type: Number,
      default: 0,
      min: 0,
      max: 5,
    },

    reviewsCount: {
      type: Number,
      default: 0,
      min: 0,
    },

    badReviewsCount: {
      type: Number,
      default: 0,
      min: 0,
    },

    isBlocked: {
      type: Boolean,
      default: false,
    },

    blockedReason: {
      type: String,
      enum: [
        'auto_low_rating',
        'admin_manual',
        null,
      ],
      default: null,
    },

    blockedAt: {
      type: Date,
      default: null,
    },

    blockedBy: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'User',
      default: null,
    },

    activeListingsCount: {
      type: Number,
      default: 0,
      min: 0,
    },
  },
  {
    _id: false,
  }
);

const userSchema = new mongoose.Schema(
  {
    name: {
      type: String,
      required: true,
      trim: true,
      minlength: 2,
      maxlength: 50,
    },

    email: {
      type: String,
      required: true,
      unique: true,
      lowercase: true,
      trim: true,
      index: true,
    },

    passwordHash: {
      type: String,
      required: true,
      select: false,
    },

    phone: {
      type: String,
      trim: true,
    },

    role: {
      type: String,
      enum: ['customer', 'seller', 'admin'],
      default: 'customer',
      index: true,
    },

    sellerProfile: {
      type: sellerProfileSchema,
      default: undefined,
    },

    isEmailVerified: {
      type: Boolean,
      default: false,
    },

    isActive: {
      type: Boolean,
      default: true,
      index: true,
    },

    preferences: {
      locations: {
        type: [String],
        default: [],
      },

      minPrice: {
        type: Number,
        min: 0,
      },

      maxPrice: {
        type: Number,
        min: 0,
      },

      bedrooms: {
        type: Number,
        min: 0,
      },
    },
  },
  {
    timestamps: true,
  }
);

userSchema.pre('validate', function (next) {
  if (this.role === 'seller' && !this.sellerProfile) {
    this.sellerProfile = {};
  }

  if (this.role !== 'seller') {
    this.sellerProfile = undefined;
  }

  next();
});

module.exports = mongoose.model('User', userSchema);