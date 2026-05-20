import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/client_project_entity.dart';

class ClientProjectCard extends StatelessWidget {
  final ClientProjectEntity project;
  final VoidCallback? onDetailTap;

  const ClientProjectCard({
    super.key,
    required this.project,
    this.onDetailTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowDark.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title + Status Badge
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    project.name,
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                _StatusBadge(status: project.status),
              ],
            ),
            const SizedBox(height: 4),

            // Location
            Row(
              children: [
                Icon(Icons.location_on_rounded,
                    size: 13, color: AppColors.textSecondaryDark),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    project.location,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondaryDark,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),

            // Progress bar (only for non-waiting projects)
            if (!project.isWaiting) ...[
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    project.phase,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondaryDark,
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    '${(project.progressPercent * 100).toInt()}%',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: _progressColor(project.status),
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: project.progressPercent,
                  minHeight: 6,
                  backgroundColor: AppColors.primaryLightGrey,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      _progressColor(project.status)),
                ),
              ),
            ],

            const SizedBox(height: 14),
            Divider(color: AppColors.border, height: 1),
            const SizedBox(height: 14),

            // Meta info row
            Row(
              children: [
                _MetaColumn(
                  label: project.isDone ? 'SELESAI PADA' : 'MULAI',
                  value: project.isDone
                      ? (project.endDate ?? project.startDate)
                      : project.startDate,
                  valueColor: AppColors.textPrimary,
                ),
                const SizedBox(width: 24),
                _MetaColumn(
                  label: project.professionalType,
                  value: project.professionalName ?? 'Belum Ditentukan',
                  valueColor: project.professionalName != null
                      ? AppColors.primary
                      : AppColors.textSecondaryDark,
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Action button
            SizedBox(
              width: double.infinity,
              child: _buildActionButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton() {
    final isPenawaran = project.isWaiting;
    final isDone = project.isDone;

    return OutlinedButton(
      onPressed: onDetailTap,
      style: OutlinedButton.styleFrom(
        backgroundColor:
            isDone ? AppColors.primaryDarkGreen : (isPenawaran ? null : AppColors.primary),
        side: BorderSide(
          color: isPenawaran ? AppColors.primaryBlue : Colors.transparent,
          width: isPenawaran ? 1.5 : 0,
        ),
        padding: const EdgeInsets.symmetric(vertical: 13),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        isPenawaran ? 'Lihat Penawaran' : 'Lihat Detail Proyek',
        style: AppTextStyles.button.copyWith(
          color: isPenawaran ? AppColors.primaryBlue : AppColors.textLight,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    );
  }

  Color _progressColor(String status) {
    switch (status) {
      case 'BERJALAN':
        return AppColors.primary;
      case 'REVIEW':
        return AppColors.primaryBlue;
      case 'SELESAI':
        return AppColors.primaryLightGreen;
      default:
        return AppColors.primaryGrey;
    }
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final config = _badgeConfig(status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: config['bg'] as Color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: AppTextStyles.labelSmall.copyWith(
          color: config['text'] as Color,
          fontWeight: FontWeight.w700,
          fontSize: 10,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Map<String, Color> _badgeConfig(String status) {
    switch (status) {
      case 'BERJALAN':
        return {'bg': const Color(0xFFE3F2FD), 'text': const Color(0xFF1565C0)};
      case 'REVIEW':
        return {'bg': const Color(0xFFF3E5F5), 'text': const Color(0xFF7B1FA2)};
      case 'SELESAI':
        return {'bg': AppColors.successBackground, 'text': AppColors.success};
      case 'MENUNGGU':
      default:
        return {'bg': const Color(0xFFFFF8E1), 'text': const Color(0xFFF57F17)};
    }
  }
}

class _MetaColumn extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;

  const _MetaColumn({
    required this.label,
    required this.value,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.labelSmall.copyWith(
            color: AppColors.primaryGrey,
            fontSize: 10,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: AppTextStyles.bodySmall.copyWith(
            color: valueColor,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
