import 'package:e_commerce_app/features/home/product/productmodel.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final ProductModel? product;

  const DetailScreen({super.key, this.product});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  static const _accent = Color(0xFFE24A69);
  static const _textMuted = Color(0xFF6B7280);
  static const _bg = Color(0xFFF6F7FB);

  final PageController _pageController = PageController();
  int _activeImageIndex = 0;
  int _selectedSizeIndex = 1;
  bool _detailsExpanded = false;

  late final List<String> _images;

  @override
  void initState() {
    super.initState();

    final product = widget.product;
    _images = [
      if (product?.image case final String url when url.trim().isNotEmpty) url,
      'assets/banner_2.jpg',
      'assets/banner_3.jpg',
      'assets/banner_4.jpg',
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToImage(int index) {
    if (!mounted) return;
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final title = product?.title ?? 'Nike Sneakers';
    final subtitle = "Vision Alta Men’s Shoes Size (All Colours)";
    final rating = 4.2;
    final ratingCount = 56890;

    final originalPrice = 2999.0;
    final salePrice = product?.price ?? 1500.0;
    final discountPct = 50;

    final sizes = const ['6 UK', '7 UK', '8 UK', '9 UK', '10 UK'];

    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _TopBar(
              onBack: () => Navigator.of(context).maybePop(),
              onCart: () {},
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ImageCarousel(
                      controller: _pageController,
                      images: _images,
                      activeIndex: _activeImageIndex,
                      onPageChanged: (i) => setState(() => _activeImageIndex = i),
                      onNext: () => _goToImage((_activeImageIndex + 1) % _images.length),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Size: ${sizes[_selectedSizeIndex].replaceAll(' ', '')}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        for (var i = 0; i < sizes.length; i++)
                          _SizeChip(
                            label: sizes[i],
                            selected: i == _selectedSizeIndex,
                            accent: _accent,
                            onTap: () => setState(() => _selectedSizeIndex = i),
                          ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 13,
                        color: _textMuted,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        _RatingStars(value: rating),
                        const SizedBox(width: 8),
                        Text(
                          rating.toStringAsFixed(1),
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '($ratingCount)',
                          style: const TextStyle(
                            color: _textMuted,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '₹${originalPrice.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 13,
                            color: _textMuted,
                            decoration: TextDecoration.lineThrough,
                            decorationThickness: 2,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '₹${salePrice.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: _accent.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            '$discountPct% Off',
                            style: const TextStyle(
                              color: _accent,
                              fontWeight: FontWeight.w800,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Product Details',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _ExpandableText(
                      text:
                          "Perhaps the most iconic sneaker of all-time, this original "
                          "\"Chicago\" colorway is the most important one ever made. "
                          "Made famous in 1985 by Michael Jordan, the shoe has stood "
                          "the test of time, becoming the most famous colorway of the "
                          "Air Jordan 1. This 2015 release saw the ...",
                      expanded: _detailsExpanded,
                      onToggle: () => setState(() => _detailsExpanded = !_detailsExpanded),
                      accent: _accent,
                    ),
                    const SizedBox(height: 14),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: const [
                        _MiniPill(icon: Icons.store_mall_directory_outlined, label: 'Nearest Store'),
                        _MiniPill(icon: Icons.workspace_premium_outlined, label: 'VIP'),
                        _MiniPill(icon: Icons.assignment_return_outlined, label: 'Return policy'),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: _PrimaryButton(
                            label: 'Go to cart',
                            icon: Icons.shopping_cart_outlined,
                            background: const Color(0xFF3B82F6),
                            onTap: () {},
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _PrimaryButton(
                            label: 'Buy Now',
                            icon: Icons.shopping_bag_outlined,
                            background: const Color(0xFF22C55E),
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      decoration: BoxDecoration(
                        color: _accent.withValues(alpha: 0.14),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: _accent.withValues(alpha: 0.25)),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.local_shipping_outlined, color: _accent),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Delivery in\n1 within 1 Hour',
                              style: TextStyle(fontWeight: FontWeight.w800, height: 1.1),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: _SecondaryButton(
                            label: 'View Similar',
                            icon: Icons.remove_red_eye_outlined,
                            onTap: () {},
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _SecondaryButton(
                            label: 'Add to Compare',
                            icon: Icons.compare_arrows_outlined,
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Similar To\n282+ Items',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, height: 1.1),
                          ),
                        ),
                        _SquareIconButton(icon: Icons.sort, onTap: () {}),
                        const SizedBox(width: 10),
                        _SquareIconButton(icon: Icons.filter_alt_outlined, onTap: () {}),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: const [
                        Expanded(
                          child: _SimilarCard(
                            image: 'assets/banner_3.jpg',
                            title: 'Nike Sneakers',
                            subtitle: 'Nike Air Jordan Retro 1 Low Mystic Black',
                            price: 1900,
                            originalPrice: 2680,
                            rating: 4.5,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: _SimilarCard(
                            image: 'assets/banner_4.jpg',
                            title: 'Nike Sneakers',
                            subtitle: 'Mid Peach Mocha Shoes For Man White Black Pink',
                            price: 1900,
                            originalPrice: 2680,
                            rating: 4.4,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onCart;

  const _TopBar({
    required this.onBack,
    required this.onCart,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
          const Spacer(),
          IconButton(
            onPressed: onCart,
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
    );
  }
}

class _ImageCarousel extends StatelessWidget {
  final PageController controller;
  final List<String> images;
  final int activeIndex;
  final ValueChanged<int> onPageChanged;
  final VoidCallback onNext;

  const _ImageCarousel({
    required this.controller,
    required this.images,
    required this.activeIndex,
    required this.onPageChanged,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(18);

    return ClipRRect(
      borderRadius: radius,
      child: Container(
        color: Colors.white,
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: PageView.builder(
                controller: controller,
                itemCount: images.length,
                onPageChanged: onPageChanged,
                itemBuilder: (context, index) {
                  final src = images[index];
                  final isNetwork = src.startsWith('http://') || src.startsWith('https://');

                  final image = isNetwork
                      ? Image.network(
                          src,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(child: Icon(Icons.broken_image_outlined));
                          },
                        )
                      : Image.asset(
                          src,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        );

                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      image,
                      DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withValues(alpha: 0.10),
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.05),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Positioned(
              right: 10,
              top: 0,
              bottom: 0,
              child: Center(
                child: Material(
                  color: Colors.white.withValues(alpha: 0.85),
                  shape: const CircleBorder(),
                  child: IconButton(
                    onPressed: onNext,
                    icon: const Icon(Icons.chevron_right_rounded),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < images.length; i++)
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      height: 7,
                      width: i == activeIndex ? 20 : 7,
                      decoration: BoxDecoration(
                        color: i == activeIndex
                            ? const Color(0xFFE24A69)
                            : Colors.white.withValues(alpha: 0.75),
                        borderRadius: BorderRadius.circular(99),
                      ),
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

class _SizeChip extends StatelessWidget {
  final String label;
  final bool selected;
  final Color accent;
  final VoidCallback onTap;

  const _SizeChip({
    required this.label,
    required this.selected,
    required this.accent,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
        decoration: BoxDecoration(
          color: selected ? accent.withValues(alpha: 0.10) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected ? accent : const Color(0xFFE5E7EB),
            width: selected ? 1.6 : 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 12,
            color: selected ? accent : const Color(0xFF374151),
          ),
        ),
      ),
    );
  }
}

class _RatingStars extends StatelessWidget {
  final double value;

  const _RatingStars({required this.value});

  @override
  Widget build(BuildContext context) {
    final full = value.floor().clamp(0, 5);
    final half = (value - full) >= 0.5 && full < 5;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < 5; i++)
          Icon(
            i < full
                ? Icons.star_rounded
                : (i == full && half ? Icons.star_half_rounded : Icons.star_border_rounded),
            size: 18,
            color: const Color(0xFFF59E0B),
          ),
      ],
    );
  }
}

class _ExpandableText extends StatelessWidget {
  final String text;
  final bool expanded;
  final VoidCallback onToggle;
  final Color accent;

  const _ExpandableText({
    required this.text,
    required this.expanded,
    required this.onToggle,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    final style = const TextStyle(color: Color(0xFF374151), height: 1.35, fontSize: 13);

    return LayoutBuilder(
      builder: (context, constraints) {
        final trimmed = text.trim();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedCrossFade(
              duration: const Duration(milliseconds: 200),
              crossFadeState: expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              firstChild: Text(
                trimmed,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: style,
              ),
              secondChild: Text(trimmed, style: style),
            ),
            const SizedBox(height: 6),
            GestureDetector(
              onTap: onToggle,
              child: Text(
                expanded ? 'Less' : 'More',
                style: TextStyle(
                  color: accent,
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _MiniPill extends StatelessWidget {
  final IconData icon;
  final String label;

  const _MiniPill({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: const Color(0xFF6B7280)),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12,
              color: Color(0xFF374151),
            ),
          ),
        ],
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color background;
  final VoidCallback onTap;

  const _PrimaryButton({
    required this.label,
    required this.icon,
    required this.background,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: background.withValues(alpha: 0.28),
              blurRadius: 14,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SecondaryButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _SecondaryButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: const Color(0xFF374151)),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF374151),
                fontWeight: FontWeight.w800,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SquareIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _SquareIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Icon(icon, size: 20, color: const Color(0xFF374151)),
      ),
    );
  }
}

class _SimilarCard extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final double price;
  final double originalPrice;
  final double rating;

  const _SimilarCard({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.originalPrice,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(
              image,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 11, color: Color(0xFF6B7280), height: 1.25),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star_rounded, size: 16, color: Color(0xFFF59E0B)),
                    const SizedBox(width: 4),
                    Text(
                      rating.toStringAsFixed(1),
                      style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12),
                    ),
                    const Spacer(),
                    Text(
                      '₹${price.toStringAsFixed(0)}',
                      style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 13),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  '₹${originalPrice.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF9CA3AF),
                    decoration: TextDecoration.lineThrough,
                    decorationThickness: 2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
