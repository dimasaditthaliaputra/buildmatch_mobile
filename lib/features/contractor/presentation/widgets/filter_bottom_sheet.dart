import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:buildmatch_mobile/core/theme/app_colors.dart';
import 'package:buildmatch_mobile/core/theme/app_text_styles.dart';
import 'package:buildmatch_mobile/core/utils/screen_size.dart';
import 'package:buildmatch_mobile/core/widgets/main_button.dart';
import 'package:buildmatch_mobile/core/widgets/global_text_field.dart';
import './budget_range_input.dart';

import '../bloc/contractor_project_request_bloc.dart';
import '../bloc/contractor_project_request_event.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  String _selectedSort = 'Terbaru';
  int? _minBudget;
  int? _maxBudget;
  late final TextEditingController _locationController;

  final List<String> _sortOptions = [
    'Terbaru',
    'Budget Tertinggi',
    'Deadline Terdekat',
  ];

  @override
  void initState() {
    super.initState();
    _locationController = TextEditingController();
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double safeBottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.fromLTRB(
        context.widthPct(0.05),
        24,
        context.widthPct(0.05),
        safeBottomPadding +
            24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 24),
          _buildSectionTitle('Estimasi Anggaran'),
          const SizedBox(height: 12),
          BudgetRangeInput(
            initialMin: _minBudget,
            initialMax: _maxBudget,
            onMinChanged: (val) => setState(() => _minBudget = val),
            onMaxChanged: (val) => setState(() => _maxBudget = val),
          ),
          const SizedBox(height: 24),
          _buildSectionTitle('Urutkan Berdasarkan'),
          const SizedBox(height: 12),
          ..._sortOptions
              .map((option) => _buildSortOption(option, AppColors.primary))
              .toList(),
          const SizedBox(height: 24),
          _buildSectionTitle('Lokasi Proyek'),
          const SizedBox(height: 12),
          GlobalTextField(
            controller: _locationController,
            hintText: 'Masukkan nama kota atau wilayah...',
            fillColor: AppColors.surface,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: MainButton(
              text: 'Terapkan Filter',
              onPressed: () {
                context.read<ContractorProjectRequestBloc>(). add(
                  ApplyContractorProjectFilter(
                    minBudget: _minBudget,
                    maxBudget: _maxBudget,
                    sortOption: _selectedSort,
                    location: _locationController.text,
                  ),
                );
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Projek Parameter',
          style: AppTextStyles.heading2.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            LucideIcons.x,
            color: AppColors.textPrimary,
            size: 22,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: AppTextStyles.bodySmall.copyWith(
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildSortOption(String title, Color orangeColor) {
    bool isSelected = _selectedSort == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedSort = title;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? orangeColor.withOpacity(0.15) : AppColors.surface,
          border: Border.all(color: orangeColor, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            Icon(
              isSelected ? Icons.circle : Icons.radio_button_unchecked,
              color: orangeColor,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
