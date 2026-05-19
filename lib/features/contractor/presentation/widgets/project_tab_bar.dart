import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/utils/screen_size.dart';
import '../bloc/project_contractor_list_bloc.dart';

class ProjectTabBar extends StatelessWidget {
  final ProjectFilterTab activeTab;
  final ValueChanged<ProjectFilterTab> onTabChanged;

  const ProjectTabBar({
    super.key,
    required this.activeTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    final tabs = [
      ProjectFilterTab.semua,
      ProjectFilterTab.berjalan,
      ProjectFilterTab.selesai,
    ];

    final labels = {
      ProjectFilterTab.semua: 'Semua',
      ProjectFilterTab.berjalan: 'Sedang Berjalan',
      ProjectFilterTab.selesai: 'Selesai',
    };

    // Ukuran responsif
    final double marginHorizontal = context.widthPct(0.04).clamp(16.0, 24.0);
    final double paddingInner = context.widthPct(0.01).clamp(4.0, 8.0);
    final double tabVerticalPadding = context.heightPct(0.012).clamp(8.0, 14.0);
    final double fontSize = context.widthPct(0.033).clamp(11.0, 14.0);
    final double dividerHeight = context.heightPct(0.025).clamp(16.0, 24.0);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: marginHorizontal),
      padding: EdgeInsets.all(paddingInner), 
      decoration: BoxDecoration(
        color: AppColors.primaryUltraLightGrey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          for (int i = 0; i < tabs.length; i++) ...[
            Expanded(
              child: GestureDetector(
                onTap: () => onTabChanged(tabs[i]),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: tabVerticalPadding),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: activeTab == tabs[i] 
                        ? AppColors.surface 
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: activeTab == tabs[i]
                        ? [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  child: Text(
                    labels[tabs[i]] ?? '',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontSize: fontSize, 
                      color: activeTab == tabs[i] ? AppColors.primary : AppColors.textMid,
                      fontWeight: FontWeight.w700,
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
                    : AppColors.primaryBlack.withOpacity(0.15),
              ),
          ],
        ],
      ),
    );
  }
}