import express, { json } from 'express';
import { config } from 'dotenv';
import cors from 'cors';
import connectDB from './config/db.js';
//User and product models import below
import User from './models/user.js';
import Product from './models/product.js';

import auth_routes from "./routes/auth_routes.js";
import product_routes from "./routes/product_routes.js";
import user_routes from "./routes/users_routes.js";
import orderRoutes from "./routes/order_routes.js";


config();

connectDB();

const app = express();

app.use(cors());
app.use(json());
app.use("/api/users", user_routes); // use the same variable
app.use("/api/orders", orderRoutes);

app.get('/', (req, res) => {
    res.send("E-Commerce API Running...");
});

app.use("/api/auth", auth_routes);
app.use("/api/products", product_routes);



const PORT = process.env.PORT || 5000;
app.get('/create-user', async (req, res) => {
    try {
      const user = await User.create({
        name: "Test User",
        email: "test@example.com",
        password: "123456"
      });
  
      res.json(user);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  });

app.get('/create-product', async (req, res) => {
  try {
    const product = await Product.create({
      name: "Test Coffee Mug",
      description: "A ceramic coffee mug",
      price: 12.99,
      category: "Mugs",
      imageUrl: "https://example.com/mug.jpg",
      stock: 50
    });

    res.json(product);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

  
app.listen(PORT, () => {
    console.log(`🚀 Server running on port ${PORT}`);
});