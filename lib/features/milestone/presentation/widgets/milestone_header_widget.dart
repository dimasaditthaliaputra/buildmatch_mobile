import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/badge_widget.dart';
import '../../../../core/widgets/custom_progress_bar.dart';
import '../../domain/entities/milestone_entity.dart';
import '../../../contractor/domain/entities/contractor_project_list_entity.dart';

class MilestoneHeaderWidget extends StatelessWidget {
  final MilestoneEntity? activeMilestone;
  final int remainingPhases;
  final ContractorProjectListEntity? project;

  const MilestoneHeaderWidget({
    super.key,
    this.activeMilestone,
    this.remainingPhases = 0,
    this.project,
  });

  @override
  Widget build(BuildContext context) {
    final title = activeMilestone != null 
        ? 'FASE ${activeMilestone!.id}: ${activeMilestone!.title.toUpperCase()}'
        : 'TIDAK ADA FASE AKTIF';
    
    final completionPct = activeMilestone?.completionPercentage ?? 0.0;
    final progressText = '${(completionPct * 100).toInt()}%';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Top Orange Area
        Container(
          color: AppColors.primary,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BadgeWidget(
                text: 'PROJEK AKTIF',
                textColor: Colors.white,
                backgroundColor: Colors.white.withOpacity(0.3),
                borderColor: Colors.transparent,
                fontSize: 10,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              ),
              const SizedBox(height: 12),
              Text(
                project?.name ?? 'Modern Villa',
                style: AppTextStyles.heading1.copyWith(
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.location_on_outlined, color: Colors.white, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    project?.location ?? 'Uluwatu, Bali - Luas 4.200 m²',
                    style: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
        
        // Progress Area
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTextStyles.labelSmall.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textMid,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Estimasi selesai : 26 Nov 2025',
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                  Text(
                    progressText,
                    style: AppTextStyles.heading2.copyWith(color: AppColors.textMid),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              CustomProgressBar(
                percent: completionPct,
                height: 6,
                borderRadius: 8,
                backgroundColor: AppColors.surfaceSoft,
                progressColor: AppColors.primary,
              ),
              const SizedBox(height: 20),
              
              // Summary Cards
              Row(
                children: [
                  Expanded(
                    child: _buildSummaryCard('ANGGARAN', 'Rp 1.4M', isPrimary: false),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildSummaryCard('UKURAN', '4,200 m²', isPrimary: false),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildSummaryCard('SISA FASE', '$remainingPhases FASE', isPrimary: true),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(String title, String value, {required bool isPrimary}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: isPrimary ? AppColors.primary : AppColors.surfaceCream,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: AppTextStyles.labelSmall.copyWith(
              color: isPrimary ? Colors.white : AppColors.textDark,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppTextStyles.bodyMedium.copyWith(
              color: isPrimary ? Colors.white : AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
