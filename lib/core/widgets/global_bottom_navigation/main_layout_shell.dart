import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../config/injection_container.dart';
import '../../../features/client/presentation/pages/client_dashboard_page.dart';
import '../../../features/client/presentation/pages/project_page.dart';
import '../../../features/contractor/presentation/pages/contractor_dashboard_page.dart';
import '../../../features/contractor/presentation/bloc/contractor_dashboard_bloc.dart';
import '../../../features/contractor/presentation/pages/contractor_project_requests_page.dart';
import '../../../features/architect/presentation/pages/architect_dashboard_page.dart';
import '../../../features/profile/presentation/pages/profile_placeholder_page.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import 'navigation_item.dart';
import 'navigation_menu_config.dart';
import 'global_bottom_navigation_bar.dart';

class MainLayoutShell extends StatefulWidget {
  final UserRole role;
  final int initialTab;

  const MainLayoutShell({
    super.key,
    required this.role,
    this.initialTab = 0,
  });

  @override
  State<MainLayoutShell> createState() => _MainLayoutShellState();
}

class _MainLayoutShellState extends State<MainLayoutShell> {
  late int _currentIndex;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialTab;
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    if (_currentIndex == index) return;
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  List<Widget> _getPages() {
    switch (widget.role) {
      case UserRole.client:
        return [
          const ClientDashboardProvider(),
          const ClientProjectProvider(),
          _InboxPlaceholderView(role: widget.role),
          const ProfilePlaceholderPage(role: 'client'),
        ];
      case UserRole.contractor:
        return [
          const ContractorDashboardProvider(),
          const ContractorProjectRequestsPage(),
          _InboxPlaceholderView(role: widget.role),
          const ProfilePlaceholderPage(role: 'contractor'),
        ];
      case UserRole.architect:
        return [
          const ArchitectDashboardProvider(),
          const _ArchitectProjectPlaceholderView(),
          _InboxPlaceholderView(role: widget.role),
          const ProfilePlaceholderPage(role: 'architect'),
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final menuItems = NavigationMenuConfig.getMenuItemsForRole(widget.role);
    final pages = _getPages();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          MediaQuery(
            data: MediaQuery.of(context).copyWith(
              padding: MediaQuery.of(context).padding.copyWith(
                bottom: 84.0 + MediaQuery.of(context).padding.bottom,
              ),
            ),
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: pages,
            ),
          ),

          // Custom global floating bottom navigation bar
          GlobalBottomNavigationBar(
            items: menuItems,
            currentIndex: _currentIndex,
            onTap: _onTabTapped,
            role: widget.role,
          ),
        ],
      ),
    );
  }
}

class _InboxPlaceholderView extends StatelessWidget {
  final UserRole role;
  const _InboxPlaceholderView({required this.role});

  Color _getRoleColor() {
    switch (role) {
      case UserRole.client:
        return AppColors.primary;
      case UserRole.contractor:
        return AppColors.contractorPrimary;
      case UserRole.architect:
        return AppColors.architectPrimary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getRoleColor();
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Pesan Masuk',
          style: AppTextStyles.heading3.copyWith(
            color: color,
            fontWeight: FontWeight.w800,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withOpacity(0.08),
              ),
              child: Icon(
                LucideIcons.messageSquare,
                size: 64,
                color: color,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Kotak Masuk Kosong',
              style: AppTextStyles.heading2.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Semua pesan, penawaran, dan percakapan Anda\nakan muncul di sini.',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondaryDark,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ArchitectProjectPlaceholderView extends StatelessWidget {
  const _ArchitectProjectPlaceholderView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Desain Portofolio',
          style: AppTextStyles.heading3.copyWith(
            color: AppColors.architectPrimary,
            fontWeight: FontWeight.w800,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.architectPrimary.withOpacity(0.08),
              ),
              child: const Icon(
                LucideIcons.draftingCompass,
                size: 64,
                color: AppColors.architectPrimary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Portofolio Arsitek',
              style: AppTextStyles.heading2.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Halaman proyek rancangan arsitektur Anda\nakan muncul di sini.',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondaryDark,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
