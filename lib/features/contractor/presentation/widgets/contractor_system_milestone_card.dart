import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/global_card.dart';
import '../../../../core/utils/idr_formatter.dart';
import '../../domain/entities/contractor_milestone_entity.dart';
import 'estimasi_waktu_picker.dart';

class ContractorSystemMilestoneCard extends StatelessWidget {
  final ContractorMilestoneEntity milestone;
  final ValueChanged<DateTime> onDeadlineChanged;

  const ContractorSystemMilestoneCard({
    super.key,
    required this.milestone,
    required this.onDeadlineChanged,
  });

  @override
  Widget build(BuildContext context) {
    final persenText =
        '${(milestone.persentase * 100).toStringAsFixed(0)} %';
    final jumlahText = IdrFormatter.formatFull(milestone.jumlahUang);

    return GlobalCard(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Title
          Text(
            milestone.nama,
            style: AppTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),

          // ── Percentage box + calculated amount
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // percentage field (read-only style)
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 11),
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

              // calculated amount label
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

          // ── Deadline — reuse EstimasiWaktuPicker (local widget)
          // We build a slim row version matching the design
          _DeadlineRow(
            selectedDate: milestone.deadline,
            onDateSelected: onDeadlineChanged,
          ),
        ],
      ),
    );
  }
}

/// Slim inline deadline row that wraps EstimasiWaktuPicker's date-picker
/// logic but displays as the compact "Deadline  |  15 Mei 2026" row shown
/// in the Dari Sistem design.
class _DeadlineRow extends StatelessWidget {
  final DateTime? selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  const _DeadlineRow({
    required this.selectedDate,
    required this.onDateSelected,
  });

  Future<void> _pick(BuildContext context) async {
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
        ? DateFormat('dd MMM yyyy', 'id_ID').format(selectedDate!)
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
              fontWeight:
                  hasDate ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
