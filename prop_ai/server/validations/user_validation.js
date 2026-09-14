const { z } = require('zod');

const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$/;

const registerSchema = z.object({
  name: z.string().trim().min(2).max(50),
  email: z.string().trim().toLowerCase().email(),
  password: z.string().regex(passwordRegex, "Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, and one number")
});

const loginSchema = z.object({
  email: z.string().trim().toLowerCase().email(),
  password: z.string()
});

module.exports = {
  registerSchema,
  loginSchema
};
