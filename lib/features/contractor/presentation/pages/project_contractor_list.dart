import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/injection_container.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/utils/screen_size.dart';
import '../bloc/project_contractor_list_bloc.dart';
import '../widgets/empty_project_list_state.dart';
import '../widgets/project_contractor_card.dart';
import '../widgets/project_tab_bar.dart';

import '../../../../../core/widgets/global_app_bar.dart';
import '../../../../../core/widgets/error_state_view.dart';

class ProjectContractorListPageWrapper extends StatelessWidget {
  const ProjectContractorListPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProjectContractorListBloc>(),
      child: const ProjectContractorListPage(),
    );
  }
}

class ProjectContractorListPage extends StatefulWidget {
  const ProjectContractorListPage({super.key});

  @override
  State<ProjectContractorListPage> createState() => _ProjectContractorListPageState();
}

class _ProjectContractorListPageState extends State<ProjectContractorListPage> {
  final TextEditingController _searchController = TextEditingController();
  
  ProjectFilterTab _selectedTab = ProjectFilterTab.semua;

  @override
  void initState() {
    super.initState();
    context.read<ProjectContractorListBloc>().add(const LoadAllProjects());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const GlobalAppBar(
        title: 'Proyek',
        backgroundColor: AppColors.surface,
        showBackButton: true,
        actions: [], 
      ),
      body: Column(
        children: [
          _buildSearchBar(context),
          
          _buildTabBar(context),

          Expanded(
            child: BlocBuilder<ProjectContractorListBloc, ProjectContractorListState>(
              builder: (context, state) {
                if (state is ProjectContractorListLoading ||
                    state is ProjectContractorListInitial) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  );
                }

                if (state is ProjectContractorListError) {
                  return _buildError(state.message);
                }

                if (state is ProjectContractorListLoaded) {
                  return state.filteredProjects.isEmpty
                      ? EmptyProjectState(
                          isSelesai: state.activeTab == ProjectFilterTab.selesai,
                        )
                      : _buildProjectList(context, state);
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    final double padHorizontal = context.widthPct(0.04).clamp(16.0, 24.0);
    final double padVertical = context.heightPct(0.01).clamp(8.0, 12.0);

    return Container(
      padding: EdgeInsets.fromLTRB(padHorizontal, padVertical, padHorizontal, padVertical * 1.5),
      color: AppColors.surface,
      child: TextField(
        controller: _searchController,
        onChanged: (query) {
          context.read<ProjectContractorListBloc>().add(SearchProjects(query));
        },
        style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary),
        decoration: InputDecoration(
          hintText: 'Cari proyek...',
          hintStyle: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: AppColors.textSecondary,
            size: 22,
          ),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  color: AppColors.textSecondary,
                  onPressed: () {
                    _searchController.clear();
                    context.read<ProjectContractorListBloc>().add(
                          const SearchProjects(''),
                        );
                  },
                )
              : null,
          filled: true,
          fillColor: AppColors.primaryUltraLightGrey.withOpacity(0.5),
          contentPadding: EdgeInsets.symmetric(
            horizontal: padHorizontal, 
            vertical: padVertical * 1.5
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return Container(
      color: AppColors.surface,
      padding: EdgeInsets.only(bottom: context.heightPct(0.015).clamp(12.0, 20.0)),
      child: ProjectTabBar(
        activeTab: _selectedTab, 
        onTabChanged: (tab) {
          setState(() {
            _selectedTab = tab; 
          });
          context.read<ProjectContractorListBloc>().add(ChangeFilterTab(tab));
        },
      ),
    );
  }

  Widget _buildProjectList(BuildContext context, ProjectContractorListLoaded state) {
    final double padHorizontal = context.widthPct(0.04).clamp(16.0, 24.0);
    final double padVertical = context.heightPct(0.015).clamp(12.0, 20.0);

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: padHorizontal, vertical: padVertical),
      itemCount: state.filteredProjects.length,
      itemBuilder: (context, index) {
        final project = state.filteredProjects[index];
        return ProjectContractorCard(
          project: project,
          onTap: () {
            // context.push('/project/${project.id}');
          },
        );
      },
    );
  }

  Widget _buildError(String message) {
    return ErrorStateView(
      title: 'Gagal Memuat Proyek',
      message: message,
      buttonText: 'Coba Lagi',
      icon: Icons.cloud_off_rounded,
      onRetry: () {
        context.read<ProjectContractorListBloc>().add(const LoadAllProjects());
      },
    );
  }
}