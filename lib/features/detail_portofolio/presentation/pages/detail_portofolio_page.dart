import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../config/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/screen_size.dart';
import '../../../../core/widgets/global_app_bar.dart';
import '../../../../core/widgets/global_text_field.dart';
import '../../../../core/widgets/main_button.dart';

import '../bloc/portofolio_bloc.dart';
import '../widgets/upload_image_widget.dart';

class DetailPortofolioPageProvider extends StatelessWidget {
  const DetailPortofolioPageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PortofolioBloc>(),
      child: const DetailPortofolioPage(),
    );
  }
}

class DetailPortofolioPage extends StatelessWidget {
  const DetailPortofolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _DetailPortofolioView();
  }
}

class _DetailPortofolioView extends StatefulWidget {
  const _DetailPortofolioView();

  @override
  State<_DetailPortofolioView> createState() => _DetailPortofolioViewState();
}

class _DetailPortofolioViewState extends State<_DetailPortofolioView> {
  final _judulController = TextEditingController();
  final _deskripsiController = TextEditingController();
  final _scrollController = ScrollController();
  final _picker = ImagePicker();

  @override
  void dispose() {
    _judulController.dispose();
    _deskripsiController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _pickImages(BuildContext context) async {
    final results = await _picker.pickMultiImage(imageQuality: 80);
    if (results.isNotEmpty && context.mounted) {
      final paths = results.map((xf) => xf.path).toList();
      context.read<PortofolioBloc>().add(ImagesAdded(paths));
    }
  }

  void _onSubmit(BuildContext context, PortofolioState state) {
    if (!state.isFormValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Lengkapi semua data (Deskripsi min. 10 karakter)',
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.textLight),
          ),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
      return;
    }
    context.read<PortofolioBloc>().add(const PortofolioSubmitted());
  }

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = context.widthPct(0.05);

    return BlocConsumer<PortofolioBloc, PortofolioState>(
      listenWhen: (previous, current) =>
          previous.submitStatus != current.submitStatus,
      listener: (context, state) {
        if (state.submitStatus == PortofolioSubmitStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Portofolio berhasil dipublikasikan!',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textLight,
                ),
              ),
              backgroundColor: AppColors.success,
            ),
          );
          Future.delayed(const Duration(milliseconds: 800), () {
            if (context.mounted) context.pop();
          });
        } else if (state.submitStatus == PortofolioSubmitStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errorMessage ?? 'Terjadi kesalahan',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textLight,
                ),
              ),
              backgroundColor: AppColors.error,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: GlobalAppBar(
            title: 'Detail Portofolio',
            backgroundColor: AppColors.background,
            showBackButton: true,
          ),
          body: SingleChildScrollView(
            controller: _scrollController,
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SectionLabel(label: 'Judul Portofolio'),
                const SizedBox(height: 8),
                GlobalTextField(
                  controller: _judulController,
                  hintText: 'Contoh: Villa Modern Minimalis',
                  fillColor: AppColors.surface,
                  onChanged: (val) =>
                      context.read<PortofolioBloc>().add(JudulChanged(val)),
                ),

                const SizedBox(height: 20),

                _SectionLabel(label: 'Deskripsi Proyek'),
                const SizedBox(height: 8),
                GlobalTextField(
                  controller: _deskripsiController,
                  hintText:
                      'Jelaskan proyek ini secara detail. Konsep desain, '
                      'tantangan yang dihadapi, material yang digunakan, '
                      'dan hasil akhir yang dipakai....',
                  maxLines: 6,
                  fillColor: AppColors.primaryLightGrey,
                  contentPadding: const EdgeInsets.all(16),
                  onChanged: (val) =>
                      context.read<PortofolioBloc>().add(DeskripsiChanged(val)),
                ),

                const SizedBox(height: 20),

                _SectionLabel(label: 'Upload Portofolio Project'),
                const SizedBox(height: 8),

                BlocBuilder<PortofolioBloc, PortofolioState>(
                  buildWhen: (prev, curr) => prev.imagePaths != curr.imagePaths,
                  builder: (context, state) {
                    return UploadGambarWidget(
                      imagePaths: state.imagePaths,
                      onUploadTap: () => _pickImages(context),
                      onRemove: (index) => context.read<PortofolioBloc>().add(
                        ImageRemoved(index),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          bottomNavigationBar: Container(
            padding: EdgeInsets.fromLTRB(
              horizontalPadding,
              12,
              horizontalPadding,
              MediaQuery.of(context).padding.bottom +
                  12, 
            ),

            child: MainButton(
              text: 'Publikasi Portofolio',
              icon: LucideIcons.sendHorizontal,
              borderRadius: 24,
              padding: const EdgeInsets.symmetric(vertical: 16),
              onPressed: () => _onSubmit(context, state),
            ),
          ),
        );
      },
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: AppTextStyles.bodyMedium.copyWith(
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
    );
  }
}
