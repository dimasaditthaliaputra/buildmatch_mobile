import 'package:buildmatch_mobile/core/theme/app_colors.dart';
import 'package:buildmatch_mobile/core/theme/app_text_styles.dart';
import 'package:buildmatch_mobile/core/utils/screen_size.dart';
import 'package:buildmatch_mobile/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:buildmatch_mobile/features/auth/presentation/bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:go_router/go_router.dart';


class ProfilePlaceholderPage extends StatelessWidget {
  final String role;

  const ProfilePlaceholderPage({
    super.key,
    required this.role,
  });

  Color _getRoleColor() {
    switch (role.toLowerCase()) {
      case 'contractor':
        return AppColors.contractorPrimary;
      case 'architect':
        return AppColors.architectPrimary;
      default:
        return AppColors.primary;
    }
  }

  Color _getRoleBgColor() {
    return _getRoleColor().withOpacity(0.08);
  }

  @override
  Widget build(BuildContext context) {
    final roleColor = _getRoleColor();
    final roleBg = _getRoleBgColor();
    final String displayName = role.toUpperCase();
    final String email = '${role.toLowerCase()}@buildmatch.com';

    final double paddingHorizontal = context.widthPct(0.06).clamp(16.0, 24.0);
    final double avatarSize = context.widthPct(0.24).clamp(80.0, 110.0);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Elegant Header Accent Background
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: context.heightPct(0.22),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    roleColor,
                    roleColor.withOpacity(0.85),
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 24),
                // Screen Title
                Text(
                  'Profil Saya',
                  style: AppTextStyles.heading2.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 20),

                // Main Scrollable Content
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
                    child: Column(
                      children: [
                        // User Avatar Card with details
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                            border: Border.all(
                              color: AppColors.border.withOpacity(0.5),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              // Avatar
                              Container(
                                width: avatarSize,
                                height: avatarSize,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 4),
                                  boxShadow: [
                                    BoxShadow(
                                      color: roleColor.withOpacity(0.2),
                                      blurRadius: 16,
                                      offset: const Offset(0, 6),
                                    ),
                                  ],
                                  color: roleColor.withOpacity(0.1),
                                ),
                                child: ClipOval(
                                  child: Icon(
                                    LucideIcons.user,
                                    size: avatarSize * 0.45,
                                    color: roleColor,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              
                              // Name
                              Text(
                                'Pengguna $displayName',
                                style: AppTextStyles.heading3.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 6),
                              
                              // Role Badge
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                                decoration: BoxDecoration(
                                  color: roleBg,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Text(
                                  displayName,
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: roleColor,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              
                              // Email
                              Text(
                                email,
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.textSecondaryDark,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Menu Options Card
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                            border: Border.all(
                              color: AppColors.border.withOpacity(0.5),
                              width: 1,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Column(
                              children: [
                                _buildMenuTile(
                                  icon: LucideIcons.userCheck,
                                  title: 'Lengkapi Data Diri',
                                  subtitle: 'Nama, NIK, NPWP & Sertifikat',
                                  iconColor: roleColor,
                                  onTap: () {
                                    context.push('/setup-profile', extra: role);
                                  },
                                ),
                                const Divider(height: 1, indent: 64),
                                _buildMenuTile(
                                  icon: LucideIcons.settings,
                                  title: 'Pengaturan Akun',
                                  subtitle: 'Keamanan, Bahasa & Notifikasi',
                                  iconColor: Colors.blueGrey,
                                  onTap: () {},
                                ),
                                const Divider(height: 1, indent: 64),
                                _buildMenuTile(
                                  icon: LucideIcons.settings,
                                  title: 'Pusat Bantuan',
                                  subtitle: 'FAQ & Hubungi Customer Service',
                                  iconColor: Colors.teal,
                                  onTap: () {},
                                ),
                                const Divider(height: 1, indent: 64),
                                _buildMenuTile(
                                  icon: LucideIcons.logOut,
                                  title: 'Keluar',
                                  subtitle: 'Keluar dari akun Anda secara aman',
                                  iconColor: AppColors.error,
                                  onTap: () => _showLogoutDialog(context),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: iconColor, size: 22),
      ),
      title: Text(
        title,
        style: AppTextStyles.bodyMedium.copyWith(
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Text(
          subtitle,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondaryDark,
            fontSize: 12,
          ),
        ),
      ),
      trailing: const Icon(
        LucideIcons.chevronRight,
        size: 18,
        color: AppColors.textSecondary,
      ),
      onTap: onTap,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Konfirmasi Keluar',
          style: AppTextStyles.heading3.copyWith(fontWeight: FontWeight.bold),
        ),
        content: Text(
          'Apakah Anda yakin ingin keluar dari akun Anda?',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondaryDark,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              'Batal',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondaryDark,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<AuthBloc>().add(AuthLogoutRequested());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
  }
}
