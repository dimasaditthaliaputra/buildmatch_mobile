import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../config/injection_container.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/screen_size.dart';
import '../../../../core/widgets/global_app_bar.dart';
import '../../../../core/widgets/main_button.dart';
import '../../../../core/widgets/filter_bar_widget.dart';
import '../../../../core/widgets/global_skeleton.dart';

import '../bloc/contractor_add_progres_bloc.dart';
import '../widgets/jenis_pekerjaan_dropdown.dart';
import '../widgets/jenis_pekerjaan_manual_field.dart';
import '../widgets/persentase_dari_sistem_card.dart';
import '../widgets/persentase_manual_card.dart';

class ContractorAddProgresPageWrapper extends StatelessWidget {
  const ContractorAddProgresPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ContractorAddProgresBloc>(),
      child: const ContractorAddProgresPage(),
    );
  }
}

class ContractorAddProgresPage extends StatefulWidget {
  const ContractorAddProgresPage({super.key});

  @override
  State<ContractorAddProgresPage> createState() => _ContractorAddProgresPageState();
}

class _ContractorAddProgresPageState extends State<ContractorAddProgresPage> {
  final TextEditingController _manualController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ContractorAddProgresBloc>().add(const TambahProgresInitialized());
  }

  @override
  void dispose() {
    _manualController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double gapMedium = context.heightPct(0.02).clamp(16.0, 24.0);
    final double gapLarge = context.heightPct(0.03).clamp(24.0, 32.0);
    final double paddingHorizontal = context.widthPct(0.05).clamp(16.0, 24.0);
    final double paddingVertical = context.heightPct(0.025).clamp(20.0, 28.0);

    return BlocListener<ContractorAddProgresBloc, ContractorAddProgresState>(
      listenWhen: (prev, curr) => curr.isSimpanSuccess || curr.errorMessage != null,
      listener: (context, state) {
        if (state.isSimpanSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Progres berhasil disimpan!'),
              backgroundColor: const Color(0xFF4CAF50),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          );
          if (context.canPop()) context.pop();
        }
        
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: Colors.redAccent,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: const GlobalAppBar(
          title: 'Tambah Progres Baru',
          backgroundColor: AppColors.surface,
          showBackButton: true,
          actions: [],
        ),
        body: BlocBuilder<ContractorAddProgresBloc, ContractorAddProgresState>(
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: paddingHorizontal, 
                      vertical: paddingVertical,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTabSelector(context, state),
                        SizedBox(height: gapLarge),

                        state.inputMode == InputMode.dariSistem
                            ? JenisPekerjaanDropdown(
                                key: const ValueKey('dropdown'),
                                items: state.daftarJenisPekerjaan,
                                selectedItem: state.selectedJenisPekerjaan,
                                isLoading: state.isLoadingJenisPekerjaan,
                                onChanged: (val) {
                                  if (val != null) {
                                    context.read<ContractorAddProgresBloc>().add(
                                          TambahProgresJenisPekerjaanDipilih(val),
                                        );
                                  }
                                },
                              )
                            : JenisPekerjaanManualField(
                                key: const ValueKey('manual_field'),
                                controller: _manualController,
                                onChanged: (val) =>
                                    context.read<ContractorAddProgresBloc>().add(
                                          TambahProgresJenisPekerjaanManualChanged(val),
                                        ),
                              ),
                        
                        SizedBox(height: gapMedium),

                        state.inputMode == InputMode.dariSistem
                            ? PersentaseDariSistemCard(
                                key: const ValueKey('sistem_card'),
                                persentase: state.persentaseAktif,
                              )
                            : PersentaseManualCard(
                                key: const ValueKey('manual_card'),
                                persentase: state.persentaseAktif,
                                progresSebelumnya: state.progresSebelumnya,
                                onTambah: () =>
                                    context.read<ContractorAddProgresBloc>().add(
                                          const TambahProgresPersentaseDitambah(),
                                        ),
                                onKurangi: () =>
                                    context.read<ContractorAddProgresBloc>().add(
                                          const TambahProgresPersentaseDikurangi(),
                                        ),
                                onChanged: (nilai) => 
                                    context.read<ContractorAddProgresBloc>().add(
                                          TambahProgresPersentaseDiubah(nilai),
                                        ),
                              ),
                      ],
                    ),
                  ),
                ),
                _SimpanButton(state: state),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildTabSelector(BuildContext context, ContractorAddProgresState state) {
    final tabs = [InputMode.dariSistem, InputMode.manual];
    final labels = {InputMode.dariSistem: 'Dari Sistem', InputMode.manual: 'Input Manual'};

    final double paddingInner = context.widthPct(0.01).clamp(4.0, 8.0);
    final double tabVerticalPadding = context.heightPct(0.012).clamp(8.0, 14.0);
    final double fontSize = context.widthPct(0.033).clamp(11.0, 14.0);
    final double dividerHeight = context.heightPct(0.025).clamp(16.0, 24.0);

    return FilterBarWidget<InputMode>(
      tabs: tabs,
      activeTab: state.inputMode,
      labelBuilder: (tab) => labels[tab] ?? '',
      margin: EdgeInsets.zero,
      padding: EdgeInsets.all(paddingInner),
      tabPadding: EdgeInsets.symmetric(vertical: tabVerticalPadding),
      fontSize: fontSize,
      dividerHeight: dividerHeight,
      onTabChanged: (mode) {
        context.read<ContractorAddProgresBloc>().add(TambahProgresTabChanged(mode));
      },
    );
  }
}

class _SimpanButton extends StatelessWidget {
  final ContractorAddProgresState state;

  const _SimpanButton({required this.state});

  @override
  Widget build(BuildContext context) {
    final double padHorizontal = context.widthPct(0.05).clamp(16.0, 24.0);
    final double padTop = context.heightPct(0.015).clamp(12.0, 16.0);
    final double padBottom = context.heightPct(0.035).clamp(24.0, 32.0);

    return Container(
      padding: EdgeInsets.fromLTRB(padHorizontal, padTop, padHorizontal, padBottom),
      decoration: BoxDecoration(
        color: AppColors.background,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        child: state.isSimpanLoading
            ? GlobalSkeleton(
                child: const MainButton(
                  text: 'Simpan Progres',
                  icon: LucideIcons.send,
                  backgroundColor: AppColors.primary,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                  onPressed: null,
                ),
              )
            : MainButton(
                text: 'Simpan Progres',
                icon: LucideIcons.send,
                backgroundColor: state.canSimpan
                    ? AppColors.primary
                    : AppColors.primary.withOpacity(0.4),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                onPressed: state.canSimpan
                    ? () => context.read<ContractorAddProgresBloc>().add(const TambahProgresDiSimpan())
                    : null,
              ),
      ),
    );
  }
}