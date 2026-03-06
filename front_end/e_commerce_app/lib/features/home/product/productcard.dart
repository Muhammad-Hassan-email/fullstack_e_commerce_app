import 'package:e_commerce_app/features/home/product/productmodel.dart';
import 'package:e_commerce_app/features/wishlist/wishlistprovider/wishlistprovider.dart';
import 'package:e_commerce_app/routes/routernames.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final isFavorite = wishlistProvider.isInWishlist(product);
    

    return GestureDetector(
      onTap: () {
        context.push(
          RouteNames.detailscreen,
          extra: product, // ✅ pass the full Product object
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 1),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 4,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(product.imageUrl, width: 80, height: 80, fit: BoxFit.cover,),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Favorite
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          wishlistProvider.toggleWishlist(product);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text('Variation: ${product.variations.join(', ')}'),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 2),
                      Text(product.rating.toString()),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Flexible(
                        child: Text('\$${product.price.toStringAsFixed(2)}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                      ),
                      const SizedBox(width: 8),
                      Text('upto ${product.discount} off',
                          style: const TextStyle(color: Colors.red, fontSize: 12)),
                      // const SizedBox(width: 8,),
                      // PrimaryButton(text: 'Add To Card', onPressed: (){}),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}