import 'package:buildmatch_mobile/core/theme/app_colors.dart';
import 'package:buildmatch_mobile/core/theme/app_text_styles.dart';
import 'package:buildmatch_mobile/core/utils/date_formatter.dart';
import 'package:buildmatch_mobile/core/utils/screen_size.dart';
import 'package:buildmatch_mobile/core/widgets/global_card.dart';
import 'package:flutter/material.dart';


class EstimasiWaktuPicker extends StatelessWidget {
  final DateTime? selectedDate;
  final String? errorText;
  final ValueChanged<DateTime> onDateSelected;

  const EstimasiWaktuPicker({
    super.key,
    this.selectedDate,
    this.errorText,
    required this.onDateSelected,
  });

  Future<void> _pickDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now.add(const Duration(days: 30)),
      firstDate: now,
      lastDate: now.add(const Duration(days: 365 * 3)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: AppColors.surface,
              surface: AppColors.surface,
              onSurface: AppColors.textPrimary,
            ),
            dialogBackgroundColor: AppColors.surface,
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasDate = selectedDate != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Estimasi Waktu',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondaryDark,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        
        GlobalCard(
          onTap: () => _pickDate(context),
          width: context.screenWidth,
          margin: EdgeInsets.zero,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          backgroundColor: AppColors.surface,
          borderRadius: 12.0,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
          child: Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 18,
                color: hasDate ? AppColors.primary : AppColors.textPrimary,
              ),
              const SizedBox(width: 10),
              Text(
                hasDate
                    ? DateFormatter.formatDate(selectedDate!)
                    : 'dd/mm/yyyy',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: hasDate
                      ? AppColors.textPrimary
                      : AppColors.textPrimary.withOpacity(0.6),
                  fontWeight: hasDate ? FontWeight.w500 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: 6),
          Text(
            errorText!,
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.error,
            ),
          ),
        ],
      ],
    );
  }
}