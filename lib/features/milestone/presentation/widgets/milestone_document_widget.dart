import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/icon_widget.dart';
import '../../../../core/widgets/global_card.dart';
import '../../../../core/widgets/section_header.dart';

class MilestoneDocumentWidget extends StatelessWidget {
  const MilestoneDocumentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'Dokumen',
          actionText: 'Lihat Semua',
          actionTextColor: AppColors.primary,
          actionTextStyle: AppTextStyles.bodyMedium,
          onActionTap: () {},
        ),
        const SizedBox(height: 16),
        _buildDocumentItem('Kontrak', 'PDF • 2.4 MB', Icons.check_circle_outline),
        const SizedBox(height: 12),
        _buildDocumentItem('Invoice', 'PDF • 1.1 MB', Icons.shield_outlined),
      ],
    );
  }

  Widget _buildDocumentItem(String title, String subtitle, IconData icon) {
    return GlobalCard(
      width: null,
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      backgroundColor: AppColors.surface,
      borderRadius: 16.0,
      borderColor: AppColors.primaryLightGrey,
      borderWidth: 1,
      boxShadow: const [],
      child: Row(
        children: [
          IconWidget(
            icon: icon,
            backgroundColor: AppColors.primaryLightGrey.withOpacity(0.5),
            iconColor: AppColors.primaryBlue,
            size: 36,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  subtitle,
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ),
          const Icon(LucideIcons.download, color: AppColors.textPrimary, size: 24),
        ],
      ),
    );
  }
}
