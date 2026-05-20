import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class ClientHeaderWidget extends StatelessWidget {
  final String clientName;
  final String greeting;
  final String? avatarUrl;
  final VoidCallback? onNotificationTap;

  const ClientHeaderWidget({
    super.key,
    required this.clientName,
    required this.greeting,
    this.avatarUrl,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      child: Row(
        children: [
          _buildAvatar(),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  greeting,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textLight,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                Text(
                  clientName,
                  style: AppTextStyles.heading3.copyWith(
                    color: AppColors.textLight,
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          _buildNotificationButton(),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.textLight.withOpacity(0.25),
        border:
            Border.all(color: AppColors.textLight.withOpacity(0.5), width: 2),
      ),
      child: avatarUrl != null
          ? ClipOval(
              child: Image.network(
                avatarUrl!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _buildAvatarFallback(),
              ),
            )
          : _buildAvatarFallback(),
    );
  }

  Widget _buildAvatarFallback() {
    return Center(
      child: Icon(
        Icons.person_rounded,
        color: AppColors.textLight,
        size: 24,
      ),
    );
  }

  Widget _buildNotificationButton() {
    return GestureDetector(
      onTap: onNotificationTap,
      child: const Icon(
        LucideIcons.bell,
        color: AppColors.textLight,
        size: 24,
      ),
    );
  }
}
