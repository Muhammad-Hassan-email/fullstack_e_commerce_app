import 'package:e_commerce_app/features/checkout/paymentmethodmodel.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
// --- Screen ---
class PaymentScreen extends StatefulWidget {
  final List<PaymentMethod> savedCards;
  final double orderAmount;
  final double shippingAmount;
  final String currencySymbol;

  const PaymentScreen({
    super.key,
    this.savedCards = const [],
    this.orderAmount = 0,
    this.shippingAmount = 0,
    this.currencySymbol = '₹',
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen>
    with TickerProviderStateMixin {
  List<PaymentMethod> _paymentOptions = [];
  int _selectedIndex = 0;
  bool _showSuccess = false;

  static const _pink = Color(0xFFFF3F6C);

  // Controllers
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  final _nameController = TextEditingController();

  // Per-field error messages
  String? _cardNumberError;
  String? _expiryError;
  String? _cvvError;
  String? _nameError;

  // Animation controllers — nullable, initialized in initState
  AnimationController? _overlayController;
  AnimationController? _checkController;
  AnimationController? _particleController;

  Animation<double>? _overlayFade;
  Animation<double>? _cardScale;
  Animation<double>? _checkScale;
  Animation<double>? _checkOpacity;
  Animation<double>? _particleAnim;

  // ─── Lifecycle ────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    _refreshPaymentOptions(widget.savedCards);
    _initAnimations();
  }

  void _initAnimations() {
    _overlayController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _checkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _overlayFade = CurvedAnimation(
      parent: _overlayController!,
      curve: Curves.easeOut,
    );
    _cardScale = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(
        parent: _overlayController!,
        curve: Curves.elasticOut,
      ),
    );
    _checkScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _checkController!,
        curve: Curves.elasticOut,
      ),
    );
    _checkOpacity = CurvedAnimation(
      parent: _checkController!,
      curve: Curves.easeIn,
    );
    _particleAnim = CurvedAnimation(
      parent: _particleController!,
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    _nameController.dispose();
    _overlayController?.dispose();
    _checkController?.dispose();
    _particleController?.dispose();
    super.dispose();
  }

  // ─── Helpers ──────────────────────────────────────────────────

  void _refreshPaymentOptions(List<PaymentMethod> cards) {
    _paymentOptions = [
      ...cards,
      const PaymentMethod(
        type: 'cash',
        label: 'Cash on Delivery',
        icon: Icons.payments_outlined,
      ),
    ];
  }

  bool get _hasCards => _paymentOptions.any((m) => m.type != 'cash');
  double get _total => widget.orderAmount + widget.shippingAmount;
  String _fmt(double v) =>
      '${widget.currencySymbol} ${v.toStringAsFixed(0)}';

  // ─── Validation ───────────────────────────────────────────────

  void _onContinue() {
    final selected = _paymentOptions[_selectedIndex];
    final isCash = selected.type == 'cash';

    if (!isCash &&
        (selected.lastFour == null || selected.lastFour!.isEmpty)) {
      _showErrorSnack('Please select a valid payment card.');
      return;
    }

    _triggerSuccess();
  }

  void _showErrorSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(children: [
          const Icon(Icons.error_outline, color: Colors.white, size: 20),
          const SizedBox(width: 10),
          Expanded(child: Text(msg)),
        ]),
        backgroundColor: Colors.red.shade600,
        behavior: SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  // ─── Success animation ────────────────────────────────────────

  Future<void> _triggerSuccess() async {
    setState(() => _showSuccess = true);
    await _overlayController!.forward();
    await Future.delayed(const Duration(milliseconds: 80));
    _checkController!.forward();
    _particleController!.forward();
  }

  void _dismissSuccess() {
    _overlayController!.reverse().then((_) {
      if (!mounted) return;
      setState(() => _showSuccess = false);
      _checkController!.reset();
      _particleController!.reset();
    });
  }

