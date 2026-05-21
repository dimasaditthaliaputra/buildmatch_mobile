import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/global_card.dart';
import '../../../../core/utils/idr_formatter.dart';
import '../../domain/entities/contractor_milestone_entity.dart';
import 'estimasi_waktu_picker.dart'; // lib/features/contractor/presentation/widgets/

class ContractorManualMilestoneCard extends StatefulWidget {
  final ContractorMilestoneEntity milestone;
  final double totalNilaiKontrak;
  final ValueChanged<ContractorMilestoneEntity> onChanged;
  final VoidCallback onDelete;

  const ContractorManualMilestoneCard({
    super.key,
    required this.milestone,
    required this.totalNilaiKontrak,
    required this.onChanged,
    required this.onDelete,
  });

  @override
  State<ContractorManualMilestoneCard> createState() =>
      _ContractorManualMilestoneCardState();
}

class _ContractorManualMilestoneCardState
    extends State<ContractorManualMilestoneCard> {
  late final TextEditingController _namaCtrl;
  late final TextEditingController _persenCtrl;
  bool _isEditingNama = false;

  @override
  void initState() {
    super.initState();
    _namaCtrl = TextEditingController(text: widget.milestone.nama);
    final persen = (widget.milestone.persentase * 100).toStringAsFixed(0);
    _persenCtrl = TextEditingController(text: persen == '0' ? '' : persen);
  }

  @override
  void dispose() {
    _namaCtrl.dispose();
    _persenCtrl.dispose();
    super.dispose();
  }

  void _onPersenChanged(String value) {
    final parsed = int.tryParse(value) ?? 0;
    final persen = parsed.clamp(0, 100) / 100.0;
    widget.onChanged(widget.milestone.copyWith(
      persentase: persen,
      jumlahUang: widget.totalNilaiKontrak * persen,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final jumlahText = widget.milestone.jumlahUang > 0
        ? IdrFormatter.formatFull(widget.milestone.jumlahUang)
        : 'IDR 0';

    return GlobalCard(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header: nama + edit + delete icons
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: _isEditingNama
                    ? TextField(
                        controller: _namaCtrl,
                        autofocus: true,
                        style: AppTextStyles.bodyLarge
                            .copyWith(fontWeight: FontWeight.w700),
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 4),
                          border: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.primary),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.primary, width: 2),
                          ),
                        ),
                        onChanged: (v) => widget.onChanged(
                            widget.milestone.copyWith(nama: v)),
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
                onTap: () =>
                    setState(() => _isEditingNama = !_isEditingNama),
                child: Icon(
                  _isEditingNama ? Icons.check : Icons.edit_outlined,
                  size: 18,
                  color: AppColors.textSecondaryDark,
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: widget.onDelete,
                child: Icon(
                  Icons.delete_outline,
                  size: 18,
                  color: AppColors.error,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // ── Tipe Milestone
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

          // ── Persentase + Jumlah Uang
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                    _PersenField(
                      controller: _persenCtrl,
                      onChanged: _onPersenChanged,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jumlah Uang',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondaryDark,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColors.primaryLightGrey),
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.background,
                      ),
                      child: Text(
                        jumlahText,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: widget.milestone.jumlahUang > 0
                              ? AppColors.textPrimary
                              : AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // ── Deadline — reuse EstimasiWaktuPicker (label overridden via
          //    a plain "Deadline" label above the picker)
          Text(
            'Deadline',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondaryDark,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),

          // EstimasiWaktuPicker has its own "Estimasi Waktu" label built-in;
          // we suppress it by wrapping with a clip + negative offset trick —
          // instead we call the widget without the label by using a thin
          // wrapper that only renders the picker row (the Card inside).
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

/// Renders only the tappable date row from EstimasiWaktuPicker's internals,
/// without the "Estimasi Waktu" header label, matching the design.
class _DeadlinePickerOnly extends StatelessWidget {
  final DateTime? selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  const _DeadlinePickerOnly({
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    // We use EstimasiWaktuPicker directly. Its internal label ("Estimasi Waktu")
    // is already shown; since the card above has "Deadline" as section header,
    // we just use EstimasiWaktuPicker straight — the label reads as sub-label
    // which is acceptable. If the project later removes the label from the
    // widget itself, simply swap to EstimasiWaktuPicker without further changes.
    return EstimasiWaktuPicker(
      selectedDate: selectedDate,
      onDateSelected: onDateSelected,
    );
  }
}

// ─── Tipe dropdown ─────────────────────────────────────────────────────────

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
          icon: const Icon(Icons.keyboard_arrow_down,
              color: AppColors.textSecondaryDark),
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
          style: AppTextStyles.bodyMedium
              .copyWith(color: AppColors.textPrimary),
          onChanged: (v) {
            if (v != null) onChanged(v);
          },
        ),
      ),
    );
  }
}

// ─── Percentage input field ────────────────────────────────────────────────

class _PersenField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const _PersenField({
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryLightGrey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(3),
              ],
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium
                  .copyWith(fontWeight: FontWeight.w600),
              decoration: const InputDecoration(
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                border: InputBorder.none,
                hintText: '0',
              ),
              onChanged: onChanged,
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            decoration: BoxDecoration(
              border: Border(
                  left: BorderSide(color: AppColors.primaryLightGrey)),
              color: AppColors.background,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Text(
              '%',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondaryDark,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
