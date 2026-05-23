import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/utils/screen_size.dart';

class EmptyProjectState extends StatelessWidget {
  final bool isSelesai;

  const EmptyProjectState({
    super.key,
    this.isSelesai = false,
  });

  @override
  Widget build(BuildContext context) {
    final double iconSize = context.widthPct(0.3).clamp(100.0, 150.0);
    final double spacing = context.heightPct(0.03).clamp(16.0, 32.0);
    final double titleSize = context.widthPct(0.05).clamp(18.0, 24.0);
    final double subTitleSize = context.widthPct(0.035).clamp(12.0, 16.0);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.folder_off_outlined,
            size: iconSize,
            color: AppColors.primaryLightGrey,
          ),
          
          SizedBox(height: spacing),
          
          Text(
            isSelesai ? 'Belum Ada Proyek Selesai' : 'Belum Ada Proyek',
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w700, 
              color: AppColors.textPrimary,
              fontSize: titleSize,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            isSelesai
                ? 'Proyek Anda yang sudah selesai\nakan muncul di sini.'
                : 'Proyek yang Anda terima\nakan muncul di sini.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondaryDark,
              height: 1.5,
              fontWeight: FontWeight.w400,
              fontSize: subTitleSize, 
            ),
          ),
        ],
      ),
    );
  }
}