  // ─── Build ────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: const Text(
          'Checkout',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          _buildBody(),
          if (_showSuccess) _buildSuccessOverlay(),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),

          // Order summary — only shown when amounts are passed
          if (widget.orderAmount > 0) ...[
            _buildSummaryRow("Order", _fmt(widget.orderAmount)),
            _buildSummaryRow("Shipping", _fmt(widget.shippingAmount)),
            const SizedBox(height: 10),
            _buildSummaryRow("Total", _fmt(_total), isBold: true),
            const Divider(height: 40, thickness: 1),
          ],

          // Header row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _hasCards ? "Payment Method" : "How would you like to pay?",
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton.icon(
                onPressed: _showAddCardSheet,
                icon: const Icon(Icons.add, size: 18, color: _pink),
                label: const Text("Add Card",
                    style: TextStyle(color: _pink, fontSize: 14)),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          if (!_hasCards) _buildNoCardBanner(),

          // Payment options
          Expanded(
            child: ListView.builder(
              itemCount: _paymentOptions.length,
              padding: EdgeInsets.zero,
              itemBuilder: (_, i) =>
                  _buildPaymentOption(i, _paymentOptions[i]),
            ),
          ),

          // Continue / Pay button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _onContinue,
              style: ElevatedButton.styleFrom(
                backgroundColor: _pink,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(
                _total > 0 ? "Pay ${_fmt(_total)}" : "Continue",
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ─── Success Overlay ──────────────────────────────────────────

  Widget _buildSuccessOverlay() {
    if (_overlayFade == null || _cardScale == null) return const SizedBox();

    return FadeTransition(
      opacity: _overlayFade!,
      child: GestureDetector(
        onTap: _dismissSuccess,
        child: Container(
          color: Colors.black.withOpacity(0.5),
          child: Center(
            child: ScaleTransition(
              scale: _cardScale!,
              child: GestureDetector(
                onTap: () {}, // prevent tap-through
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.78,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32, vertical: 44),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: AnimatedBuilder(
                          animation: _particleController!,
                          builder: (_, child) => CustomPaint(
                            painter: _ParticlePainter(
                                progress: _particleAnim!.value),
                            child: child,
                          ),
                          child: Center(
                            child: ScaleTransition(
                              scale: _checkScale!,
                              child: FadeTransition(
                                opacity: _checkOpacity!,
                                child: Container(
                                  width: 82,
                                  height: 82,
                                  decoration: BoxDecoration(
                                    color: _pink,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: _pink.withOpacity(0.35),
                                        blurRadius: 22,
                                        spreadRadius: 4,
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.check_rounded,
                                    color: Colors.white,
                                    size: 44,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),
                      const Text(
                        'Payment done\nsuccessfully.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Tap anywhere to dismiss',
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey.shade400),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ─── Reusable widgets ─────────────────────────────────────────

  Widget _buildNoCardBanner() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF0F3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _pink.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: _pink.withOpacity(0.1), shape: BoxShape.circle),
            child: const Icon(Icons.credit_card_off_outlined,
                color: _pink, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("No saved cards",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black87)),
                const SizedBox(height: 4),
                GestureDetector(
                  onTap: _showAddCardSheet,
                  child: const Text(
                    "Tap 'Add Card' to save one, or pay cash below.",
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(int index, PaymentMethod method) {
    final isSelected = _selectedIndex == index;
    final isCash = method.type == 'cash';

    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFF0F3) : Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? _pink : Colors.grey.shade200,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected
                    ? _pink.withOpacity(0.1)
                    : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(method.icon,
                  size: 24,
                  color: isSelected ? _pink : Colors.grey.shade600),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isCash ? "Cash on Delivery" : _cardTypeLabel(method.type),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: isSelected ? Colors.black : Colors.black87,
                    ),
                  ),
                  if (method.lastFour != null)
                    Text("•••• •••• •••• ${method.lastFour}",
                        style: const TextStyle(
                            color: Colors.grey, fontSize: 13)),
                  if (isCash)
                    const Text("Pay when your order arrives",
                        style:
                            TextStyle(color: Colors.grey, fontSize: 13)),
                ],
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: isSelected ? _pink : Colors.grey.shade300,
                    width: 2),
                color: isSelected ? _pink : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  String _cardTypeLabel(String type) {
    switch (type) {
      case 'visa':
        return 'Visa Card';
      case 'paypal':
        return 'PayPal';
      case 'mastercard':
        return 'Mastercard';
      case 'apple':
        return 'Apple Pay';
      default:
        return type;
    }
  }

  Widget _buildSummaryRow(String label, String value,
      {bool isBold = false}) {
    final style = TextStyle(
      fontSize: 15,
      color: isBold ? Colors.black : Colors.grey,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(label, style: style), Text(value, style: style)],
      ),
    );
  }

  // ─── Add Card Sheet ───────────────────────────────────────────

  void _showAddCardSheet() {
    _cardNumberController.clear();
    _expiryController.clear();
    _cvvController.clear();
    _nameController.clear();

    // Reset errors when sheet opens
    setState(() {
      _cardNumberError = null;
      _expiryError = null;
      _cvvError = null;
      _nameError = null;
    });

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: false,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheetState) {
          // Per-field validation — sets errors and returns overall validity
          bool validate() {
            bool valid = true;

            final number = _cardNumberController.text.trim();
            final clean = number.replaceAll(' ', '');
            if (number.isEmpty) {
              setSheetState(() =>
                  _cardNumberError = 'Card number is required');
              valid = false;
            } else if (clean.length < 12) {
              setSheetState(() =>
                  _cardNumberError = 'Enter a valid 12–16 digit number');
              valid = false;
            } else {
              setSheetState(() => _cardNumberError = null);
            }

            final expiry = _expiryController.text.trim();
            if (expiry.isEmpty) {
              setSheetState(
                  () => _expiryError = 'Expiry date is required');
              valid = false;
            } else if (!RegExp(r'^(0[1-9]|1[0-2])\/\d{2}$')
                .hasMatch(expiry)) {
              setSheetState(
                  () => _expiryError = 'Use MM/YY format (e.g. 08/27)');
              valid = false;
            } else {
              setSheetState(() => _expiryError = null);
            }

            final cvv = _cvvController.text.trim();
            if (cvv.isEmpty) {
              setSheetState(() => _cvvError = 'CVV is required');
              valid = false;
            } else if (cvv.length < 3) {
              setSheetState(() => _cvvError = 'CVV must be 3–4 digits');
              valid = false;
            } else {
              setSheetState(() => _cvvError = null);
            }

            final name = _nameController.text.trim();
            if (name.isEmpty) {
              setSheetState(
                  () => _nameError = 'Cardholder name is required');
              valid = false;
            } else if (name.length < 2) {
              setSheetState(() => _nameError = 'Enter a valid name');
              valid = false;
            } else {
              setSheetState(() => _nameError = null);
            }

            return valid;
          }

          return Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 24,
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with close button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Add New Card",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    GestureDetector(
                      onTap: () => Navigator.pop(ctx),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.close,
                            size: 18, color: Colors.black54),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Card number
                _buildTextField(
                  "Card Number",
                  Icons.credit_card,
                  controller: _cardNumberController,
                  keyboardType: TextInputType.number,
                  errorText: _cardNumberError,
                  onChanged: () {
                    if (_cardNumberError != null) {
                      setSheetState(() => _cardNumberError = null);
                    }
                  },
                ),
                const SizedBox(height: 14),

                // Expiry + CVV row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildTextField(
                        "MM/YY",
                        Icons.date_range,
                        controller: _expiryController,
                        keyboardType: TextInputType.number,
                        errorText: _expiryError,
                        onChanged: () {
                          if (_expiryError != null) {
                            setSheetState(() => _expiryError = null);
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildTextField(
                        "CVV",
                        Icons.lock_outline,
                        controller: _cvvController,
                        keyboardType: TextInputType.number,
                        obscure: true,
                        errorText: _cvvError,
                        onChanged: () {
                          if (_cvvError != null) {
                            setSheetState(() => _cvvError = null);
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Cardholder name
                _buildTextField(
                  "Cardholder Name",
                  Icons.person_outline,
                  controller: _nameController,
                  errorText: _nameError,
                  onChanged: () {
                    if (_nameError != null) {
                      setSheetState(() => _nameError = null);
                    }
                  },
                ),
                const SizedBox(height: 24),

                // Save button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (!validate()) return; // stop if invalid

                      final clean = _cardNumberController.text
                          .trim()
                          .replaceAll(' ', '');
                      final lastFour =
                          clean.substring(clean.length - 4);

                      // Clear fields on success
                      _cardNumberController.clear();
                      _expiryController.clear();
                      _cvvController.clear();
                      _nameController.clear();
                      setSheetState(() {
                        _cardNumberError = null;
                        _expiryError = null;
                        _cvvError = null;
                        _nameError = null;
                      });

                      Navigator.pop(ctx);
                      setState(() {
                        final updated = [
                          ..._paymentOptions
                              .where((m) => m.type != 'cash'),
                          PaymentMethod(
                            type: 'visa',
                            label: 'Visa Card',
                            lastFour: lastFour,
                            icon: Icons.credit_card,
                          ),
                        ];
                        _refreshPaymentOptions(updated);
                        _selectedIndex = _paymentOptions.length - 2;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _pink,
                      padding:
                          const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text("Save Card",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ─── Text field with inline error ─────────────────────────────

  Widget _buildTextField(
    String hint,
    IconData icon, {
    TextEditingController? controller,
    TextInputType? keyboardType,
    bool obscure = false,
    String? errorText,
    VoidCallback? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscure,
          onChanged: onChanged != null ? (_) => onChanged() : null,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon,
                color: errorText != null
                    ? Colors.red.shade400
                    : Colors.grey),
            filled: true,
            fillColor: errorText != null
                ? Colors.red.shade50
                : Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: errorText != null
                  ? BorderSide(
                      color: Colors.red.shade300, width: 1.5)
                  : BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: errorText != null
                  ? BorderSide(
                      color: Colors.red.shade400, width: 1.5)
                  : const BorderSide(
                      color: Color(0xFFFF3F6C), width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 14),
          ),
        ),
        // Inline error message
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 4),
            child: Row(
              children: [
                Icon(Icons.info_outline,
                    size: 13, color: Colors.red.shade400),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    errorText,
                    style: TextStyle(
                        fontSize: 12, color: Colors.red.shade400),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

// ─── Particle Painter ─────────────────────────────────────────

class _ParticlePainter extends CustomPainter {
  final double progress;
  static const _pink = Color(0xFFFF3F6C);

  _ParticlePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    if (progress == 0) return;
    final center = Offset(size.width / 2, size.height / 2);
    final rng = math.Random(7);

    for (int i = 0; i < 18; i++) {
      final angle = (i / 18) * 2 * math.pi;
      final dist = 52.0 * progress;
      final opacity = (1.0 - progress).clamp(0.0, 1.0);
      final r = (3.5 * (1 - progress * 0.6)).clamp(0.5, 4.0);
      final color = i % 3 == 0
          ? _pink.withOpacity(opacity)
          : const Color(0xFFFFB3C1).withOpacity(opacity);
      final dx = center.dx +
          dist * math.cos(angle) +
          rng.nextDouble() * 8 -
          4;
      final dy = center.dy +
          dist * math.sin(angle) +
          rng.nextDouble() * 8 -
          4;
      canvas.drawCircle(Offset(dx, dy), r, Paint()..color = color);
    }
  }

  @override
  bool shouldRepaint(_ParticlePainter old) =>
      old.progress != progress;
}