import 'package:flutter/material.dart';

class OrderComplete extends StatelessWidget {
  const OrderComplete({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0E0E0),
      body: Stack(
        children: [
          Column(
            children: [
              // Status Bar Space
              const SizedBox(height: 50),

              // AppBar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.chevron_left,
                          size: 28, color: Colors.black87),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'Checkout',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 28),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Order Summary Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 16),
                  child: Column(
                    children: [
                      _summaryRow('Order', '₹ 7,000', isTotal: false),
                      const SizedBox(height: 8),
                      _summaryRow('Shipping', '₹ 30', isTotal: false),
                      const Divider(height: 24, color: Color(0xFFF0F0F0)),
                      _summaryRow('Total', '₹ 7,030', isTotal: true),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Payment Method Cards
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    _paymentCard(
                      icon: _mastercardIcon(),
                    ),
                    const SizedBox(height: 10),
                    _paymentCard(
                      icon: _appleIcon(),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Continue Button
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFC42D44),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 4,
                    ),
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ),
              ),

              // Bottom Navigation Bar
              Container(
                color: Colors.white,
                padding: const EdgeInsets.only(bottom: 20, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _navItem(Icons.home_outlined, 'Home', false),
                    _navItem(Icons.favorite_border, 'Wishlist', false),
                    _navItemCart(),
                    _navItem(Icons.search, 'Search', false),
                    _navItem(Icons.settings_outlined, 'Setting', false),
                  ],
                ),
              ),
            ],
          ),

          // Modal Overlay
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.15),
              child: Center(
                child: _successModal(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value, {required bool isTotal}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 15 : 14,
            fontWeight: isTotal ? FontWeight.w800 : FontWeight.w500,
            color: isTotal ? Colors.black87 : Colors.grey,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 15 : 14,
            fontWeight: isTotal ? FontWeight.w800 : FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _paymentCard({required Widget icon}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          icon,
          const SizedBox(width: 14),
          const Text(
            '*********2109',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Color(0xFFAAAAAA),
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _mastercardIcon() {
    return Container(
      width: 36,
      height: 36,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 0,
            child: Container(
              width: 22,
              height: 22,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFEB001B),
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: Container(
              width: 22,
              height: 22,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFF79E1B),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _appleIcon() {
    return Container(
      width: 36,
      height: 36,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
      ),
      child: const Icon(
        Icons.apple,
        color: Colors.white,
        size: 22,
      ),
    );
  }

  Widget _navItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 24,
          color: isActive ? const Color(0xFFC42D44) : Colors.grey,
        ),
        const SizedBox(height: 3),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: isActive ? const Color(0xFFC42D44) : Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _navItemCart() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFC42D44),
            boxShadow: [
              BoxShadow(
                color: Color(0x66C42D44),
                blurRadius: 10,
                offset: Offset(0, 4),
              )
            ],
          ),
          child: const Icon(
            Icons.shopping_cart_outlined,
            color: Colors.white,
            size: 22,
          ),
        ),
      ],
    );
  }

  Widget _successModal() {
    return Container(
      width: 300,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Floating dots
          Positioned(
            top: -20,
            left: -10,
            child: _dot(10, const Color(0xFFF48FB1)),
          ),
          Positioned(
            top: -30,
            right: 30,
            child: _dot(7, const Color(0xFFF48FB1)),
          ),
          Positioned(
            top: 10,
            right: -10,
            child: _dot(9, const Color(0xFFF48FB1)),
          ),
          Positioned(
            bottom: 30,
            right: -12,
            child: _dot(6, const Color(0xFFF48FB1)),
          ),
          Positioned(
            bottom: 30,
            left: -12,
            child: _dot(8, const Color(0xFFF48FB1)),
          ),

          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Badge Icon
              Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  color: const Color(0xFFC42D44),
                  borderRadius: BorderRadius.circular(44),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFC42D44).withOpacity(0.35),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 44,
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Payment done successfully.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _dot(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(0.7),
      ),
    );
  }
}