// lib/features/cart/checkoutscreen.dart
import 'package:e_commerce_app/features/cart/cartmodel.dart';
import 'package:e_commerce_app/features/cart/provider/cartprovider.dart';
import 'package:e_commerce_app/routes/routernames.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  // ✅ Address state
  String _address = '216 St Paul\'s Rd, London N1 2LL, UK';
  String _contact = '+44-784232';

  void _editAddress() {
    final addressController = TextEditingController(text: _address);
    final contactController = TextEditingController(text: _contact);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          left: 20, right: 20, top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Edit Delivery Address',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              controller: addressController,
              decoration: InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: contactController,
              decoration: InputDecoration(
                labelText: 'Contact',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE24A69),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  setState(() {
                    _address = addressController.text;
                    _contact = contactController.text;
                  });
                  Navigator.pop(context);
                },
                child: const Text('Save',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Checkout',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: cart.isEmpty
          ? _buildEmptyCart()
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ✅ Delivery Address Section
                  _buildSectionTitle(
                      Icons.location_on_outlined, 'Delivery Address'),
                  const SizedBox(height: 10),
                  _buildAddressCard(),
                  const SizedBox(height: 24),

                  // ✅ Shopping List Section
                  const Text(
                    'Shopping List',
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),

                  // ✅ Dynamic cart items
                  ...cart.items.map((item) => _buildCartItem(item, cart)),

                  const Divider(height: 32),

                  // ✅ Order Summary
                  _buildOrderSummary(cart),

                  const SizedBox(height: 100),
                ],
              ),
            ),
      bottomNavigationBar: cart.isEmpty ? null : _buildBottomBar(cart),
    );
  }

  Widget _buildSectionTitle(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.black87),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  // ✅ Dynamic address card
  Widget _buildAddressCard() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Address :',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 13)),
                      const SizedBox(height: 4),
                      Text(_address,
                          style: const TextStyle(
                              fontSize: 13, color: Colors.black87)),
                      const SizedBox(height: 4),
                      Text('Contact : $_contact',
                          style: const TextStyle(
                              fontSize: 13, color: Colors.black87)),
                    ],
                  ),
                ),
                // ✅ Edit button
                GestureDetector(
                  onTap: _editAddress,
                  child: const Icon(Icons.edit_outlined,
                      size: 18, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        // ✅ Add new address button
        GestureDetector(
          onTap: _editAddress,
          child: Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.add, color: Colors.black54),
          ),
        ),
      ],
    );
  }

  // ✅ Dynamic cart item matching the UI design
  Widget _buildCartItem(CartItem item, CartProvider cart) {
    final discountPct = int.tryParse(
          item.product.discount.replaceAll('%', '').trim(),
        ) ?? 0;
    final originalPrice = discountPct > 0
        ? item.product.price / (1 - discountPct / 100)
        : item.product.price;

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Product image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                item.product.imageUrl,
                width: 110,
                height: 130,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 110,
                  height: 130,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.image_not_supported),
                ),
              ),
            ),
            const SizedBox(width: 14),
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
                  const SizedBox(height: 6),

                  // ✅ Variations chips
                  if (item.product.variations.isNotEmpty) ...[
                    Row(
                      children: [
                        const Text('Variations : ',
                            style: TextStyle(
                                fontSize: 12, color: Colors.black54)),
                        Wrap(
                          spacing: 6,
                          children: item.product.variations
                              .take(3)
                              .map(
                                (v) => Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey.shade400),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(v,
                                      style:
                                          const TextStyle(fontSize: 11)),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                  ],

                  // ✅ Rating stars
                  Row(
                    children: [
                      ...List.generate(5, (i) {
                        return Icon(
                          i < item.product.rating.floor()
                              ? Icons.star_rounded
                              : Icons.star_border_rounded,
                          size: 16,
                          color: const Color(0xFFF59E0B),
                        );
                      }),
                      const SizedBox(width: 4),
                      Text(
                        item.product.rating.toStringAsFixed(1),
                        style: const TextStyle(
                            fontSize: 12, color: Colors.black54),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // ✅ Price row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '\$ ${item.product.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(width: 8),
                      if (discountPct > 0)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'upto $discountPct% off',
                              style: const TextStyle(
                                  color: Color(0xFFE24A69),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              '\$ ${originalPrice.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // ✅ Quantity controls
                  Row(
                    children: [
                      _qtyButton(
                        icon: Icons.remove,
                        onTap: () => cart.updateQuantity(
                            item.product, item.quantity - 1),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          '${item.quantity}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      _qtyButton(
                        icon: Icons.add,
                        onTap: () => cart.updateQuantity(
                            item.product, item.quantity + 1),
                      ),
                      const Spacer(),
                      // ✅ Remove button
                      GestureDetector(
                        onTap: () => cart.removeFromCart(item.product),
                        child: const Icon(Icons.delete_outline,
                            color: Colors.red, size: 20),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // ✅ Dynamic per-item total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total Order (${item.quantity}) :',
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
            Text(
              '\$ ${item.totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ],
        ),
        const Divider(height: 24),
      ],
    );
  }

  Widget _qtyButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 28,
        width: 28,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, size: 16),
      ),
    );
  }

  // ✅ Dynamic order summary
  Widget _buildOrderSummary(CartProvider cart) {
    return Column(
      children: [
        _summaryRow('Order Amount', '\$ ${cart.subtotal.toStringAsFixed(2)}'),
        if (cart.discountAmount > 0)
          _summaryRow(
            'Discount (${cart.appliedCoupon})',
            '-\$ ${cart.discountAmount.toStringAsFixed(2)}',
            valueColor: Colors.green,
          ),
        _summaryRow(
          'Delivery Fee',
          cart.deliveryFee == 0
              ? 'Free'
              : '\$ ${cart.deliveryFee.toStringAsFixed(2)}',
          valueColor: cart.deliveryFee == 0 ? Colors.green : Colors.black,
        ),
        const Divider(height: 24),
        _summaryRow(
          'Order Total',
          '\$ ${cart.total.toStringAsFixed(2)}',
          isBold: true,
        ),
      ],
    );
  }

  Widget _summaryRow(String label, String value,
      {bool isBold = false, Color valueColor = Colors.black}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: isBold ? 16 : 14,
                  fontWeight:
                      isBold ? FontWeight.bold : FontWeight.normal)),
          Text(value,
              style: TextStyle(
                  fontSize: isBold ? 16 : 14,
                  fontWeight: FontWeight.bold,
                  color: valueColor)),
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
          Text('Your cart is empty',
              style:
                  TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('Add items to checkout',
              style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildBottomBar(CartProvider cart) {
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
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Order placed successfully!')),
                );
                
                // Use pushReplacement instead of go to avoid stack issues
                Future.delayed(const Duration(milliseconds: 500), () {
                  if (mounted) context.push(RouteNames.shoppingbag);
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE24A69),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text(
                'Continue',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}