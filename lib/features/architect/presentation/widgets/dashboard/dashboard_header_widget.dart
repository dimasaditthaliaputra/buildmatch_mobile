import 'package:flutter/material.dart';
import 'package:buildmatch_mobile/core/theme/app_colors.dart';
import 'package:buildmatch_mobile/core/theme/app_text_styles.dart';
import 'package:buildmatch_mobile/core/utils/screen_size.dart';

class DashboardHeaderWidget extends StatelessWidget {
  final String architectName;
  final String architectRole;
  final String? avatarUrl;
  final VoidCallback? onNotificationTap;
  final bool hasUnreadNotification;

  const DashboardHeaderWidget({
    super.key,
    required this.architectName,
    required this.architectRole,
    this.avatarUrl,
    this.onNotificationTap,
    this.hasUnreadNotification = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              _buildAvatar(context),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Arsitek Dashboard',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textLight,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'BuildMatch',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textLight,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              _buildNotificationButton(),
            ],
          ),
          
          const SizedBox(height: 24),
          
          Text(
            'Selamat Datang,',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textLight,
              fontWeight: FontWeight.w700,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            architectName,
            style: AppTextStyles.heading2.copyWith(
              color: AppColors.textLight,
              fontWeight: FontWeight.w700,
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    return Container(
      width: context.widthPct(0.13), 
      height: context.widthPct(0.13),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.textLight.withOpacity(0.2),
        border: Border.all(color: AppColors.textLight.withOpacity(0.5), width: 2),
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
      child: Text(
        architectName.isNotEmpty ? architectName[0].toUpperCase() : 'U',
        style: const TextStyle(
          color: AppColors.textLight,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _buildNotificationButton() {
    return GestureDetector(
      onTap: onNotificationTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.notifications_none_rounded, 
              color: AppColors.textLight,
              size: 28,
            ),
          ),
          if (hasUnreadNotification)
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: AppColors.error,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.transparent,
                    width: 0,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}