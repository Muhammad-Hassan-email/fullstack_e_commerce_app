import 'package:flutter/material.dart';
import 'package:e_commerce_app/features/home/product/productmodel.dart';
import 'package:e_commerce_app/features/home/product/productapi.dart';

enum SortOption { none, priceLowHigh, priceHighLow, rating, newest }

class ProductProvider extends ChangeNotifier {
  List<Product> _products = [];
  bool _loading = false;

  // ✅ Sort & Filter state
  SortOption _sortOption = SortOption.none;
  String _selectedCategory = '';
  String _selectedProductType = '';
  double _minPrice = 0;
  double _maxPrice = double.infinity;
  double _minRating = 0;

  List<Product> get products => _products;
  bool get loading => _loading;
  SortOption get sortOption => _sortOption;
  String get selectedCategory => _selectedCategory;
  String get selectedProductType => _selectedProductType;
  double get minPrice => _minPrice;
  double get maxPrice => _maxPrice;
  double get minRating => _minRating;

  // ✅ Get unique categories from products
  List<String> get availableCategories {
    return _products.map((p) => p.category).toSet().toList();
  }

  // ✅ Get unique product types
  List<String> get availableProductTypes {
    return _products.map((p) => p.productType).toSet().toList();
  }

  // ✅ Get max price for slider
  double get maxAvailablePrice {
    if (_products.isEmpty) return 1000;
    return _products.map((p) => p.price).reduce((a, b) => a > b ? a : b);
  }

  // ✅ Core filter + sort method
  List<Product> getProductsByType(String type) {
    List<Product> filtered = type == 'all'
        ? List.from(_products)
        : _products
            .where((p) => p.productType.toLowerCase() == type.toLowerCase())
            .toList();

    // Apply filters
    if (_selectedCategory.isNotEmpty) {
      filtered = filtered
          .where((p) => p.category == _selectedCategory)
          .toList();
    }

    if (_selectedProductType.isNotEmpty) {
      filtered = filtered
          .where((p) => p.productType == _selectedProductType)
          .toList();
    }

    filtered = filtered
        .where((p) => p.price >= _minPrice &&
            p.price <= (_maxPrice == double.infinity ? maxAvailablePrice : _maxPrice))
        .toList();

    filtered = filtered.where((p) => p.rating >= _minRating).toList();

    // Apply sort
    switch (_sortOption) {
      case SortOption.priceLowHigh:
        filtered.sort((a, b) => a.price.compareTo(b.price));
        break;
      case SortOption.priceHighLow:
        filtered.sort((a, b) => b.price.compareTo(a.price));
        break;
      case SortOption.rating:
        filtered.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case SortOption.newest:
        filtered = filtered.reversed.toList();
        break;
      case SortOption.none:
        break;
    }

    return filtered;
  }

  // ✅ Setters
  void setSortOption(SortOption option) {
    _sortOption = option;
    notifyListeners();
  }

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setProductType(String type) {
    _selectedProductType = type;
    notifyListeners();
  }

  void setPriceRange(double min, double max) {
    _minPrice = min;
    _maxPrice = max;
    notifyListeners();
  }

  void setMinRating(double rating) {
    _minRating = rating;
    notifyListeners();
  }

  void resetFilters() {
    _sortOption = SortOption.none;
    _selectedCategory = '';
    _selectedProductType = '';
    _minPrice = 0;
    _maxPrice = double.infinity;
    _minRating = 0;
    notifyListeners();
  }

  Future<void> fetchProducts() async {
    _loading = true;
    notifyListeners();
    try {
      _products = await ApiService.fetchProducts();
    } catch (e) {
      debugPrint("Error fetching products: $e");
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}