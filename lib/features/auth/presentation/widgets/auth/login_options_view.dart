import 'package:buildmatch_mobile/core/utils/screen_size.dart';
import 'package:buildmatch_mobile/core/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../../core/theme/app_colors.dart';

class LoginOptionsView extends StatelessWidget {
  final VoidCallback onEmailLoginTapped;
  final VoidCallback onRegisterTapped;

  const LoginOptionsView({
    super.key,
    required this.onEmailLoginTapped,
    required this.onRegisterTapped,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.screenWidth;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                const Logo(),
                const SizedBox(height: 16),

                // App Name
                Text(
                  'BuildMatch',
                  style: GoogleFonts.inter(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 16),

                // Tagline
                Text(
                  'Wujudkan proyek impian Anda\nbersama profesional terpercaya.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 48),

                // Google Login Button
                ElevatedButton(
                  onPressed: () {
                    context.go('/home');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.textPrimary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Colors.grey.shade300),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/google.png',
                        height: (screenWidth * 0.1).clamp(12, 24),
                        width: (screenWidth * 0.1).clamp(12, 24),
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(LucideIcons.sun, color: Colors.blue),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Masuk Dengan Google',
                        style: GoogleFonts.inter(
                          fontSize: (screenWidth * 0.1).clamp(12, 16),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Divider
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey.shade300)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'ATAU',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey.shade300)),
                  ],
                ),
                const SizedBox(height: 32),

                // Email Login Text Button
                GestureDetector(
                  onTap: onEmailLoginTapped,
                  child: Text(
                    'Masuk Menggunakan Email',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Register Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Apakah Sudah Mempunyai Akun? ',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    GestureDetector(
                      onTap: onRegisterTapped,
                      child: Text(
                        'Daftar',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors
                              .warning, // Or AppColors.primary based on image. The image says 'Daftar' in yellow/orange.
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 48),
              ],
            ),
          ),
          // Terms and Conditions
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: GoogleFonts.inter(
                fontSize: 12,
                color: AppColors.textPrimary.withOpacity(0.6),
              ),
              children: [
                const TextSpan(text: 'Dengan mendaftar, Anda menyetujui '),
                TextSpan(
                  text: 'Ketentuan',
                  style: GoogleFonts.inter(
                    color: AppColors.warning,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const TextSpan(text: ' & \n'),
                TextSpan(
                  text: 'Kebijakan',
                  style: GoogleFonts.inter(
                    color: AppColors.warning,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const TextSpan(text: ' kami.'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
