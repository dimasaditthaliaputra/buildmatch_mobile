import 'package:buildmatch_mobile/core/theme/app_colors.dart';
import 'package:buildmatch_mobile/core/theme/app_text_styles.dart';
import 'package:buildmatch_mobile/core/utils/screen_size.dart';
import 'package:buildmatch_mobile/core/widgets/global_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hintText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int maxLines;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;

  const ProfileFormFieldWidget({
    super.key,
    required this.controller,
    required this.label,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.onChanged,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    final double labelFontSize = (context.screenWidth * 0.038).clamp(13.0, 16.0);
    final double inputFontSize = (context.screenWidth * 0.038).clamp(13.0, 15.0);

    return FormField<String>(
      validator: validator,
      initialValue: controller.text,
      builder: (FormFieldState<String> state) {
        // Synchronize FormFieldState with TextEditingController changes
        controller.addListener(() {
          if (state.value != controller.text) {
            state.didChange(controller.text);
          }
        });

        final hasError = state.hasError;

        // Auto-assign digitsOnly formatter for numbers and phone types if no formatters are specified
        final formatters = inputFormatters ??
            ((keyboardType == TextInputType.number || keyboardType == TextInputType.phone)
                ? [FilteringTextInputFormatter.digitsOnly]
                : null);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: AppTextStyles.bodyMedium.copyWith(
                fontSize: labelFontSize,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: hasError ? Colors.redAccent : AppColors.primaryDarkGrey.withAlpha(70),
                  width: hasError ? 1.5 : 1.0,
                ),
              ),
              child: Row(
                crossAxisAlignment: maxLines > 1
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.center,
                children: [
                  if (prefixIcon != null) ...[
                    const SizedBox(width: 14),
                    Padding(
                      padding: EdgeInsets.only(
                        top: maxLines > 1 ? 14 : 0,
                      ),
                      child: IconTheme(
                        data: IconThemeData(
                          color: hasError
                              ? Colors.redAccent
                              : AppColors.primary.withValues(alpha: 0.8),
                        ),
                        child: prefixIcon!,
                      ),
                    ),
                  ],
                  Expanded(
                    child: GlobalTextField(
                      controller: controller,
                      hintText: hintText ?? '',
                      maxLines: maxLines,
                      keyboardType: keyboardType,
                      inputFormatters: formatters,
                      onChanged: (val) {
                        state.didChange(val);
                        if (onChanged != null) onChanged!(val);
                      },
                      fillColor: Colors.transparent,
                      textStyle: AppTextStyles.bodyMedium.copyWith(
                        fontSize: inputFontSize,
                        color: AppColors.textPrimary,
                      ),
                      hintStyle: AppTextStyles.bodyMedium.copyWith(
                        fontSize: inputFontSize,
                        color: AppColors.textSecondaryDark.withOpacity(0.5),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 14,
                      ),
                      // Clear border inside GlobalTextField since the container handles it
                      border: InputBorder.none,
                    ),
                  ),
                  if (suffixIcon != null) ...[
                    IconTheme(
                      data: IconThemeData(
                        color: hasError
                            ? Colors.redAccent
                            : AppColors.textSecondaryDark.withOpacity(0.7),
                      ),
                      child: suffixIcon!,
                    ),
                    const SizedBox(width: 14),
                  ],
                ],
              ),
            ),
            if (hasError) ...[
              const SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Text(
                  state.errorText!,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Colors.redAccent,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
