import 'package:flutter/material.dart';
import '../../../../core/widgets/global_custom_tab_bar.dart';

class ProjectTabBarWidget extends StatelessWidget {
  final int selectedTab; // 0 = Semua Proyek, 1 = Penawaran
  final ValueChanged<int> onTabChanged;

  const ProjectTabBarWidget({
    super.key,
    required this.selectedTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GlobalCustomTabBar(
      tabs: const ['Semua Proyek', 'Penawaran'],
      selectedIndex: selectedTab,
      onTabChanged: onTabChanged,
    );
  }
}
