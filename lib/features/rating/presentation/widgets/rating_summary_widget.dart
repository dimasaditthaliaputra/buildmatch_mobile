import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/rating_stat_entity.dart';

class RatingSummaryWidget extends StatelessWidget {
  final RatingStatEntity stats;

  const RatingSummaryWidget({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Side: Big Rating
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      stats.averageRating.toStringAsFixed(1),
                      style: AppTextStyles.heading1.copyWith(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        height: 1.0,
                      ),
                    ),
                    Text(
                      '/5',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < stats.averageRating.round()
                          ? Icons.star
                          : Icons.star_border,
                      color: AppColors.primary,
                      size: 16,
                    );
                  }),
                ),
                const SizedBox(height: 4),
                Text(
                  '${stats.totalReviews} Ulasan',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          
          // Right Side: Progress Bars
          Expanded(
            flex: 3,
            child: Column(
              children: [
                for (int i = 5; i >= 1; i--)
                  _buildProgressBar(
                    star: i,
                    count: stats.ratingCounts[i] ?? 0,
                    total: stats.totalReviews,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar({
    required int star,
    required int count,
    required int total,
  }) {
    final double percentage = total > 0 ? count / total : 0.0;
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        children: [
          Text(
            star.toString(),
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: percentage,
                backgroundColor: AppColors.primaryGrey,
                color: AppColors.primary,
                minHeight: 6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
