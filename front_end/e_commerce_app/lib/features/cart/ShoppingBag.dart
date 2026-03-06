// lib/features/cart/shoppingbagpage.dart
import 'package:e_commerce_app/features/cart/cartmodel.dart';
import 'package:e_commerce_app/features/cart/provider/cartprovider.dart';
import 'package:e_commerce_app/features/checkout/paymentscreen.dart';
import 'package:e_commerce_app/routes/routernames.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ShoppingBagPage extends StatefulWidget {
  const ShoppingBagPage({super.key});

  @override
  State<ShoppingBagPage> createState() => _ShoppingBagPageState();
}

class _ShoppingBagPageState extends State<ShoppingBagPage> {
  final TextEditingController _couponController = TextEditingController();

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  void _showCouponSheet(BuildContext context, CartProvider cart) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20, right: 20, top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Apply Coupon',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              // ✅ Available coupons hint
              const Text(
                'Available: SAVE10, SAVE20, FLAT50',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _couponController,
                      decoration: InputDecoration(
                        hintText: 'Enter coupon code',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      textCapitalization: TextCapitalization.characters,
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF3F6C),
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      final message =
                          cart.applyCoupon(_couponController.text);
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(message)),
                      );
                      _couponController.clear();
                    },
                    child: const Text(
                      'Apply',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_ios, color: Colors.black),
        title: Text(
          'Shopping Bag (${cart.itemCount})', // ✅ dynamic count
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: cart.isEmpty
          ? _buildEmptyCart()
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ✅ Dynamic product list
                  ...cart.items.map((item) => _buildCartItem(context, item, cart)),

                  const Divider(height: 40),

                  // ✅ Coupon Section
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.confirmation_number_outlined),
                    title: Text(
                      cart.appliedCoupon.isEmpty
                          ? 'Apply Coupons'
                          : 'Coupon: ${cart.appliedCoupon}',
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    trailing: cart.appliedCoupon.isEmpty
                        ? TextButton(
                            onPressed: () => _showCouponSheet(context, cart),
                            child: const Text('Select',
                                style:
                                    TextStyle(color: Colors.pinkAccent)),
                          )
                        : TextButton(
                            onPressed: () => cart.removeCoupon(),
                            child: const Text('Remove',
                                style: TextStyle(color: Colors.red)),
                          ),
                  ),
                  const Divider(height: 40),

                  // ✅ Payment Details
                  const Text(
                    'Order Payment Details',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  _buildPriceRow('Order Amount',
                      '\$${cart.subtotal.toStringAsFixed(2)}'),
                  if (cart.discountAmount > 0)
                    _buildPriceRow(
                      'Discount (${cart.appliedCoupon})',
                      '-\$${cart.discountAmount.toStringAsFixed(2)}',
                      isDiscount: true,
                    ),
                  _buildPriceRow(
                    'Delivery Fee',
                    cart.deliveryFee == 0
                        ? 'Free'
                        : '\$${cart.deliveryFee.toStringAsFixed(2)}',
                    isFree: cart.deliveryFee == 0,
                  ),
                  const Divider(height: 40),
                  _buildPriceRow(
                    'Order Total',
                    '\$${cart.total.toStringAsFixed(2)}',
                    isTotal: true,
                  ),
                ],
              ),
            ),
      bottomNavigationBar: cart.isEmpty ? null : _buildBottomCheckout(cart),
    );
  }

  // ✅ Dynamic cart item
  Widget _buildCartItem(
      BuildContext context, CartItem item, CartProvider cart) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              item.product.imageUrl,
              width: 100,
              height: 130,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.image_not_supported, size: 60),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ✅ Product name
                Text(
                  item.product.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  item.product.category,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 10),

                // ✅ Size & Quantity dropdowns
                Row(
                  children: [
                    // Size dropdown
                    if (item.product.variations.isNotEmpty)
                      _buildDropdown(
                        'Size',
                        item.selectedSize,
                        item.product.variations,
                        (val) => cart.updateSize(item.product, val!),
                      ),
                    const SizedBox(width: 10),
                    // Quantity dropdown
                    _buildDropdown(
                      'Qty',
                      item.quantity.toString(),
                      List.generate(10, (i) => '${i + 1}'),
                      (val) => cart.updateQuantity(
                          item.product, int.parse(val!)),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // ✅ Price
                Text(
                  '\$${item.totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),

                // ✅ Remove button
                GestureDetector(
                  onTap: () => cart.removeFromCart(item.product),
                  child: const Text(
                    'Remove',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(String label, String value, List<String> options,
      ValueChanged<String?> onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButton<String>(
        value: options.contains(value) ? value : options.first,
        underline: const SizedBox(),
        isDense: true,
        items: options
            .map((o) => DropdownMenuItem(value: o, child: Text(o)))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildPriceRow(String label, String value,
      {bool isFree = false,
      bool isTotal = false,
      bool isDiscount = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 18 : 14,
              fontWeight:
                  isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: isTotal ? 18 : 14,
              color: isDiscount
                  ? Colors.green
                  : isFree
                      ? Colors.green
                      : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyCart() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_bag_outlined, size: 80, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'Your bag is empty',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Add items to get started',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomCheckout(CartProvider cart) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black12, blurRadius: 10, spreadRadius: 1)
        ],
        borderRadius:
            const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '\$${cart.total.toStringAsFixed(2)}', // ✅ dynamic total
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const Text(
                'View Details',
                style:
                    TextStyle(color: Colors.pinkAccent, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // ✅ Correct
                context.push(RouteNames.payment);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF3F6C),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text(
                'Proceed to Payment',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}