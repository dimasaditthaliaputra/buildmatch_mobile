import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class InfoColumnText extends StatelessWidget {
  final String label;
  final String value;
  final CrossAxisAlignment alignment;
  final double labelSize;
  final double valueSize;
  final bool isValueTop;

  const InfoColumnText({
    super.key,
    required this.label,
    required this.value,
    this.alignment = CrossAxisAlignment.start,
    this.labelSize = 11, 
    this.valueSize = 13,
    this.isValueTop = false,
  });

  @override
  Widget build(BuildContext context) {
    final labelWidget = Text(
      label,
      style: AppTextStyles.labelSmall.copyWith(
        color: AppColors.primaryDark, 
        fontSize: labelSize,
        fontWeight: FontWeight.w700,
      ),
    );

    final valueWidget = Text(
      value,
      style: AppTextStyles.bodySmall.copyWith(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w700,
        fontSize: valueSize,
      ),
    );

    return Container(
      width: double.infinity, 
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.06), 
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.15), 
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: alignment,
        mainAxisSize: MainAxisSize.min,
        children: [
          isValueTop ? valueWidget : labelWidget,
          const SizedBox(height: 6),
          isValueTop ? labelWidget : valueWidget,
        ],
      ),
    );
  }
}