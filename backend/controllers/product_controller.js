import Product from "../models/product.js";

// Add product (for admin)
export const addProduct = async (req, res) => {
  const { name, description, price, category, imageUrl, stock } = req.body;

  if (req.user.role !== "admin") {
    return res.status(403).json({ message: "Access denied. Admin only." });
  }

  try {
    const product = await Product.create({ name, description, price, category, imageUrl, stock });
    res.status(201).json(product);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Get all products
export const getProducts = async (req, res) => {
  try {
    const products = await Product.find();
    res.json(products);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};