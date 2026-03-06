// lib/features/cart/model/cartmodel.dart
import 'package:e_commerce_app/features/home/product/productmodel.dart';

class CartItem {
  final Product product;
  int quantity;
  String selectedSize;

  CartItem({
    required this.product,
    this.quantity = 1,
    this.selectedSize = 'Default',
  });

  double get totalPrice => product.price * quantity;
}