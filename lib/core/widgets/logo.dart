import 'package:buildmatch_mobile/core/theme/app_colors.dart';
import 'package:buildmatch_mobile/core/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class Logo extends StatelessWidget {
  final double? sizeContainer;
  final double? sizeLogo;
  final Color? color;
  final IconData? iconName;

  const Logo({
    super.key,
    this.sizeContainer,
    this.sizeLogo,
    this.color,
    this.iconName,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.screenWidth;

    return Container(
      width: sizeContainer ?? screenWidth * 0.18,
      height: sizeContainer ?? screenWidth * 0.18,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color ?? AppColors.primary,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Icon(
        (iconName ?? LucideIcons.draftingCompass) as IconData?,
        size: sizeLogo ?? screenWidth * 0.09,
        color: color ?? Colors.white,
      ),
    );
  }
}
