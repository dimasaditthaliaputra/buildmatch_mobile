import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

class MainButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final double borderRadius;
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  
  final EdgeInsetsGeometry padding;

  const MainButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.borderRadius = 16,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    // Nilai default ini yang akan membentuk tombolmu
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: backgroundColor ?? AppColors.primary,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Padding(
            padding: padding,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: GoogleFonts.inter(
                    fontSize: fontSize ?? 16,
                    fontWeight: fontWeight ?? FontWeight.w700,
                    color: textColor ?? Colors.white,
                  ),
                ),
                if (icon != null) ...[
                  const SizedBox(width: 8),
                  Icon(icon, color: textColor ?? Colors.white, size: 20),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}