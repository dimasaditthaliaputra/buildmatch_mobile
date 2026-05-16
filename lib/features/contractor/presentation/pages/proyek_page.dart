import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../config/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/screen_size.dart'; 
import '../../../../core/widgets/global_app_bar.dart'; 

import '../widgets/project_card.dart'; 
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
      appBar: const GlobalAppBar(
        title: 'Proyek',
      ),
      body: Column(
        children: [
          _buildSearchBar(context),
          Expanded(child: _buildProjectList(context)),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    final double searchBarHeight = context.heightPct(0.055).clamp(46.0, 56.0);
    final double searchPadH = context.widthPct(0.04).clamp(16.0, 20.0);
    final double searchPadV = context.heightPct(0.01).clamp(8.0, 12.0);

    return Container(
      color: AppColors.background,
      padding: EdgeInsets.fromLTRB(searchPadH, searchPadV, searchPadH, searchPadV * 1.5),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: searchBarHeight,
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
                    fontSize: context.widthPct(0.035).clamp(13.0, 15.0),
                  ),
                  prefixIcon: Icon(
                    LucideIcons.search,
                    size: context.widthPct(0.05).clamp(18.0, 22.0),
                    color: AppColors.textSecondary,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: context.heightPct(0.015).clamp(13.0, 16.0),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: context.widthPct(0.025).clamp(10.0, 14.0)),
          _FilterButton(height: searchBarHeight),
        ],
      ),
    );
  }

  Widget _buildProjectList(BuildContext context) {
    final double listPadH = context.widthPct(0.04).clamp(16.0, 20.0);
    final double listPadV = context.heightPct(0.01).clamp(8.0, 12.0);
    final double locIconSize = context.widthPct(0.045).clamp(16.0, 20.0);
    final double locTextSize = context.widthPct(0.035).clamp(12.0, 14.0);
    final double titleSize = context.widthPct(0.045).clamp(16.0, 20.0);

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
            padding: EdgeInsets.fromLTRB(listPadH, listPadV, listPadH, listPadV * 3),
            itemCount: state.filteredProjects.length,
            itemBuilder: (context, index) {
              final project = state.filteredProjects[index];
              
              return Padding(
                padding: EdgeInsets.only(bottom: context.heightPct(0.03).clamp(24.0, 32.0)),
                child: ProjectCard(
                  imageUrl: project.imageUrl,
                  onTap: () => context.push('/project/${project.id}'),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          _buildTag(context, project.category), 
                          SizedBox(width: context.widthPct(0.015).clamp(6.0, 10.0)),
                          Icon(
                            LucideIcons.mapPin,
                            size: locIconSize,
                            color: AppColors.primaryDark,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              project.city,
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.primaryDark,
                                fontWeight: FontWeight.w600,
                                fontSize: locTextSize,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: context.heightPct(0.01).clamp(8.0, 12.0)),
                      Text(
                        project.title,
                        style: AppTextStyles.heading3.copyWith(
                          fontSize: titleSize,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: context.heightPct(0.015).clamp(12.0, 16.0)),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildTag(BuildContext context, String label) {
    final double tagFs = context.widthPct(0.028).clamp(9.0, 11.0);
    final double tagPadH = context.widthPct(0.02).clamp(8.0, 12.0);
    final double tagPadV = context.heightPct(0.004).clamp(3.0, 6.0);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: tagPadH, vertical: tagPadV),
      decoration: BoxDecoration(
        color: AppColors.surfaceCream,
        borderRadius: BorderRadius.circular(16), 
      ),
      child: Text(
        label.toUpperCase(),
        style: GoogleFonts.inter(
          fontSize: tagFs,
          fontWeight: FontWeight.w600,
          color: AppColors.primaryDark,
          letterSpacing: 0.4,
        ),
      ),
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
  final double height;

  const _FilterButton({required this.height});

  @override
  Widget build(BuildContext context) {
    final double iconSize = context.widthPct(0.05).clamp(18.0, 22.0);

    return GestureDetector(
      onTap: () {},
      child: Container(
        width: height, 
        height: height,
        decoration: BoxDecoration(
          color: AppColors.primaryDark,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          LucideIcons.slidersHorizontal,
          size: iconSize,
          color: Colors.white,
        ),
      ),
    );
  }
}