import 'package:flutter/material.dart';
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
            icon: LucideIcons.shoppingCart,
            activeIcon: LucideIcons.shoppingCart,
            routeName: '/', // Path not yet in router, fallback to '/'
          ),
          NavigationItem(
            label: 'Pengaturan',
            icon: LucideIcons.user,
            activeIcon: LucideIcons.user,
            routeName: '/', // Fallback to '/'
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
            routeName: '/contractor-proyek',
          ),
          NavigationItem(
            label: 'Inbox',
            icon: LucideIcons.shoppingCart,
            activeIcon: LucideIcons.shoppingCart,
            routeName: '/', // Fallback to '/'
          ),
          NavigationItem(
            label: 'Pengaturan',
            icon: LucideIcons.user,
            activeIcon: LucideIcons.user,
            routeName: '/', // Fallback to '/'
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
            routeName: '/', // Fallback to '/'
          ),
          NavigationItem(
            label: 'Inbox',
            icon: LucideIcons.shoppingCart,
            activeIcon: LucideIcons.shoppingCart,
            routeName: '/', // Fallback to '/'
          ),
          NavigationItem(
            label: 'Pengaturan',
            icon: LucideIcons.user,
            activeIcon: LucideIcons.user,
            routeName: '/', // Fallback to '/'
          ),
        ];
    }
  }
}
