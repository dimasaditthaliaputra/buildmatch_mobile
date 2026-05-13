import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../config/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/project_card.dart';
import '../bloc/project_bloc.dart';
import '../bloc/project_event.dart';
import '../bloc/project_state.dart';

class ProyekPage extends StatelessWidget {
  const ProyekPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProjectBloc>()..add(LoadProjects()),
      child: const _ProyekView(),
    );
  }
}

class _ProyekView extends StatelessWidget {
  const _ProyekView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          _buildSearchBar(context),
          Expanded(child: _buildProjectList()),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: GestureDetector(
          onTap: () => context.pop(),
          child: const Icon(
            LucideIcons.arrowLeft,
            color: AppColors.textPrimary,
            size: 22,
          ),
        ),
      ),
      title: Text(
        'Proyek',
        style: AppTextStyles.heading3.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
      centerTitle: false,
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 46,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Cari proyek...',
                  hintStyle: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                  ),
                  prefixIcon: const Icon(
                    LucideIcons.search,
                    size: 18,
                    color: AppColors.textSecondary,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 13),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          _FilterButton(),
        ],
      ),
    );
  }

  Widget _buildProjectList() {
    return BlocBuilder<ProjectBloc, ProjectState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        if (state.filteredProjects.isEmpty) {
          return _buildEmptyState();
        }

        return ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(overscroll: false),
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            itemCount: state.filteredProjects.length,
            itemBuilder: (context, index) {
              final project = state.filteredProjects[index];
              return AppCard(
                imageUrl: project.imageUrl,
                tag: project.category,
                location: project.city,
                title: project.title,
                infoItems: [
                  AppCardInfo(
                    label: 'Rentang Harga',
                    value: '${project.rentPriceMin} - ${project.rentPriceMax}',
                  ),
                  AppCardInfo(
                    label: 'Luas Bangunan',
                    value: project.buildingArea,
                  ),
                ],
                onTap: () => context.push('/project/${project.id}'),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            LucideIcons.folderOpen,
            size: 64,
            color: AppColors.textSecondary.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'Belum ada proyek',
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Proyek akan muncul di sini',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: open filter bottom sheet
      },
      child: Container(
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          color: AppColors.primaryDark,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(
          LucideIcons.slidersHorizontal,
          size: 20,
          color: Colors.white,
        ),
      ),
    );
  }
}
