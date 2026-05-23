import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import 'package:buildmatch_mobile/core/utils/screen_size.dart';
import '../../../domain/entities/architect_dashboard_entity.dart';

import '../../../../../core/widgets/badge_widget.dart';
import 'package:buildmatch_mobile/core/widgets/custom_progress_bar.dart';
import 'package:buildmatch_mobile/core/widgets/section_header.dart';
import '../../../../../core/widgets/global_card.dart';

import 'package:go_router/go_router.dart';

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
          onActionTap: () {
            context.push('/project-architect-list');
          },
        ),

        const SizedBox(height: 16),

        ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: projects.length,
          itemBuilder: (context, index) {
            return ActiveProjectCard(project: projects[index]);
          },
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
    return GlobalCard(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 4),
      backgroundColor: AppColors.surface,
      borderRadius: 16,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.03),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
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
                        color: AppColors.textMid,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              BadgeWidget(
                  text: 'AKtif', 
                  textColor: AppColors.success, 
                  backgroundColor: AppColors.success.withOpacity(0.12), 
                  borderColor: AppColors.success.withOpacity(0.4)
              ),
            ],
          ),
          const SizedBox(height: 16),

          Text(
            '${(project.progressPercent * 100).toStringAsFixed(0)}%',
            style: AppTextStyles.heading3.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 8),

          CustomProgressBar(percent: project.progressPercent),

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
        color: AppColors.primaryLightGrey,
        borderRadius: BorderRadius.circular(4),
      ),
      clipBehavior: Clip.antiAlias,
      child: (project.imageUrl != null && project.imageUrl!.isNotEmpty)
          ? Image.network(
              project.imageUrl!,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.image_not_supported_outlined,
                  color: AppColors.primaryDarkGrey,
                  size: 24,
                );
              },
            )
          : const Icon(
              Icons.domain_disabled,
              color: AppColors.primaryDarkGrey,
              size: 24,
            ),
    );
  }
}
