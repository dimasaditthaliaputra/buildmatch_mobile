import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class GlobalCard extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  
  final double borderRadius;
  final List<BoxShadow>? boxShadow;
  
  final VoidCallback? onTap;
  final VoidCallback? onDoubleTap; 
  final VoidCallback? onLongPress;

  const GlobalCard({
    super.key,
    this.width = 358,
    this.height,
    required this.child,
    this.padding,
    this.margin,
    this.backgroundColor = AppColors.surface,
    this.borderRadius = 16.0, 
    this.boxShadow,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      child: Container(
        width: width ?? double.infinity,
        height: height,
        margin: margin ?? const EdgeInsets.only(bottom: 16),
        padding: padding ?? const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor ?? Theme.of(context).cardColor,

          borderRadius: BorderRadius.circular(borderRadius),
          
          boxShadow: boxShadow ?? [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}