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
import '../../../../core/widgets/global_app_bar.dart';
import '../bloc/contractor_project_offer_bloc.dart';
import '../widgets/budget_range_input.dart';
import '../widgets/estimasi_waktu_picker.dart';
import '../widgets/proyek_info_card.dart';

class ContractorProjectOfferPageProvider extends StatelessWidget {
  const ContractorProjectOfferPageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ContractorProjectOfferBloc>(),
      child: ContractorProjectOfferPage(),
    );
  }
}

class ContractorProjectOfferPage extends StatelessWidget {
  const ContractorProjectOfferPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ContractorProjectOfferView();
  }
}

class ContractorProjectOfferView extends StatefulWidget {
  const ContractorProjectOfferView();

  @override
  State<ContractorProjectOfferView> createState() =>
      _ContractorProjectOfferViewState();
}

class _ContractorProjectOfferViewState
    extends State<ContractorProjectOfferView> {
  final _pesanController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _pesanController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onSubmit(BuildContext context, ContractorProjectOfferState state) {
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

    context.read<ContractorProjectOfferBloc>().add(
      PenawaranSubmitted(projectId: 'TEST-123'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const GlobalAppBar(
        title: 'Ajukan Penawaran',
        backgroundColor: AppColors.surface,
        titleColor: AppColors.primary,
        titleFontSize: 20,
        titleFontWeight: FontWeight.w700,
        showBackButton: true,
        centerTitle: false,
      ),
      body: BlocConsumer<ContractorProjectOfferBloc, ContractorProjectOfferState>(
        listenWhen: (previous, current) =>
            previous.submitStatus != current.submitStatus,
        listener: (context, state) {
          if (state.submitStatus == ProjectOfferSubmitStatus.success) {
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
                            title: 'Pilih Rentang Budget',
                            onMinChanged: (value) => context
                                .read<ContractorProjectOfferBloc>()
                                .add(BudgetMinChanged(value)),
                            onMaxChanged: (value) => context
                                .read<ContractorProjectOfferBloc>()
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
                                context.read<ContractorProjectOfferBloc>().add(
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
                                context.read<ContractorProjectOfferBloc>().add(
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
                  child: isLoading
                      ? const MainButton(
                          text: 'Mengirim...',
                          backgroundColor: AppColors.primary, 
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                        )
                      : MainButton(
                          text: 'Kirim Penawaran',
                          icon: Icons.send_rounded,
                          backgroundColor: state.isFormValid
                              ? AppColors.primary
                              : AppColors.primary.withOpacity(0.4),
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                          onPressed: () => _onSubmit(context, state),
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
