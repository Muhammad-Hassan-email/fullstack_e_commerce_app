import 'dart:convert';
import 'package:http/http.dart' as http;

class WishlistService {
  final String baseUrl = "http://10.0.2.2:3000/api/wishlist";
  final String userId; // In production, get from auth token/session

  WishlistService({required this.userId});

  Future<List<String>> getWishlist() async {
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {'userId': userId},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<String> wishlistIds =
          List<String>.from(data['wishlist'].map((p) => p['_id']));
      return wishlistIds;
    } else {
      throw Exception('Failed to load wishlist');
    }
  }

  Future<void> addToWishlist(String productId) async {
    final response = await http.post(
      Uri.parse("$baseUrl/add"),
      headers: {'Content-Type': 'application/json', 'userId': userId},
      body: jsonEncode({'productId': productId}),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to add to wishlist');
    }
  }

  Future<void> removeFromWishlist(String productId) async {
    final response = await http.post(
      Uri.parse("$baseUrl/remove"),
      headers: {'Content-Type': 'application/json', 'userId': userId},
      body: jsonEncode({'productId': productId}),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to remove from wishlist');
    }
  }
}