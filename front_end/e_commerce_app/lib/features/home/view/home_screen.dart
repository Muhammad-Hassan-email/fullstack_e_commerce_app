import 'package:e_commerce_app/features/home/homewidget/appbarwidget.dart';
import 'package:e_commerce_app/features/home/homewidget/featuredsectionwidget.dart';
import 'package:e_commerce_app/features/home/homewidget/promo_image_banner.dart';
import 'package:e_commerce_app/features/home/homewidget/searchbarwidget.dart';
import 'package:e_commerce_app/features/home/homewidget/sectionheaderwidget.dart';
import 'package:e_commerce_app/features/home/product/producttype.dart';
import 'package:e_commerce_app/routes/routernames.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            CustomSliverAppBar(
            logoPath: 'assets/app_logo.png',
            showBackButton: false,
            showProfileIcon: true,
            onMenuTap: () {
              print("Menu tapped");
            },
            onProfileTap: () {
              print("Profile tapped");
            },
          ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SearchBarWidget(
                    onChanged: (value) {
                      print("Searching: $value");
                    },
                  ),

                  const SizedBox(height: 20),

                  const FeaturedSectionWidget(),

                  const SizedBox(height: 20),

                  PromoImageBanner(
                    assetPath: 'assets/banner_1.jpg',
                    onTap: () {
                      context.push(
                        RouteNames.plistscrn,
                        extra: {
                          'title': "Special Offers",
                          'type': ProductType.featured,
                        },
                      );
                    }, height: 120,
                  ),

                  const SizedBox(height: 20),
                  //Deal Of the Day banner
                  SectionHeaderBanner(
                    title: "Deal of the Day",
                    subtitle: "22h 55m 20s remaining",
                    subtitleIcon: Icons.access_time,
                    backgroundColor: const Color(0xFF4A90E2),
                    onViewAll: () {
                      context.push(
                        RouteNames.plistscrn,
                        extra: {
                          'title': "Deal of the Day",
                          'type': ProductType.deal,
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  PromoImageBanner(
                    assetPath: 'assets/banner_2.jpg',
                    height: 140,
                    onTap: () {
                      context.push(
                        RouteNames.plistscrn,
                        extra: {
                          'title': "Flat and Heels",
                          'type': ProductType.featured,
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  //Trending Product Banner
                  SectionHeaderBanner(
                    title: "Trending Products",
                    subtitle: "Last Date 29/02/22",
                    subtitleIcon: Icons.calendar_today,
                    backgroundColor: const Color(0xFFE85D75),
                    onViewAll: () {
                      context.push(
                        RouteNames.plistscrn,
                        extra: {
                          'title': "Trending Products",
                          'type': ProductType.trending,
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  //Hot Summer Sale Banner
                  PromoImageBanner(
                    title: 'New Arrival',
                    assetPath: 'assets/banner_3.jpg',
                    height: 180,
                    onTap: () {
                      context.push(
                        RouteNames.plistscrn,
                        extra: {
                          'title': "Hot Summer Sale",
                          'type': ProductType.featured,
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  //_buildNewArrivals(),
                  const SizedBox(height: 20),
                  PromoImageBanner(
                    title: 'Sponsored',
                    assetPath: 'assets/banner_4.jpg',
                    height: 180,
                    onTap: () {
                      context.push(
                        RouteNames.plistscrn,
                        extra: {
                          'title': "Hot Summer Sale",
                          'type': ProductType.featured,
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // Widget _buildNewArrivals() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 16),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             const Text(
  //               'New Arrivals',
  //               style: TextStyle(
  //                 fontSize: 18,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //             Text(
  //               "Summer '25 Collections",
  //               style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
  //             ),
  //           ],
  //         ),
  //         TextButton(
  //           onPressed: () {
  //             context.push(
  //               RouteNames.plistscrn,
  //               extra: {
  //                 'title': "Trending Products",
  //                 'type': ProductType.trending,
  //               },
  //             );
  //           },
  //           child: const Row(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Text('View all'),
  //               Icon(Icons.arrow_forward_ios, size: 12),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildSponsored() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 16),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         const Text(
  //           'Sponsored',
  //           style: TextStyle(
  //             fontSize: 18,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //         const SizedBox(height: 12),
  //         PromoImageBanner(
  //           title: 'Sponsored',
  //           assetPath: 'assets/banner_4.jpg',
  //           height: 160,
  //           margin: EdgeInsets.zero,
  //           borderRadius: const BorderRadius.all(Radius.circular(12)),
  //           onTap: () {
  //             context.push(
  //               RouteNames.plistscrn,
  //               extra: {
  //                 'title': "Sponsored",
  //                 'type': ProductType.featured,
  //               },
  //             );
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
        color: Colors.white,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(Icons.home, 'Home', 0),
              _navItem(Icons.favorite_border, 'Wishlist', 1),
              _navItem(Icons.shopping_cart_outlined, 'Cart', 2),
              _navItem(Icons.search, 'Search', 3),
              _navItem(Icons.settings_outlined, 'Setting', 4),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int index) {
    final isSelected = _currentIndex == index;
    return InkWell(
      onTap: () => setState(() => _currentIndex = index),
      borderRadius: BorderRadius.circular(24),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 24,
              color: isSelected ? const Color(0xFFE24A69) : Colors.grey,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? const Color(0xFFE24A69) : Colors.grey,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
