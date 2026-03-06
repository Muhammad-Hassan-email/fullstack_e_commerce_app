import mongoose from 'mongoose';

// Define product schema
const productSchema = new mongoose.Schema(
  {
    name: {
      type: String,
      required: true,
    },
    description: {
      type: String,
    },
    price: {
      type: Number,
      required: true,
    },
    category: {
      type: String,
    },
    imageUrl: {
      type: String, // Link to product image
    },
    variations: {type: String},   // ← add
    rating: {type: Number},         // ← add
    discount: {type: String},
    stock: {
      type: Number,
      default: 0,
    },
  },
  {
    timestamps: true, // Automatically adds createdAt and updatedAt
  }
);

// Export Product model
const Product = mongoose.models.Product || mongoose.model('Product', productSchema);
export default Product;