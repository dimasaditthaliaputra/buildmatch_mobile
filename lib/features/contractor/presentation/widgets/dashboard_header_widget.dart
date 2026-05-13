import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class DashboardHeaderWidget extends StatelessWidget {
  final String contractorName;
  final String contractorRole;
  final String? avatarUrl;
  final VoidCallback? onNotificationTap;

  const DashboardHeaderWidget({
    super.key,
    required this.contractorName,
    required this.contractorRole,
    this.avatarUrl,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // ─── Baris Atas: Profil & Notifikasi ──────────────────────────
          Row(
            children: [
              _buildAvatar(),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kontraktor Dashboard',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textLight,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'BuildMatch',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textLight,
                        fontWeight: FontWeight.w500,
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
          
          // ─── Baris Bawah: Ucapan Selamat Datang ───────────────────────
          Text(
            'Selamat Datang,',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textLight,
              fontWeight: FontWeight.w700,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            contractorName,
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

  Widget _buildAvatar() {
    return Container(
      width: 50, 
      height: 48,
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
        contractorName.isNotEmpty ? contractorName[0].toUpperCase() : 'U',
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
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(
          Icons.notifications_none_rounded, 
          color: AppColors.textLight,
          size: 24,
        ),
      ),
    );
  }
}