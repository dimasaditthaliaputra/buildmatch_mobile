import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class GlobalCustomTabBar extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTabChanged;
  final Color backgroundColor;
  final Color selectedTextColor;
  final Color unselectedTextColor;
  final EdgeInsetsGeometry padding;
  final double height;

  const GlobalCustomTabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabChanged,
    this.backgroundColor = AppColors.primaryLightGrey,
    this.selectedTextColor = AppColors.primary,
    this.unselectedTextColor = AppColors.textSecondaryDark,
    this.padding = const EdgeInsets.all(4),
    this.height = 44,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: List.generate(tabs.length, (index) {
          return _TabItem(
            label: tabs[index],
            isSelected: selectedIndex == index,
            selectedTextColor: selectedTextColor,
            unselectedTextColor: unselectedTextColor,
            onTap: () => onTabChanged(index),
          );
        }),
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Color selectedTextColor;
  final Color unselectedTextColor;

  const _TabItem({
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.selectedTextColor,
    required this.unselectedTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.surface : Colors.transparent,
            borderRadius: BorderRadius.circular(9),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.shadowDark.withValues(alpha: 0.08),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              label,
              style: AppTextStyles.bodyMedium.copyWith(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? selectedTextColor : unselectedTextColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
