import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CustomProgressBar extends StatelessWidget {
  final double percent;
  final double? width;
  final double height;
  final Color? backgroundColor;
  final Color? progressColor;
  final double borderRadius;
  final BoxBorder? border;
  final List<BoxShadow>? boxShadow;

  const CustomProgressBar({
    super.key,
    required this.percent,
    this.width,
    this.height = 8.0, 
    this.backgroundColor,
    this.progressColor,
    this.borderRadius = 12.0,
    this.border,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: border,
        boxShadow: boxShadow,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          border != null ? (borderRadius - 1) : borderRadius,
        ),
        child: LinearProgressIndicator(
          value: percent,
          backgroundColor: backgroundColor ?? AppColors.primary.withOpacity(0.25),
          valueColor: AlwaysStoppedAnimation<Color>(
            progressColor ?? AppColors.primary,
          ),
          minHeight: height,
        ),
      ),
    );
  }
}