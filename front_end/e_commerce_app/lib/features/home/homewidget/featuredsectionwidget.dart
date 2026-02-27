import 'package:flutter/material.dart';

class FeaturedSectionWidget extends StatelessWidget {
  const FeaturedSectionWidget({super.key});

  static const categories = [
    ('Beauty', Icons.auto_stories),
    ('Fashion', Icons.checkroom),
    ('Kids', Icons.child_care),
    ('Mens', Icons.man),
    ('Womens', Icons.woman),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'All Featured',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.swap_vert,
                        size: 18),
                    label: const Text('Sort'),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.tune,
                        size: 18),
                    label: const Text('Filter'),
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
            padding: const EdgeInsets.symmetric(
                horizontal: 12),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final (name, icon) = categories[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 6),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor:
                          Colors.grey.shade200,
                      child: Icon(icon,
                          size: 28,
                          color:
                              Colors.grey.shade700),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight:
                            FontWeight.w500,
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