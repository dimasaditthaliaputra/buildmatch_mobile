import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/idr_formatter.dart';
import '../../../../core/utils/screen_size.dart';
import '../../domain/entities/contractor_dashboard_entity.dart';

import '../../../../core/widgets/main_button.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../core/widgets/badge_widget.dart';
import '../../../../core/widgets/info_column_text.dart';

class ProjectListingSection extends StatelessWidget {
  final List<ProjectListingEntity> listings;
  final VoidCallback? onSeeAll;
  final Function(ProjectListingEntity)? onDetailTap;

  const ProjectListingSection({
    super.key,
    required this.listings,
    this.onSeeAll,
    this.onDetailTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeader(
          title: 'Daftar Proyek', 
          actionText: 'LIHAT SEMUA',
          onActionTap: onSeeAll
        ),

        const SizedBox(height: 12),
        
        ...listings.map(
          (listing) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: ProjectListingCard(
              listing: listing,
              onDetailTap: onDetailTap != null ? () => onDetailTap!(listing) : null,
            ),
          ),
        ),
      ],
    );
  }
}

class ProjectListingCard extends StatelessWidget {
  final ProjectListingEntity listing;
  final VoidCallback? onDetailTap;

  const ProjectListingCard({
    super.key,
    required this.listing,
    this.onDetailTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      listing.name,
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      listing.location,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textDark,
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              if (listing.isNew)
                BadgeWidget(
                  text: 'New', 
                  textColor: AppColors.primary, 
                  backgroundColor: AppColors.primary.withOpacity(0.12), 
                  borderColor: AppColors.primary.withOpacity(0.4)
                )   
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: InfoColumnText(
                  label: 'Rentang Harga',
                  value: IdrFormatter.formatRupiahRange(
                    listing.minPrice,
                    listing.maxPrice,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: InfoColumnText(
                  label: 'Luas Bangunan',
                  value: '${listing.buildingArea.toInt()} m²',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

         SizedBox(
          width: double.infinity,
          height: math.max(context.heightPct(0.055), 45.0),
          child: MainButton(
            text: 'Lihat Detail',
            onPressed: onDetailTap,
            borderRadius: 25,
            fontSize: 14,
            fontWeight: FontWeight.w900,
            padding: EdgeInsets.zero,
          ),
         )
        ],
      ),
    );
  }
}