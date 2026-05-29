import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

/// A styled text field for the Edit Profile page, with a leading icon and an
/// edit (pencil) icon on the right side.
class ProfileEditFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData leadingIcon;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool enabled;

  const ProfileEditFieldWidget({
    super.key,
    required this.controller,
    required this.label,
    required this.leadingIcon,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondaryDark,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          enabled: enabled,
          style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.surfacePale,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 12, right: 8),
              child: Icon(leadingIcon,
                  color: AppColors.primaryOrange, size: 20),
            ),
            prefixIconConstraints:
                const BoxConstraints(minWidth: 44, minHeight: 44),
            suffixIcon: Icon(
              Icons.edit_outlined,
              color: AppColors.textSecondaryDark.withValues(alpha: 0.5),
              size: 18,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.primaryOrange,
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.error, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.error, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
