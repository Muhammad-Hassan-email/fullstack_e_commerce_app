// lib/features/cart/provider/cartprovider.dart
import 'package:e_commerce_app/features/cart/cartmodel.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/features/home/product/productmodel.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];
  String _appliedCoupon = '';
  double _discountAmount = 0;

  // ✅ Available coupons
  static const Map<String, double> _coupons = {
    'SAVE10': 0.10,  // 10% off
    'SAVE20': 0.20,  // 20% off
    'FLAT50': 50.0,  // flat $50 off
  };

  List<CartItem> get items => _items;
  String get appliedCoupon => _appliedCoupon;
  double get discountAmount => _discountAmount;
  bool get isEmpty => _items.isEmpty;

  // ✅ Total before discount
  double get subtotal =>
      _items.fold(0, (sum, item) => sum + item.totalPrice);

  // ✅ Delivery fee logic
  double get deliveryFee => subtotal > 500 ? 0 : 49;

  // ✅ Final total
  double get total => subtotal - _discountAmount + deliveryFee;

  // ✅ Item count badge
  int get itemCount =>
      _items.fold(0, (sum, item) => sum + item.quantity);

  bool isInCart(Product product) =>
      _items.any((item) => item.product.id == product.id);

  // ✅ Add to cart
  void addToCart(Product product, {String size = 'Default'}) {
    final index =
        _items.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      _items[index].quantity++;
    } else {
      _items.add(CartItem(product: product, selectedSize: size));
    }
    notifyListeners();
  }

  // ✅ Remove from cart
  void removeFromCart(Product product) {
    _items.removeWhere((item) => item.product.id == product.id);
    _recalculateDiscount();
    notifyListeners();
  }

  // ✅ Update quantity
  void updateQuantity(Product product, int quantity) {
    final index =
        _items.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      if (quantity <= 0) {
        _items.removeAt(index);
      } else {
        _items[index].quantity = quantity;
      }
      _recalculateDiscount();
      notifyListeners();
    }
  }

  // ✅ Update size
  void updateSize(Product product, String size) {
    final index =
        _items.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      _items[index].selectedSize = size;
      notifyListeners();
    }
  }

  // ✅ Apply coupon
  String applyCoupon(String code) {
    final upper = code.trim().toUpperCase();
    if (_coupons.containsKey(upper)) {
      _appliedCoupon = upper;
      _recalculateDiscount();
      notifyListeners();
      return 'Coupon applied successfully!';
    }
    return 'Invalid coupon code';
  }

  // ✅ Remove coupon
  void removeCoupon() {
    _appliedCoupon = '';
    _discountAmount = 0;
    notifyListeners();
  }

  void _recalculateDiscount() {
    if (_appliedCoupon.isEmpty) return;
    final value = _coupons[_appliedCoupon] ?? 0;
    if (value < 1) {
      _discountAmount = subtotal * value; // percentage
    } else {
      _discountAmount = value; // flat amount
    }
  }

  // ✅ Clear cart
  void clearCart() {
    _items.clear();
    _appliedCoupon = '';
    _discountAmount = 0;
    notifyListeners();
  }
}