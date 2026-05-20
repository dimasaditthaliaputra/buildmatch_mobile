import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/dashboard_background_global_widget.dart';
import '../../../../config/injection_container.dart';
import '../bloc/client_dashboard_bloc.dart';
import '../bloc/client_dashboard_event.dart';
import '../bloc/client_dashboard_state.dart';
import '../widgets/client_header_widget.dart';
import '../widgets/client_action_cards_widget.dart';
import '../widgets/popular_projects_section.dart';

// --- Provider Wrapper ---
class ClientDashboardProvider extends StatelessWidget {
  const ClientDashboardProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ClientDashboardBloc>(),
      child: const ClientDashboardPage(),
    );
  }
}

// --- Page ---
class ClientDashboardPage extends StatefulWidget {
  const ClientDashboardPage({super.key});

  @override
  State<ClientDashboardPage> createState() => _ClientDashboardPageState();
}

class _ClientDashboardPageState extends State<ClientDashboardPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<ClientDashboardBloc>().add(
          const LoadClientDashboard(clientId: 'current_user'),
        );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<ClientDashboardBloc, ClientDashboardState>(
        builder: (context, state) {
          if (state is ClientDashboardLoading) {
            return _buildLoadingState();
          }
          if (state is ClientDashboardError) {
            return _buildErrorState(state.message);
          }
          if (state is ClientDashboardLoaded) {
            return _buildLoadedState(state);
          }
          return _buildLoadingState();
        },
      ),
    );
  }

  Widget _buildLoadingState() {
    return Column(
      children: [
        const DashboardBackgroundGlobalWidget(heightPct: 0.18, minHeight: 120),
        Expanded(
          child: Center(
            child: CircularProgressIndicator(
                color: AppColors.primary, strokeWidth: 2.5),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState(String message) {
    return Column(
      children: [
        const DashboardBackgroundGlobalWidget(heightPct: 0.18, minHeight: 120),
        Expanded(
          child: Center(
            child: Text(
              'Error: $message',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoadedState(ClientDashboardLoaded state) {
    final dashboard = state.dashboard;

    return RefreshIndicator(
      color: AppColors.primary,
      backgroundColor: AppColors.surface,
      onRefresh: () async {
        context.read<ClientDashboardBloc>().add(
              const RefreshClientDashboard(clientId: 'current_user'),
            );
        await Future.delayed(const Duration(milliseconds: 600));
      },
      child: SingleChildScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics()),
        child: Stack(
          children: [
            // Orange background blob
            const DashboardBackgroundGlobalWidget(
              heightPct: 0.3,
              minHeight: 220,
            ),

            SafeArea(
              bottom: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  ClientHeaderWidget(
                    clientName: dashboard.clientName,
                    greeting: dashboard.greeting,
                    avatarUrl: dashboard.avatarUrl,
                    onNotificationTap: () {},
                  ),

                  const SizedBox(height: 20),

                  // Action Cards (Butuh Desain, Cari Kontraktor, shortcuts)
                  ClientActionCardsWidget(
                    onDesainBaru: () {},
                    onCariKontraktor: () {},
                    onListPenawaran: () {},
                    onProyekBerjalan: () {},
                  ),

                  const SizedBox(height: 28),

                  // Popular Projects Section
                  PopularProjectsSection(
                    projects: dashboard.popularProjects,
                    onSeeAll: () {},
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
