const { z } = require('zod');

const createPropertySchema = z.object({
  title: z.string().trim().min(10).max(120),
  description: z.string().trim().min(30).max(3000),
  purpose: z.enum(['sale', 'rent']),
  propertyType: z.enum([
    'apartment',
    'villa',
    'townhouse',
    'penthouse',
    'studio',
    'duplex',
    'office',
    'shop',
    'land',
  ]),
  price: z.number().positive(),
  currency: String,
  bedrooms: z.number().int().min(0).max(50),
  bathrooms: z.number().min(0).max(50),
  areaSqFt: z.number().positive(),
  location: {
  country: String,
  countryCode: String,
  state: String,
  city: String,
  district: String,
  address: String,

  coordinates: {
    type: {
      type: String,
      enum: ["Point"],
      default: "Point"
    },
    coordinates: {
      type: [Number],
      index: "2dsphere"
    }
  }
  },
  amenities: z.array(z.string()).default([]),
  features: z.object({
    furnished: z.boolean().default(false),
    parkingSpaces: z.number().min(0).default(0),
    balcony: z.boolean().default(false),
    swimmingPool: z.boolean().default(false),
    gym: z.boolean().default(false),
    seaView: z.boolean().default(false),
    garden: z.boolean().default(false),
    smartHome: z.boolean().default(false),
  }).default({}),
  images: z.array(z.string().url()).min(1).max(20),
});

module.exports = {
  createPropertySchema,
};
