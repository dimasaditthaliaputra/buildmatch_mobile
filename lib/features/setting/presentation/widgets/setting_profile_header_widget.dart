import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/utils/screen_size.dart';

/// Displays the user avatar (header section of Setting page).
class SettingProfileHeaderWidget extends StatelessWidget {
  final String? avatarUrl;
  final String displayName;
  final String roleName;

  const SettingProfileHeaderWidget({
    super.key,
    this.avatarUrl,
    required this.displayName,
    required this.roleName,
  });

  @override
  Widget build(BuildContext context) {
    final double avatarRadius = context.widthPct(0.15).clamp(48.0, 72.0);

    return Column(
      children: [
        // ---- Avatar ----
        Container(
          width: avatarRadius * 2,
          height: avatarRadius * 2,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.surface,
            border: Border.all(color: AppColors.surface, width: 4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: ClipOval(
            child: avatarUrl != null && avatarUrl!.isNotEmpty
                ? Image.network(
                    avatarUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, e, s) => _buildPlaceholder(avatarRadius),
                  )
                : _buildPlaceholder(avatarRadius),
          ),
        ),
        const SizedBox(height: 12),

        // ---- Name ----
        Text(
          displayName.isEmpty ? 'Pengguna' : displayName,
          style: AppTextStyles.heading3.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),

        // ---- Role badge ----
        Text(
          _roleLabel(roleName),
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondaryDark,
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceholder(double radius) {
    return Container(
      color: AppColors.surfaceCream,
      child: Icon(
        LucideIcons.userRound,
        size: radius,
        color: AppColors.primaryLight,
      ),
    );
  }

  String _roleLabel(String role) {
    switch (role.toLowerCase()) {
      case 'arsitek':
        return 'Arsitek';
      case 'kontraktor':
        return 'Kontraktor';
      default:
        return 'Klien';
    }
  }
}
