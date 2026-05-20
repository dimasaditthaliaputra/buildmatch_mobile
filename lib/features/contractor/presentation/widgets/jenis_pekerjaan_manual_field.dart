import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/screen_size.dart';
import '../../../../core/widgets/global_text_field.dart';

class JenisPekerjaanManualField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const JenisPekerjaanManualField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final double padHorizontal = context.widthPct(0.04).clamp(12.0, 16.0);
    final double padVertical = context.heightPct(0.02).clamp(14.0, 18.0);
    final double iconPadding = context.widthPct(0.035).clamp(10.0, 14.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Jenis Pekerjaan',
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 10),
        Stack(
          alignment: Alignment.centerRight,
          children: [
            GlobalTextField(
              controller: controller,
              hintText: 'Masukkan jenis pekerjaan',
              onChanged: onChanged,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppColors.primaryUltraLightGrey,
                  width: 1,
                ),
              ),
              contentPadding: EdgeInsets.only(
                left: padHorizontal, 
                top: padVertical, 
                bottom: padVertical, 
                right: padHorizontal + 30, // Ruang ekstra untuk ikon
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: iconPadding),
              child: Icon(
                LucideIcons.pencilLine,
                size: 18,
                color: AppColors.textSecondary.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ],
    );
  }
}