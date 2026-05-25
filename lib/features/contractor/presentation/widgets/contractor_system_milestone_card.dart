import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/global_card.dart';
import '../../../../core/utils/idr_formatter.dart';
import '../../domain/entities/contractor_milestone_entity.dart';
import '../../../../core/utils/date_formatter.dart';

class ContractorSystemMilestoneCard extends StatelessWidget {
  final ContractorMilestoneEntity milestone;
  final ValueChanged<DateTime> onDeadlineChanged;
  final bool isDisabled;

  const ContractorSystemMilestoneCard({
    super.key,
    required this.milestone,
    required this.onDeadlineChanged,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final persenText = '${(milestone.persentase * 100).toStringAsFixed(0)} %';
    final jumlahText = IdrFormatter.formatFull(milestone.jumlahUang);

    return Opacity(
      opacity: isDisabled ? 0.4 : 1.0,
      child: GlobalCard(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              milestone.nama,
              style: AppTextStyles.bodyLarge.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),

            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 11,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primaryLightGrey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    persenText,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jumlah yang Dihitung',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondaryDark,
                          fontSize: 10,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        jumlahText,
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            _DeadlineRow(
              selectedDate: milestone.deadline,
              onDateSelected: onDeadlineChanged,
              isDisabled: isDisabled,
            ),
          ],
        ),
      ),
    );
  }
}

class _DeadlineRow extends StatelessWidget {
  final DateTime? selectedDate;
  final ValueChanged<DateTime> onDateSelected;
  final bool isDisabled;

  const _DeadlineRow({
    required this.selectedDate,
    required this.onDateSelected,
    this.isDisabled = false,
  });

  Future<void> _pick(BuildContext context) async {
    if (isDisabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Silakan atur deadline milestone sebelumnya terlebih dahulu.',
          ),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now.add(const Duration(days: 30)),
      firstDate: now,
      lastDate: now.add(const Duration(days: 365 * 3)),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: const ColorScheme.light(
            primary: AppColors.primary,
            onPrimary: AppColors.surface,
            surface: AppColors.surface,
            onSurface: AppColors.textPrimary,
          ),
          dialogBackgroundColor: AppColors.surface,
        ),
        child: child!,
      ),
    );
    if (picked != null) onDateSelected(picked);
  }

  @override
  Widget build(BuildContext context) {
    final hasDate = selectedDate != null;
    final label = hasDate
        ? DateFormat('dd MMM yyyy').format(selectedDate!)
        : 'Select Date';

    return GestureDetector(
      onTap: () => _pick(context),
      child: Row(
        children: [
          Icon(
            Icons.calendar_today_outlined,
            size: 16,
            color: AppColors.textSecondaryDark,
          ),
          const SizedBox(width: 8),
          Text(
            'Deadline',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondaryDark,
            ),
          ),
          const Spacer(),
          Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(
              color: hasDate ? AppColors.textPrimary : AppColors.textSecondary,
              fontWeight: hasDate ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
