import 'package:e_commerce_app/services/wishlistservice.dart';
import 'package:flutter/material.dart';

class ProductItemWidget extends StatefulWidget {
  final String productId;
  final String productName;
  final String imageUrl;
  final WishlistService wishlistService;

  const ProductItemWidget({
    super.key,
    required this.productId,
    required this.productName,
    required this.imageUrl,
    required this.wishlistService,
  });

  @override
  State<ProductItemWidget> createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends State<ProductItemWidget> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkIfFavorite();
  }

  void _checkIfFavorite() async {
    final wishlist = await widget.wishlistService.getWishlist();
    setState(() {
      isFavorite = wishlist.contains(widget.productId);
    });
  }

  void _toggleWishlist() async {
    setState(() {
      isFavorite = !isFavorite;
    });

    try {
      if (isFavorite) {
        await widget.wishlistService.addToWishlist(widget.productId);
      } else {
        await widget.wishlistService.removeFromWishlist(widget.productId);
      }
    } catch (e) {
      // Revert UI if API fails
      setState(() {
        isFavorite = !isFavorite;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error updating wishlist')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(widget.imageUrl, width: 50, height: 50),
      title: Text(widget.productName),
      trailing: IconButton(
        onPressed: _toggleWishlist,
        icon: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: isFavorite ? Colors.red : Colors.black,
        ),
      ),
    );
  }
}