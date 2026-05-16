import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class GlobalTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final ValueChanged<String>? onChanged;
  final Color fillColor;
  final InputBorder? border;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final TextAlign textAlign;
  final EdgeInsetsGeometry? contentPadding;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool isDense;

  const GlobalTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
    this.onChanged,
    this.fillColor = AppColors.surface, 
    this.border,
    this.hintStyle,
    this.contentPadding,
    this.keyboardType,
    this.textAlign = TextAlign.start,
    this.inputFormatters,
    this.textStyle,
    this.isDense = false,
  });

  @override
  Widget build(BuildContext context) {
    final defaultBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    );

    final defaultHintStyle = AppTextStyles.bodySmall.copyWith(
      color: AppColors.textSecondaryDark.withOpacity(0.5),
      height: 1.6,
    );

    final defaultContentPadding = const EdgeInsets.all(16);

    final defaultTextStyle = AppTextStyles.bodyMedium.copyWith(
      color: AppColors.textPrimary,
    );

    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      textAlign: textAlign,
      inputFormatters: inputFormatters,
      style: textStyle ?? defaultTextStyle,
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor, 
        hintText: hintText,
        hintStyle: hintStyle ?? defaultHintStyle,
        contentPadding: contentPadding ?? defaultContentPadding,
        isDense: isDense, 
        border: border ?? defaultBorder,
        enabledBorder: border ?? defaultBorder,
        focusedBorder: border ?? defaultBorder,
      ),
      onChanged: onChanged,
    );
  }
}