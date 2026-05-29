import 'package:buildmatch_mobile/core/widgets/global_app_bar.dart';
import 'package:buildmatch_mobile/core/widgets/global_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../config/injection_container.dart';
import '../bloc/rating_bloc.dart';
import '../bloc/rating_event.dart';
import '../bloc/rating_state.dart';
import '../widgets/rating_summary_widget.dart';
import '../widgets/review_card_widget.dart';

class ListRatingPageProvider extends StatelessWidget {
  const ListRatingPageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RatingBloc>()..add(const FetchRatingsEvent()),
      child: const ListRatingPage(),
    );
  }
}

class ListRatingPage extends StatefulWidget {
  const ListRatingPage({super.key});

  @override
  State<ListRatingPage> createState() => _ListRatingPageState();
}

class _ListRatingPageState extends State<ListRatingPage> {
  final List<Map<String, String>> _filterOptions = [
    {'value': 'all', 'label': 'Semua'},
    {'value': 'satisfied', 'label': 'Puas'},
    {'value': 'with_photos', 'label': 'Ada Foto'},
    {'value': 'highest', 'label': 'Tertinggi'},
    {'value': 'lowest', 'label': 'Terendah'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: GlobalAppBar(title: 'Ulasan & Rating'),
      body: BlocBuilder<RatingBloc, RatingState>(
        builder: (context, state) {
          if (state is RatingLoading) {
            return _buildSkeletonLoading();
          } else if (state is RatingError) {
            return _buildErrorState(state.message);
          } else if (state is RatingLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<RatingBloc>().add(
                      RefreshRatingsEvent(filter: state.activeFilter),
                    );
              },
              child: CustomScrollView(
                slivers: [
                  // Summary Section
                  SliverToBoxAdapter(
                    child: Container(
                      color: Colors.white,
                      child: RatingSummaryWidget(stats: state.stats),
                    ),
                  ),

                  // Filter Chips
                  SliverToBoxAdapter(
                    child: _buildFilterChips(
                        state.activeFilter, state.stats.totalReviews),
                  ),

                  // Reviews List
                  if (state.reviews.isEmpty)
                    SliverFillRemaining(
                      child: Center(
                        child: Text(
                          'Belum ada ulasan untuk filter ini.',
                          style: AppTextStyles.bodyMedium,
                        ),
                      ),
                    )
                  else
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return ReviewCardWidget(
                            review: state.reviews[index],
                          );
                        },
                        childCount: state.reviews.length,
                      ),
                    ),
                  
                  // Bottom Padding
                  const SliverToBoxAdapter(child: SizedBox(height: 24)),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildFilterChips(String activeFilter, int totalReviews) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Row(
          children: _filterOptions.map((filter) {
            final isActive = activeFilter == filter['value'];
            
            // Format label (e.g., "Semua (589)")
            String label = filter['label']!;
            if (filter['value'] == 'all') {
              label = '$label ($totalReviews)';
            }
            
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ChoiceChip(
                label: Text(label),
                selected: isActive,
                onSelected: (selected) {
                  if (selected && !isActive) {
                    context
                        .read<RatingBloc>()
                        .add(FetchRatingsEvent(filter: filter['value']!));
                  }
                },
                selectedColor: AppColors.primary,
                labelStyle: AppTextStyles.bodyMedium.copyWith(
                  color: isActive ? Colors.white : AppColors.textPrimary,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                ),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                  side: BorderSide(
                    color: isActive ? AppColors.primary : AppColors.primaryGrey,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: AppColors.error),
            const SizedBox(height: 16),
            Text(
              'Gagal Memuat Data',
              style: AppTextStyles.heading3,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                context.read<RatingBloc>().add(const FetchRatingsEvent());
              },
              child: const Text('Coba Lagi'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkeletonLoading() {
    return CustomScrollView(
      slivers: [
        // Skeleton for Summary Widget
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GlobalSkeleton.text(width: 80, height: 48, borderRadius: 8),
                      const SizedBox(height: 12),
                      GlobalSkeleton.text(width: 100, height: 16),
                      const SizedBox(height: 8),
                      GlobalSkeleton.text(width: 80, height: 12),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: List.generate(
                      5,
                      (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: GlobalSkeleton.text(height: 10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        
        // Skeleton for Filter Chips
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: SizedBox(
              height: 40,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  return GlobalSkeleton(
                    width: index == 0 ? 80 : 100,
                    height: 40,
                    borderRadius: 24,
                  );
                },
              ),
            ),
          ),
        ),

        // Skeleton for Review Cards
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GlobalSkeleton.avatar(size: 40),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GlobalSkeleton.text(width: 120, height: 14),
                              const SizedBox(height: 6),
                              GlobalSkeleton.text(width: 80, height: 10),
                            ],
                          ),
                        ),
                        GlobalSkeleton.text(width: 40, height: 14),
                      ],
                    ),
                    const SizedBox(height: 16),
                    GlobalSkeleton.text(width: double.infinity, height: 12),
                    const SizedBox(height: 6),
                    GlobalSkeleton.text(width: double.infinity, height: 12),
                    const SizedBox(height: 6),
                    GlobalSkeleton.text(width: MediaQuery.of(context).size.width * 0.5, height: 12),
                    if (index % 2 == 0) ...[
                      const SizedBox(height: 16),
                      Row(
                        children: List.generate(
                          3,
                          (i) => Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: GlobalSkeleton(width: 80, height: 80, borderRadius: 8),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              );
            },
            childCount: 4,
          ),
        ),
      ],
    );
  }
}
