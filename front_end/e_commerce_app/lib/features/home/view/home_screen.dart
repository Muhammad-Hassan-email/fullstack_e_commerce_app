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
                context.push(RouteNames.profile);
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
                          'type': ProductType.featured.name,
                        },
                      );
                    },
                    height: 120,
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
                          'type': ProductType.featured.name,
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
                          'type': ProductType.trending.name,
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
                          'type': ProductType.featured.name,
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  //_buildNewArrivals(),
                  const SizedBox(height: 20),
                  PromoImageBanner(
                    assetPath: 'assets/banner_1.jpg',
                    onTap: () {
                      context.push(
                        RouteNames.plistscrn,
                        extra: {
                          'title': "Special Offers",
                          'type': "featured", // pass category/type
                        },
                      );
                    },
                    height: 120,
                  ),
                  const SizedBox(height: 100),
                  ElevatedButton(
                    onPressed: () {
                      context.push(
                        RouteNames.plistscrn,
                        extra: {'title': "Test Products", 'type': "all"},
                      );
                    },
                    child: const Text("Go to ProductScreen"),
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
