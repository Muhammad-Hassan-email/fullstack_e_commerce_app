import { Schema, model } from 'mongoose';

const userSchema = new Schema(
  {
    f_name: {
      type: String,
      required: true,
      trim: true
    },
    l_name: {
      type: String,
      required: true,
      trim: true
    },
    phone: {
      type: String,
      required: true,
      trim: true
    },
    address: {
      type: String,
      required: true,
      trim: true
    },
    city: {
      type: String,
      required: true,
      trim: true
    },
    state: {
      type: String,
      required: true,
      trim: true
    },
    country: {
      type: String,
      required: true,
      trim: true
    },
    email: {
      type: String,
      required: true,
      unique: true
    },
    password: {
      type: String,
      required: true
    },
    role: {
      type: String,
      enum: ['user', 'admin'],
      default: 'user',
      isAdmin: { 
        type: Boolean, 
        default: false, 
      }
    }
  },
  {
    timestamps: true
  }
);

export default model('User', userSchema);