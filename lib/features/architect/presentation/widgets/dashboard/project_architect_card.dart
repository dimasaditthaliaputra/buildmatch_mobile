import 'package:flutter/material.dart';
import '../../../../../core/utils/date_formatter.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/utils/screen_size.dart';
import '../../../domain/entities/architect_project_list_entity.dart';
import '../../../../../core/widgets/global_card.dart';
import '../../../../../core/widgets/badge_widget.dart';
import '../../../../../core/widgets/main_button.dart';

class ProjectArchitectCard extends StatelessWidget {
  final ArchitectProjectListEntity project; 
  final VoidCallback onTap;

  const ProjectArchitectCard({
    super.key,
    required this.project,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isRunning = project.status == ProjectStatus.berjalan;

    final double cardPadding = context.widthPct(0.04).clamp(14.0, 20.0);
    final double titleSize = context.widthPct(0.04).clamp(14.0, 18.0);
    final double subTextSize = context.widthPct(0.035).clamp(12.0, 15.0);
    final double labelSize = context.widthPct(0.03).clamp(10.0, 12.0);
    final double spacing = context.heightPct(0.01).clamp(6.0, 10.0);
    final double btnHeight = context.heightPct(0.065).clamp(48.0, 56.0);

    return GlobalCard(
      margin: EdgeInsets.only(bottom: spacing * 1.5),
      padding: EdgeInsets.all(cardPadding),
      borderRadius: 16,
      backgroundColor: AppColors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  project.name,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                    fontSize: titleSize,
                  ),
                ),
              ),
              SizedBox(width: context.widthPct(0.02)),
              BadgeWidget(
                text: isRunning ? 'Berjalan' : 'Selesai',
                textColor: isRunning ? AppColors.textOrangeLight : AppColors.success,
                backgroundColor: isRunning
                    ? AppColors.primary.withOpacity(0.12)
                    : AppColors.successBackground,
                borderColor: Colors.transparent, 
              ),
            ],
          ),
          SizedBox(height: spacing),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on_outlined,
                size: subTextSize,
                color: AppColors.textDark,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  project.location,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textDark,
                    fontSize: subTextSize,
                  ),
                ),
              ),
            ],
          ),
          
          Padding(
            padding: EdgeInsets.symmetric(vertical: spacing * 1.5),
            child: Divider(
              color: AppColors.primaryUltraLightGrey, 
              height: 1, 
              thickness: 1
            ),
          ),

          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'MULAI',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.textMid,
                        fontWeight: FontWeight.w600,
                        fontSize: labelSize,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      DateFormatter.formatDate(project.startDate),
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                        fontSize: subTextSize,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'KLIEN',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.textMid,
                        fontWeight: FontWeight.w600,
                        fontSize: labelSize,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      project.clientName,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                        fontSize: subTextSize,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: spacing * 1.5),
            child: Divider(
              color: AppColors.primaryUltraLightGrey, 
              height: 1, 
              thickness: 1
            ),
          ),

          SizedBox(height: spacing),

          SizedBox(
            width: context.screenWidth,
            height: btnHeight,
            child: MainButton(
              backgroundColor: AppColors.primary,
              text: 'Lihat Detail Proyek',
              onPressed: onTap,
              borderRadius: 12,
              padding: const EdgeInsets.symmetric(vertical: 0), 
              fontSize: titleSize,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}