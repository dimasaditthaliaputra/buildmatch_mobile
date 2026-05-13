import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/screen_size.dart';
import '../../domain/entities/contractor_dashboard_entity.dart';

import '../../../../core/widgets/app_badge.dart';
import '../../../../core/widgets/custom_progress_bar.dart';
import '../../../../core/widgets/section_header.dart';

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
        SectionHeader(
          title: 'Proyek Aktif', 
          actionText: 'LIHAT SEMUA',
          onActionTap: onSeeAll
        ),

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
              _buildImagePlaceholder(context),
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
              StatusBadge(
                status: project.status,
              ),
            ],
          ),
          const SizedBox(height: 24),

          Text(
            '${(project.progressPercent * 100).toStringAsFixed(0)}%',
            style: AppTextStyles.heading3.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 8),

          CustomProgressBar(
            percent: project.progressPercent,
          ),

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

  Widget _buildImagePlaceholder(BuildContext context) {
    return Container(
      width: context.widthPct(0.18),
      height: context.widthPct(0.18),
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
}