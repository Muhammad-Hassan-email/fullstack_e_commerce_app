import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:e_commerce_app/routes/routernames.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        context.go(RouteNames.onboarding);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: const [
              _StylishLogo(size: 56),
              SizedBox(width: 12),
              Text(
                'Stylish',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE24A69),
                  fontFamily: 'Georgia',
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Custom painter for the Stylish logo - two interlocking curved shapes
/// with pink-red and blue gradients forming an S-like infinity symbol.
class _StylishLogo extends StatelessWidget {
  const _StylishLogo({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _StylishLogoPainter(),
      ),
    );
  }
}

class _StylishLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.4;

    // Left C-shape (pinkish-red to coral gradient) - curves right
    final pinkGradient = LinearGradient(
      colors: [
        const Color(0xFFE24A69),
        const Color(0xFFF08A9E),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    // Right C-shape (light blue to deeper blue gradient) - curves left
    final blueGradient = LinearGradient(
      colors: [
        const Color(0xFF6BA3E8),
        const Color(0xFF4A83E2),
      ],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
    );

    const pi = 3.14159265359;
    final strokeWidth = size.width * 0.14;
    final rect = Rect.fromCircle(center: center, radius: radius);
    final arcRect = Rect.fromCenter(
      center: center,
      width: radius * 2,
      height: radius * 2,
    );

    // Pink/red C-shape - upper curve of S (from top-left to bottom-right)
    final leftPath = Path()
      ..addArc(arcRect, 1.25 * pi, pi);

    final leftPaint = Paint()
      ..shader = pinkGradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(leftPath, leftPaint);

    // Blue C-shape - lower curve of S (from bottom-right to top-left)
    final rightPath = Path()
      ..addArc(arcRect, 0.25 * pi, pi);

    final rightPaint = Paint()
      ..shader = blueGradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(rightPath, rightPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}