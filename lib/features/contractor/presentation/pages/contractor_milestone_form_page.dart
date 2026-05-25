import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../config/injection_container.dart';
import '../../../../core/widgets/filter_bar_widget.dart';
import '../../../../core/widgets/global_app_bar.dart';
import '../../../../core/widgets/main_button.dart';
import '../../../../core/utils/idr_formatter.dart';
import '../../domain/entities/contractor_milestone_entity.dart';
import '../../domain/usecases/contractor_get_system_milestones_usecase.dart';
import '../../domain/usecases/contractor_publikasi_milestone_usecase.dart';
import '../bloc/contractor_milestone_bloc.dart';
import '../bloc/contractor_milestone_event.dart';
import '../bloc/contractor_milestone_state.dart';
import '../widgets/contractor_milestone_empty_state.dart';
import '../widgets/contractor_manual_milestone_card.dart';
import '../widgets/contractor_system_milestone_card.dart';
import '../widgets/contractor_tambah_milestone_button.dart';
import '../widgets/total_alokasi_widget.dart';

class ContractorMilestoneFormPage extends StatelessWidget {
  final double totalNilaiKontrak;

  const ContractorMilestoneFormPage({
    super.key,
    required this.totalNilaiKontrak,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ContractorMilestoneBloc(
        getSystemMilestones: sl<ContractorGetSystemMilestonesUseCase>(),
        publikasiMilestone: sl<ContractorPublikasiMilestoneUseCase>(),
        totalNilaiKontrak: totalNilaiKontrak,
      ),
      child: const _ContractorMilestoneFormView(),
    );
  }
}

class _ContractorMilestoneFormView extends StatelessWidget {
  const _ContractorMilestoneFormView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContractorMilestoneBloc, ContractorMilestoneState>(
      listener: (context, state) {
        if (state is ContractorMilestonePublishSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Milestone berhasil dipublikasikan!'),
              backgroundColor: AppColors.success,
            ),
          );
          Navigator.of(context).pop();
        }
        if (state is ContractorMilestoneError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: GlobalAppBar(
            showBackButton: true,
            title: 'Buat Milestone Project',
          ),
          body: Column(
            children: [
              Expanded(child: _buildBody(context, state)),
              _PublikasiButton(state: state),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, ContractorMilestoneState state) {
    if (state is ContractorMilestoneLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      );
    }
    if (state is ContractorMilestoneLoaded) {
      return _ContractorMilestoneContent(state: state);
    }
    return const SizedBox.shrink();
  }
}

class _ContractorMilestoneContent extends StatelessWidget {
  final ContractorMilestoneLoaded state;

  const _ContractorMilestoneContent({required this.state});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ContractorMilestoneBloc>();
    final isManual = state.inputMode == MilestoneInputMode.manual;
    final isFull = state.totalAlokasi >= 1.0;

    final totalTerpakai = state.totalNilaiKontrak * state.totalAlokasi;
    final sisaDana = state.totalNilaiKontrak - totalTerpakai;

    return SingleChildScrollView(
      physics:
          const ClampingScrollPhysics(), 
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FilterBarWidget<MilestoneInputMode>(
            tabs: MilestoneInputMode.values,
            activeTab: state.inputMode,
            margin: EdgeInsets.zero,
            labelBuilder: (mode) => mode == MilestoneInputMode.dariSistem
                ? 'Dari Sistem'
                : 'Input Manual',
            onTabChanged: (mode) =>
                bloc.add(ContractorMilestoneInputModeChanged(mode)),
          ),
          const SizedBox(height: 16),

          TotalAlokasiWidget(percentage: state.totalAlokasi),
          const SizedBox(height: 12), 
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white, 
              borderRadius: BorderRadius.circular(8), 
              border: Border.all(
                color: Colors.grey.shade300, 
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sisa Dana Keseluruhan:',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600, 
                  ),
                ),
                Text(
                  IdrFormatter.formatFull(sisaDana),
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: sisaDana >= 0
                        ? const Color(
                            0xFF387C2B,
                          ) 
                        : AppColors.error,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          if (state.milestones.isEmpty && isManual)
            const ContractorMilestoneEmptyState()
          else if (isManual)
            _ManualList(state: state)
          else
            _SystemList(state: state),

          const SizedBox(height: 16),

          if (isManual)
            ContractorTambahMilestoneButton(
              isEnabled: !isFull,
              onTap: () {
                bloc.add(ContractorMilestoneAdded());
              },
            ),
        ],
      ),
    );
  }
}

class _SystemList extends StatelessWidget {
  final ContractorMilestoneLoaded state;

  const _SystemList({required this.state});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ContractorMilestoneBloc>();

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: state.milestones.length,
      itemBuilder: (_, i) {
        final m = state.milestones[i];
        final isDisabled = i > 0 && state.milestones[i - 1].deadline == null;

        return ContractorSystemMilestoneCard(
          key: ValueKey(m.id),
          milestone: m,
          isDisabled: isDisabled,
          onDeadlineChanged: (date) => bloc.add(
            ContractorMilestoneSystemDeadlineUpdated(
              milestoneId: m.id,
              deadline: date,
            ),
          ),
        );
      },
    );
  }
}

class _ManualList extends StatelessWidget {
  final ContractorMilestoneLoaded state;

  const _ManualList({required this.state});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ContractorMilestoneBloc>();

    return ReorderableListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      onReorder: (oldIdx, newIdx) => bloc.add(
        ContractorMilestoneReordered(oldIndex: oldIdx, newIndex: newIdx),
      ),
      proxyDecorator: (child, _, animation) => Material(
        color: Colors.transparent,
        elevation: 8,
        shadowColor: Colors.black26,
        child: child,
      ),
      itemCount: state.milestones.length,
      itemBuilder: (_, i) {
        final m = state.milestones[i];
        return ContractorManualMilestoneCard(
          key: ValueKey(m.id),
          milestone: m,
          index: i,
          totalNilaiKontrak: state.totalNilaiKontrak,
          onChanged: (updated) => bloc.add(ContractorMilestoneUpdated(updated)),
          onDelete: () => bloc.add(ContractorMilestoneDeleted(m.id)),
        );
      },
    );
  }
}

class _PublikasiButton extends StatelessWidget {
  final ContractorMilestoneState state;

  const _PublikasiButton({required this.state});

  @override
  Widget build(BuildContext context) {
    final isLoading = state is ContractorMilestonePublishing;
    final canPublish =
        state is ContractorMilestoneLoaded &&
        (state as ContractorMilestoneLoaded).canPublish;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        child: MainButton(
          text: isLoading ? 'Mempublikasikan...' : 'Publikasi Milestone',
          icon: isLoading ? null : Icons.send,
          onPressed: canPublish && !isLoading
              ? () => context.read<ContractorMilestoneBloc>().add(
                  const ContractorMilestonePublished(),
                )
              : null,
          backgroundColor: canPublish && !isLoading
              ? AppColors.primary
              : AppColors.primaryLightGrey,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }
}
