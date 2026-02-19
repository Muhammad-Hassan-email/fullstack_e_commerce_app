import express from "express";
import {
  createOrder,
  getMyOrders,
  getAllOrders,
  updateOrderToDelivered,
} from "../controllers/order_controller.js";
import { protect, admin } from "../middleware/auth_middleware.js";

const router = express.Router();

router.post("/", protect, createOrder);
router.get("/myorders", protect, getMyOrders);
router.get("/", protect, admin, getAllOrders);
router.put("/:id/deliver", protect, admin, updateOrderToDelivered);

export default router;
