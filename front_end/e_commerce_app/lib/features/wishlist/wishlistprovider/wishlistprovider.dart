import 'package:e_commerce_app/features/home/product/productmodel.dart';
import 'package:flutter/material.dart';
import '../../../services/wishlistservice.dart';

class WishlistProvider extends ChangeNotifier {
  final WishlistService wishlistService;
  List<Product> _wishlist = []; // ✅ unified type

  WishlistProvider({required this.wishlistService}) {
    fetchWishlist();
  }

  List<Product> get wishlist => _wishlist;

  Future<void> fetchWishlist() async {
    try {
      final wishlistIds = await wishlistService.getWishlist();
      _wishlist = wishlistIds.map((id) => Product(
        id: id,
        name: 'Product $id',
        imageUrl: 'assets/banner_1.jpg',
        variations: ['Default'],
        rating: 4.0,
        price: 20.0,
        discount: '10%',
        category: '',
        stock: 0, 
        description: '',
        productType: '',
      )).toList();
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching wishlist: $e');
    }
  }

  // ✅ All methods now use Product consistently
  bool isInWishlist(Product product) {
    return _wishlist.any((p) => p.id == product.id); // ✅ id not name
  }

  Future<void> addToWishlist(Product product) async {
    try {
      _wishlist.add(product); // ✅ fixed syntax
      notifyListeners();
      await wishlistService.addToWishlist(product.id); // ✅ id not name
    } catch (e) {
      _wishlist.remove(product);
      notifyListeners();
    }
  }

  Future<void> removeFromWishlist(Product product) async { // ✅ Product not ProductItem
    try {
      _wishlist.removeWhere((p) => p.id == product.id); // ✅ id not name
      notifyListeners();
      await wishlistService.removeFromWishlist(product.id); // ✅ id not name
    } catch (e) {
      _wishlist.add(product);
      notifyListeners();
    }
  }

  Future<void> toggleWishlist(Product product) async { // ✅ Product not ProductItem
    if (isInWishlist(product)) {
      await removeFromWishlist(product);
    } else {
      await addToWishlist(product);
    }
  }
}