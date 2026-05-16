import 'package:buildmatch_mobile/features/auth/presentation/pages/choose_roles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../config/injection_container.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/contractor/presentation/pages/contractor_dashboard_page.dart';
import '../../features/contractor/presentation/bloc/contractor_dashboard_bloc.dart';

import '../../features/contractor/presentation/pages/proyek_page.dart';

import '../../features/contractor/presentation/pages/formpenawaran_page.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: '/form-penawaran',
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
        pageBuilder: (context, state) {
          final args = state.extra as FormPenawaranArgs? ?? FormPenawaranArgs(
          proyekId: 'TEST-123',
          namaProyek: 'Proyek Dummy (Testing)',
          budgetKlienMin: 100000000.0,
          budgetKlienMax: 200000000.0,
          batasWaktuKlien: DateTime.now(),
          deskripsiProyek: 'Ini adalah deskripsi dummy karena halaman dibuka langsung tanpa membawa data extra.',
        );
          return buildFadeTransitionPage(
            key: state.pageKey,
            child: FormPenawaranPageProvider(args: args),
          );
        },
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
