import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/screen_size.dart';
import '../../domain/entities/contractor_dashboard_entity.dart';

class ProjectDonutChart extends StatelessWidget {
  final ProjectStatsEntity stats;

  const ProjectDonutChart({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Grafik Proyek',
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              fontSize: 13,
            ),
          ),
          Text(
            '${stats.total} proyek aktif',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
              fontSize: 10,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: CustomPaint(
                    painter: _DonutChartPainter(stats: stats),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${stats.total}',
                            style: AppTextStyles.heading2.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            'Total',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.textSecondary,
                              fontSize: 9,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _LegendItem(
                      color: AppColors.primary,
                      label: 'Aktif',
                      count: stats.active,
                    ),
                    const SizedBox(height: 6),
                    _LegendItem(
                      color: AppColors.warning,
                      label: 'Review',
                      count: stats.review,
                    ),
                    const SizedBox(height: 6),
                    _LegendItem(
                      color: Colors.grey.shade400,
                      label: 'Pending',
                      count: stats.pending,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _StatItem(value: '${stats.total}', label: 'Selesai'),
              _StatItem(value: '${stats.active}', label: 'Aktif'),
              _StatItem(
                value: stats.averageRating.toStringAsFixed(1),
                label: 'Rating',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DonutChartPainter extends CustomPainter {
  final ProjectStatsEntity stats;

  _DonutChartPainter({required this.stats});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - 4;
    const strokeWidth = 14.0;

    final total = stats.total > 0 ? stats.total.toDouble() : 1;
    final segments = [
      _Segment(stats.active / total, AppColors.primary),
      _Segment(stats.review / total, AppColors.warning),
      _Segment(stats.pending / total, Colors.grey.shade400),
    ];

    var startAngle = -math.pi / 2;
    const gap = 0.04;

    for (final seg in segments) {
      if (seg.value <= 0) continue;
      final sweepAngle = seg.value * 2 * math.pi - gap;

      final paint =
          Paint()
            ..color = seg.color
            ..style = PaintingStyle.stroke
            ..strokeWidth = strokeWidth
            ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );

      startAngle += seg.value * 2 * math.pi;
    }

    // Background circle for remaining
    final bgPaint =
        Paint()
          ..color = AppColors.border
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth;

    canvas.drawCircle(center, radius, bgPaint);

    // Redraw segments on top
    startAngle = -math.pi / 2;
    for (final seg in segments) {
      if (seg.value <= 0) continue;
      final sweepAngle = seg.value * 2 * math.pi - gap;

      final paint =
          Paint()
            ..color = seg.color
            ..style = PaintingStyle.stroke
            ..strokeWidth = strokeWidth
            ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );

      startAngle += seg.value * 2 * math.pi;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _Segment {
  final double value;
  final Color color;
  _Segment(this.value, this.color);
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  final int count;

  const _LegendItem({
    required this.color,
    required this.label,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          '$label ($count)',
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: AppTextStyles.heading3.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          label,
          style: AppTextStyles.labelSmall.copyWith(
            color: AppColors.textSecondary,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}

class FinancialChartWidget extends StatefulWidget {
  final List<FinancialDataEntity> data;

  const FinancialChartWidget({super.key, required this.data});

  @override
  State<FinancialChartWidget> createState() => _FinancialChartWidgetState();
}

class _FinancialChartWidgetState extends State<FinancialChartWidget> {
  bool _showYearly = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
            children: [
              Text(
                'Grafik Keuangan',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  fontSize: 13,
                ),
              ),
              Row(
                children: [
                  _ToggleTab(
                    label: 'Tahun',
                    isActive: _showYearly,
                    onTap: () => setState(() => _showYearly = true),
                  ),
                  const SizedBox(width: 4),
                  _ToggleTab(
                    label: 'Bulan',
                    isActive: !_showYearly,
                    onTap: () => setState(() => _showYearly = false),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '6 bulan terakhir',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
              fontSize: 10,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: context.heightPct(0.15),
            child: CustomPaint(
              painter: _LineChartPainter(data: widget.data),
              size: Size(double.infinity, context.heightPct(0.15)),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: widget.data
                .map(
                  (d) => Expanded(
                    child: Center(
                      child: Text(
                        d.month,
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.textSecondary,
                          fontSize: 9,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _ChartLegend(
                color: AppColors.primary,
                label: 'Pendapatan',
              ),
              const SizedBox(width: 16),
              _ChartLegend(
                color: AppColors.textSecondary.withOpacity(0.5),
                label: 'Bulan lalu',
                isDashed: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ToggleTab extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _ToggleTab({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: AppTextStyles.labelSmall.copyWith(
            color: isActive ? Colors.white : AppColors.textSecondary,
            fontSize: 10,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  final List<FinancialDataEntity> data;

  _LineChartPainter({required this.data});

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final maxIncome = data.map((d) => d.income).reduce(math.max);
    final maxExpense = data.map((d) => d.expense).reduce(math.max);
    final maxVal = math.max(maxIncome, maxExpense) * 1.1;

    // Grid lines
    final gridPaint =
        Paint()
          ..color = AppColors.border
          ..strokeWidth = 0.8;

    for (int i = 0; i <= 4; i++) {
      final y = size.height * (1 - i / 4);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Income line
    _drawLine(
      canvas,
      size,
      data.map((d) => d.income).toList(),
      maxVal,
      AppColors.primary,
      filled: true,
    );

    // Expense line (dashed)
    _drawLine(
      canvas,
      size,
      data.map((d) => d.expense).toList(),
      maxVal,
      AppColors.textSecondary.withOpacity(0.4),
    );
  }

  void _drawLine(
    Canvas canvas,
    Size size,
    List<double> values,
    double maxVal,
    Color color, {
    bool filled = false,
  }) {
    if (values.isEmpty) return;

    final paint =
        Paint()
          ..color = color
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round;

    final path = Path();
    final points = <Offset>[];

    for (int i = 0; i < values.length; i++) {
      final x = size.width * i / (values.length - 1);
      final y = size.height * (1 - values[i] / maxVal);
      points.add(Offset(x, y));
    }

    // Smooth curve
    path.moveTo(points.first.dx, points.first.dy);
    for (int i = 0; i < points.length - 1; i++) {
      final cp1 = Offset(
        (points[i].dx + points[i + 1].dx) / 2,
        points[i].dy,
      );
      final cp2 = Offset(
        (points[i].dx + points[i + 1].dx) / 2,
        points[i + 1].dy,
      );
      path.cubicTo(
        cp1.dx,
        cp1.dy,
        cp2.dx,
        cp2.dy,
        points[i + 1].dx,
        points[i + 1].dy,
      );
    }

    if (filled) {
      final fillPath = Path.from(path);
      fillPath.lineTo(points.last.dx, size.height);
      fillPath.lineTo(points.first.dx, size.height);
      fillPath.close();

      final fillPaint =
          Paint()
            ..color = color.withOpacity(0.08)
            ..style = PaintingStyle.fill;
      canvas.drawPath(fillPath, fillPaint);
    }

    canvas.drawPath(path, paint);

    // Dots
    final dotPaint = Paint()..color = color;
    for (final pt in points) {
      canvas.drawCircle(pt, 3, dotPaint);
      canvas.drawCircle(
        pt,
        3,
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _ChartLegend extends StatelessWidget {
  final Color color;
  final String label;
  final bool isDashed;

  const _ChartLegend({
    required this.color,
    required this.label,
    this.isDashed = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 20,
          height: 2,
          child: CustomPaint(
            painter: _LinePainter(color: color, isDashed: isDashed),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: AppTextStyles.labelSmall.copyWith(
            color: AppColors.textSecondary,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}

class _LinePainter extends CustomPainter {
  final Color color;
  final bool isDashed;
  _LinePainter({required this.color, required this.isDashed});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color..strokeWidth = 2;
    if (isDashed) {
      double x = 0;
      while (x < size.width) {
        canvas.drawLine(
          Offset(x, size.height / 2),
          Offset(math.min(x + 4, size.width), size.height / 2),
          paint,
        );
        x += 7;
      }
    } else {
      canvas.drawLine(
        Offset(0, size.height / 2),
        Offset(size.width, size.height / 2),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}