import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../config/injection_container.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/utils/screen_size.dart';
import '../../../../../core/widgets/search_bar_widget.dart';
import '../../../../../core/widgets/filter_bar_widget.dart';
import '../bloc/contractor_project_list_bloc.dart';
import '../widgets/empty_project_list_state.dart';
import '../widgets/project_contractor_card.dart';

import '../../../../../core/widgets/global_app_bar.dart';
import '../../../../../core/widgets/error_state_view.dart';

class ProjectContractorListPageWrapper extends StatelessWidget {
  const ProjectContractorListPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ContractorProjectListBloc>(),
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
    context.read<ContractorProjectListBloc>().add(const LoadAllProjects());
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
            child: BlocBuilder<ContractorProjectListBloc, ContractorProjectListState>(
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
      color: AppColors.surface, 
      padding: EdgeInsets.fromLTRB(padHorizontal, padVertical, padHorizontal, padVertical * 1.5),
      
      child: SearchBarWidget(
        controller: _searchController,
        hintText: 'Cari proyek...',
        hintStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textSecondary,
        ),
        
        borderRadius: 12.0,
        contentPadding: EdgeInsets.symmetric(
          horizontal: padHorizontal, 
          vertical: padVertical * 1.5,
        ),
        
        fillColor: AppColors.surface,
        borderSide: BorderSide(
          color: AppColors.primaryUltraGrey,
          width: 1.0,
        ),

        onChanged: (query) {
          context.read<ContractorProjectListBloc>().add(SearchProjects(query));
        },
        onClear: () {
          context.read<ContractorProjectListBloc>().add(const SearchProjects(''));
        },
      ),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    final tabs = [
      ProjectFilterTab.semua,
      ProjectFilterTab.berjalan,
      ProjectFilterTab.selesai,
    ];

    final labels = {
      ProjectFilterTab.semua: 'Semua',
      ProjectFilterTab.berjalan: 'Sedang Berjalan',
      ProjectFilterTab.selesai: 'Selesai',
    };

    final double marginHorizontal = context.widthPct(0.04).clamp(16.0, 24.0);
    final double paddingInner = context.widthPct(0.01).clamp(4.0, 8.0);
    final double tabVerticalPadding = context.heightPct(0.012).clamp(8.0, 14.0);
    final double fontSize = context.widthPct(0.033).clamp(11.0, 14.0);
    final double dividerHeight = context.heightPct(0.025).clamp(16.0, 24.0);

    return Container(
      color: AppColors.surface,
      padding: EdgeInsets.only(bottom: context.heightPct(0.015).clamp(12.0, 20.0)),
      
      child: FilterBarWidget<ProjectFilterTab>(
        tabs: tabs,
        activeTab: _selectedTab,
        labelBuilder: (tab) => labels[tab] ?? '',
        
        margin: EdgeInsets.symmetric(horizontal: marginHorizontal),
        padding: EdgeInsets.all(paddingInner),
        tabPadding: EdgeInsets.symmetric(vertical: tabVerticalPadding),
        fontSize: fontSize,
        dividerHeight: dividerHeight,
        
        onTabChanged: (tab) {
          setState(() {
            _selectedTab = tab; 
          });
          context.read<ContractorProjectListBloc>().add(ChangeFilterTab(tab));
        },
      ),
    );
  }


  Widget _buildProjectList(BuildContext context, ProjectContractorListLoaded state) {
    final double padHorizontal = context.widthPct(0.04).clamp(16.0, 24.0);
    final double padVertical = context.heightPct(0.015).clamp(12.0, 20.0);

    return ListView.builder(
      padding: EdgeInsets.fromLTRB(
        padHorizontal, 
        padVertical, 
        padHorizontal, 
        padVertical + MediaQuery.of(context).padding.bottom,
      ),
      itemCount: state.filteredProjects.length,
      itemBuilder: (context, index) {
        final project = state.filteredProjects[index];
        return ProjectContractorCard(
          project: project,
          onTap: () {
            context.push('/milestone-contractor', extra: project);
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
        context.read<ContractorProjectListBloc>().add(const LoadAllProjects());
      },
    );
  }
}