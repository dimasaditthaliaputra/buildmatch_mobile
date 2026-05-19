import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;
  final VoidCallback? onClear;
  
  final String hintText;
  final TextStyle? hintStyle;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? contentPadding;
  
  final Color? fillColor;
  final Color? containerColor;
  final double borderRadius;
  final BorderSide borderSide;
  final List<BoxShadow>? boxShadow;

  const SearchBarWidget({
    super.key,
    required this.controller,
    this.onChanged,
    this.onClear,
    this.hintText = 'Cari...',
    this.hintStyle,
    this.margin,
    this.contentPadding,
    this.fillColor,
    this.containerColor = AppColors.surface,
    this.borderRadius = 12.0,
    this.borderSide = BorderSide.none,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: containerColor,
        boxShadow: boxShadow,
        borderRadius: BorderRadius.circular(borderRadius),
      ),

      child: ValueListenableBuilder<TextEditingValue>(
        valueListenable: controller,
        builder: (context, value, child) {
          return TextField(
            controller: controller,
            onChanged: onChanged,
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: hintStyle ?? AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              prefixIcon: const Icon(
                Icons.search_rounded,
                color: AppColors.textSecondary,
                size: 22,
              ),
              suffixIcon: value.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.close, size: 20),
                      color: AppColors.textSecondary,
                      onPressed: () {
                        controller.clear();
                        onClear?.call();
                        onChanged?.call(''); 
                      },
                    )
                  : null,
              filled: true,
              fillColor: fillColor ?? AppColors.primaryUltraLightGrey.withOpacity(0.5),
              contentPadding: contentPadding ?? const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: borderSide,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: borderSide,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: borderSide,
              ),
            ),
          );
        },
      ),
    );
  }
}