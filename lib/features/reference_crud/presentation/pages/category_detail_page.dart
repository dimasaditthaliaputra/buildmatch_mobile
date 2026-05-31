import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/global_app_bar.dart';
import '../../../../core/widgets/global_skeleton.dart';
import '../../../../core/widgets/main_button.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../config/injection_container.dart';
import '../bloc/category_bloc.dart';
import '../bloc/category_event.dart';
import '../bloc/category_state.dart';
import 'category_form_page.dart';

class CategoryDetailPageProvider extends StatelessWidget {
  final String categoryId;
  const CategoryDetailPageProvider({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CategoryBloc>(),
      child: CategoryDetailPage(categoryId: categoryId),
    );
  }
}

class CategoryDetailPage extends StatefulWidget {
  final String categoryId;
  const CategoryDetailPage({super.key, required this.categoryId});

  @override
  State<CategoryDetailPage> createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(GetCategoryDetailEvent(widget.categoryId));
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Konfirmasi Hapus'),
          content: const Text('Apakah Anda yakin ingin menghapus kategori ini?'),
          actions: [
            TextButton(
              onPressed: () => dialogContext.pop(),
              child: const Text('Batal'),
            ),
            MainButton(
              text: 'Hapus',
              backgroundColor: AppColors.error,
              onPressed: () {
                dialogContext.pop(); // Close dialog
                context.read<CategoryBloc>().add(DeleteCategoryEvent(widget.categoryId));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: GlobalAppBar(title: 'Detail Kategori'),
      body: BlocConsumer<CategoryBloc, CategoryState>(
        listener: (context, state) {
          if (state is CategorySubmitSuccess) {
            SnackbarUtils.showSuccess(state.message);
            context.pop(); // Go back to list
          } else if (state is CategorySubmitError) {
            SnackbarUtils.showError(state.message);
          }
        },
        buildWhen: (previous, current) {
          return current is CategoryLoading ||
                 current is CategoryDetailLoaded ||
                 current is CategoryError;
        },
        builder: (context, state) {
          if (state is CategoryLoading) {
            return _buildSkeletonLoading();
          } else if (state is CategoryError) {
            return Center(child: Text(state.message));
          } else if (state is CategoryDetailLoaded) {
            final category = state.category;
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nama', style: AppTextStyles.bodySmall),
                  const SizedBox(height: 4),
                  Text(category.name, style: AppTextStyles.heading3),
                  const SizedBox(height: 24),
                  
                  Text('Deskripsi', style: AppTextStyles.bodySmall),
                  const SizedBox(height: 4),
                  Text(category.description, style: AppTextStyles.bodyMedium),
                  const SizedBox(height: 24),

                  Text('Dibuat pada', style: AppTextStyles.bodySmall),
                  const SizedBox(height: 4),
                  Text(category.createdAt.toLocal().toString(), style: AppTextStyles.bodyMedium),

                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: MainButton(
                          text: 'Edit',
                          backgroundColor: AppColors.primaryUltraLightGrey,
                          textColor: AppColors.textPrimary,
                          onPressed: () {
                            context.push('/reference-crud/form', extra: category).then((_) {
                              // Reload detail after update
                              context.read<CategoryBloc>().add(GetCategoryDetailEvent(widget.categoryId));
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: MainButton(
                          text: 'Hapus',
                          backgroundColor: AppColors.error,
                          onPressed: () => _showDeleteConfirmation(context),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildSkeletonLoading() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GlobalSkeleton.text(width: 80, height: 14),
          const SizedBox(height: 8),
          GlobalSkeleton.text(width: 200, height: 24),
          const SizedBox(height: 24),
          
          GlobalSkeleton.text(width: 80, height: 14),
          const SizedBox(height: 8),
          GlobalSkeleton.text(width: double.infinity, height: 16),
          const SizedBox(height: 4),
          GlobalSkeleton.text(width: double.infinity, height: 16),
        ],
      ),
    );
  }
}
