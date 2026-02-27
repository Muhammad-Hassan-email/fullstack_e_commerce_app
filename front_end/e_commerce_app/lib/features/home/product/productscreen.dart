import 'package:e_commerce_app/features/completeproductview/detailscreen.dart';
import 'package:e_commerce_app/features/home/product/dummyproduct.dart';
import 'package:e_commerce_app/features/home/product/productmodel.dart';
import 'package:e_commerce_app/features/home/product/producttype.dart';
import 'package:flutter/material.dart';

class ProductListingScreen extends StatefulWidget {
  final String title;
  final ProductType type;

  const ProductListingScreen({
    super.key,
    required this.title,
    required this.type,
  });

  @override
  State<ProductListingScreen> createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  List<ProductModel> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  void loadProducts() {
    switch (widget.type) {
      case ProductType.deal:
        products = ProductService.getDealProducts();
        break;

      case ProductType.trending:
        products = ProductService.getTrendingProducts();
        break;

      case ProductType.featured:
        products = ProductService.getFeaturedProducts();
        break;

      case ProductType.newArrival:
        products = ProductService.getNewArrivalProducts();
        break;
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : products.isEmpty
              ? const Center(child: Text("No Products Found"))
              : GridView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
  final product = products[index];

  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => DetailScreen(product: product),
        ),
      );
    },
    borderRadius: BorderRadius.circular(12),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Image.network(
                product.image,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "\$${product.price}",
                  style: const TextStyle(color: Colors.green),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
},
              ),
    );
  }
}
