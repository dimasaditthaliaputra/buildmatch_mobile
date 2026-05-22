import 'dart:math' as math;
import 'package:buildmatch_mobile/features/architect/presentation/bloc/architect_dashboard_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/screen_size.dart';
import '../../../../config/injection_container.dart';
import '../widgets/dashboard/dashboard_header_widget.dart';
import '../widgets/dashboard/financial_summary_section.dart';
import '../widgets/dashboard/active_project_section.dart';
import '../widgets/dashboard/project_listing_section.dart';
import '../widgets/dashboard/chart_widgets.dart';
import '../../../../core/widgets/dashboard_background_global_widget.dart';

class ArchitectDashboardProvider extends StatelessWidget {
  const ArchitectDashboardProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ArchitectDashboardBloc>(),
      child: const ArchitectDashboardPage(),
    );
  }
}

class ArchitectDashboardPage extends StatefulWidget {
  const ArchitectDashboardPage({super.key});

  @override
  State<ArchitectDashboardPage> createState() =>
      _ArchitectDashboardPageState();
}

class _ArchitectDashboardPageState extends State<ArchitectDashboardPage> {
  final ScrollController _scrollController = ScrollController();
  final PageController _chartPageController = PageController(viewportFraction: 0.92);

  @override
  void initState() {
    super.initState();
    context.read<ArchitectDashboardBloc>().add(
      const LoadArchitectDashboard(architectId: 'current_user'),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _chartPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeData().scaffoldBackgroundColor,
      body: BlocBuilder<ArchitectDashboardBloc, ArchitectDashboardState>(
        builder: (context, state) {
          if (state is ArchitectDashboardLoading) {
            return _buildLoadingState();
          }
          if (state is ArchitectDashboardError) {
            return _buildErrorState(state.message);
          }
          if (state is ArchitectDashboardLoaded) {
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
        _buildOrangeHeader(),
        Expanded(
          child: Center(
            child: CircularProgressIndicator(color: AppColors.primary, strokeWidth: 2.5),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState(String message) {
    return Column(
      children: [
        _buildOrangeHeader(),
        Expanded(
          child: Center(
            child: Text('Error: $message', style: TextStyle(color: AppColors.primary)),
          ),
        ),
      ],
    );
  }

  Widget _buildOrangeHeader() {
    return Container(
      height: math.max(
          context.heightPct(0.15) + MediaQuery.of(context).padding.top, 100.0),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primaryMedium, AppColors.primaryDark],
        ),
      ),
    );
  }

  Widget _buildLoadedState(ArchitectDashboardLoaded state) {
    final dashboard = state.dashboard;

    return RefreshIndicator(
      color: AppColors.primary,
      backgroundColor: AppColors.surface,
      onRefresh: () async {
        context.read<ArchitectDashboardBloc>().add(
          const RefreshArchitectDashboard(architectId: 'current_user'),
        );
        await Future.delayed(const Duration(milliseconds: 600));
      },
      child: SingleChildScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        child: Stack(
          children: [
            const DashboardBackgroundGlobalWidget(),

            SafeArea(
              bottom: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: DashboardHeaderWidget(
                      architectName: dashboard.architectName,
                      architectRole: dashboard.architecRole,
                      avatarUrl: dashboard.avatarUrl,
                    ),
                  ),

                  const SizedBox(height: 16),

                  FinancialSummarySection(summary: dashboard.financialSummary),

                  const SizedBox(height: 24),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ActiveProjectSection(
                      projects: dashboard.activeProjects,
                      onSeeAll: () {},
                    ),
                  ),

                  const SizedBox(height: 16),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ProjectListingSection(
                      listings: dashboard.projectListings,
                      onSeeAll: () {},
                      onDetailTap: (listing) {},
                    ),
                  ),

                  const SizedBox(height: 16),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Grafik',
                      style: AppTextStyles.heading3.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w800,
                        fontSize: 22,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: context.widthPct(0.04)),
                    child: IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: context.widthPct(0.92),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 6),
                              child: FinancialChartWidget(
                                data: dashboard.financialChartData,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: context.widthPct(0.92),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 6),
                              child: ProjectDonutChart(
                                stats: dashboard.projectStats,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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