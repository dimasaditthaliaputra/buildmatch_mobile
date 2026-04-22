import 'package:buildmatch_mobile/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class GlobalBackground extends StatelessWidget {
  final bool showSecondaryDecoration;
  final Widget child;

  const GlobalBackground({
    super.key,
    this.showSecondaryDecoration = false,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Top Right Circle
        AnimatedPositioned(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          top: -70,
          right: -80,
          child: Container(
            width: 200,
            height: 200,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary,
            ),
          ),
        ),

        // Bottom Left Circle
        AnimatedPositioned(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          bottom: -120,
          left: showSecondaryDecoration ? -50 : -150,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            width: showSecondaryDecoration ? 200 : 300,
            height: showSecondaryDecoration ? 200 : 300,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary,
            ),
          ),
        ),

        // Bottom Right Circle
        AnimatedPositioned(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          bottom: showSecondaryDecoration ? -100 : -200,
          right: showSecondaryDecoration ? -50 : -150,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity: showSecondaryDecoration ? 1.0 : 0.0,
            child: Container(
              width: 300,
              height: 300,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary,
              ),
            ),
          ),
        ),

        // Content
        child,
      ],
    );
  }
}
