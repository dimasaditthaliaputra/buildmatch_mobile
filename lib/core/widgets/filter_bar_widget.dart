import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class FilterBarWidget<T> extends StatelessWidget {
  final List<T> tabs;
  
  final T activeTab;
  
  final String Function(T) labelBuilder;
  
  final ValueChanged<T> onTabChanged;

  final Color backgroundColor;
  final Color activeTabColor;
  final Color activeTextColor;
  final Color inactiveTextColor;
  final Color? dividerColor;
  
  final double borderRadius;
  final double tabBorderRadius;
  final Border? border;
  final List<BoxShadow>? activeBoxShadow;
  
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? tabPadding;
  
  final double? fontSize;
  final double dividerHeight;
  
  final TextStyle? textStyle; 

  const FilterBarWidget({
    super.key,
    required this.tabs,
    required this.activeTab,
    required this.labelBuilder,
    required this.onTabChanged,
    this.backgroundColor = AppColors.primaryUltraLightGrey,
    this.activeTabColor = AppColors.surface,
    this.activeTextColor = AppColors.primary,
    this.inactiveTextColor = AppColors.textMid,
    this.dividerColor,
    this.borderRadius = 16.0,
    this.tabBorderRadius = 12.0,
    this.border,
    this.activeBoxShadow,
    this.margin,
    this.padding,
    this.tabPadding,
    this.fontSize,
    this.dividerHeight = 18.0,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 16),
      padding: padding ?? const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: border,
      ),
      child: Row(
        children: [
          for (int i = 0; i < tabs.length; i++) ...[
            Expanded(
              child: GestureDetector(
                onTap: () => onTabChanged(tabs[i]),
                child: Container(
                  padding: tabPadding ?? const EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: activeTab == tabs[i] ? activeTabColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(tabBorderRadius),
                    boxShadow: activeTab == tabs[i]
                        ? (activeBoxShadow ??
                            [
                              BoxShadow(
                                color: AppColors.primaryBlack.withOpacity(0.04),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ])
                        : null,
                  ),
                  child: Text(
                    labelBuilder(tabs[i]),
                    textAlign: TextAlign.center,
                    style: (textStyle ?? AppTextStyles.bodyMedium).copyWith(
                      fontSize: fontSize ?? textStyle?.fontSize ?? 13.0,
                      color: activeTab == tabs[i] ? activeTextColor : inactiveTextColor,
                      fontWeight: textStyle?.fontWeight ?? FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            
            if (i < tabs.length - 1)
              Container(
                width: 1,
                height: dividerHeight,
                color: (activeTab == tabs[i] || activeTab == tabs[i + 1])
                    ? Colors.transparent
                    : (dividerColor ?? AppColors.primaryBlack.withOpacity(0.15)),
              ),
          ],
        ],
      ),
    );
  }
}