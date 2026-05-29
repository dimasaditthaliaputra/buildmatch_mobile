import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Komponen Skeleton Global yang reusable dan adaptif.
/// Gunakan named constructors seperti `.text`, `.avatar`, atau `.card` untuk layout instan.
class GlobalSkeleton extends StatefulWidget {
  final double? width;
  final double? height;
  final double borderRadius;
  final BoxShape shape;
  final Widget? child;

  const GlobalSkeleton({
    super.key,
    this.width,
    this.height,
    this.borderRadius = 8.0,
    this.shape = BoxShape.rectangle,
    this.child,
  });

  /// Helper untuk merender Skeleton berbentuk Text Line
  factory GlobalSkeleton.text({
    double width = double.infinity,
    double height = 16.0,
    double borderRadius = 4.0,
  }) {
    return GlobalSkeleton(
      width: width,
      height: height,
      borderRadius: borderRadius,
    );
  }

  /// Helper untuk merender Skeleton berbentuk Avatar/Circle
  factory GlobalSkeleton.avatar({double size = 48.0}) {
    return GlobalSkeleton(
      width: size,
      height: size,
      shape: BoxShape.circle,
    );
  }

  /// Helper untuk merender Skeleton berbentuk Card
  factory GlobalSkeleton.card({
    double width = double.infinity,
    double height = 120.0,
    double borderRadius = 16.0,
  }) {
    return GlobalSkeleton(
      width: width,
      height: height,
      borderRadius: borderRadius,
    );
  }

  @override
  State<GlobalSkeleton> createState() => _GlobalSkeletonState();
}

class _GlobalSkeletonState extends State<GlobalSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
    
    // Animasi bergerak dari kiri ke kanan melintasi ukuran container
    _animation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            return LinearGradient(
              colors: [
                AppColors.primaryLightGrey,
                AppColors.primaryUltraLightGrey,
                AppColors.primaryLightGrey,
              ],
              stops: const [0.1, 0.5, 0.9],
              begin: Alignment(_animation.value - 1, 0),
              end: Alignment(_animation.value + 1, 0),
            ).createShader(bounds);
          },
          child: child!,
        );
      },
      child: widget.child ??
          Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: Colors.white, // Warna dasar yang akan ditimpa gradient
              shape: widget.shape,
              borderRadius: widget.shape == BoxShape.circle
                  ? null
                  : BorderRadius.circular(widget.borderRadius),
            ),
          ),
    );
  }
}
