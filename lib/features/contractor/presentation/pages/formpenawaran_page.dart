import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/main_button.dart';
import '../../../../core/widgets/global_text_field.dart';
import '../../../../core/utils/screen_size.dart';
import '../../../../core/widgets/global_card.dart';
import '../bloc/penawaran_bloc.dart';
import '../widgets/budget_range_input.dart';
import '../widgets/estimasi_waktu_picker.dart';
import '../widgets/proyek_info_card.dart';

class FormPenawaranArgs {
  final String proyekId;
  final String namaProyek;
  final double budgetKlienMin;
  final double budgetKlienMax;
  final DateTime batasWaktuKlien;
  final String deskripsiProyek;

  const FormPenawaranArgs({
    required this.proyekId,
    required this.namaProyek,
    required this.budgetKlienMin,
    required this.budgetKlienMax,
    required this.batasWaktuKlien,
    required this.deskripsiProyek,
  });
}

class FormPenawaranPageProvider extends StatelessWidget {
  final FormPenawaranArgs args;

  const FormPenawaranPageProvider({Key? key, required this.args})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PenawaranBloc>(),
      child: FormPenawaranPage(args: args),
    );
  }
}

class FormPenawaranPage extends StatelessWidget {
  final FormPenawaranArgs args;

  const FormPenawaranPage({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return _AjukanPenawaranView(
      proyekId: args.proyekId,
      namaProyek: args.namaProyek,
      budgetKlienMin: args.budgetKlienMin,
      budgetKlienMax: args.budgetKlienMax,
      batasWaktuKlien: args.batasWaktuKlien,
      deskripsiProyek: args.deskripsiProyek,
    );
  }
}

class _AjukanPenawaranView extends StatefulWidget {
  final String proyekId;
  final String namaProyek;
  final double budgetKlienMin;
  final double budgetKlienMax;
  final DateTime batasWaktuKlien;
  final String deskripsiProyek;

  const _AjukanPenawaranView({
    required this.proyekId,
    required this.namaProyek,
    required this.budgetKlienMin,
    required this.budgetKlienMax,
    required this.batasWaktuKlien,
    required this.deskripsiProyek,
  });

  @override
  State<_AjukanPenawaranView> createState() => _AjukanPenawaranViewState();
}

class _AjukanPenawaranViewState extends State<_AjukanPenawaranView> {
  final _pesanController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _pesanController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onSubmit(BuildContext context, PenawaranState state) {
    if (!state.isFormValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Lengkapi semua data penawaran (Pesan min. 10 karakter)',
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.textLight),
          ),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
      return;
    }

    context.read<PenawaranBloc>().add(
      PenawaranSubmitted(projectId: widget.proyekId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: Container(
            margin: const EdgeInsets.all(8),
            child: const Icon(
              Icons.arrow_back,
              color: AppColors.primaryBlack,
              size: 24,
            ),
          ),
        ),
        title: Text(
          'Ajukan Penawaran',
          style: AppTextStyles.heading3.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        centerTitle: false,
      ),
      body: BlocConsumer<PenawaranBloc, PenawaranState>(
        listenWhen: (previous, current) =>
            previous.submitStatus != current.submitStatus,
        listener: (context, state) {
          if (state.submitStatus == PenawaranSubmitStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Penawaran berhasil diajukan!',
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
          }
        },
        builder: (context, state) {
          final isLoading = state.isLoading;

          return Stack(
            children: [
              SingleChildScrollView(
                controller: _scrollController,
                padding: const EdgeInsets.only(bottom: 120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(32),
                              bottomRight: Radius.circular(32),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                          child: ProyekInfoCard(
                            // namaProyek: widget.namaProyek,
                            // budgetMin: widget.budgetKlienMin,
                            // budgetMax: widget.budgetKlienMax,
                            // batasWaktu: widget.batasWaktuKlien,
                            // deskripsi: widget.deskripsiProyek,
                            // isAktif: true,
                            namaProyek: 'Modern Zen Villa - Pejaten Terrace',
                            budgetMin: 450000000.0,
                            budgetMax: 500000000.0,
                            batasWaktu: DateTime(2024, 12, 2),
                            deskripsi:
                                'Mencari kontraktor untuk villa 3 kamar tidur konsep industrial-tropical. Fokus pada sirkulasi udara alami dan pencahayaan.',
                            isAktif: true,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BudgetRangeInput(
                            onMinChanged: (value) => context
                                .read<PenawaranBloc>()
                                .add(BudgetMinChanged(value)),
                            onMaxChanged: (value) => context
                                .read<PenawaranBloc>()
                                .add(BudgetMaxChanged(value)),
                          ),
                          const SizedBox(height: 24),

                          Text(
                            'Pesan Untuk Klien',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.textSecondaryDark,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 10),

                          GlobalCard(
                            width: context.screenWidth,
                            margin: EdgeInsets.zero,
                            padding: EdgeInsets.zero,
                            backgroundColor: AppColors.primaryLightGrey,
                            borderRadius: 12.0,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                            child: GlobalTextField(
                              controller: _pesanController,
                              hintText:
                                  'Jelaskan mengapa Anda kandidat terbaik...',
                              maxLines: 5,
                              fillColor: AppColors.primaryLightGrey,
                              hintStyle: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.textSecondary,
                                fontSize: 14,
                              ),
                              onChanged: (value) {
                                context.read<PenawaranBloc>().add(
                                  PesanChanged(value),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 24),

                          EstimasiWaktuPicker(
                            selectedDate: state.estimasiWaktu,
                            onDateSelected: (date) {
                              if (date != null) {
                                context.read<PenawaranBloc>().add(
                                  EstimasiWaktuChanged(date),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                    20,
                    16,
                    20,
                    MediaQuery.of(context).padding.bottom + 16,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.9),
                        blurRadius: 20,
                        spreadRadius: 10,
                        offset: const Offset(0, -10),
                      ),
                    ],
                  ),
                  child: MainButton(
                    text: isLoading ? 'Mengirim...' : 'Kirim Penawaran',
                    icon: isLoading ? null : Icons.send_rounded,
                    backgroundColor: (isLoading || !state.isFormValid)
                        ? AppColors.primaryUltraGrey
                        : AppColors.primary,
                    onPressed: (isLoading || !state.isFormValid)
                        ? null
                        : () => _onSubmit(context, state),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
