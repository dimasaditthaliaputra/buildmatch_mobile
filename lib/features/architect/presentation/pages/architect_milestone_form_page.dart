import 'package:buildmatch_mobile/features/architect/presentation/widgets/project/architect_manual_milestone_card.dart';
import 'package:buildmatch_mobile/features/architect/presentation/widgets/project/architect_milestone_empty_state.dart';
import 'package:buildmatch_mobile/features/architect/presentation/widgets/project/architect_system_milestone_card.dart';
import 'package:buildmatch_mobile/features/architect/presentation/widgets/project/architect_tambah_milestone_button.dart';
import 'package:buildmatch_mobile/features/architect/presentation/widgets/project/total_alokasi_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../config/injection_container.dart';
import '../../../../core/widgets/filter_bar_widget.dart';
import '../../../../core/widgets/global_app_bar.dart';
import '../../../../core/widgets/main_button.dart';
import '../../../../core/utils/idr_formatter.dart';
import '../../domain/entities/architect_milestone_entity.dart';
import '../../domain/usecases/get_architect_system_milestones_usecase.dart';
import '../../domain/usecases/get_architect_publikasi_milestone_usecase.dart';
import '../bloc/architect_milestone_bloc.dart';
import '../bloc/architect_milestone_event.dart';
import '../bloc/architect_milestone_state.dart';


class ArchitectMilestoneFormPage extends StatelessWidget {
  final double totalNilaiKontrak;

  const ArchitectMilestoneFormPage({
    super.key,
    required this.totalNilaiKontrak,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ArchitectMilestoneBloc(
        getSystemMilestones: sl<ArchitectGetSystemMilestonesUseCase>(),
        publikasiMilestone: sl<ArchitectPublikasiMilestoneUseCase>(),
        totalNilaiKontrak: totalNilaiKontrak,
      ),
      child: const _ArchitectMilestoneFormView(),
    );
  }
}

class _ArchitectMilestoneFormView extends StatelessWidget {
  const _ArchitectMilestoneFormView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ArchitectMilestoneBloc, ArchitectMilestoneState>(
      listener: (context, state) {
        if (state is ArchitectMilestonePublishSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Milestone berhasil dipublikasikan!'),
              backgroundColor: AppColors.success,
            ),
          );
          Navigator.of(context).pop();
        }
        if (state is ArchitectMilestoneError) {
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

  Widget _buildBody(BuildContext context, ArchitectMilestoneState state) {
    if (state is ArchitectMilestoneLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      );
    }
    if (state is ArchitectMilestoneLoaded) {
      return _ArchitectMilestoneContent(state: state);
    }
    return const SizedBox.shrink();
  }
}

class _ArchitectMilestoneContent extends StatelessWidget {
  final ArchitectMilestoneLoaded state;

  const _ArchitectMilestoneContent({required this.state});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ArchitectMilestoneBloc>();
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
                bloc.add(ArchitectMilestoneInputModeChanged(mode)),
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
            const ArchitectMilestoneEmptyState()
          else if (isManual)
            _ManualList(state: state)
          else
            _SystemList(state: state),

          const SizedBox(height: 16),

          if (isManual)
            ArchitectTambahMilestoneButton(
              isEnabled: !isFull,
              onTap: () {
                bloc.add(ArchitectMilestoneAdded());
              },
            ),
        ],
      ),
    );
  }
}

class _SystemList extends StatelessWidget {
  final ArchitectMilestoneLoaded state;

  const _SystemList({required this.state});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ArchitectMilestoneBloc>();

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: state.milestones.length,
      itemBuilder: (_, i) {
        final m = state.milestones[i];
        final isDisabled = i > 0 && state.milestones[i - 1].deadline == null;

        return ArchitectSystemMilestoneCard(
          key: ValueKey(m.id),
          milestone: m,
          isDisabled: isDisabled,
          onDeadlineChanged: (date) => bloc.add(
            ArchitectMilestoneSystemDeadlineUpdated(
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
  final ArchitectMilestoneLoaded state;

  const _ManualList({required this.state});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ArchitectMilestoneBloc>();

    return ReorderableListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      onReorder: (oldIdx, newIdx) => bloc.add(
        ArchitectMilestoneReordered(oldIndex: oldIdx, newIndex: newIdx),
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
        return ArchitectManualMilestoneCard(
          key: ValueKey(m.id),
          milestone: m,
          index: i,
          totalNilaiKontrak: state.totalNilaiKontrak,
          onChanged: (updated) => bloc.add(ArchitectMilestoneUpdated(updated)),
          onDelete: () => bloc.add(ArchitectMilestoneDeleted(m.id)),
        );
      },
    );
  }
}

class _PublikasiButton extends StatelessWidget {
  final ArchitectMilestoneState state;

  const _PublikasiButton({required this.state});

  @override
  Widget build(BuildContext context) {
    final isLoading = state is ArchitectMilestonePublishing;
    final canPublish =
        state is ArchitectMilestoneLoaded &&
        (state as ArchitectMilestoneLoaded).canPublish;

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
              ? () => context.read<ArchitectMilestoneBloc>().add(
                  const ArchitectMilestonePublished(),
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
