// import 'package:flutter/material.dart';

// class PromoBannerWidget extends StatelessWidget {
//   final VoidCallback? onShopNow;

//   const PromoBannerWidget({
//     super.key,
//     this.onShopNow,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Container(
//         height: 160,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               const Color(0xFFE24A69),
//               const Color(0xFFE24A69).withOpacity(0.85),
//             ],
//             begin: Alignment.centerLeft,
//             end: Alignment.centerRight,
//           ),
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Row(
//           children: [

//             /// LEFT CONTENT
//             Expanded(
//               flex: 3,
//               child: Padding(
//                 padding: const EdgeInsets.all(18),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [

//                     const Text(
//                       '50-40% OFF',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),

//                     const SizedBox(height: 4),

//                     const Text(
//                       'New in product!',
//                       style: TextStyle(
//                         color: Colors.white70,
//                         fontSize: 13,
//                       ),
//                     ),

//                     const Text(
//                       'All colours',
//                       style: TextStyle(
//                         color: Colors.white70,
//                         fontSize: 13,
//                       ),
//                     ),

//                     const SizedBox(height: 8),

//                     /// Responsive Button
//                     FittedBox(
//                       child: TextButton.icon(
//                         onPressed: onShopNow,
//                         style: TextButton.styleFrom(
//                           backgroundColor: Colors.white,
//                           foregroundColor: const Color(0xFFE24A69),
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 12,
//                             vertical: 6,
//                           ),
//                           minimumSize: Size.zero,
//                           tapTargetSize:
//                               MaterialTapTargetSize.shrinkWrap,
//                         ),
//                         icon: const Icon(Icons.arrow_forward, size: 14),
//                         label: const Text(
//                           'Shop Now',
//                           style: TextStyle(fontSize: 13),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             /// RIGHT ICON
//             Expanded(
//               flex: 2,
//               child: Center(
//                 child: Icon(
//                   Icons.shopping_bag_outlined,
//                   size: 70,
//                   color: Colors.white.withOpacity(0.25),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class PromoBannerWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? description;

  final List<Color>? gradientColors; // Optional gradient
  final Color? backgroundColor; // Optional solid color

  final IconData icon;
  final String buttonText;
  final VoidCallback? onTap;

  const PromoBannerWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.description,
    this.gradientColors,
    this.backgroundColor,
    required this.icon,
    this.buttonText = "Shop Now",
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          gradient: gradientColors != null
              ? LinearGradient(
                  colors: gradientColors!,
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
              : null,
          color: gradientColors == null
              ? backgroundColor ?? Colors.grey.shade200
              : null,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [

            /// LEFT CONTENT
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    /// TITLE
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 4),

                    /// SUBTITLE
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.white70,
                      ),
                    ),

                    if (description != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        description!,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.white70,
                        ),
                      ),
                    ],

                    const SizedBox(height: 10),

                    /// BUTTON (Optional)
                    if (onTap != null)
                      FittedBox(
                        child: TextButton.icon(
                          onPressed: onTap,
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 6,
                            ),
                            minimumSize: Size.zero,
                            tapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          ),
                          icon: const Icon(Icons.arrow_forward, size: 14),
                          label: Text(
                            buttonText,
                            style: const TextStyle(fontSize: 13),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            /// RIGHT ICON
            Expanded(
              flex: 2,
              child: Center(
                child: Icon(
                  icon,
                  size: 70,
                  color: Colors.white.withOpacity(0.25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}