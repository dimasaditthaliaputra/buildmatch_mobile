import 'package:buildmatch_mobile/core/theme/app_colors.dart';
import 'package:buildmatch_mobile/core/theme/app_text_styles.dart';
import 'package:buildmatch_mobile/core/utils/screen_size.dart';
import 'package:flutter/material.dart';


class TotalAlokasiWidget extends StatelessWidget {
  final double percentage;

  const TotalAlokasiWidget({
    super.key,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    final String displayValue = "${(percentage * 100).toStringAsFixed(0)}%";
    final double padHorizontal = context.widthPct(0.04).clamp(12.0, 16.0);
    final double padVertical = context.heightPct(0.015).clamp(10.0, 14.0);
    final double fontSizeBig = context.widthPct(0.055).clamp(20.0, 26.0);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: padHorizontal, vertical: padVertical),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.primaryUltraLightGrey,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total Alokasi:',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            displayValue,
            style: AppTextStyles.heading3.copyWith(
              color: AppColors.success,
              fontWeight: FontWeight.w800,
              fontSize: fontSizeBig,
            ),
          ),
        ],
      ),
    );
  }
}