import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/screen_size.dart';
import '../../../../core/widgets/global_app_bar.dart';
import '../../../../core/widgets/search_bar_widget.dart';
import '../../../../config/injection_container.dart';
import '../bloc/project_offers_bloc.dart';
import '../bloc/project_offers_event.dart';
import '../bloc/project_offers_state.dart';
import '../widgets/offer_card_widget.dart';
import '../../../client/presentation/widgets/project_empty_state_widget.dart';

class PenawaranProjectPageWrapper extends StatelessWidget {
  final String projectId;

  const PenawaranProjectPageWrapper({super.key, required this.projectId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          sl<ProjectOffersBloc>()..add(LoadProjectOffers(projectId: projectId)),
      child: PenawaranProjectPage(projectId: projectId),
    );
  }
}

class PenawaranProjectPage extends StatefulWidget {
  final String projectId;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onFilterTap;

  const PenawaranProjectPage({
    super.key,
    required this.projectId,
    this.onChanged,
    this.onFilterTap,
  });

  @override
  State<PenawaranProjectPage> createState() => _PenawaranProjectPageState();
}

class _PenawaranProjectPageState extends State<PenawaranProjectPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double padHorizontal = context.widthPct(0.06).clamp(16.0, 24.0);
    final double padVertical = context.heightPct(0.01).clamp(8.0, 16.0);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const GlobalAppBar(
        title: 'Proyek',
        backgroundColor: AppColors.background,
        showBackButton: true,
      ),
      body: Column(
        children: [
          // Search and Filter Bar
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: padHorizontal,
              vertical: padVertical,
            ),
            child: Row(
              children: [
                Expanded(
                  child: SearchBarWidget(
                    controller: _searchController,
                    hintText: 'Cari penawaran...',
                    onChanged: (query) {
                      context.read<ProjectOffersBloc>().add(
                        SearchProjectOffers(query: query),
                      );
                      if (widget.onChanged != null) {
                        widget.onChanged!(query);
                      }
                    },
                    fillColor: AppColors.surface,
                    borderRadius: 12.0,
                    borderSide: const BorderSide(
                      color: AppColors.surfaceBeige,
                      width: 1.0,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: context.heightPct(0.015).clamp(14.0, 18.0),
                      horizontal: 16.0,
                    ),
                    showFilter: true,
                    onFilterTap: widget.onFilterTap,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: context.heightPct(0.02)),

          // List of Offers
          Expanded(
            child: BlocBuilder<ProjectOffersBloc, ProjectOffersState>(
              builder: (context, state) {
                if (state is ProjectOffersLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  );
                }

                if (state is ProjectOffersError) {
                  return Center(
                    child: Text(
                      'Terjadi kesalahan:\n${state.message}',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.error,
                      ),
                    ),
                  );
                }

                if (state is ProjectOffersLoaded) {
                  final offers = state.filteredOffers;

                  if (offers.isEmpty) {
                    final isSearching = state.searchQuery.isNotEmpty;
                    return ProjectEmptyStateWidget(
                      title: isSearching ? 'Tidak Ditemukan' : 'Belum Ada Penawaran',
                      subtitle: isSearching 
                          ? 'Penawaran dengan kata kunci tersebut\ntidak ditemukan.'
                          : 'Belum ada profesional yang memberikan\npenawaran untuk proyek ini.',
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<ProjectOffersBloc>().add(
                        LoadProjectOffers(projectId: widget.projectId),
                      );
                    },
                    child: ListView.builder(
                      padding: EdgeInsets.fromLTRB(
                        padHorizontal,
                        padVertical,
                        padHorizontal,
                        padVertical + context.bottomPadding,
                      ),
                      itemCount: offers.length,
                      itemBuilder: (context, index) {
                        final offer = offers[index];
                        return OfferCardWidget(
                          offer: offer,
                          onProfileTap: () {
                            // Navigate to profile
                          },
                        );
                      },
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
