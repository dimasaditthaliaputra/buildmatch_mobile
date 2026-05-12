import 'package:buildmatch_mobile/features/auth/presentation/pages/choose_roles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/contractor/presentation/pages/proyek_page.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        name: 'splash',
        pageBuilder: (context, state) => buildFadeTransitionPage(
          key: state.pageKey,
          child: const SplashScreen(),
        ),
      ),
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        pageBuilder: (context, state) => buildFadeTransitionPage(
          key: state.pageKey,
          child: const OnboardingPage(),
        ),
      ),
      GoRoute(
        path: '/auth',
        name: 'auth',
        pageBuilder: (context, state) => buildFadeTransitionPage(
          key: state.pageKey,
          child: const AuthPage(),
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
      GoRoute(
        path: '/home',
        name: 'home',
        pageBuilder: (context, state) => buildFadeTransitionPage(
          key: state.pageKey,
          child: const HomePage(),
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
          curve: Curves.easeInOut, // lebih smooth daripada linear
        ),
        child: child,
      );
    },
  );
}
