import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// Dependency Injection
import '../../config/injection_container.dart';

// Core Widgets / Common Pages
import '../widgets/no_connection_page.dart';

// Features - Splash & Onboarding
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';

// Features - Auth
import '../../features/auth/presentation/pages/auth_page.dart';
import 'package:buildmatch_mobile/features/auth/presentation/pages/otp_page.dart';
import 'package:buildmatch_mobile/features/auth/presentation/pages/choose_roles_page.dart';

// Features - Client & Home
import '../../features/home/presentation/pages/home_page.dart';

// Features - Contractor Role
import '../../features/contractor/presentation/pages/contractor_dashboard_page.dart';
import '../../features/contractor/presentation/bloc/contractor_dashboard_bloc.dart';
import '../../features/contractor/presentation/pages/proyek_page.dart';
import '../../features/contractor/presentation/pages/project_detail_page.dart';
import '../../features/contractor/presentation/pages/formpenawaran_page.dart';

// Features - Architect Role
import '../../features/architect/presentation/pages/architect_dashboard_page.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: '/',
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
        pageBuilder: (context, state) => buildFadeTransitionPage(
          key: state.pageKey,
          child: const OtpPage(),
        ),
      ),
      GoRoute(
        path: '/choose-roles',
        name: 'choose-roles',
        pageBuilder: (context, state) => buildFadeTransitionPage(
          key: state.pageKey,
          child: const ChooseRolesPage(),
        ),
      ),

      // 3. CLIENT / HOME ROUTES
      GoRoute(
        path: '/home',
        name: 'home',
        pageBuilder: (context, state) => buildFadeTransitionPage(
          key: state.pageKey,
          child: const HomePage(),
        ),
      ),

      // 4. CONTRACTOR ROLE ROUTES
      GoRoute(
        path: '/contractor-dashboard',
        name: 'contractor-dashboard',
        pageBuilder: (context, state) => buildFadeTransitionPage(
          key: state.pageKey,
          child: BlocProvider(
            create: (context) => sl<ContractorDashboardBloc>(),
            child: const ContractorDashboardPage(),
          ),
        ),
      ),
      GoRoute(
        path: '/contractor-proyek',
        name: 'contractor-proyek',
        pageBuilder: (context, state) => buildFadeTransitionPage(
          key: state.pageKey,
          child: const ProyekPage(),
        ),
      ),
      GoRoute(
        path: '/form-penawaran',
        name: 'form-penawaran',
        pageBuilder: (context, state) => buildFadeTransitionPage(
          key: state.pageKey,
          child: const FormPenawaranPageProvider(),
        ),
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

      // 5. ARCHITECT ROLE ROUTES
      GoRoute(
        path: '/architect-dashboard',
        name: 'architect-dashboard',
        pageBuilder: (context, state) => buildFadeTransitionPage(
          key: state.pageKey,
          child: const ArchitectDashboardPage(),
        ),
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
        opacity: CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        ),
        child: child,
      );
    },
  );
}
