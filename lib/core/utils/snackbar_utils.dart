import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class SnackbarUtils {
  SnackbarUtils._();

  static bool suppressSnackbars = false;

  static void showError(String message) {
    _showSnackbar(
      title: 'Gagal',
      message: message,
      bgColor: AppColors.error,
      icon: LucideIcons.circleAlert,
    );
  }

  static void showSuccess(String message) {
    _showSnackbar(
      title: 'Berhasil',
      message: message,
      bgColor: AppColors.success,
      icon: LucideIcons.circleCheck,
    );
  }

  static void showInfo(String message) {
    _showSnackbar(
      title: 'Informasi',
      message: message,
      bgColor: AppColors.primary,
      icon: LucideIcons.info,
    );
  }

  static void _showSnackbar({
    required String title,
    required String message,
    required Color bgColor,
    required IconData icon,
  }) {
    if (suppressSnackbars) return;

    final messenger = scaffoldMessengerKey.currentState;
    if (messenger == null) return;

    final view = PlatformDispatcher.instance.views.first;
    final double safeAreaBottom = MediaQueryData.fromView(view).padding.bottom;
        
    final double bottomMargin = safeAreaBottom + 86.0;

    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(left: 16, right: 16, bottom: bottomMargin),
        duration: const Duration(seconds: 4),
        content: Container(
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: bgColor.withValues(alpha: 0.5),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: bgColor.withValues(alpha: 0.2),
                blurRadius: 16,
                spreadRadius: 2,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  // Left Accent border (White looks clean on solid vibrant colors)
                  Container(
                    width: 6,
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                  const SizedBox(width: 16),

                  // Refined Status Icon with soft white background circle
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Message Text and Header
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            message,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: Colors.white.withValues(alpha: 0.9),
                              fontWeight: FontWeight.w500,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Close button
                  GestureDetector(
                    onTap: () {
                      scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
                    },
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      alignment: Alignment.center,
                      child: Icon(
                        LucideIcons.x,
                        color: Colors.white.withValues(alpha: 0.7),
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
