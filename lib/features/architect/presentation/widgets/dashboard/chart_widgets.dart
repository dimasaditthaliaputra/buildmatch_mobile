import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:buildmatch_mobile/core/theme/app_colors.dart';
import 'package:buildmatch_mobile/core/theme/app_text_styles.dart';
import 'package:buildmatch_mobile/core/utils/screen_size.dart';
import 'package:buildmatch_mobile/core/widgets/global_card.dart';
import '../../../domain/entities/architect_dashboard_entity.dart';

class ProjectDonutChart extends StatelessWidget {
  final ProjectStatsEntity stats;

  const ProjectDonutChart({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return GlobalCard(
      padding: const EdgeInsets.all(14),
      margin: EdgeInsets.zero,
      backgroundColor: AppColors.surface,
      borderRadius: 16.0,
      boxShadow: [
        BoxShadow(
          color: AppColors.shadowDark.withOpacity(0.06),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
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
              color: AppColors.textMid,
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
                      color: AppColors.success,
                      label: 'Selesai',
                      count: stats.done,
                    ),
                    const SizedBox(height: 6),
                    _LegendItem(
                      color: AppColors.surfaceCream,
                      label: 'Pending',
                      count: stats.pending,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.surfacePale,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _StatItem(value: '${stats.total}', label: 'Selesai'),
                ),
                Container(width: 1, height: 28, color: AppColors.textMid.withOpacity(0.15)),
                Expanded(
                  child: _StatItem(value: '${stats.active}', label: 'Aktif'),
                ),
                Container(width: 1, height: 28, color: AppColors.textMid.withOpacity(0.15)),
                Expanded(
                  child: _StatItem(
                    value: stats.averageRating.toStringAsFixed(1),
                    label: 'Rating',
                  ),
                ),
              ],
            ),
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
      _Segment(stats.done / total, AppColors.success),
      _Segment(stats.pending / total, AppColors.surfaceCream),
    ];

    var startAngle = -math.pi / 2;
    const gap = 0.04;

    final bgPaint = Paint()
      ..color = AppColors.border.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(center, radius, bgPaint);

    for (final seg in segments) {
      if (seg.value <= 0) continue;
      final sweepAngle = seg.value * 2 * math.pi - gap;

      final paint = Paint()
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
            color: AppColors.textMid,
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
            color: AppColors.textOrangeSecondary,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          label,
          style: AppTextStyles.labelSmall.copyWith(
            color: AppColors.textMid,
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
    return GlobalCard(
      padding: const EdgeInsets.all(14),
      margin: EdgeInsets.zero,
      backgroundColor: AppColors.surface,
      borderRadius: 16.0,
      boxShadow: [
        BoxShadow(
          color: AppColors.shadowDark.withOpacity(0.06),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
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
              color: AppColors.textMid,
              fontSize: 10,
            ),
          ),
          const SizedBox(height: 20),

          SizedBox(
            height: 120,
            child: CustomPaint(
              painter: _LineChartPainter(data: widget.data),
              size: const Size(double.infinity, 120),
            ),
          ),
          const SizedBox(height: 8),

          Padding(
            padding: const EdgeInsets.only(left: 36.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: widget.data.map((d) {
                return Text(
                  d.month.toUpperCase(),
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w800,
                    fontSize: 10,
                  ),
                );
              }).toList(),
            ),
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
                color: AppColors.surfaceSoft,
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
          color: isActive ? AppColors.surfaceCream : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: AppTextStyles.labelSmall.copyWith(
            color: isActive ? AppColors.textMid : AppColors.textSecondary,
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

    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    final double leftOffset = 36.0;

    final gridPaint = Paint()
      ..color = AppColors.border.withOpacity(0.8)
      ..strokeWidth = 1.0;

    for (int i = 1; i <= 5; i++) {
      final y = size.height * (1 - i / 5);

      canvas.drawLine(Offset(leftOffset, y), Offset(size.width, y), gridPaint);

      textPainter.text = TextSpan(
        text: '${i * 100}jt',
        style: const TextStyle(
          color: Color(0xFF333333),
          fontSize: 9,
          fontWeight: FontWeight.w600,
        ),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(0, y - textPainter.height / 2)); 
    }

    final maxIncome = data.map((d) => d.income).reduce(math.max);
    final maxExpense = data.map((d) => d.expense).reduce(math.max);
    double maxVal = math.max(maxIncome, maxExpense);
    if (maxVal == 0) maxVal = 500; 

    maxVal = ((maxVal / 100).ceil() * 100).toDouble();
    if(maxVal < 500) maxVal = 500;

    _drawLine(
      canvas,
      size,
      data.map((d) => d.income).toList(),
      maxVal,
      AppColors.primary,
      leftOffset,
    );

    _drawLine(
      canvas,
      size,
      data.map((d) => d.expense).toList(),
      maxVal,
      const Color(0xFFFFD4A8), 
      leftOffset,
    );
  }

  void _drawLine(
    Canvas canvas,
    Size size,
    List<double> values,
    double maxVal,
    Color color,
    double leftOffset,
  ) {
    if (values.isEmpty) return;

    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();
    final points = <Offset>[];

    for (int i = 0; i < values.length; i++) {
      final x = leftOffset + (size.width - leftOffset) * (i / (values.length > 1 ? values.length - 1 : 1));
      
      final y = size.height * (1 - (values[i] / maxVal));
      points.add(Offset(x, y));
    }

    if (points.length > 1) {
      path.moveTo(points.first.dx, points.first.dy);
      for (int i = 0; i < points.length - 1; i++) {
        path.lineTo(points[i + 1].dx, points[i + 1].dy);
      }
      canvas.drawPath(path, paint);
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
          width: 30, 
          height: 3,
          child: CustomPaint(
            painter: _LinePainter(color: color, isDashed: isDashed),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: AppTextStyles.labelSmall.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 11,
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
    final paint = Paint()..color = color..strokeWidth = 3..strokeCap = StrokeCap.round;
    if (isDashed) {
      double x = 0;
      while (x < size.width) {
        canvas.drawLine(
          Offset(x, size.height / 2),
          Offset(math.min(x + 4, size.width), size.height / 2),
          paint,
        );
        x += 8;
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