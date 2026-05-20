import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/global_card.dart';
import '../../../../core/widgets/badge_widget.dart';

class ClientActionCardsWidget extends StatelessWidget {
  final VoidCallback? onDesainBaru;
  final VoidCallback? onCariKontraktor;
  final VoidCallback? onListPenawaran;
  final VoidCallback? onProyekBerjalan;

  const ClientActionCardsWidget({
    super.key,
    this.onDesainBaru,
    this.onCariKontraktor,
    this.onListPenawaran,
    this.onProyekBerjalan,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Parent Card Putih menggunakan GlobalCard
          GlobalCard(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            borderRadius: 24,
            margin: EdgeInsets.zero,
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowDark.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
            child: Column(
              children: [
                _buildMainActionCard(
                  tag: 'Butuh Desain',
                  title: 'Mulai Desain Baru',
                  subtitle: 'Konsultasi sekarang',
                  onTap: onDesainBaru,
                  isPrimary: true,
                ),
                const SizedBox(height: 12),
                _buildMainActionCard(
                  tag: 'Sudah Punya Desain',
                  title: 'Cari Kontraktor',
                  subtitle: 'Lihat Rekomendasi',
                  onTap: onCariKontraktor,
                  isPrimary: false,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Bottom two small shortcut cards menggunakan GlobalCard
          Row(
            children: [
              Expanded(
                child: _buildShortcutCard(
                  label: 'Lihat List\nPenawaran',
                  onTap: onListPenawaran,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildShortcutCard(
                  label: 'Lihat List Proyek Yang\nSedang Berjalan',
                  onTap: onProyekBerjalan,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMainActionCard({
    required String tag,
    required String title,
    required String subtitle,
    required bool isPrimary,
    VoidCallback? onTap,
  }) {
    return GlobalCard(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      backgroundColor: isPrimary ? AppColors.primary : AppColors.surfaceSoft,
      borderRadius: 20,
      margin: EdgeInsets.zero,
      boxShadow: const [], // Flat color di dalam parent card
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tag Badge menggunakan BadgeWidget global
          BadgeWidget(
            text: tag,
            textColor: isPrimary ? AppColors.textLight : AppColors.textBrown,
            backgroundColor: isPrimary ? AppColors.primaryMedium : AppColors.surfaceUltraLightBeige,
            borderColor: Colors.transparent,
            fontSize: 10,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          ),
          const SizedBox(height: 12),
          // Title
          Text(
            title,
            style: AppTextStyles.heading2.copyWith(
              color: isPrimary ? AppColors.textLight : AppColors.textBrown,
              fontWeight: FontWeight.w800,
              fontSize: 24,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 16),
          // Horizontal Divider Line
          Container(
            height: 1,
            width: double.infinity,
            color: isPrimary
                ? AppColors.textLight.withOpacity(0.2)
                : AppColors.textBrown.withOpacity(0.15),
          ),
          const SizedBox(height: 16),
          // Subtitle with Arrow Icon
          Row(
            children: [
              Expanded(
                child: Text(
                  subtitle,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: isPrimary
                        ? AppColors.textLight.withOpacity(0.9)
                        : AppColors.textBrown,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_rounded,
                size: 16,
                color: isPrimary ? AppColors.textLight : AppColors.textBrown,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildShortcutCard({
    required String label,
    VoidCallback? onTap,
  }) {
    return GlobalCard(
      height: 105,
      padding: const EdgeInsets.all(14),
      margin: EdgeInsets.zero,
      backgroundColor: AppColors.surfacePale,
      borderRadius: 16,
      boxShadow: const [], // flat border style
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary,
              ),
              child: const Icon(
                Icons.arrow_forward_rounded,
                color: AppColors.textLight,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
