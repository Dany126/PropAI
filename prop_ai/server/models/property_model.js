const mongoose = require('mongoose');

const propertySchema = new mongoose.Schema(
  {
    ownerId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'User',
      required: true,
      index: true,
    },

    title: {
      type: String,
      required: true,
      trim: true,
      minlength: 10,
      maxlength: 120,
    },

    description: {
      type: String,
      required: true,
      trim: true,
      minlength: 30,
      maxlength: 3000,
    },

    purpose: {
      type: String,
      enum: ['sale', 'rent'],
      required: true,
      index: true,
    },

    propertyType: {
      type: String,
      enum: [
        'apartment',
        'villa',
        'townhouse',
        'penthouse',
        'studio',
        'duplex',
        'office',
        'shop',
        'land',
      ],
      required: true,
      index: true,
    },

    price: {
      type: Number,
      required: true,
      min: 0,
      index: true,
    },

    currency: {
      type: String,
      enum: ['AED'],
      default: 'AED',
    },

    bedrooms: {
      type: Number,
      required: true,
      min: 0,
      max: 50,
      index: true,
    },

    bathrooms: {
      type: Number,
      required: true,
      min: 0,
      max: 50,
    },

    areaSqFt: {
      type: Number,
      required: true,
      min: 1,
    },

    location: {
      country: {
        type: String,
        required: true,
        trim: true,
        default: 'UAE',
      },

      emirate: {
        type: String,
        required: true,
        trim: true,
        index: true,
      },

      city: {
        type: String,
        required: true,
        trim: true,
        index: true,
      },

      community: {
        type: String,
        required: true,
        trim: true,
        index: true,
      },

      address: {
        type: String,
        trim: true,
        maxlength: 300,
      },

      coordinates: {
        type: {
          type: String,
          enum: ['Point'],
          default: 'Point',
        },

        coordinates: {
          type: [Number],
          validate: {
            validator: function (value) {
              return (
                Array.isArray(value) &&
                value.length === 2 &&
                value[0] >= -180 &&
                value[0] <= 180 &&
                value[1] >= -90 &&
                value[1] <= 90
              );
            },
            message: 'Coordinates must be [longitude, latitude]',
          },
        },
      },
    },

    amenities: {
      type: [String],
      default: [],
    },

    features: {
      furnished: {
        type: Boolean,
        default: false,
      },

      parkingSpaces: {
        type: Number,
        default: 0,
        min: 0,
      },

      balcony: {
        type: Boolean,
        default: false,
      },

      swimmingPool: {
        type: Boolean,
        default: false,
      },

      gym: {
        type: Boolean,
        default: false,
      },

      seaView: {
        type: Boolean,
        default: false,
      },

      garden: {
        type: Boolean,
        default: false,
      },

      smartHome: {
        type: Boolean,
        default: false,
      },
    },

    images: {
      type: [String],
      required: true,
      validate: {
        validator: function (value) {
          return value.length >= 1 && value.length <= 20;
        },
        message: 'Property must contain between 1 and 20 images',
      },
    },

    status: {
      type: String,
      enum: [
        'draft',
        'published',
        'sold',
        'rented',
        'unpublished',
        'removed',
      ],
      default: 'draft',
      index: true,
    },

    embedding: {
      type: [Number],
      default: undefined,
      select: false,
    },

    embeddingText: {
      type: String,
      default: undefined,
      select: false,
    },
  },
  {
    timestamps: true,
  }
);

propertySchema.index({
  'location.coordinates': '2dsphere',
});

propertySchema.index({
  ownerId: 1,
  status: 1,
});

propertySchema.index({
  purpose: 1,
  propertyType: 1,
  price: 1,
});

module.exports = mongoose.model('Property', propertySchema);
