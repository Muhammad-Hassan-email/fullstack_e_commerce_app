import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String category;
  final String productType;
  final String imageUrl;
  final int stock;
  final List<String> variations;  // ← add
  final double rating;            // ← add
  final String discount;          // ← add

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.productType,
    required this.imageUrl,
    required this.stock,
    required this.variations,
    required this.rating,
    required this.discount,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    // ✅ Print the json to see which field is null
    debugPrint('Parsing product: $json');
    return Product(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      category: json['category'],
      //productType: json['productType'],
      imageUrl: json['imageUrl'],
      stock: json['stock'],
      productType: json['productType']?.toString() ?? 'featured', // ✅ null safe
    variations: List<String>.from(json['variations'] ?? []),    // ✅ null safe
    rating: (json['rating'] as num?)?.toDouble() ?? 0.0,        // ✅ null safe
    discount: json['discount']?.toString() ?? '0%',             // ✅ null safe
    );
  }
}