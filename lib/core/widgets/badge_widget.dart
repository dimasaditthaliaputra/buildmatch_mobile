import 'package:flutter/material.dart';
import '../theme/app_text_styles.dart';

class BadgeWidget extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final Color borderColor;
  final double fontSize;
  final EdgeInsetsGeometry padding;

  const BadgeWidget({
    super.key,
    required this.text,
    required this.textColor,
    required this.backgroundColor,
    required this.borderColor,
    this.fontSize = 10,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: borderColor, width: 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text.toUpperCase(),
        style: AppTextStyles.labelSmall.copyWith(
          color: textColor,
          fontSize: fontSize,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}