import { Router } from 'express';
const router = Router();

// Middleware to simulate authenticated user
// In production, use JWT or session authentication
const authMiddleware = async (req, res, next) => {
  const userId = req.header('userId'); // client sends userId in header
  if (!userId) return res.status(401).json({ message: 'Unauthorized' });
  req.user = await findById(userId);
  if (!req.user) return res.status(404).json({ message: 'User not found' });
  next();
};

// Add product to wishlist
router.post('/add', authMiddleware, async (req, res) => {
  const { productId } = req.body;
  if (!productId) return res.status(400).json({ message: 'Product ID is required' });

  if (!req.user.wishlist.includes(productId)) {
    req.user.wishlist.push(productId);
    await req.user.save();
  }

  res.json({ message: 'Product added to wishlist', wishlist: req.user.wishlist });
});

// Remove product from wishlist
router.post('/remove', authMiddleware, async (req, res) => {
  const { productId } = req.body;
  if (!productId) return res.status(400).json({ message: 'Product ID is required' });

  req.user.wishlist = req.user.wishlist.filter(id => id.toString() !== productId);
  await req.user.save();

  res.json({ message: 'Product removed from wishlist', wishlist: req.user.wishlist });
});

// Get user wishlist
router.get('/', authMiddleware, async (req, res) => {
  await req.user.populate('wishlist'); // populate product details
  res.json({ wishlist: req.user.wishlist });
});

export default router;