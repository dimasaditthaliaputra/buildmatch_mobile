import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/global_app_bar.dart';
import '../../../../core/widgets/main_button.dart';
import '../../../../core/widgets/section_header.dart';
import '../bloc/milestone_contractor_bloc.dart';
import '../bloc/milestone_contractor_event.dart';
import '../bloc/milestone_contractor_state.dart';
import '../../domain/entities/milestone_entity.dart';
import '../../domain/entities/progress_entity.dart';
import '../../../contractor/domain/entities/contractor_project_list_entity.dart';
import '../widgets/milestone_document_widget.dart';
import '../widgets/milestone_header_widget.dart';
import '../widgets/milestone_timeline_item_widget.dart';
import '../../../../core/widgets/global_skeleton.dart';

class MilestoneContractorProvider extends StatelessWidget {
  final ContractorProjectListEntity? project;
  const MilestoneContractorProvider({super.key, this.project});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MilestoneContractorBloc>(),
      child: MilestoneContractorPage(project: project),
    );
  }
}

class MilestoneContractorPage extends StatefulWidget {
  final ContractorProjectListEntity? project;
  const MilestoneContractorPage({super.key, this.project});

  @override
  State<MilestoneContractorPage> createState() =>
      _MilestoneContractorPageState();
}

class _MilestoneContractorPageState extends State<MilestoneContractorPage> {
  @override
  void initState() {
    super.initState();
    context.read<MilestoneContractorBloc>().add(
          LoadMilestoneContractorData(projectId: widget.project?.id),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MilestoneContractorBloc, MilestoneContractorState>(
      builder: (context, state) {
        Widget bodyWidget = const SizedBox.shrink();
        Widget? bottomNavWidget;

        if (state is MilestoneContractorLoading) {
          bodyWidget = SingleChildScrollView(
            child: Column(
              children: [
                GlobalSkeleton(
                  child: Container(
                    height: 250,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(32),
                        bottomRight: Radius.circular(32),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GlobalSkeleton.text(width: 150, height: 24),
                          GlobalSkeleton.text(width: 100, height: 16),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: GlobalSkeleton.card(height: 160),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else if (state is MilestoneContractorError) {
          bodyWidget = Center(child: Text('Error: ${state.message}'));
        } else if (state is MilestoneContractorLoaded) {
          var milestones = state.milestones;

          if (widget.project?.status == ProjectStatus.selesai) {
            milestones = milestones.map((m) {
              final updatedProgressList = m.progressList?.map((p) {
                return ProgressEntity(
                  id: p.id,
                  title: p.title,
                  description: p.description,
                  percentage: p.percentage,
                  evidencePhotos: p.evidencePhotos,
                  paymentStatus: 'LUNAS',
                  paymentAmount: p.paymentAmount,
                );
              }).toList();

              return MilestoneEntity(
                id: m.id,
                title: m.title,
                description: m.description,
                status: 'SELESAI',
                isConstruction: m.isConstruction,
                paymentAmount: m.paymentAmount,
                paymentStatus: m.paymentAmount > 0 || m.paymentStatus.isNotEmpty ? 'LUNAS' : m.paymentStatus,
                evidencePhotos: m.evidencePhotos,
                progressList: updatedProgressList,
                completionPercentage: 1.0,
              );
            }).toList();
          }

          if (milestones.isEmpty) {
            bodyWidget = _buildEmptyState(context);
            bottomNavWidget = SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: MainButton(
                  text: 'Buat Milestone',
                  icon: Icons.add_circle_outline,
                  backgroundColor: AppColors.primary,
                  onPressed: () {
                    context.push('/contractor-milestone-form');
                  },
                ),
              ),
            );
          } else {
            // Find currently running milestone
            MilestoneEntity? activeMilestone;
            int activeIndex = -1;
            for (int i = 0; i < milestones.length; i++) {
              if (milestones[i].status == 'MENUNGGU') {
                activeMilestone = milestones[i];
                activeIndex = i;
                break;
              }
            }
            // Fallback 1: First 'BELUM MULAI' milestone
            if (activeMilestone == null) {
              for (int i = 0; i < milestones.length; i++) {
                if (milestones[i].status == 'BELUM MULAI') {
                  activeMilestone = milestones[i];
                  activeIndex = i;
                  break;
                }
              }
            }
            // Fallback 2: Last completed milestone
            if (activeMilestone == null && milestones.isNotEmpty) {
              activeMilestone = milestones.last;
              activeIndex = milestones.length - 1;
            }

            final allCompleted = milestones.isNotEmpty && milestones.every((m) => m.status == 'SELESAI');
            final remainingPhases = allCompleted
                ? 0
                : (activeIndex != -1 ? (milestones.length - activeIndex) : 0);

            bodyWidget = SingleChildScrollView(
              child: Column(
                children: [
                  MilestoneHeaderWidget(
                    activeMilestone: activeMilestone,
                    remainingPhases: remainingPhases,
                    project: widget.project,
                  ),

                  const SizedBox(height: 20),

                  // Timeline Content
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SectionHeader(
                          title: 'Timeline Milestone',
                          actionText: 'Edit Milestone',
                          actionTextColor: AppColors.primary,
                          actionTextStyle: AppTextStyles.bodyMedium.copyWith(
                            fontSize: 14,
                          ),
                          onActionTap: () {},
                        ),
                        const SizedBox(height: 16),

                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: milestones.length,
                          itemBuilder: (context, index) {
                            final milestone = milestones[index];
                            final isLast = index == milestones.length - 1;

                            // Check if line should be gradient (from running/MENUNGGU to not-yet-running/BELUM MULAI)
                            bool showGradientLine = false;
                            if (!isLast) {
                              final nextMilestone = milestones[index + 1];
                              if (milestone.status == 'MENUNGGU' &&
                                  nextMilestone.status == 'BELUM MULAI') {
                                showGradientLine = true;
                              }
                            }

                            return MilestoneTimelineItemWidget(
                              milestone: milestone,
                              isLast: isLast,
                              showGradientLine: showGradientLine,
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Documents Section
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: MilestoneDocumentWidget(),
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            );

            final isFinished = milestones.isNotEmpty && milestones.every((m) => m.status == 'SELESAI');

            bottomNavWidget = SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: MainButton(
                  text: 'Beri Ulasan Untuk Klien',
                  icon: Icons.send_outlined,
                  backgroundColor: isFinished ? AppColors.primary : AppColors.primaryGrey,
                  textColor: isFinished ? Colors.white : AppColors.textLight.withOpacity(0.8),
                  onPressed: isFinished
                      ? () {
                          context.push(
                            '/rating-client',
                            extra: {
                              'clientId': widget.project?.id ?? '',
                              'clientName': widget.project?.clientName ?? '',
                            },
                          );
                        }
                      : () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Selesaikan semua milestone terlebih dahulu untuk memberikan ulasan.',
                              ),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                ),
              ),
            );
          }
        }

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: const GlobalAppBar(
            title: 'Project Management',
            centerTitle: false,
            showBackButton: true,
            backgroundColor: AppColors.surface,
          ),
          body: bodyWidget,
          bottomNavigationBar: bottomNavWidget,
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          MilestoneHeaderWidget(
            activeMilestone: null,
            remainingPhases: 0,
            project: widget.project,
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.surfacePale,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.surfaceCream,
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    Icons.view_timeline_outlined,
                    size: 80,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Belum Ada Milestone',
                  style: AppTextStyles.heading2.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Proyek ini belum memiliki rencana milestone. Silakan buat milestone baru untuk membagi proyek menjadi beberapa fase pengerjaan dan mempermudah pelaporan progres ke klien.',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondaryDark,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    border: Border.all(
                      color: AppColors.primaryLightGrey,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.info_outline,
                        color: AppColors.primary,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Kontraktor wajib membuat milestone di awal proyek sebelum mengajukan klaim pembayaran termin.',
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.textPrimary,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
