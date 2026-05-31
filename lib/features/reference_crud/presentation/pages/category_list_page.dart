import 'package:buildmatch_mobile/core/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/global_app_bar.dart';
import '../../../../core/widgets/global_skeleton.dart';
import '../../../../core/widgets/search_bar_widget.dart';
import '../../../../core/widgets/main_button.dart';
import '../../../../config/injection_container.dart';
import '../bloc/category_bloc.dart';
import '../bloc/category_event.dart';
import '../bloc/category_state.dart';

class CategoryListPageProvider extends StatelessWidget {
  const CategoryListPageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CategoryBloc>()..add(const LoadCategoriesEvent()),
      child: const CategoryListPage(),
    );
  }
}

class CategoryListPage extends StatefulWidget {
  const CategoryListPage({super.key});

  @override
  State<CategoryListPage> createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<CategoryBloc>().add(LoadMoreCategoriesEvent());
    }
  }

  Future<void> _onRefresh() async {
    context.read<CategoryBloc>().add(
      LoadCategoriesEvent(isRefresh: true, searchQuery: _searchController.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: GlobalAppBar(title: 'Daftar Kategori'),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: BlocConsumer<CategoryBloc, CategoryState>(
              listener: (context, state) {
                // If there's any state that needs to show snackbar, handle here.
              },
              buildWhen: (previous, current) {
                // Only rebuild if the state is related to list loading
                return current is CategoryLoading ||
                    current is CategoryLoaded ||
                    current is CategoryEmpty ||
                    current is CategoryError;
              },
              builder: (context, state) {
                if (state is CategoryLoading) {
                  return _buildSkeletonLoading();
                } else if (state is CategoryError) {
                  return _buildErrorState(state.message);
                } else if (state is CategoryEmpty) {
                  return _buildEmptyState();
                } else if (state is CategoryLoaded) {
                  return RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: ListView.builder(
                      controller: _scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount:
                          state.categories.length +
                          (state.isLoadingMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index >= state.categories.length) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }

                        final category = state.categories[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: ListTile(
                            title: Text(
                              category.name,
                              style: AppTextStyles.heading3,
                            ),
                            subtitle: Text(
                              category.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.bodySmall,
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                            ),
                            onTap: () {
                              context
                                  .push('/reference-crud/detail/${category.id}')
                                  .then((_) => _onRefresh());
                            },
                          ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/reference-crud/form').then((_) => _onRefresh());
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SearchBarWidget(
        controller: _searchController,
        hintText: 'Cari kategori...',
        onChanged: (value) => _onRefresh(),
        onClear: () {
          _searchController.clear();
          _onRefresh();
        },
        fillColor: AppColors.surface,
        borderRadius: 12.0,
        borderSide: const BorderSide(color: AppColors.surfaceBeige, width: 1.0),
        contentPadding: EdgeInsets.symmetric(
          vertical: context.heightPct(0.015).clamp(14.0, 18.0),
          horizontal: 16.0,
        ),
      ),
    );
  }

  Widget _buildSkeletonLoading() {
    return ListView.builder(
      itemCount: 6,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: GlobalSkeleton.card(height: 80),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.6,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.inbox, size: 48, color: Colors.grey),
              const SizedBox(height: 16),
              Text('Belum ada data', style: AppTextStyles.heading3),
              const SizedBox(height: 8),
              Text(
                'Data kategori masih kosong.',
                style: AppTextStyles.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: AppColors.error),
          const SizedBox(height: 16),
          Text('Terjadi Kesalahan', style: AppTextStyles.heading3),
          const SizedBox(height: 8),
          Text(message, style: AppTextStyles.bodyMedium),
          const SizedBox(height: 16),
          MainButton(text: 'Coba Lagi', onPressed: _onRefresh),
        ],
      ),
    );
  }
}
