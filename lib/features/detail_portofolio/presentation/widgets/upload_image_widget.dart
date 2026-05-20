import 'dart:io';
import 'dart:ui'; 
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/screen_size.dart'; 

class UploadGambarWidget extends StatelessWidget {
  final List<String> imagePaths;
  final VoidCallback onUploadTap;
  final ValueChanged<int> onRemove;

  const UploadGambarWidget({
    super.key,
    required this.imagePaths,
    required this.onUploadTap,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    if (imagePaths.isEmpty) {
      return _UploadPlaceholder(onTap: onUploadTap);
    }
    return _ImageGrid(
      imagePaths: imagePaths,
      onAddTap: onUploadTap,
      onRemove: onRemove,
    );
  }
}

class _UploadPlaceholder extends StatelessWidget {
  final VoidCallback onTap;
  const _UploadPlaceholder({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final double width = context.screenWidth;
    final double verticalPadding = width * 0.05; 
    final double iconSize = width * 0.07; 
    final double innerIconSize =
        iconSize * 0.65; 
    final double gapWidth = width * 0.025; 

    return GestureDetector(
      onTap: onTap,
      child: CustomPaint(
        painter: _DashedRectPainter(
          color: AppColors.surfaceBeige,
          strokeWidth: 1.5,
          gap: 6,
          dash: 8,
          radius: 12,
        ),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: verticalPadding),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: iconSize,
                height: iconSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.textBrown, width: 2),
                ),
                child: Icon(
                  Icons.add,
                  color: AppColors.textBrown,
                  size: innerIconSize,
                ),
              ),
              SizedBox(width: gapWidth),
              Text(
                'Upload Gambar Projek',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textBrown,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ImageGrid extends StatelessWidget {
  final List<String> imagePaths;
  final VoidCallback onAddTap;
  final ValueChanged<int> onRemove;

  const _ImageGrid({
    required this.imagePaths,
    required this.onAddTap,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: imagePaths.length + 1,
      itemBuilder: (context, index) {
        if (index == imagePaths.length) {
          return GestureDetector(
            onTap: onAddTap,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.surfaceBeige),
              ),
              child: const Icon(Icons.add, color: AppColors.textBrown),
            ),
          );
        }

        return Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(File(imagePaths[index]), fit: BoxFit.cover),
            ),
            Positioned(
              top: 4,
              right: 4,
              child: GestureDetector(
                onTap: () => onRemove(index),
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: AppColors.error,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, color: Colors.white, size: 14),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _DashedRectPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;
  final double dash;
  final double radius;

  _DashedRectPainter({
    required this.color,
    this.strokeWidth = 1.0,
    this.gap = 5.0,
    this.dash = 5.0,
    this.radius = 0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(radius),
    );

    final Path path = Path()..addRRect(rrect);

    final Path metricsPath = Path();
    for (final PathMetric pathMetric in path.computeMetrics()) {
      double distance = 0.0;
      bool draw = true;
      while (distance < pathMetric.length) {
        final double length = draw ? dash : gap;
        if (distance + length > pathMetric.length) {
          metricsPath.addPath(
            pathMetric.extractPath(distance, pathMetric.length),
            Offset.zero,
          );
          break;
        }
        if (draw) {
          metricsPath.addPath(
            pathMetric.extractPath(distance, distance + length),
            Offset.zero,
          );
        }
        distance += length;
        draw = !draw;
      }
    }

    canvas.drawPath(metricsPath, paint);
  }

  @override
  bool shouldRepaint(covariant _DashedRectPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.gap != gap ||
        oldDelegate.dash != dash ||
        oldDelegate.radius != radius;
  }
}