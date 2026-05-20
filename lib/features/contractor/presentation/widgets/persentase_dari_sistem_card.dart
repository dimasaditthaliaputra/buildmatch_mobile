import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_progress_bar.dart';
import '../../../../core/widgets/global_card.dart';
import '../../../../core/widgets/badge_widget.dart';
import '../../../../core/utils/screen_size.dart';

class PersentaseDariSistemCard extends StatelessWidget {
  final double persentase;

  const PersentaseDariSistemCard({super.key, required this.persentase});

  @override
  Widget build(BuildContext context) {
    final persen = (persentase * 100).toStringAsFixed(0);
    final double cardPadding = context.widthPct(0.05).clamp(16.0, 24.0);
    final double fontSizeBig = context.widthPct(0.09).clamp(30.0, 42.0);
    
    return GlobalCard(
      width: double.infinity,
      padding: EdgeInsets.all(cardPadding), 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'PERSENTASE PEKERJAAN',
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.primary,
              letterSpacing: 0.5,
              fontWeight: FontWeight.w600, 
              fontSize: 14,
            ),
          ),
          SizedBox(height: context.heightPct(0.01).clamp(6.0, 10.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '$persen%',
                style: AppTextStyles.heading1.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: fontSizeBig,
                ),
              ),
              BadgeWidget(
                text: 'OTOMATIS',
                textColor: AppColors.success, 
                backgroundColor: AppColors.success.withOpacity(0.12), 
                borderColor: AppColors.success.withOpacity(0.4)
              ),
            ],
          ),
          SizedBox(height: context.heightPct(0.02).clamp(12.0, 20.0)),
          CustomProgressBar(
            percent: persentase,
            height: context.heightPct(0.012).clamp(8.0, 12.0), 
            backgroundColor: AppColors.primary.withOpacity(0.12), 
            progressColor: AppColors.primary,
            borderRadius: 20.0,
          ),
          SizedBox(height: context.heightPct(0.025).clamp(16.0, 24.0)),
          _InfoBox(),
        ],
      ),
    );
  }
}

class _InfoBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Icon(
              Icons.info_outline_rounded,
              size: 20, 
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Nilai persentase ini dikunci oleh sistem berdasarkan laporan verifikasi lapangan terakhir oleh Tim Pengawas.',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.primary,
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}