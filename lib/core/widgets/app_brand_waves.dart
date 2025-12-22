import 'package:flutter/material.dart';
import 'package:event_app/core/theme/app_colors.dart';

class AppHeaderWave extends StatelessWidget {
  final double height;
  final Widget? overlay;
  const AppHeaderWave({super.key, this.height = 200, this.overlay});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipPath(
              clipper: _TopWaveClipper(),
              clipBehavior: Clip.hardEdge,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: AppColors.primaryGradient,
                ),
              ),
            ),
          ),
          if (overlay != null) overlay!,
        ],
      ),
    );
  }
}

class AppFooterWave extends StatelessWidget {
  final double height;
  const AppFooterWave({super.key, this.height = 120});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: SizedBox(
        height: height,
        child: ClipPath(
          clipper: _BottomWaveClipper(),
          clipBehavior: Clip.hardEdge,
          child: Container(
            decoration: const BoxDecoration(
              gradient: AppColors.primaryGradient,
            ),
          ),
        ),
      ),
    );
  }
}

// --- Decorative clippers for header/footer waves ---
class _TopWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height * 0.70);
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.85,
      size.width * 0.5,
      size.height * 0.80,
    );
    path.quadraticBezierTo(
      size.width * 0.8,
      size.height * 0.72,
      size.width,
      size.height * 0.88,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class _BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height * 0.35);
    path.quadraticBezierTo(
      size.width * 0.2,
      size.height * 0.10,
      size.width * 0.45,
      size.height * 0.18,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.30,
      size.width,
      size.height * 0.12,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
