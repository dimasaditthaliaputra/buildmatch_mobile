import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:buildmatch_mobile/core/theme/app_text_styles.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/global_text_field.dart';
import '../../../../../core/utils/screen_size.dart';
import '../../../../../core/widgets/global_card.dart';

class BudgetRangeInput extends StatefulWidget {
  final int? initialMin;
  final int? initialMax;
  final ValueChanged<int> onMinChanged;
  final ValueChanged<int> onMaxChanged;

  const BudgetRangeInput({
    super.key,
    this.initialMin,
    this.initialMax,
    required this.onMinChanged,
    required this.onMaxChanged,
  });

  @override
  State<BudgetRangeInput> createState() => _BudgetRangeInputState();
}

class _BudgetRangeInputState extends State<BudgetRangeInput> {
  late final TextEditingController _minController;
  late final TextEditingController _maxController;

  @override
  void initState() {
    super.initState();

    String formatInitial(int? value) {
      if (value == null || value == 0) return '';
      final formatter = NumberFormat.currency(
        locale: 'id_ID',
        symbol: 'Rp ',
        decimalDigits: 0,
      );
      return formatter.format(value);
    }

    _minController = TextEditingController(
      text: formatInitial(widget.initialMin),
    );
    _maxController = TextEditingController(
      text: formatInitial(widget.initialMax),
    );
  }

  @override
  void dispose() {
    _minController.dispose();
    _maxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pilih Rentang Budget',
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondaryDark,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _BudgetTextField(
                controller: _minController,
                hint: 'Rp MIN',
                onChanged: (raw) {
                  final val = int.tryParse(raw.replaceAll(RegExp(r'\D'), ''));
                  if (val != null) widget.onMinChanged(val);
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                width: 20,
                height: 2,
                decoration: BoxDecoration(
                  color: AppColors.primaryBlack,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            Expanded(
              child: _BudgetTextField(
                controller: _maxController,
                hint: 'Rp MAKS',
                onChanged: (raw) {
                  final val = int.tryParse(raw.replaceAll(RegExp(r'\D'), ''));
                  if (val != null) widget.onMaxChanged(val);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _BudgetTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final ValueChanged<String> onChanged;

  const _BudgetTextField({
    required this.controller,
    required this.hint,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GlobalCard(
      width: null,
      height: math.max(context.heightPct(0.065), 52.0), 
      
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      backgroundColor: AppColors.surface,
      borderRadius: 12.0,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.04),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
      child: GlobalTextField(
        controller: controller,
        hintText: hint,
        fillColor: AppColors.surface,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [CurrencyInputFormatter()],
        isDense: true,

        textStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),

        hintStyle: AppTextStyles.bodySmall.copyWith(
          color: AppColors.textSecondary,
          fontSize: 14,
        ),

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        onChanged: onChanged,
      ),
    );
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final numericString = newValue.text.replaceAll(RegExp(r'\D'), '');
    if (numericString.isEmpty) return newValue.copyWith(text: '');

    final intValue = int.parse(numericString);

    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    String newText = formatter.format(intValue);

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}