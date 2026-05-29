import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'navigation_item.dart';

enum UserRole {
  client,
  contractor,
  architect,
}

class NavigationMenuConfig {
  static List<NavigationItem> getMenuItemsForRole(UserRole role) {
    switch (role) {
      case UserRole.client:
        return const [
          NavigationItem(
            label: 'Beranda',
            icon: LucideIcons.house,
            activeIcon: LucideIcons.house,
            routeName: '/client-dashboard',
          ),
          NavigationItem(
            label: 'Proyek',
            icon: LucideIcons.fileText,
            activeIcon: LucideIcons.fileText,
            routeName: '/client-proyek',
          ),
          NavigationItem(
            label: 'Inbox',
            icon: LucideIcons.messageCircle,
            activeIcon: LucideIcons.messageCircle,
            routeName: '/inbox',
          ),
          NavigationItem(
            label: 'Pengaturan',
            icon: LucideIcons.user,
            activeIcon: LucideIcons.user,
            routeName: '/setting',
          ),
        ];
      case UserRole.contractor:
        return const [
          NavigationItem(
            label: 'Beranda',
            icon: LucideIcons.house,
            activeIcon: LucideIcons.house,
            routeName: '/contractor-dashboard',
          ),
          NavigationItem(
            label: 'Proyek',
            icon: LucideIcons.fileText,
            activeIcon: LucideIcons.fileText,
            routeName: '/contractor-project-list',
          ),
          NavigationItem(
            label: 'Inbox',
            icon: LucideIcons.messageCircle,
            activeIcon: LucideIcons.messageCircle,
            routeName: '/inbox',
          ),
          NavigationItem(
            label: 'Pengaturan',
            icon: LucideIcons.user,
            activeIcon: LucideIcons.user,
            routeName: '/setting',
          ),
        ];
      case UserRole.architect:
        return const [
          NavigationItem(
            label: 'Beranda',
            icon: LucideIcons.house,
            activeIcon: LucideIcons.house,
            routeName: '/architect-dashboard',
          ),
          NavigationItem(
            label: 'Proyek',
            icon: LucideIcons.fileText,
            activeIcon: LucideIcons.fileText,
            routeName: '/architect-project-list',
          ),
          NavigationItem(
            label: 'Inbox',
            icon: LucideIcons.messageCircle,
            activeIcon: LucideIcons.messageCircle,
            routeName: '/inbox',
          ),
          NavigationItem(
            label: 'Pengaturan',
            icon: LucideIcons.user,
            activeIcon: LucideIcons.user,
            routeName: '/setting',
          ),
        ];
    }
  }
}
