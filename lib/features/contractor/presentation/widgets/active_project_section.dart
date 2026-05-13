import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/contractor_dashboard_entity.dart';

class ActiveProjectSection extends StatelessWidget {
  final List<ActiveProjectEntity> projects;
  final VoidCallback? onSeeAll;

  const ActiveProjectSection({
    super.key,
    required this.projects,
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(title: 'Proyek Aktif', onSeeAll: onSeeAll),
        const SizedBox(height: 16),
        ...projects.map(
          (project) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: ActiveProjectCard(project: project),
          ),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;

  const _SectionHeader({required this.title, this.onSeeAll});

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
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
        GestureDetector(
          onTap: onSeeAll,
          child: Text(
            'LIHAT SEMUA',
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.textPrimary,
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

class ActiveProjectCard extends StatelessWidget {
  final ActiveProjectEntity project;

  const ActiveProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImagePlaceholder(),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.name,
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      project.phase,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.primary,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              _buildStatusBadge(project.status),
            ],
          ),
          const SizedBox(height: 24),

          Text(
            '${project.progressPercent.toInt()}%',
            style: AppTextStyles.heading3.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 8),

          _buildProgressBar(project.progressPercent),
          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (project.startDate != null)
                Text(
                  project.startDate!,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              if (project.targetDate != null)
                Text(
                  project.targetDate!,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImagePlaceholder() {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8),
        image: project.imageUrl != null
            ? DecorationImage(
                image: NetworkImage(project.imageUrl!),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: project.imageUrl == null
          ? null 
          : null,
    );
  }

  Widget _buildStatusBadge(String status) {
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

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.toUpperCase(),
        style: AppTextStyles.labelSmall.copyWith(
          color: textColor,
          fontSize: 10,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildProgressBar(double percent) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: LinearProgressIndicator(
        value: percent / 100,
        backgroundColor: AppColors.primary.withOpacity(0.25), // Background bar
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
        minHeight: 8,
      ),
    );
  }
}