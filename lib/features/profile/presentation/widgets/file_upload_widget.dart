import 'package:buildmatch_mobile/core/theme/app_colors.dart';
import 'package:buildmatch_mobile/core/theme/app_text_styles.dart';
import 'package:buildmatch_mobile/core/utils/screen_size.dart';
import 'package:buildmatch_mobile/core/widgets/icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class FileUploadWidget extends StatefulWidget {
  final String label;
  final String? fileName;
  final String fileExtension;
  final ValueChanged<String?> onFileChanged;
  final bool isRequired;
  final bool isSquare;

  const FileUploadWidget({
    super.key,
    required this.label,
    required this.fileName,
    this.fileExtension = 'pdf',
    required this.onFileChanged,
    this.isRequired = false,
    this.isSquare = false,
  });

  @override
  State<FileUploadWidget> createState() => _FileUploadWidgetState();
}

class _FileUploadWidgetState extends State<FileUploadWidget> {
  bool _isUploading = false;
  double _uploadProgress = 0.0;

  void _simulateUpload() async {
    setState(() {
      _isUploading = true;
      _uploadProgress = 0.0;
    });

    // Simulate progress updates for a rich UX
    for (int i = 1; i <= 10; i++) {
      await Future.delayed(const Duration(milliseconds: 120));
      if (!mounted) return;
      setState(() {
        _uploadProgress = i * 0.1;
      });
    }

    if (!mounted) return;
    setState(() {
      _isUploading = false;
    });

    final simulatedName =
        '${widget.label.replaceAll(" ", "_")}_Dokumen.${widget.fileExtension}';
    widget.onFileChanged(simulatedName);
  }

  void _removeFile() {
    widget.onFileChanged(null);
  }

  Widget _buildUploadedFileState(double textFontSize) {
    if (widget.isSquare) {
      return Container(
        width: 84,
        height: 84,
        decoration: BoxDecoration(
          color: AppColors.contractorPrimary.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.contractorPrimary.withValues(alpha: 0.3),
            width: 1.5,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    LucideIcons.fileText,
                    color: AppColors.contractorPrimary,
                    size: 28,
                  ),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: Text(
                      widget.fileName!,
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 2,
              right: 2,
              child: GestureDetector(
                onTap: _removeFile,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.redAccent,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    LucideIcons.x,
                    color: Colors.white,
                    size: 8,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.contractorBg.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.contractorPrimary.withValues(alpha: 0.5),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            const Icon(
              LucideIcons.fileText,
              color: AppColors.contractorPrimary,
              size: 32,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.fileName!,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontSize: textFontSize,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'PDF • 1.2 MB • Berhasil Diunggah',
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontSize: textFontSize - 2,
                      color: AppColors.textSecondaryDark,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: _removeFile,
              icon: const Icon(
                LucideIcons.trash2,
                color: Colors.redAccent,
                size: 20,
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildUploadPlaceholder() {
    if (widget.isSquare) {
      return CustomPaint(
        painter: DashedBorderPainter(
          color: AppColors.contractorPrimary,
          borderRadius: 12,
        ),
        child: Container(
          width: 84,
          height: 84,
          decoration: BoxDecoration(
            color: AppColors.contractorPrimary.withValues(alpha: 0.03),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                LucideIcons.plus,
                color: AppColors.contractorPrimary,
                size: 20,
              ),
              const SizedBox(height: 4),
              Text(
                'Tambah',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppColors.contractorPrimary,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return CustomPaint(
        painter: DashedBorderPainter(
          color: AppColors.primaryGrey.withValues(alpha: 0.6),
          borderRadius: 16,
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 36.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconWidget(
                icon: LucideIcons.upload,
                backgroundColor: AppColors.primaryBlue.withValues(alpha: 0.1),
                iconColor: AppColors.primaryBlue,
                size: (context.screenWidth * 0.06).clamp(48.0, 64.0),
              ),
              const SizedBox(height: 12),
              Text(
                'Klik untuk unggah',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'PDF (Maks. 10MB)',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontSize: 12,
                  color: AppColors.textSecondaryDark.withValues(alpha: 0.9),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double labelFontSize = (context.screenWidth * 0.038).clamp(13.0, 16.0);
    final double textFontSize = (context.screenWidth * 0.035).clamp(12.0, 14.0);
    final bool hasFile = widget.fileName != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.label,
              style: AppTextStyles.bodyMedium.copyWith(
                fontSize: labelFontSize,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            if (widget.isRequired)
              Text(
                ' *',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontSize: labelFontSize,
                  fontWeight: FontWeight.w600,
                  color: Colors.redAccent,
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: (_isUploading || hasFile) ? null : _simulateUpload,
          child: _isUploading
              ? Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.primary,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Mengunggah file...',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  fontSize: textFontSize,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '${(_uploadProgress * 100).toInt()}%',
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontSize: textFontSize,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: _uploadProgress,
                          backgroundColor: AppColors.border,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : hasFile
                  ? _buildUploadedFileState(textFontSize)
                  : _buildUploadPlaceholder(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;
  final double dashLength;
  final double borderRadius;

  DashedBorderPainter({
    required this.color,
    this.strokeWidth = 1.5,
    this.gap = 4.0,
    this.dashLength = 6.0,
    this.borderRadius = 12.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.addRRect(RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(borderRadius),
    ));

    for (final pathMetric in path.computeMetrics()) {
      double distance = 0.0;
      while (distance < pathMetric.length) {
        final len = (distance + dashLength < pathMetric.length)
            ? dashLength
            : pathMetric.length - distance;

        final extract = pathMetric.extractPath(distance, distance + len);
        canvas.drawPath(extract, paint);
        distance += dashLength + gap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
