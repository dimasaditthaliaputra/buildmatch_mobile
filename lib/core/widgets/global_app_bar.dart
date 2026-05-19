import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final bool? showBackButton;
  final double? titleFontSize;
  final FontWeight? titleFontWeight;
  final double? titleSpacing;

  const GlobalAppBar({
    super.key,
    required this.title,
    this.titleColor,
    this.onBackPressed,
    this.actions,
    this.centerTitle = false,
    this.backgroundColor = AppColors.background,
    this.showBackButton,
    this.titleFontSize,
    this.titleFontWeight,
    this.titleSpacing,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Ukuran responsif
    final double padLeft = (size.width * 0.04).clamp(14.0, 20.0);
    final double iconSize = (size.width * 0.06).clamp(20.0, 28.0);
    final double baseTitleFontSize = (size.width * 0.05).clamp(16.0, 24.0);
    final double fontSize = titleFontSize ?? baseTitleFontSize;
    final FontWeight fontWeight =
        titleFontWeight ?? FontWeight.w800;

    final bool canPop = context.canPop();
    final bool shouldShowBack = showBackButton ?? canPop;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
      ),
      backgroundColor: backgroundColor,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      titleSpacing: titleSpacing,
      leading: shouldShowBack
          ? Padding(
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
            )
          : null,
      title: Text(
        title,
        style: AppTextStyles.heading3.copyWith(
          fontSize: fontSize,
          fontWeight: fontWeight,
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
