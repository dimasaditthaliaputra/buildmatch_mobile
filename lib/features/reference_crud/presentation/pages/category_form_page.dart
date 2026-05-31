import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/global_app_bar.dart';
import '../../../../core/widgets/main_button.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../config/injection_container.dart';
import '../../domain/entities/category_entity.dart';
import '../bloc/category_bloc.dart';
import '../bloc/category_event.dart';
import '../bloc/category_state.dart';

class CategoryFormPageProvider extends StatelessWidget {
  final CategoryEntity? category;
  const CategoryFormPageProvider({super.key, this.category});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CategoryBloc>(),
      child: CategoryFormPage(category: category),
    );
  }
}

class CategoryFormPage extends StatefulWidget {
  final CategoryEntity? category; // If null, it's Create. If provided, it's Update.

  const CategoryFormPage({super.key, this.category});

  @override
  State<CategoryFormPage> createState() => _CategoryFormPageState();
}

class _CategoryFormPageState extends State<CategoryFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  bool get isEdit => widget.category != null;

  @override
  void initState() {
    super.initState();
    if (isEdit) {
      _nameController.text = widget.category!.name;
      _descriptionController.text = widget.category!.description;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (isEdit) {
        context.read<CategoryBloc>().add(
          UpdateCategoryEvent(
            id: widget.category!.id,
            name: _nameController.text,
            description: _descriptionController.text,
          ),
        );
      } else {
        context.read<CategoryBloc>().add(
          CreateCategoryEvent(
            name: _nameController.text,
            description: _descriptionController.text,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: GlobalAppBar(title: isEdit ? 'Edit Kategori' : 'Tambah Kategori'),
      body: BlocListener<CategoryBloc, CategoryState>(
        listener: (context, state) {
          if (state is CategorySubmitSuccess) {
            SnackbarUtils.showSuccess(state.message);
            context.pop(); // Go back to previous page
          } else if (state is CategorySubmitError) {
            SnackbarUtils.showError(state.message);
          }
        },
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nama Kategori',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nama kategori tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Deskripsi',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Deskripsi tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const Spacer(),
                BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (context, state) {
                    return MainButton(
                      text: state is CategorySubmitting
                          ? 'Menyimpan...'
                          : (isEdit ? 'Simpan Perubahan' : 'Simpan Kategori'),
                      onPressed: state is CategorySubmitting ? null : _submitForm,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
