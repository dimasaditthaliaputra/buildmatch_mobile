import 'package:buildmatch_mobile/features/auth/presentation/pages/choose_roles_page.dart';
import 'package:buildmatch_mobile/features/auth/presentation/pages/otp_page.dart';

import '../../features/contractor/presentation/pages/contractor_milestone_form_page.dart';
import 'package:buildmatch_mobile/features/architect/presentation/pages/architect_milestone_form_page.dart';
import '../../features/project_offers/presentation/pages/offering_project_page.dart';
import '../../features/detail_portofolio/presentation/pages/detail_portofolio_page.dart';
import '../../features/rating/presentation/pages/rating_client_page.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Dynamic Bottom Navigation Shell
import 'package:buildmatch_mobile/core/widgets/global_bottom_navigation/main_layout_shell.dart';
import 'package:buildmatch_mobile/core/widgets/global_bottom_navigation/navigation_menu_config.dart';

// Core Widgets / Common Pages
import '../widgets/no_connection_page.dart';

// Features - Splash & Onboarding
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';

// Features - Auth
import '../../features/auth/presentation/pages/auth_page.dart';
import '../../features/profile/presentation/pages/profile_user_page.dart';

// Features - Contractor Role
import '../../features/contractor/presentation/pages/contractor_project_requests_page.dart';
import '../../features/contractor/presentation/pages/project_detail_page.dart';
import '../../features/contractor/presentation/pages/contractor_project_offer_page.dart';
import '../../features/contractor/presentation/pages/contractor_add_progres_page.dart';

// Features - Architect Role
import '../../features/architect/presentation/pages/architect_project_detail_page.dart';
import 'package:buildmatch_mobile/features/architect/presentation/pages/architect_project_offer.dart';
import '../../features/architect/presentation/pages/architect_project_list.dart';
import 'package:buildmatch_mobile/features/architect/presentation/pages/architect_project_requests_page.dart';


// Features - Waiting Approval (Contractor Verification)
import '../../features/waiting_approval/presentation/pages/verif_contractor_page.dart';

// Features - Milestone
import '../../features/milestone/presentation/pages/milestone_contractor_page.dart';
import '../../features/contractor/domain/entities/contractor_project_list_entity.dart';

// Features - Notifications
import '../../features/notifications/presentation/pages/list_notification_page.dart';

// Features - Inbox
import '../../features/inbox/presentation/pages/list_contact_chat_page.dart';
import '../../features/inbox/presentation/pages/room_chat_page.dart';
import '../../features/inbox/domain/entities/consultation_room_entity.dart';

// Features - Setting
import '../../features/setting/domain/entities/setting_user_entity.dart';
import '../../features/setting/presentation/pages/setting_page.dart';
import '../../features/setting/presentation/pages/setting_profile_page.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: '/client-dashboard',
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
        builder: (context, state) => const MainLayoutShell(
          role: UserRole.client,
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
      GoRoute(
        path: '/penawaran-project/:projectId',
        name: 'penawaran-project',
        builder: (context, state) {
          final projectId = state.pathParameters['projectId'] ?? '';
          return PenawaranProjectPageWrapper(projectId: projectId);
        },
      ),

      // 4. CONTRACTOR ROLE ROUTES
      GoRoute(
        path: '/contractor-dashboard',
        name: 'contractor-dashboard',
        builder: (context, state) => const MainLayoutShell(
          role: UserRole.contractor,
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
      GoRoute(
        path: '/contractor-milestone-form',
        name: 'contractor-milestone-form',
        builder: (context, state) {
          final double totalNilai = state.extra as double? ?? 150000000.0;
          return ContractorMilestoneFormPage(totalNilaiKontrak: totalNilai);
        },
      ),
      GoRoute(
        path: '/milestone-contractor',
        name: 'milestone-contractor',
        builder: (context, state) {
          final project = state.extra as ContractorProjectListEntity?;
          return MilestoneContractorProvider(project: project);
        },
      ),

      // 5. ARCHITECT ROLE ROUTES
      GoRoute(
        path: '/architect-dashboard',
        name: 'architect-dashboard',
        builder: (context, state) => const MainLayoutShell(
          role: UserRole.architect,
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
      GoRoute(
        path: '/architect-proyek-requests',
        name: 'architect-proyek-requests',
        builder: (context, state) => const ArchitectProjectRequestsPage(),
      ),
       GoRoute(
        path: '/architect-project-offer',
        name: 'architect-project-offer',
        builder: (context, state) => const ArchitectProjectOfferPageProvider(),
      ),

        GoRoute(
        path: '/architect-project-list',
        name: 'architect-project-list',
        builder: (context, state) => const ProjectArchitectListPageWrapper(),
      ),

      GoRoute(
        path: '/architect-milestone-form',
        name: 'architect-milestone-form',
        builder: (context, state) {
          final double totalNilai = state.extra as double? ?? 150000000.0;
          return ArchitectMilestoneFormPage(totalNilaiKontrak: totalNilai);
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
      GoRoute(
        path: '/notifications',
        name: 'notifications',
        builder: (context, state) => const ListNotificationPage(),
      ),

      // 7. INBOX ROUTES
      GoRoute(
        path: '/inbox',
        name: 'inbox',
        builder: (context, state) => const ListContactChatPage(),
      ),
      GoRoute(
        path: '/inbox/:roomId',
        name: 'room-chat',
        builder: (context, state) {
          final roomId = state.pathParameters['roomId'] ?? '';
          final room = state.extra as ConsultationRoomEntity?;
          return RoomChatPage(roomId: roomId, room: room);
        },
      ),
      // 8. SETTING ROUTES
      GoRoute(
        path: '/setting',
        name: 'setting',
        builder: (context, state) => const SettingPageProvider(),
      ),
      GoRoute(
        path: '/setting-edit-profile',
        name: 'setting-edit-profile',
        builder: (context, state) {
          final user = state.extra as SettingUserEntity?;
          return SettingProfilePageProvider(initialUser: user);
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
        opacity: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
        child: child,
      );
    },
  );
}
