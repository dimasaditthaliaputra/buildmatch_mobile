import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/utils/screen_size.dart';
import '../../../../core/widgets/global_card.dart';

class ProyekInfoCard extends StatelessWidget {
  final String namaProyek;
  final double budgetMin;
  final double budgetMax;
  final DateTime batasWaktu;
  final String deskripsi;
  final bool isAktif;

  const ProyekInfoCard({
    super.key,
    required this.namaProyek,
    required this.budgetMin,
    required this.budgetMax,
    required this.batasWaktu,
    required this.deskripsi,
    this.isAktif = true,
  });

  String _formatBudget(double value) {
    if (value >= 1000000000) {
      return '${(value / 1000000000).toStringAsFixed(0)}M';
    } else if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(0)}jt';
    }
    return NumberFormat.compact(locale: 'id_ID').format(value);
  }

  @override
  Widget build(BuildContext context) {
    return GlobalCard(
      width: context.screenWidth,
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      backgroundColor: AppColors.surface,
      borderRadius: 14.0,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.07),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isAktif)
            Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 5,
                ),
                decoration: const BoxDecoration(
                  color: AppColors.primaryDark,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(14),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                child: Text(
                  'PROYEK AKTIF',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.textLight,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                    fontSize: 10,
                  ),
                ),
              ),
            ),

          Padding(
            padding: const EdgeInsets.fromLTRB(22, 10, 22, 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  namaProyek,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 10),

                Row(
                  children: [
                    _buildInfoChip(
                      icon: Icons.monetization_on_outlined,
                      label:
                          'Rp ${_formatBudget(budgetMin)} - ${_formatBudget(budgetMax)}',
                      iconColor: AppColors.primaryDark,
                      sublabel: 'Budget klien',
                    ),
                    const SizedBox(width: 16),
                    _buildInfoChip(
                      icon: Icons.calendar_month_outlined,
                      label: DateFormatter.formatDate(batasWaktu),
                      iconColor: AppColors.primaryDark,
                      sublabel: 'Batas Waktu klien',
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                Text(
                  deskripsi,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondaryDark,
                    height: 1.5,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String label,
    required String sublabel,
    required Color iconColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: AppColors.surfaceCream,
            borderRadius: BorderRadius.circular(6), 
          ),
          child: Icon(icon, size: 18, color: iconColor),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.textOrangeDark,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
            Text(
              sublabel,
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.textMid,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ],
    );
  }
}