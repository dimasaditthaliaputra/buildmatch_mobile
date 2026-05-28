import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/screen_size.dart';
import '../../domain/entities/project_offer_entity.dart';

class OfferCardWidget extends StatelessWidget {
  final ProjectOfferEntity offer;
  final VoidCallback onProfileTap;

  const OfferCardWidget({
    super.key,
    required this.offer,
    required this.onProfileTap,
  });

  String _formatPrice(double price) {
    if (price >= 1000000) {
      return 'Rp ${(price / 1000000).toStringAsFixed(0)} Juta';
    }
    return NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0).format(price);
  }

  String _formatReviews(int count) {
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(0)}K Ulasan';
    }
    return '$count Ulasan';
  }

  @override
  Widget build(BuildContext context) {
    final isArchitect = offer.role == ProjectOfferRole.architect;
    final roleText = isArchitect ? 'ARSITEK' : 'KONTRAKTOR';
    final roleColor = isArchitect ? AppColors.textOrangeDark : AppColors.contractorPrimary;
    final roleBgColor = isArchitect ? AppColors.surfaceSoft : AppColors.contractorBg;

    final double padAll = context.widthPct(0.05).clamp(16.0, 20.0);
    final double avatarRadius = context.widthPct(0.07).clamp(24.0, 32.0);
    final double iconSize = context.widthPct(0.04).clamp(14.0, 18.0);

    return Container(
      margin: EdgeInsets.only(bottom: context.heightPct(0.02).clamp(12.0, 20.0)),
      padding: EdgeInsets.all(padAll),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowDark.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Avatar, Name, Role Tag
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: avatarRadius,
                backgroundImage: NetworkImage(offer.avatarUrl),
                backgroundColor: AppColors.primaryLightGrey,
              ),
              SizedBox(width: context.widthPct(0.04)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            offer.name,
                            style: AppTextStyles.heading3,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: context.widthPct(0.02)),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: context.widthPct(0.025).clamp(8.0, 12.0), 
                            vertical: context.heightPct(0.005).clamp(4.0, 6.0),
                          ),
                          decoration: BoxDecoration(
                            color: roleBgColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            roleText,
                            style: AppTextStyles.labelSmall.copyWith(
                              color: roleColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: context.heightPct(0.008)),
                    Row(
                      children: [
                        Icon(LucideIcons.star, color: AppColors.warning, size: iconSize),
                        SizedBox(width: context.widthPct(0.01)),
                        Text(
                          '${offer.rating} Rating',
                          style: AppTextStyles.caption.copyWith(color: AppColors.textPrimary),
                        ),
                        SizedBox(width: context.widthPct(0.03)),
                        Icon(LucideIcons.messageSquare, color: AppColors.primaryBlue, size: iconSize),
                        SizedBox(width: context.widthPct(0.01)),
                        Text(
                          _formatReviews(offer.reviewsCount),
                          style: AppTextStyles.caption.copyWith(color: AppColors.textPrimary),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: context.heightPct(0.03)),

          // Price and Estimate
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Harga Penawaran',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: context.heightPct(0.005)),
                    Text(
                      _formatPrice(offer.price),
                      style: AppTextStyles.heading3.copyWith(
                        color: AppColors.primaryDark,
                        fontWeight: FontWeight.bold,
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
                      'Estimasi Pengerjaan',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: context.heightPct(0.005)),
                    Text(
                      '${offer.estimatedDays} Hari',
                      style: AppTextStyles.heading3.copyWith(
                        color: AppColors.primaryGreen,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: context.heightPct(0.025)),

          // Message
          Text(
            'Pesan Penawaran',
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: context.heightPct(0.01)),
          Text(
            offer.message,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondaryDark,
              height: 1.5,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: context.heightPct(0.03)),

          // Action Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onProfileTap,
              child: const Text('Lihat Profile'),
            ),
          ),
        ],
      ),
    );
  }
}
