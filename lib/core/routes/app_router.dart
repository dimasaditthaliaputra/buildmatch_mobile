import 'package:buildmatch_mobile/features/auth/presentation/pages/choose_roles_page.dart';
import 'package:buildmatch_mobile/features/auth/presentation/pages/otp_page.dart';

import 'package:buildmatch_mobile/features/contractor/presentation/pages/rating_client_page.dart';
import 'package:dartz/dartz.dart';

import 'package:buildmatch_mobile/features/client/presentation/pages/client_dashboard_page.dart';
import '../../features/detail_portofolio/presentation/pages/detail_portofolio_page.dart';
import '../../features/rating/presentation/pages/rating_client_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// Dynamic Bottom Navigation Shell
import 'package:buildmatch_mobile/core/widgets/global_bottom_navigation/main_layout_shell.dart';
import 'package:buildmatch_mobile/core/widgets/global_bottom_navigation/navigation_menu_config.dart';

// Dependency Injection
import '../../config/injection_container.dart';

// Core Widgets / Common Pages
import '../../features/rating/presentation/pages/rating_client_page.dart';
import '../widgets/no_connection_page.dart';

// Features - Splash & Onboarding
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';

// Features - Auth
import '../../features/auth/presentation/pages/auth_page.dart';
import '../../features/profile/presentation/pages/profile_user_page.dart';

// Features - Client & Home
import '../../features/home/presentation/pages/home_page.dart';

// Features - Contractor Role
import '../../features/contractor/presentation/pages/contractor_dashboard_page.dart';
import '../../features/contractor/presentation/bloc/contractor_dashboard_bloc.dart';
import '../../features/contractor/presentation/pages/contractor_project_requests_page.dart';
import '../../features/contractor/presentation/pages/project_detail_page.dart';
import '../../features/contractor/presentation/pages/contractor_project_offer_page.dart';
import '../../features/contractor/presentation/pages/contractor_project_list.dart';
import '../../features/contractor/presentation/pages/contractor_add_progres_page.dart';

// Features - Architect Role
import '../../features/architect/presentation/pages/architect_dashboard_page.dart';
import '../../features/architect/presentation/pages/architect_project_detail_page.dart';

// Features - Waiting Approval (Contractor Verification)
import '../../features/waiting_approval/presentation/pages/verif_contractor_page.dart';
import '../../features/waiting_approval/presentation/bloc/waiting_approval_bloc.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: '/splash',
    routes: [
      // 1. COMMON / GLOBAL ROUTES
      GoRoute(
        path: '/splash',
        name: 'splash',
        pageBuilder: (context, state) => buildFadeTransitionPage(
          key: state.pageKey,
          child: const SplashScreen(),
        ),
      ),
      GoRoute(
        path: '/no-connection',
        name: 'no-connection',
        builder: (context, state) => const NoConnectionPage(),
      ),
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        pageBuilder: (context, state) => buildFadeTransitionPage(
          key: state.pageKey,
          child: const OnboardingPage(),
        ),
      ),

      // 2. AUTHENTICATION ROUTES
      GoRoute(
        path: '/auth',
        name: 'auth',
        pageBuilder: (context, state) => buildFadeTransitionPage(
          key: state.pageKey,
          child: const AuthPage(),
        ),
      ),
      GoRoute(
        path: '/otp',
        name: 'otp',
        builder: (context, state) => const OtpPage(),
      ),
      GoRoute(
        path: '/choose-roles',
        name: 'choose-roles',
        pageBuilder: (context, state) => buildFadeTransitionPage(
          key: state.pageKey,
          child: const ChooseRolesPage(),
        ),
      ),
      GoRoute(
        path: '/setup-profile',
        name: 'setup-profile',
        builder: (context, state) {
          final String role = state.extra as String? ?? 'client';
          return SetupProfilePage(role: role);
        },
      ),
      GoRoute(
        path: '/verif-contractor',
        name: 'verif-contractor',
        builder: (context, state) => const VerifContractorProvider(),
      ),

      // 3. CLIENT / HOME ROUTES
      GoRoute(
        path: '/client-dashboard',
        name: 'client-dashboard',
        pageBuilder: (context, state) => buildFadeTransitionPage(
          key: state.pageKey,
          child: const MainLayoutShell(role: UserRole.client),
        ),
      ),
      GoRoute(
        path: '/dashboard-client',
        name: 'dashboard-client',
        pageBuilder: (context, state) => buildFadeTransitionPage(
          key: state.pageKey,
          child: const MainLayoutShell(role: UserRole.client),
        ),
      ),
      GoRoute(
        path: '/client-proyek',
        name: 'client-proyek',
        pageBuilder: (context, state) => buildFadeTransitionPage(
          key: state.pageKey,
          child: const MainLayoutShell(role: UserRole.client, initialTab: 1),
        ),
      ),

      // 4. CONTRACTOR ROLE ROUTES
      GoRoute(
        path: '/contractor-dashboard',
        name: 'contractor-dashboard',
        pageBuilder: (context, state) => buildFadeTransitionPage(
          key: state.pageKey,
          child: const MainLayoutShell(role: UserRole.contractor),
        ),
      ),
      GoRoute(
        path: '/contractor-proyek-requests',
        name: 'contractor-proyek-requests',
        builder: (context, state) => const ContractorProjectRequestsPage(),
      ),
      GoRoute(
        path: '/contractor-proyek-offer',
        name: 'contractor-proyek-offer',
        builder: (context, state) => const ContractorProjectOfferPageProvider(),
      ),
      GoRoute(
        path: '/proyek-detail/:id',
        name: 'proyek-detail',
        pageBuilder: (context, state) {
          final String id = state.pathParameters['id'] ?? '0';

          return buildFadeTransitionPage(
            key: state.pageKey,
            child: ProjectDetailPage(projectId: id),
          );
        },
      ),
      GoRoute(
        path: '/contractor-project-list',
        name: 'contractor-project-list',
        builder: (context, state) =>
            const MainLayoutShell(role: UserRole.contractor, initialTab: 1),
      ),
      GoRoute(
        path: '/contractor-add-progres',
        name: 'contractor-add-progres',
        builder: (context, state) => const ContractorAddProgresPageWrapper(),
      ),

      // 5. ARCHITECT ROLE ROUTES
      GoRoute(
        path: '/architect-dashboard',
        name: 'architect-dashboard',
        pageBuilder: (context, state) => buildFadeTransitionPage(
          key: state.pageKey,
          child: const MainLayoutShell(role: UserRole.architect),
        ),
      ),

      GoRoute(
        path: '/architect-project-detail/:id',
        name: 'architect-project-detail',
        pageBuilder: (context, state) {
          final String id = state.pathParameters['id'] ?? '0';

          return buildFadeTransitionPage(
            key: state.pageKey,
            child: ArchitectProjectDetailPage(projectId: id),
          );
        },
      ),

      // 6. GLOBAL FUNCTION
      GoRoute(
        path: '/rating-client',
        name: 'rating-client',
        builder: (context, state) =>
            const RatingClientPage(clientId: '', clientName: ''),
      ),
      GoRoute(
        path: '/detail-portofolio',
        name: 'detail-portofolio',
        builder: (context, state) => const DetailPortofolioPageProvider(),
      ),
    ],
  );
}

CustomTransitionPage<void> buildFadeTransitionPage({
  required LocalKey key,
  required Widget child,
  Duration duration = const Duration(milliseconds: 1000),
}) {
  return CustomTransitionPage<void>(
    key: key,
    child: child,
    transitionDuration: duration,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
        child: child,
      );
    },
  );
}
