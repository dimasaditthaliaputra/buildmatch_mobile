import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/screen_size.dart';
import '../../domain/entities/client_dashboard_entity.dart';

class PopularProjectsSection extends StatelessWidget {
  final List<PopularProjectEntity> projects;
  final VoidCallback? onSeeAll;

  const PopularProjectsSection({
    super.key,
    required this.projects,
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Proyek Populer',
                      style: AppTextStyles.heading3.copyWith(
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Inspirasi hunian modern impian',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondaryDark,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: onSeeAll,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Text(
                    'LIHAT SEMUA',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Horizontal scroll list
        SizedBox(
          height: context.widthPct(1.15), // Responsive height using aspect ratio
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: projects.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              return _PopularProjectCard(project: projects[index]);
            },
          ),
        ),
      ],
    );
  }
}

class _PopularProjectCard extends StatelessWidget {
  final PopularProjectEntity project;

  const _PopularProjectCard({required this.project});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.widthPct(0.72), // 72% of screen width
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: AppColors.surface,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // Background image / placeholder
            Positioned.fill(
              child: project.imageUrl != null
                  ? Image.network(
                      project.imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _buildPlaceholderBg(),
                    )
                  : _buildPlaceholderBg(),
            ),

            // Favorite button with Glassmorphism
            Positioned(
              top: 16,
              right: 16,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withOpacity(0.25),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      project.isFavorited
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      size: 24,
                      color: project.isFavorited
                          ? Colors.red
                          : AppColors.textLight,
                    ),
                  ),
                ),
              ),
            ),

            // Bottom info with Glassmorphism
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF111111).withOpacity(0.45),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          project.name,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textLight,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            letterSpacing: 0.2,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(
                              Icons.person_rounded,
                              size: 16,
                              color: AppColors.textLight.withOpacity(0.9),
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                project.type,
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.textLight.withOpacity(0.9),
                                  fontSize: 14,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              project.rating.toStringAsFixed(1),
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.textLight,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderBg() {
    final colors = [
      [const Color(0xFF1A237E), const Color(0xFF0D47A1)],
      [const Color(0xFF1B5E20), const Color(0xFF2E7D32)],
      [const Color(0xFF4A148C), const Color(0xFF6A1B9A)],
    ];
    final colorPair = colors[project.id.hashCode % colors.length];
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colorPair,
        ),
      ),
      child: const Center(
        child: Icon(Icons.home_work_rounded, color: Colors.white38, size: 64),
      ),
    );
  }
}

