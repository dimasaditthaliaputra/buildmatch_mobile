import 'package:buildmatch_mobile/core/theme/app_colors.dart';
import 'package:buildmatch_mobile/core/theme/app_text_styles.dart';
import 'package:buildmatch_mobile/core/widgets/global_card.dart';
import 'package:buildmatch_mobile/features/architect/domain/entities/architect_milestone_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'estimasi_waktu_picker.dart';

class ArchitectManualMilestoneCard extends StatefulWidget {
  final int index;
  final ArchitectMilestoneEntity milestone;
  final double totalNilaiKontrak;
  final ValueChanged<ArchitectMilestoneEntity> onChanged;
  final VoidCallback onDelete;

  const ArchitectManualMilestoneCard({
    super.key,
    required this.index,
    required this.milestone,
    required this.totalNilaiKontrak,
    required this.onChanged,
    required this.onDelete,
  });

  @override
  State<ArchitectManualMilestoneCard> createState() =>
      _ArchitectManualMilestoneCardState();
}

class _ArchitectManualMilestoneCardState
    extends State<ArchitectManualMilestoneCard> {
  late final TextEditingController _namaCtrl;
  late final TextEditingController _uangCtrl;
  bool _isEditingNama = false;

  @override
  void initState() {
    super.initState();
    _namaCtrl = TextEditingController(text: widget.milestone.nama);

    final uangInt = widget.milestone.jumlahUang.toInt();
    final uangStr = uangInt == 0
        ? ''
        : NumberFormat.decimalPattern('id_ID').format(uangInt);
    _uangCtrl = TextEditingController(text: uangStr);
  }

  @override
  void dispose() {
    _namaCtrl.dispose();
    _uangCtrl.dispose();
    super.dispose();
  }

  void _onUangChanged(String value) {
    final cleanValue = value.replaceAll(RegExp(r'[^0-9]'), '');
    final parsedUang = double.tryParse(cleanValue) ?? 0.0;

    if (cleanValue.isNotEmpty) {
      final formattedValue = NumberFormat.decimalPattern(
        'id_ID',
      ).format(int.parse(cleanValue));
      _uangCtrl.value = TextEditingValue(
        text: formattedValue,
        selection: TextSelection.collapsed(offset: formattedValue.length),
      );
    } else {
      _uangCtrl.value = const TextEditingValue(text: '');
    }

    double persen = 0.0;
    if (widget.totalNilaiKontrak > 0) {
      persen = parsedUang / widget.totalNilaiKontrak;
    }

    widget.onChanged(
      widget.milestone.copyWith(persentase: persen, jumlahUang: parsedUang),
    );
  }

  @override
  Widget build(BuildContext context) {
    final persenText =
        '${(widget.milestone.persentase * 100).toStringAsFixed(1)} %';

    return GlobalCard(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: _isEditingNama
                    ? TextField(
                        controller: _namaCtrl,
                        autofocus: true,
                        style: AppTextStyles.bodyLarge.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 4,
                          ),
                          border: const UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.primary),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.primary,
                              width: 2,
                            ),
                          ),
                        ),
                        onChanged: (v) => widget.onChanged(
                          widget.milestone.copyWith(nama: v),
                        ),
                        onSubmitted: (_) =>
                            setState(() => _isEditingNama = false),
                      )
                    : Text(
                        widget.milestone.nama,
                        style: AppTextStyles.bodyLarge.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () => setState(() => _isEditingNama = !_isEditingNama),
                child: Icon(
                  _isEditingNama ? Icons.check : Icons.edit_outlined,
                  size: 18,
                  color: AppColors.textSecondaryDark,
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: widget.onDelete,
                child: const Icon(
                  Icons.delete_outline,
                  size: 18,
                  color: AppColors.error,
                ),
              ),
              const SizedBox(width: 12),
              ReorderableDragStartListener(
                index: widget.index,
                child: const Icon(
                  Icons.drag_handle,
                  size: 22,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          Text(
            'Tipe Milestone',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondaryDark,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          _TipeDropdown(
            value: widget.milestone.tipe,
            onChanged: (tipe) =>
                widget.onChanged(widget.milestone.copyWith(tipe: tipe)),
          ),
          const SizedBox(height: 12),

          // --- BAGIAN INI SUDAH DITUKAR (Uang di Kiri, Persentase di Kanan) ---
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jumlah Uang (IDR)',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondaryDark,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    _UangField(
                      controller: _uangCtrl,
                      onChanged: _onUangChanged,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Persentase',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondaryDark,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primaryLightGrey),
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.background,
                      ),
                      child: Text(
                        persenText,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: widget.milestone.persentase > 0
                              ? AppColors.textPrimary
                              : AppColors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // -------------------------------------------------------------------
          const SizedBox(height: 12),

          Text(
            'Deadline',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondaryDark,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          _DeadlinePickerOnly(
            selectedDate: widget.milestone.deadline,
            onDateSelected: (date) =>
                widget.onChanged(widget.milestone.copyWith(deadline: date)),
          ),
        ],
      ),
    );
  }
}

class _DeadlinePickerOnly extends StatelessWidget {
  final DateTime? selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  const _DeadlinePickerOnly({
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return EstimasiWaktuPicker(
      selectedDate: selectedDate,
      onDateSelected: onDateSelected,
    );
  }
}

class _TipeDropdown extends StatelessWidget {
  final MilestoneTipe value;
  final ValueChanged<MilestoneTipe> onChanged;

  const _TipeDropdown({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryLightGrey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<MilestoneTipe>(
          value: value,
          isExpanded: true,
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.textSecondaryDark,
          ),
          items: const [
            DropdownMenuItem(
              value: MilestoneTipe.nonPembangunan,
              child: Text('Non-pembangunan'),
            ),
            DropdownMenuItem(
              value: MilestoneTipe.pembangunan,
              child: Text('Pembangunan'),
            ),
          ],
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textPrimary,
          ),
          onChanged: (v) {
            if (v != null) onChanged(v);
          },
        ),
      ),
    );
  }
}

class _UangField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const _UangField({required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryLightGrey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600),
        decoration: const InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          border: InputBorder.none,
          hintText: '0',
          prefixText: 'Rp ',
        ),
        onChanged: onChanged,
      ),
    );
  }
}
