import express from "express";
import User from "../models/user.js";
import { protect, admin } from "../middleware/auth_middleware.js";

const router = express.Router();

// GET all users - admin only
router.get("/", protect, admin, async (req, res) => {
  try {
    const users = await User.find().select("-password"); // exclude password
    res.json(users);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

export default router;