import User from "../models/user.js";
import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";


// Register user
export const registerUser = async (req, res) => {
  const { f_name, l_name, phone, address, city, state, country, email, password } = req.body;
  try {
    const userExists = await User.findOne({ email });
    if (userExists) return res.status(400).json({ message: "User already exists" });

    const hashedPassword = await bcrypt.hash(password, 10);

    const user = await User.create({
      f_name,
      l_name,
      phone,
      address,
      city,
      state,
      country,
      email: email,
      password: hashedPassword,
      role: "user",
    });  

    res.status(201).json({
      _id: user._id,
      f_name: user.f_name,
      l_name: user.l_name,
      phone: user.phone,
      address: user.address,
      city: user.city,
      state: user.state,
      country: user.country,
      email: user.email,
      role: user.role,
    });    
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Login user
export const loginUser = async (req, res) => {
  const { email, password } = req.body;
  try {
    const user = await User.findOne({ email });
    if (!user) return res.status(400).json({ message: "Invalid email or password" });

    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) return res.status(400).json({ message: "Invalid email or password" });

    const token = jwt.sign({ id: user._id, role: user.role }, process.env.JWT_SECRET, {
      expiresIn: "1d",
    });

    res.json({ token, user });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};