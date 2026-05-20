import 'package:flutter/material.dart';

class NavigationItem {
  final String label;
  final IconData icon;
  final IconData activeIcon;
  final String routeName;

  const NavigationItem({
    required this.label,
    required this.icon,
    required this.activeIcon,
    required this.routeName,
  });
}
