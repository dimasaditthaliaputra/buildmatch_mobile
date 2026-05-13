import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class CustomBadge extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final Color borderColor;
  final double fontSize;
  final EdgeInsetsGeometry padding;

  const CustomBadge({
    super.key,
    required this.text,
    required this.textColor,
    required this.backgroundColor,
    required this.borderColor,
    this.fontSize = 10,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: borderColor, width: 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text.toUpperCase(),
        style: AppTextStyles.labelSmall.copyWith(
          color: textColor,
          fontSize: fontSize,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class StatusBadge extends StatelessWidget {
  final String status;

  const StatusBadge({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;
    Color borderColor;

    switch (status.toUpperCase()) {
      case 'AKTIF':
        textColor = AppColors.success;
        bgColor = AppColors.successBackground;
        borderColor = AppColors.success.withOpacity(0.3);
        break;
      case 'REVIEW':
        textColor = AppColors.textMid;
        bgColor = AppColors.surfaceCream;
        borderColor = AppColors.primaryLight.withOpacity(0.5);
        break;
      case 'PENDING':
        textColor = AppColors.textSecondary;
        bgColor = AppColors.surfacePale;
        borderColor = AppColors.border;
        break;
      default:
        textColor = AppColors.primary;
        bgColor = AppColors.surfacePale;
        borderColor = AppColors.primaryLight.withOpacity(0.4);
    }

    return CustomBadge(
      text: status,
      textColor: textColor,
      backgroundColor: bgColor,
      borderColor: borderColor,
    );
  }
}