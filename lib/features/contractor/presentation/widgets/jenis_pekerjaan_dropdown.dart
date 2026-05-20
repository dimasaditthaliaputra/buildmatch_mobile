import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/screen_size.dart';
import '../../domain/entities/contractor_progres_entity.dart';

class JenisPekerjaanDropdown extends StatelessWidget {
  final List<JenisPekerjaanEntity> items;
  final JenisPekerjaanEntity? selectedItem;
  final ValueChanged<JenisPekerjaanEntity?> onChanged;
  final bool isLoading;

  const JenisPekerjaanDropdown({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final double boxHeight = context.heightPct(0.065).clamp(48.0, 56.0);
    final double padHorizontal = context.widthPct(0.04).clamp(12.0, 16.0);

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
        Container(
          height: boxHeight,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: padHorizontal),
          child: isLoading
              ? const Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                )
              : DropdownButtonHideUnderline(
                  child: DropdownButton<JenisPekerjaanEntity>(
                    value: selectedItem,
                    isExpanded: true,
                    hint: Text(
                      'Pilih jenis pekerjaan',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary.withOpacity(0.6),
                      ),
                    ),
                    icon: const Icon(Icons.keyboard_arrow_down_rounded,
                        color: AppColors.textSecondary),
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textPrimary,
                    ),
                    dropdownColor: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    items: items.map((item) {
                      return DropdownMenuItem<JenisPekerjaanEntity>(
                        value: item,
                        child: Text(item.nama),
                      );
                    }).toList(),
                    onChanged: onChanged,
                  ),
                ),
        ),
      ],
    );
  }
}