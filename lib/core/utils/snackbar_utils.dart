import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class SnackbarUtils {
  SnackbarUtils._();

  static bool suppressSnackbars = false;

  static void showError(String message) {
    _showSnackbar(message, AppColors.error, Icons.error_outline_rounded);
  }

  static void showSuccess(String message) {
    _showSnackbar(message, AppColors.success, Icons.check_circle_outline_rounded);
  }

  static void showInfo(String message) {
    _showSnackbar(message, AppColors.primary, Icons.info_outline_rounded);
  }

  static void _showSnackbar(String message, Color bgColor, IconData icon) {
    if (suppressSnackbars) return;
    
    final messenger = scaffoldMessengerKey.currentState;
    if (messenger == null) return;

    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: bgColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        duration: const Duration(seconds: 4),
      ),
    );
  }
}
