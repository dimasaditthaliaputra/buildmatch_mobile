import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import '../../../contractor/domain/entities/contractor_project_list_entity.dart';
import '../widgets/milestone_document_widget.dart';
import '../widgets/milestone_header_widget.dart';
import '../widgets/milestone_timeline_item_widget.dart';

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
    context.read<MilestoneContractorBloc>().add(LoadMilestoneContractorData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const GlobalAppBar(
        title: 'Project Management',
        centerTitle: false,
        showBackButton: true,
        backgroundColor: AppColors.surface,
      ),
      body: BlocBuilder<MilestoneContractorBloc, MilestoneContractorState>(
        builder: (context, state) {
          if (state is MilestoneContractorLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MilestoneContractorError) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is MilestoneContractorLoaded) {
            final milestones = state.milestones;

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

            final remainingPhases = activeIndex != -1
                ? (milestones.length - activeIndex)
                : 0;

            return SingleChildScrollView(
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
          }
          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: MainButton(
            text: 'Beri Ulasan Untuk Klien',
            icon: Icons.send_outlined,
            onPressed: () {
              // Action when review button is clicked
            },
          ),
        ),
      ),
    );
  }
}
