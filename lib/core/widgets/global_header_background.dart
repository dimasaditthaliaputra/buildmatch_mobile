import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class GlobalHeaderBackground extends StatelessWidget {
  final double? height;
  final double curveHeight;
  final Widget? child;
  final EdgeInsetsGeometry? padding;

  const GlobalHeaderBackground({
    super.key,
    this.height,
    this.curveHeight = 48.0, // Used to control the smoothness/depth of the bottom arc
    this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _ArcClipper(curveHeight),
      child: Container(
        width: double.infinity,
        height: height,
        padding: padding,
        color: AppColors.primary,
        child: child,
      ),
    );
  }
}

class _ArcClipper extends CustomClipper<Path> {
  final double curveHeight;

  _ArcClipper(this.curveHeight);

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - curveHeight);
    path.quadraticBezierTo(
      size.width / 2,
      size.height + (curveHeight / 2),
      size.width,
      size.height - curveHeight,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant _ArcClipper oldClipper) =>
      oldClipper.curveHeight != curveHeight;
}
