import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../utils/screen_size.dart';

class FileRow extends StatelessWidget {
  final String fileName;
  final String fileType;
  final String fileSize;
  final VoidCallback? onDownload;

  const FileRow({
    super.key,
    required this.fileName,
    required this.fileType,
    required this.fileSize,
    this.onDownload,
  });

  @override
  Widget build(BuildContext context) {
    final bool isPdf = fileType.toUpperCase() == 'PDF';
    final double iconBoxSize = context.widthPct(0.12).clamp(44.0, 56.0);
    final double nameFontSize = context.widthPct(0.035).clamp(13.0, 15.0);
    final double subFontSize = context.widthPct(0.030).clamp(11.0, 13.0);

    final Color iconColor = isPdf ? AppColors.primaryBlue : AppColors.primaryGreen;
    final Color iconBgColor = isPdf 
        ? AppColors.primaryBlue.withValues(alpha: 0.1) 
        : AppColors.primaryGreen.withValues(alpha: 0.1);
        
    final IconData icon = isPdf ? LucideIcons.badgeCheck : LucideIcons.shieldCheck;

    return Container(
      margin: EdgeInsets.only(bottom: context.heightPct(0.015)),
      padding: EdgeInsets.all(context.widthPct(0.035)),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        children: [
          Container(
            width: iconBoxSize,
            height: iconBoxSize,
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: iconBoxSize * 0.5,
              color: iconColor,
            ),
          ),
          SizedBox(width: context.widthPct(0.04)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fileName,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: nameFontSize,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '$fileType • $fileSize',
                  style: AppTextStyles.bodySmall.copyWith(
                    fontSize: subFontSize,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onDownload,
            child: Icon(
              LucideIcons.download,
              size: context.widthPct(0.06).clamp(20.0, 26.0),
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}