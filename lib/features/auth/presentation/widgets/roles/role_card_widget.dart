import 'package:buildmatch_mobile/core/theme/app_colors.dart';
import 'package:buildmatch_mobile/core/theme/app_text_styles.dart';
import 'package:buildmatch_mobile/core/utils/screen_size.dart';
import 'package:buildmatch_mobile/core/widgets/badge_widget.dart';
import 'package:flutter/material.dart';
import '../../../domain/entities/roles_entity.dart';

class RoleCardWidget extends StatelessWidget {
  final RolesEntity role;
  final bool isSelected;
  final VoidCallback onTap;

  const RoleCardWidget({
    super.key,
    required this.role,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Dynamic responsive font sizes based on screen width
    final double badgeFontSize = (context.screenWidth * 0.028).clamp(9.0, 11.0);
    final double titleFontSize = (context.screenWidth * 0.045).clamp(24.0, 26.0);
    final double descriptionFontSize = (context.screenWidth * 0.033).clamp(18, 20.0);

    // Curated styling based on role name
    final bool isClient = role.rolesName == 'Client';
    final bool isArchitect = role.rolesName == 'Architect';
    
    // Colors customization
    Color primaryColor;
    Color iconBgColor;
    Color badgeColor;
    Color badgeTextColor;
    String badgeText;

    if (isClient) {
      primaryColor = AppColors.primary;
      iconBgColor = AppColors.clientBg;
      badgeColor = AppColors.clientBg;
      badgeTextColor = AppColors.primary;
      badgeText = 'CLIENT';
    } else if (isArchitect) {
      primaryColor = AppColors.architectPrimary;
      iconBgColor = AppColors.architectBg;
      badgeColor = AppColors.architectBg;
      badgeTextColor = AppColors.architectPrimary;
      badgeText = 'ARSITEK';
    } else {
      primaryColor = AppColors.contractorPrimary;
      iconBgColor = AppColors.contractorBg;
      badgeColor = AppColors.contractorBg;
      badgeTextColor = AppColors.contractorPrimary;
      badgeText = 'KONTRAKTOR';
    }

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? iconBgColor.withOpacity(0.3) : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? primaryColor : AppColors.border,
            width: isSelected ? 2 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected 
                  ? primaryColor.withValues(alpha: 0.08) 
                  : AppColors.textSecondaryDark.withValues(alpha: 0.02),
              blurRadius: isSelected ? 12 : 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon Badge
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: isSelected ? primaryColor : iconBgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                role.icon,
                color: isSelected ? Colors.white : primaryColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            
            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Badge / Label Pill
                  BadgeWidget(
                    text: badgeText,
                    textColor: isSelected ? primaryColor : badgeTextColor,
                    backgroundColor: isSelected ? primaryColor.withOpacity(0.15) : badgeColor,
                    borderColor: Colors.transparent,
                    fontSize: badgeFontSize,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  ),
                  const SizedBox(height: 8),
                  
                  // Title
                  Text(
                    role.title,
                    style: AppTextStyles.heading3.copyWith(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  
                  // Description
                  Text(
                    role.description,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontSize: descriptionFontSize,
                      height: 1.4,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondaryDark,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
