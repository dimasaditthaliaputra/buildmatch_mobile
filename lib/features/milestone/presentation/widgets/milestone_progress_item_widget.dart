import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/idr_formatter.dart';
import '../../../../core/widgets/badge_widget.dart';
import '../../../../core/widgets/global_card.dart';
import '../../domain/entities/progress_entity.dart';

class MilestoneProgressItemWidget extends StatelessWidget {
  final ProgressEntity progress;

  const MilestoneProgressItemWidget({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return GlobalCard(
      margin: const EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.zero,
      backgroundColor: AppColors.surface,
      borderRadius: 12.0,
      borderColor: AppColors.primaryUltraGrey,
      borderWidth: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Progress
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      progress.title,
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      progress.description,
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: AppColors.textDark,
                      ),
                    ),
                  ],
                ),
                Text(
                  '${(progress.percentage * 100).toInt()}%',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.primaryBlue,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1, color: AppColors.primaryLightGrey),

          // Bukti Foto / Upload Area
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (progress.evidencePhotos.isNotEmpty) ...[
                  Text(
                    'Bukti foto',
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      ...progress.evidencePhotos.map(
                        (photo) => Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              photo,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                    width: 60,
                                    height: 60,
                                    color: AppColors.primary,
                                  ),
                            ),
                          ),
                        ),
                      ),
                      if (progress.paymentStatus != 'LUNAS')
                        _buildUploadButton(context),
                    ],
                  ),
                ] else ...[
                  Row(children: [_buildUploadButton(context)]),
                ],
              ],
            ),
          ),

          // Pembayaran & Edit Button
          Container(
            width: double.infinity,
            color: AppColors.surfaceCream,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
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
                            'Pembayaran ${progress.title}',
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            IdrFormatter.formatFull(progress.paymentAmount.toDouble()),
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    BadgeWidget(
                      text: progress.paymentStatus,
                      textColor: progress.paymentStatus == 'LUNAS'
                          ? AppColors.success
                          : AppColors.textLight,
                      backgroundColor: progress.paymentStatus == 'LUNAS'
                          ? AppColors.successBackground
                          : AppColors.primaryLight,
                      borderColor: Colors.transparent,
                      fontSize: 10,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadButton(BuildContext context) {
    return GestureDetector( 
      onTap: () async {
        final ImagePicker picker = ImagePicker();
        try {
          final XFile? image = await picker.pickImage(
            source: ImageSource.camera,
            imageQuality: 80,
          );
          if (image != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Foto berhasil diambil: ${image.name}'),
                backgroundColor: AppColors.success,
              ),
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Gagal membuka kamera: $e'),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColors.primaryLightGrey,
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.add_photo_alternate_outlined,
              color: AppColors.textSecondary,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text('UPLOAD', style: AppTextStyles.labelSmall.copyWith(fontSize: 8)),
          ],
        ),
      ),
    );
  }
}
