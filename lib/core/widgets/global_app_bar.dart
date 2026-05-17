import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class GlobalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color? titleColor;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;
  final bool centerTitle;
  final Color backgroundColor;

  const GlobalAppBar({
    super.key,
    required this.title,
    this.titleColor,
    this.onBackPressed,
    this.actions,
    this.centerTitle = false,
    this.backgroundColor = AppColors.background,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Ukuran responsif
    final double padLeft = (size.width * 0.04).clamp(14.0, 20.0);
    final double iconSize = (size.width * 0.06).clamp(20.0, 28.0);
    final double titleFontSize = (size.width * 0.045).clamp(16.0, 22.0);

    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leading: Padding(
        padding: EdgeInsets.only(left: padLeft),
        child: GestureDetector(
          onTap:
              onBackPressed ??
              () {
                if (context.canPop()) {
                  context.pop();
                }
              },
          child: Icon(
            LucideIcons.arrowLeft,
            color: AppColors.textPrimary,
            size: iconSize,
          ),
        ),
      ),
      title: Text(
        title,
        style: AppTextStyles.heading3.copyWith(
          fontSize: titleFontSize,
          fontWeight: FontWeight.w800,
          color: titleColor ?? AppColors.primary,
        ),
      ),
      centerTitle: centerTitle,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
