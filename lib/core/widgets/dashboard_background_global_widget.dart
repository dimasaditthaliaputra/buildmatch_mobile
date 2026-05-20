import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../utils/screen_size.dart';

class DashboardBackgroundGlobalWidget extends StatelessWidget {
  final double? heightPct;
  final double minHeight;

  const DashboardBackgroundGlobalWidget({
    super.key,
    this.heightPct = 0.32,
    this.minHeight = 260.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: math.max(context.heightPct(heightPct!), minHeight),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(32),
        ),
      ),
    );
  }
}
