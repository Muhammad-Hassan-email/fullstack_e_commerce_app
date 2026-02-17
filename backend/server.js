import express, { json } from 'express';
import { config } from 'dotenv';
import cors from 'cors';
import connectDB from './config/db.js';
import User from './models/user.js';

config();

connectDB();

const app = express();

app.use(cors());
app.use(json());

app.get('/', (req, res) => {
    res.send("E-Commerce API Running...");
});

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
  
app.listen(PORT, () => {
    console.log(`🚀 Server running on port ${PORT}`);
});