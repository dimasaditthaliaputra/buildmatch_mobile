import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';


class SectionHeader extends StatelessWidget {
  final String title;
  final String actionText;
  final VoidCallback? onActionTap;
  final Color? actionTextColor;
  final TextStyle? actionTextStyle;

  const SectionHeader({
    super.key,
    required this.title,
    this.actionText = 'LIHAT SEMUA',
    this.onActionTap,
    this.actionTextColor,
    this.actionTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: AppTextStyles.heading3.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w800,
            fontSize: 22,
          ),
        ),
        if (onActionTap != null)
          GestureDetector(
            onTap: onActionTap,
            child: Text(
              actionText,
              style: (actionTextStyle ?? AppTextStyles.labelSmall).copyWith(
                color: actionTextColor ?? AppColors.textPrimary,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }
}