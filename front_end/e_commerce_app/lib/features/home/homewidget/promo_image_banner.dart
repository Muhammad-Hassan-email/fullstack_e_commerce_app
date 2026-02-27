// import 'package:flutter/material.dart';

// class PromoImageBanner extends StatelessWidget {
//   final String title;
//   final String assetPath;
//   final VoidCallback? onTap;
//   final double height;
//   final EdgeInsetsGeometry margin;
//   final BorderRadius borderRadius;
//   final BoxFit fit;

//   const PromoImageBanner({
//     super.key,
//     required this.assetPath,
//     required this.title,
//     this.onTap,
//     this.height = 160,
//     this.margin = const EdgeInsets.symmetric(horizontal: 16),
//     this.borderRadius = const BorderRadius.all(Radius.circular(16)),
//     this.fit = BoxFit.cover,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: margin,
//       child: ClipRRect(
//         borderRadius: borderRadius,
//         child: Material(
//           color: Colors.transparent,
//           child: InkWell(
//             onTap: onTap,
//             child: Ink.image(
//               image: AssetImage(assetPath),
//               height: height,
//               width: double.infinity,
//               fit: fit,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class PromoImageBanner extends StatelessWidget {
  final String? title;
  final String assetPath;
  final double height;
  final VoidCallback onTap;

  const PromoImageBanner({
    super.key,
    this.title,
    required this.assetPath,
    required this.height,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // The image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              assetPath,
              height: height,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8), // space between image and title
          // The title below the image
          if (title != null) ...[
            const SizedBox(height: 8), // space between image and title
            Text(
              title!,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ],
      ),
    );
  }
}