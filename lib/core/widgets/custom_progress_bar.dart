import 'package:flutter/material.dart';
import '../theme/app_colors.dart';


class CustomProgressBar extends StatelessWidget {
  final double percent;

  const CustomProgressBar({super.key, required this.percent});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: LinearProgressIndicator(
        value: percent,
        backgroundColor: AppColors.primary.withOpacity(0.25),
        valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
        minHeight: 8,
      ),
    );
  }
}