import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../config/injection_container.dart';
import '../bloc/client_project_bloc.dart';
import '../bloc/client_project_event.dart';
import '../bloc/client_project_state.dart';
import '../widgets/project_search_bar_widget.dart';
import '../widgets/project_tab_bar_widget.dart';
import '../widgets/project_empty_state_widget.dart';
import '../widgets/client_project_card.dart';
import '../../../../core/widgets/global_app_bar.dart';

// --- Provider Wrapper ---
class ClientProjectProvider extends StatelessWidget {
  const ClientProjectProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ClientProjectBloc>(),
      child: const ClientProjectPage(),
    );
  }
}

// --- Page ---
class ClientProjectPage extends StatefulWidget {
  const ClientProjectPage({super.key});

  @override
  State<ClientProjectPage> createState() => _ClientProjectPageState();
}

class _ClientProjectPageState extends State<ClientProjectPage> {
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    context.read<ClientProjectBloc>().add(
      const LoadClientPenawaran(clientId: 'current_user'),
    );
  }

  void _onTabChanged(int index) {
    if (_selectedTab == index) return;
    setState(() => _selectedTab = index);

    final bloc = context.read<ClientProjectBloc>();
    bloc.add(SwitchProjectTab(tabIndex: index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const GlobalAppBar(
        title: 'Proyek',
        backgroundColor: AppColors.surface,
        showBackButton: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Column(
              children: [
                // Search bar + filter button
                ProjectSearchBarWidget(
                  onChanged: (query) {
                    context.read<ClientProjectBloc>().add(
                      SearchClientProjects(query: query),
                    );
                  },
                ),
                const SizedBox(height: 12),
                // Tab bar
                ProjectTabBarWidget(
                  selectedTab: _selectedTab,
                  onTabChanged: _onTabChanged,
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Content area
          Expanded(
            child: BlocBuilder<ClientProjectBloc, ClientProjectState>(
              builder: (context, state) {
                if (state is ClientProjectLoading) {
                  return _buildLoading();
                }
                if (state is ClientProjectError) {
                  return _buildError(state.message);
                }
                if (state is ClientProjectLoaded) {
                  return _buildProjectList(state);
                }
                return _buildLoading();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.primary,
        strokeWidth: 2.5,
      ),
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Text(
        'Gagal memuat data: $message',
        style: TextStyle(color: AppColors.error),
      ),
    );
  }

  Widget _buildProjectList(ClientProjectLoaded state) {
    final projects = state.filteredProjects;

    if (projects.isEmpty) {
      final isPenawaran = state.currentTab == 0;
      return ProjectEmptyStateWidget(
        title: isPenawaran ? 'Belum Ada Penawaran' : 'Belum Ada Proyek',
        subtitle: isPenawaran
            ? 'Penawaran yang Anda kirim akan\nmuncul di sini.'
            : 'Proyek yang Anda buat akan\nmuncul di sini.',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      physics: const BouncingScrollPhysics(),
      itemCount: projects.length,
      itemBuilder: (context, index) {
        final project = projects[index];
        return ClientProjectCard(
          project: project,
          onDetailTap: () {
            // Navigate to detail
          },
        );
      },
    );
  }
}
