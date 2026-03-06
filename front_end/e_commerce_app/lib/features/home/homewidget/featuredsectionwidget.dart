import 'package:e_commerce_app/constants/secondarybutton.dart';
import 'package:e_commerce_app/features/home/product/productprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeaturedSectionWidget extends StatefulWidget { // ✅ StatefulWidget
  const FeaturedSectionWidget({super.key});

  @override
  State<FeaturedSectionWidget> createState() => _FeaturedSectionWidgetState();
}

class _FeaturedSectionWidgetState extends State<FeaturedSectionWidget> {

  static const categories = [
    ('Beauty', Icons.auto_stories),
    ('Fashion', Icons.checkroom),
    ('Kids', Icons.child_care),
    ('Mens', Icons.man),
    ('Womens', Icons.woman),
  ];

  // ✅ Sort bottom sheet
  void _showSortSheet(BuildContext context, ProductProvider provider) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Sort By',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              _sortTile(context, provider, 'Price: Low to High', SortOption.priceLowHigh),
              _sortTile(context, provider, 'Price: High to Low', SortOption.priceHighLow),
              _sortTile(context, provider, 'Top Rated', SortOption.rating),
              _sortTile(context, provider, 'Newest First', SortOption.newest),
              _sortTile(context, provider, 'None', SortOption.none),
            ],
          ),
        );
      },
    );
  }

  Widget _sortTile(BuildContext context, ProductProvider provider,
      String label, SortOption option) {
    final isSelected = provider.sortOption == option;
    return ListTile(
      title: Text(label),
      trailing: isSelected
          ? const Icon(Icons.check, color: Color(0xFFE24A69))
          : null,
      onTap: () {
        provider.setSortOption(option);
        Navigator.pop(context);
      },
    );
  }

  // ✅ Filter bottom sheet
  void _showFilterSheet(BuildContext context, ProductProvider provider) {
    double tempMin = provider.minPrice;
    double tempMax = provider.maxPrice == double.infinity
        ? provider.maxAvailablePrice
        : provider.maxPrice;
    double tempRating = provider.minRating;
    String tempCategory = provider.selectedCategory;
    String tempProductType = provider.selectedProductType;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Filter',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () {
                            provider.resetFilters();
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Reset',
                            style: TextStyle(color: Color(0xFFE24A69)),
                          ),
                        ),
                      ],
                    ),
                    const Divider(),

                    // ✅ Category filter
                    const Text('Category',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: [
                        _filterChip(
                          label: 'All',
                          selected: tempCategory.isEmpty,
                          onTap: () => setModalState(() => tempCategory = ''),
                        ),
                        ...provider.availableCategories.map(
                          (cat) => _filterChip(
                            label: cat,
                            selected: tempCategory == cat,
                            onTap: () => setModalState(() => tempCategory = cat),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // ✅ Product Type filter
                    const Text('Product Type',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: [
                        _filterChip(
                          label: 'All',
                          selected: tempProductType.isEmpty,
                          onTap: () => setModalState(() => tempProductType = ''),
                        ),
                        ...provider.availableProductTypes.map(
                          (type) => _filterChip(
                            label: type,
                            selected: tempProductType == type,
                            onTap: () => setModalState(() => tempProductType = type),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // ✅ Price Range filter
                    const Text('Price Range',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    RangeSlider(
                      values: RangeValues(tempMin, tempMax),
                      min: 0,
                      max: provider.maxAvailablePrice,
                      divisions: 20,
                      activeColor: const Color(0xFFE24A69),
                      labels: RangeLabels(
                        '\$${tempMin.toStringAsFixed(0)}',
                        '\$${tempMax.toStringAsFixed(0)}',
                      ),
                      onChanged: (values) {
                        setModalState(() {
                          tempMin = values.start;
                          tempMax = values.end;
                        });
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('\$${tempMin.toStringAsFixed(0)}'),
                        Text('\$${tempMax.toStringAsFixed(0)}'),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // ✅ Rating filter
                    const Text('Minimum Rating',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Slider(
                      value: tempRating,
                      min: 0,
                      max: 5,
                      divisions: 5,
                      activeColor: const Color(0xFFE24A69),
                      label: '${tempRating.toStringAsFixed(1)} ★',
                      onChanged: (value) =>
                          setModalState(() => tempRating = value),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('0 ★'),
                        Text('${tempRating.toStringAsFixed(1)} ★'),
                        const Text('5 ★'),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // ✅ Apply button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE24A69),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          provider.setCategory(tempCategory);
                          provider.setProductType(tempProductType);
                          provider.setPriceRange(tempMin, tempMax);
                          provider.setMinRating(tempRating);
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Apply Filters',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _filterChip({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Chip(
        label: Text(label),
        backgroundColor: selected ? const Color(0xFFE24A69) : Colors.grey.shade200,
        labelStyle: TextStyle(
          color: selected ? Colors.white : Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ProductProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'All Featured',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  IconTextButton(
                    icon: Icons.swap_vert,
                    text: 'Sort',
                    onPressed: () => _showSortSheet(context, provider), // ✅
                  ),
                  const SizedBox(width: 10),
                  IconTextButton(
                    icon: Icons.filter_alt,
                    text: 'Filter',
                    onPressed: () => _showFilterSheet(context, provider), // ✅
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 88,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final (name, icon) = categories[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.grey.shade200,
                      child: Icon(icon, size: 28, color: Colors.grey.shade700),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}