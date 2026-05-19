import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/screen_size.dart';
import '../../../../config/injection_container.dart';
import '../bloc/contractor_dashboard_bloc.dart';
import '../widgets/dashboard_header_widget.dart';
import '../widgets/financial_summary_section.dart';
import '../widgets/active_project_section.dart';
import '../widgets/project_listing_section.dart';
import '../widgets/chart_widgets.dart';

class ContractorDashboardProvider extends StatelessWidget {
  const ContractorDashboardProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ContractorDashboardBloc>(),
      child: const ContractorDashboardPage(),
    );
  }
}

class ContractorDashboardPage extends StatefulWidget {
  const ContractorDashboardPage({super.key});

  @override
  State<ContractorDashboardPage> createState() =>
      _ContractorDashboardPageState();
}

class _ContractorDashboardPageState extends State<ContractorDashboardPage> {
  final ScrollController _scrollController = ScrollController();
  final PageController _chartPageController = PageController(viewportFraction: 0.92);

  @override
  void initState() {
    super.initState();
    context.read<ContractorDashboardBloc>().add(
      const LoadContractorDashboard(contractorId: 'current_user'),
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
      backgroundColor: AppColors.background,
      body: BlocBuilder<ContractorDashboardBloc, ContractorDashboardState>(
        builder: (context, state) {
          if (state is ContractorDashboardLoading) {
            return _buildLoadingState();
          }
          if (state is ContractorDashboardError) {
            return _buildErrorState(state.message);
          }
          if (state is ContractorDashboardLoaded) {
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

  Widget _buildLoadedState(ContractorDashboardLoaded state) {
    final dashboard = state.dashboard;

    return RefreshIndicator(
      color: AppColors.primary,
      backgroundColor: AppColors.surface,
      onRefresh: () async {
        context.read<ContractorDashboardBloc>().add(
          const RefreshContractorDashboard(contractorId: 'current_user'),
        );
        await Future.delayed(const Duration(milliseconds: 600));
      },
      child: SingleChildScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        child: Stack(
          children: [
            Container(
              height: math.max(context.heightPct(0.32), 260.0),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(32),
                ),
              ),
            ),

            SafeArea(
              bottom: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: DashboardHeaderWidget(
                      contractorName: dashboard.contractorName,
                      contractorRole: dashboard.contractorRole,
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

                  const SizedBox(height: 24),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ProjectListingSection(
                      listings: dashboard.projectListings,
                      onSeeAll: () {},
                      onDetailTap: (listing) {},
                    ),
                  ),

                  const SizedBox(height: 24),

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

                  SizedBox(
                    height: math.max(context.heightPct(0.38), 290.0),
                    child: PageView(
                      controller: _chartPageController,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: FinancialChartWidget(
                            data: dashboard.financialChartData,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: ProjectDonutChart(
                            stats: dashboard.projectStats,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}