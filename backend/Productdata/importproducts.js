import mongoose from 'mongoose';
import XLSX from 'xlsx';
import dotenv from 'dotenv';
import Product from '../models/product.js'; // adjust path if needed

dotenv.config({ path: '../.env' });

const DB = process.env.MONGO_URI || 'mongodb://127.0.0.1:27017/muhammadhassanullahhk_db_user';

mongoose.connect(DB)
  .then(() => console.log("MongoDB connected ✅"))
  .catch(err => console.log("MongoDB connection error:", err));

const workbook = XLSX.readFile('dummy_products_100.xlsx');
const sheet = workbook.Sheets['Products'];
const data = XLSX.utils.sheet_to_json(sheet);

async function importData() {
  try {
    await Product.deleteMany(); // Optional: Remove old products

    const formattedData = data.map(item => ({
      name: item.ProductName,
      description: item.Description,
      price: item.Price,
      category: item.Category,
      imageUrl: item.ImageURL,
      stock: item.StockQuantity,
    }));

    await Product.insertMany(formattedData);
    console.log("✅ 100 Dummy Products Imported Successfully");
    mongoose.connection.close();
  } catch (err) {
    console.error(err);
  }
}

importData();