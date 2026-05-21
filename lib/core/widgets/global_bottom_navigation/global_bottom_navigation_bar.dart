import 'dart:ui';
import 'package:buildmatch_mobile/core/theme/app_colors.dart';
import 'package:buildmatch_mobile/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import '../../utils/screen_size.dart';
import 'navigation_item.dart';
import 'navigation_menu_config.dart';

class GlobalBottomNavigationBar extends StatefulWidget {
  final List<NavigationItem> items;
  final int currentIndex;
  final Function(int) onTap;
  final UserRole role;

  const GlobalBottomNavigationBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    required this.role,
  });

  @override
  State<GlobalBottomNavigationBar> createState() => _GlobalBottomNavigationBarState();
}

class _GlobalBottomNavigationBarState extends State<GlobalBottomNavigationBar> {
  double? _previousActiveX;

  Color _getActiveColor() {
    switch (widget.role) {
      case UserRole.client:
        return AppColors.primary;
      case UserRole.contractor:
        return AppColors.contractorPrimary;
      case UserRole.architect:
        return AppColors.architectPrimary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final activeColor = _getActiveColor();
    final double screenWidth = context.screenWidth;
    final double safeAreaBottom = MediaQuery.of(context).padding.bottom;
    
    // Layout measurements
    const double barHeight = 74.0;
    final double itemWidth = screenWidth / widget.items.length;

    // Calculate activeX for the curve center
    final double targetActiveX = (widget.currentIndex + 0.5) * itemWidth;
    
    final double startActiveX = _previousActiveX ?? targetActiveX;
    // Update previous activeX for the next render
    _previousActiveX = targetActiveX;

    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: MetaData(
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: screenWidth,
          height: barHeight + safeAreaBottom,
          color: Colors.transparent,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // 1. Sliding Curved Background using CustomPainter & TweenAnimationBuilder
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: startActiveX, end: targetActiveX),
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeOutCubic,
                builder: (context, activeX, child) {
                  return CustomPaint(
                    size: Size(screenWidth, barHeight + safeAreaBottom),
                    painter: CurvedNavBarPainter(
                      activeX: activeX,
                      shadowColor: Colors.black.withOpacity(0.06),
                      borderColor: Colors.black.withOpacity(0.04),
                      currentIndex: widget.currentIndex,
                      itemCount: widget.items.length,
                    ),
                  );
                },
              ),

              // 2. Sliding Solid Active Circle matching activeX
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: startActiveX, end: targetActiveX),
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeOutCubic,
                builder: (context, activeX, child) {
                  const double circleSize = 52.0;
                  return Positioned(
                    left: activeX - (circleSize / 2),
                    top: -12.0, // Placed beautifully inside the hump
                    child: Container(
                      width: circleSize,
                      height: circleSize,
                      decoration: BoxDecoration(
                        color: activeColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                },
              ),

              // 3. Row of Interactive Tab Items
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                height: barHeight,
                child: Row(
                  children: List.generate(widget.items.length, (index) {
                    final item = widget.items[index];
                    final isSelected = index == widget.currentIndex;

                    return Expanded(
                      child: GestureDetector(
                        onTap: () => widget.onTap(index),
                        behavior: HitTestBehavior.opaque,
                        child: SizedBox(
                          height: barHeight,
                          child: Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.center,
                            children: [
                              // Smooth vertical translation for Active Icon
                              AnimatedPositioned(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeOutCubic,
                                top: isSelected ? 2.0 : 16.0,
                                child: AnimatedScale(
                                  duration: const Duration(milliseconds: 250),
                                  scale: isSelected ? 1.05 : 1.0,
                                  child: Icon(
                                    isSelected ? item.activeIcon : item.icon,
                                    color: isSelected ? Colors.white : const Color(0xFF7E7E7E),
                                    size: 24.0,
                                  ),
                                ),
                              ),

                              // Static vertical position for text labels to align them perfectly
                              Positioned(
                                bottom: 8.0,
                                child: AnimatedDefaultTextStyle(
                                  duration: const Duration(milliseconds: 200),
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: isSelected ? activeColor : AppColors.textSecondaryDark,
                                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                                    fontSize: 12.0,
                                  ),
                                  child: Text(item.label),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CurvedNavBarPainter extends CustomPainter {
  final double activeX;
  final Color shadowColor;
  final Color borderColor;
  final int currentIndex;
  final int itemCount;

  CurvedNavBarPainter({
    required this.activeX,
    required this.shadowColor,
    required this.borderColor,
    required this.currentIndex,
    required this.itemCount,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final Paint borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // Bezier Curve hump parameters
    const double humpWidth = 84.0;
    const double humpDepth = 26.0; // depth of the curve going up
    const double cornerRadius = 32.0;

    // Corner radius: remove corner if active tab is at the edge
    final bool isFirst = currentIndex == 0;
    final bool isLast = currentIndex == itemCount - 1;

    // 1. Base nav bar shape (rounded rectangle)
    final Path baseRectPath = Path()
      ..addRRect(RRect.fromRectAndCorners(
        Rect.fromLTWH(0, 0, size.width, size.height),
        topLeft: isFirst ? Radius.zero : const Radius.circular(cornerRadius),
        topRight: isLast ? Radius.zero : const Radius.circular(cornerRadius),
      ));

    // 2. The dynamic hump path
    final double startHump = activeX - humpWidth / 2 - 12.0;
    final double endHump = activeX + humpWidth / 2 + 12.0;

    final Path humpPath = Path();
    // Start slightly below y=0 to ensure solid union without artifacts
    humpPath.moveTo(startHump, 10);
    humpPath.lineTo(startHump, 0);
    
    // Dynamic rising curve
    humpPath.cubicTo(
      activeX - humpWidth / 2 + 2.0, 0,
      activeX - humpWidth / 3 - 2.0, -humpDepth,
      activeX, -humpDepth,
    );
    // Dynamic descending curve
    humpPath.cubicTo(
      activeX + humpWidth / 3 + 2.0, -humpDepth,
      activeX + humpWidth / 2 - 2.0, 0,
      endHump, 0,
    );
    
    // End slightly below y=0
    humpPath.lineTo(endHump, 10);
    humpPath.close();

    // 3. Union the base rectangle and the hump
    // This perfectly handles edges: if the hump exceeds the left/right bounds,
    // the union organically merges it with the rounded corners, creating a seamless cutoff!
    Path finalPath = Path.combine(PathOperation.union, baseRectPath, humpPath);

    // Draw main white body
    canvas.drawPath(finalPath, paint);

    // Draw subtle border stroke
    canvas.drawPath(finalPath, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CurvedNavBarPainter oldDelegate) {
    return oldDelegate.activeX != activeX ||
        oldDelegate.shadowColor != shadowColor ||
        oldDelegate.borderColor != borderColor ||
        oldDelegate.currentIndex != currentIndex ||
        oldDelegate.itemCount != itemCount;
  }
}
