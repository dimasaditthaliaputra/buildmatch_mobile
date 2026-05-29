import 'dart:ui' show PathMetric;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/idr_formatter.dart';
import '../../../../core/widgets/badge_widget.dart';
import '../../../../core/widgets/custom_progress_bar.dart';
import '../../../../core/widgets/global_card.dart';
import '../../domain/entities/milestone_entity.dart';
import 'milestone_progress_item_widget.dart';

class MilestoneTimelineItemWidget extends StatelessWidget {
  final MilestoneEntity milestone;
  final bool isLast;
  final bool showGradientLine;

  const MilestoneTimelineItemWidget({
    super.key,
    required this.milestone,
    this.isLast = false,
    this.showGradientLine = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (!isLast)
          Positioned(
            left: 14,
            top: 36,
            bottom: 0,
            child: Container(width: 3, decoration: _getLineDecoration()),
          ),
        Positioned(left: 3, top: 12, child: _buildTimelineIcon()),
        Padding(
          padding: const EdgeInsets.only(left: 42, bottom: 24),
          child: GlobalCard(
            width: null,
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            backgroundColor: milestone.status == 'BELUM MULAI'
                ? AppColors.primaryLightGrey
                : AppColors.surface,
            borderRadius: 8.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(),
                      if (milestone.evidencePhotos.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        _buildEvidencePhotos(),
                      ],
                      if (milestone.isConstruction &&
                          milestone.progressList != null) ...[
                        const SizedBox(height: 16),
                        Text(
                          'Daftar Progres',
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ...milestone.progressList!.map(
                          (progress) =>
                              MilestoneProgressItemWidget(progress: progress),
                        ),
                        if (milestone.status != 'SELESAI')
                          _buildAddProgressButton(context),
                      ],
                    ],
                  ),
                ),
                if (milestone.paymentAmount > 0 ||
                    milestone.paymentStatus.isNotEmpty)
                  _buildPaymentCard(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineIcon() {
    if (milestone.status == 'SELESAI') {
      return Container(
        width: 24,
        height: 24,
        decoration: const BoxDecoration(
          color: AppColors.success,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.check, color: AppColors.surface, size: 16),
      );
    } else if (milestone.status == 'MENUNGGU') {
      return Container(
        width: 24,
        height: 24,
        decoration: const BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            milestone.id,
            style: const TextStyle(
              color: AppColors.surface,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    } else {
      return Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: AppColors.primaryLightGrey,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.primaryLightGrey, width: 2),
        ),
      );
    }
  }

  Color _getTimelineLineColor() {
    if (milestone.status == 'SELESAI') return AppColors.success;
    if (milestone.status == 'MENUNGGU') return AppColors.primaryLight;
    return AppColors.primaryLightGrey;
  }

  BoxDecoration _getLineDecoration() {
    if (showGradientLine) {
      return const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.primary, AppColors.primaryLightGrey],
        ),
      );
    }
    return BoxDecoration(color: _getTimelineLineColor());
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                milestone.title,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: AppColors.primaryBlack,
                ),
              ),
            ),
            _buildStatusBadge(),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          milestone.description,
          style: AppTextStyles.bodySmall.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 8),
        if (milestone.status == 'SELESAI' ||
            milestone.status == 'MENUNGGU') ...[
          CustomProgressBar(
            percent: milestone.completionPercentage,
            height: 6,
            borderRadius: 8,
            backgroundColor: AppColors.surfaceSoft,
            progressColor: _getTimelineLineColor(),
          ),
          const SizedBox(height: 4),
          if (milestone.completionPercentage == 1.0)
            Text(
              '100% - Selesai',
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.textDark,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
        ],
      ],
    );
  }

  Widget _buildStatusBadge() {
    final Color textColor;
    final Color bgColor;

    if (milestone.status == 'SELESAI') {
      textColor = AppColors.success;
      bgColor = AppColors.successBackground;
    } else if (milestone.status == 'MENUNGGU') {
      textColor = AppColors.textOrangeSecondary;
      bgColor = AppColors.surfaceCream;
    } else {
      textColor = AppColors.textLight;
      bgColor = AppColors.primaryUltraGrey;
    }

    return BadgeWidget(
      text: milestone.status,
      textColor: textColor,
      backgroundColor: bgColor,
      borderColor: Colors.transparent,
      fontSize: 10,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    );
  }

  Widget _buildPaymentCard() {
    return Container(
      width: double.infinity,
      color: AppColors.surfaceCream,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              LucideIcons.banknote,
              color: AppColors.surface,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pembayaran Fase ${milestone.id}',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.primaryDark,
                  ),
                ),
                Text(
                  IdrFormatter.formatFull(milestone.paymentAmount.toDouble()),
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          BadgeWidget(
            text: milestone.paymentStatus,
            textColor: milestone.paymentStatus == 'LUNAS'
                ? AppColors.success
                : AppColors.primary,
            backgroundColor: milestone.paymentStatus == 'LUNAS'
                ? AppColors.successBackground
                : AppColors.surfaceSoft,
            borderColor: Colors.transparent,
            fontSize: 10,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          ),
        ],
      ),
    );
  }

  Widget _buildEvidencePhotos() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bukti',
          style: AppTextStyles.labelSmall.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: milestone.evidencePhotos
              .map(
                (photo) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      photo,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 60,
                        height: 60,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _buildAddProgressButton(BuildContext context) {
    final bool hasPendingPayment = milestone.progressList?.any((p) => p.paymentStatus == 'MENUNGGU') ?? false;

    return GestureDetector(
      onTap: hasPendingPayment
          ? () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Selesaikan pembayaran progres sebelumnya terlebih dahulu untuk menambah progres baru.',
                  ),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          : () {
              context.push('/contractor-add-progres');
            },
      child: CustomPaint(
        foregroundPainter: DashedBorderPainter(
          color: hasPendingPayment ? AppColors.primaryUltraGrey : AppColors.primaryUltraGrey,
          radius: 12.0,
          strokeWidth: 1.5,
          gap: 4.0,
          dash: 6.0,
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: hasPendingPayment
                ? AppColors.primaryUltraLightGrey
                : AppColors.surface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(
                Icons.add_circle_outline,
                color: hasPendingPayment ? AppColors.textLight.withValues(alpha: 0.6) : AppColors.textPrimary,
                size: 24,
              ),
              const SizedBox(height: 8),
              Text(
                'Tambah Progres Baru',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: hasPendingPayment ? AppColors.textLight.withValues(alpha: 0.6) : AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;
  final double dash;
  final double radius;

  DashedBorderPainter({
    this.color = Colors.grey,
    this.strokeWidth = 1.0,
    this.gap = 4.0,
    this.dash = 4.0,
    this.radius = 12.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        strokeWidth / 2,
        strokeWidth / 2,
        size.width - strokeWidth,
        size.height - strokeWidth,
      ),
      Radius.circular(radius),
    );

    final Path path = Path()..addRRect(rrect);

    final Path dashPath = _buildDashedPath(path, dash, gap);
    canvas.drawPath(dashPath, paint);
  }

  Path _buildDashedPath(Path source, double dashWidth, double gapWidth) {
    final Path dest = Path();
    for (final PathMetric metric in source.computeMetrics()) {
      double distance = 0.0;
      bool draw = true;
      while (distance < metric.length) {
        final double len = draw ? dashWidth : gapWidth;
        if (draw) {
          dest.addPath(
            metric.extractPath(
              distance,
              (distance + len).clamp(0.0, metric.length),
            ),
            Offset.zero,
          );
        }
        distance += len;
        draw = !draw;
      }
    }
    return dest;
  }

  @override
  bool shouldRepaint(covariant DashedBorderPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.gap != gap ||
        oldDelegate.dash != dash ||
        oldDelegate.radius != radius;
  }
}
