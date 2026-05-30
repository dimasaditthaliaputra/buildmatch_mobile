import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../config/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/screen_size.dart';
import '../../../../core/widgets/main_button.dart';
import '../../../../core/widgets/file_row.dart';
import '../../../../core/widgets/global_card.dart';
import '../../../../core/widgets/global_skeleton.dart';
import '../../domain/entities/contractor_project_detail_entity.dart';
import '../../domain/entities/contractor_project_list_entity.dart';
import '../../domain/entities/contractor_project_request_entity.dart';
import '../bloc/contractor_project_detail_bloc.dart';
import '../bloc/contractor_project_detail_event.dart';
import '../bloc/contractor_project_detail_state.dart';

import '../widgets/detail_row.dart';
import '../widgets/insight_item.dart';

class ProjectDetailPage extends StatelessWidget {
  final String projectId;
  final bool isFromRequest;

  const ProjectDetailPage({
    super.key,
    required this.projectId,
    this.isFromRequest = true,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          sl<ContractorProjectDetailBloc>()
            ..add(LoadContractorProjectDetail(projectId)),
      child: _ProjectDetailView(isFromRequest: isFromRequest),
    );
  }
}

class _ProjectDetailView extends StatelessWidget {
  final bool isFromRequest;

  const _ProjectDetailView({required this.isFromRequest});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      ContractorProjectDetailBloc,
      ContractorProjectDetailState
    >(
      builder: (context, state) {
        if (state.isLoading) {
          return const _ProjectDetailSkeleton();
        }

        if (state.project == null) {
          return const Scaffold(
            backgroundColor: AppColors.background,
            body: Center(child: Text('Proyek tidak ditemukan')),
          );
        }

        return _ProjectDetailContent(
          project: state.project!,
          isFromRequest: isFromRequest,
        );
      },
    );
  }
}

class _ProjectDetailSkeleton extends StatelessWidget {
  const _ProjectDetailSkeleton();

  @override
  Widget build(BuildContext context) {
    final double heroHeight = context.heightPct(0.30).clamp(200.0, 320.0);
    final double bottomButtonHeight = context
        .heightPct(0.11)
        .clamp(80.0, 110.0);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          ScrollConfiguration(
            behavior: ScrollConfiguration.of(
              context,
            ).copyWith(overscroll: false),
            child: CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: [
                _buildHeroAppBar(context, heroHeight),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      SizedBox(height: context.heightPct(0.02)),
                      _buildStatsRow(context),
                      SizedBox(height: context.heightPct(0.02)),
                      _buildKonstruksiCard(context),
                      SizedBox(height: context.heightPct(0.02)),
                      _buildBudgetCard(context),
                      SizedBox(height: context.heightPct(0.02)),
                      _buildDeskripsiCard(context),
                      SizedBox(height: context.heightPct(0.02)),
                      _buildFileDesainCard(context),
                      SizedBox(height: context.heightPct(0.02)),
                      _buildInsightPenawaranCard(context),
                      SizedBox(height: context.heightPct(0.02)),
                      _buildClientCard(context),
                      SizedBox(height: bottomButtonHeight),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _buildBottomButton(context),
        ],
      ),
    );
  }

  Widget _buildHeroAppBar(BuildContext context, double heroHeight) {
    final double backBtnSize = context.widthPct(0.10).clamp(36.0, 48.0);

    return SliverAppBar(
      expandedHeight: heroHeight,
      stretch: false,
      pinned: true,
      backgroundColor: AppColors.background,
      surfaceTintColor: Colors.transparent,
      leading: Padding(
        padding: EdgeInsets.only(
          left: context.widthPct(0.03),
          top: 4,
          bottom: 4,
        ),
        child: Container(
          width: backBtnSize,
          height: backBtnSize,
          decoration: BoxDecoration(
            color: AppColors.surface.withValues(alpha: 0.8),
            shape: BoxShape.circle,
          ),
          child: Icon(
            LucideIcons.arrowLeft,
            color: AppColors.textPrimary,
            size: backBtnSize * 0.5,
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            const GlobalSkeleton(
              width: double.infinity,
              height: double.infinity,
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppColors.shadowDark.withValues(alpha: 0.87),
                  ],
                  stops: const [0.5, 1.0],
                ),
              ),
            ),
            Positioned(
              left: context.widthPct(0.04),
              right: context.widthPct(0.04),
              bottom: context.heightPct(0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GlobalSkeleton.text(
                    width: context.widthPct(0.6),
                    height: context.widthPct(0.055).clamp(18.0, 24.0),
                  ),
                  SizedBox(height: context.heightPct(0.01)),
                  Row(
                    children: [
                      Icon(
                        LucideIcons.mapPin,
                        size: context.widthPct(0.04).clamp(14.0, 18.0),
                        color: AppColors.textLight.withValues(alpha: 0.6),
                      ),
                      SizedBox(width: context.widthPct(0.01)),
                      GlobalSkeleton.text(
                        width: context.widthPct(0.3),
                        height: context.widthPct(0.035).clamp(12.0, 14.0),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsRow(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.widthPct(0.04)),
      child: Row(
        children: List.generate(
          4,
          (index) => Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: context.widthPct(0.01)),
              padding: EdgeInsets.symmetric(
                vertical: context.heightPct(0.015).clamp(10.0, 16.0),
              ),
              decoration: BoxDecoration(
                color: AppColors.primaryUltraLightGrey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GlobalSkeleton.text(
                    width: context.widthPct(0.12),
                    height: context.widthPct(0.035).clamp(12.0, 16.0),
                  ),
                  SizedBox(height: context.heightPct(0.006)),
                  GlobalSkeleton.text(
                    width: context.widthPct(0.08),
                    height: context.widthPct(0.028).clamp(10.0, 12.0),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildKonstruksiCard(BuildContext context) {
    final double titleFontSize = context.widthPct(0.045).clamp(16.0, 20.0);

    return GlobalCard(
      margin: EdgeInsets.symmetric(horizontal: context.widthPct(0.05)),
      width: double.infinity,
      backgroundColor: AppColors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GlobalSkeleton.text(
            width: context.widthPct(0.4),
            height: titleFontSize,
          ),
          SizedBox(height: context.heightPct(0.016)),
          ...List.generate(
            5,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GlobalSkeleton.text(
                    width: context.widthPct(0.25),
                    height: 14,
                  ),
                  GlobalSkeleton.text(
                    width: context.widthPct(0.35),
                    height: 14,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBudgetCard(BuildContext context) {
    final double titleFontSize = context.widthPct(0.045).clamp(16.0, 20.0);

    return GlobalCard(
      margin: EdgeInsets.symmetric(horizontal: context.widthPct(0.05)),
      width: double.infinity,
      backgroundColor: AppColors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GlobalSkeleton.text(
            width: context.widthPct(0.5),
            height: titleFontSize,
          ),
          SizedBox(height: context.heightPct(0.016)),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(context.widthPct(0.04)),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(10),
              border: const Border(
                left: BorderSide(color: AppColors.primaryGrey, width: 4),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GlobalSkeleton.text(
                  width: context.widthPct(0.4),
                  height: 12,
                ),
                SizedBox(height: context.heightPct(0.008)),
                GlobalSkeleton.text(
                  width: context.widthPct(0.6),
                  height: 18,
                ),
                SizedBox(height: context.heightPct(0.006)),
                GlobalSkeleton.text(
                  width: context.widthPct(0.3),
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeskripsiCard(BuildContext context) {
    final double titleFontSize = context.widthPct(0.045).clamp(16.0, 20.0);

    return GlobalCard(
      margin: EdgeInsets.symmetric(horizontal: context.widthPct(0.05)),
      width: double.infinity,
      backgroundColor: AppColors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GlobalSkeleton.text(
            width: context.widthPct(0.45),
            height: titleFontSize,
          ),
          SizedBox(height: context.heightPct(0.016)),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(context.widthPct(0.04)),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(10),
              border: const Border(
                left: BorderSide(color: AppColors.primaryGrey, width: 4),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GlobalSkeleton.text(width: double.infinity, height: 14),
                SizedBox(height: 6),
                GlobalSkeleton.text(width: double.infinity, height: 14),
                SizedBox(height: 6),
                GlobalSkeleton.text(width: context.widthPct(0.5), height: 14),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFileDesainCard(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.widthPct(0.05)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GlobalSkeleton.text(
                width: context.widthPct(0.4),
                height: context.widthPct(0.045).clamp(16.0, 20.0),
              ),
              GlobalSkeleton.text(
                width: 80,
                height: 14,
              ),
            ],
          ),
          SizedBox(height: context.heightPct(0.015)),
          ...List.generate(
            2,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primaryUltraLightGrey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        LucideIcons.fileText,
                        color: AppColors.textSecondary.withValues(alpha: 0.5),
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GlobalSkeleton.text(width: 140, height: 14),
                          const SizedBox(height: 4),
                          GlobalSkeleton.text(width: 60, height: 10),
                        ],
                      ),
                    ),
                    Icon(
                      LucideIcons.download,
                      color: AppColors.textSecondary.withValues(alpha: 0.5),
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightPenawaranCard(BuildContext context) {
    return GlobalCard(
      margin: EdgeInsets.symmetric(horizontal: context.widthPct(0.05)),
      width: double.infinity,
      backgroundColor: AppColors.surface,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GlobalSkeleton.text(
                width: context.widthPct(0.42),
                height: context.widthPct(0.045).clamp(16.0, 20.0),
              ),
              Container(
                width: 48,
                height: 20,
                decoration: BoxDecoration(
                  color: AppColors.primaryLightGrey,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ],
          ),
          SizedBox(height: context.heightPct(0.02)),
          Row(
            children: List.generate(
              3,
              (index) => Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    left: index == 0 ? 0 : 4,
                    right: index == 2 ? 0 : 4,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      GlobalSkeleton.text(width: 40, height: 18),
                      const SizedBox(height: 6),
                      GlobalSkeleton.text(width: 60, height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClientCard(BuildContext context) {
    final double avatarSize = context.widthPct(0.14).clamp(48.0, 64.0);

    return GlobalCard(
      margin: EdgeInsets.symmetric(horizontal: context.widthPct(0.05)),
      width: double.infinity,
      backgroundColor: AppColors.surface,
      child: Row(
        children: [
          GlobalSkeleton.avatar(size: avatarSize),
          SizedBox(width: context.widthPct(0.04)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GlobalSkeleton.text(width: 120, height: 16),
                SizedBox(height: context.heightPct(0.008)),
                GlobalSkeleton.text(width: 160, height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButton(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: EdgeInsets.fromLTRB(
          context.widthPct(0.04),
          context.heightPct(0.015),
          context.widthPct(0.04),
          context.heightPct(0.034),
        ),
        decoration: BoxDecoration(
          color: AppColors.background,
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowDark.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: GlobalSkeleton(
          borderRadius: 24,
          child: Container(
            width: double.infinity,
            height: context.heightPct(0.06).clamp(48.0, 56.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProjectDetailContent extends StatelessWidget {
  final ContractorProjectDetailEntity project;
  final bool isFromRequest;

  const _ProjectDetailContent({
    required this.project,
    required this.isFromRequest,
  });

  @override
  Widget build(BuildContext context) {
    final double heroHeight = context.heightPct(0.30).clamp(200.0, 320.0);
    final double bottomButtonHeight = context
        .heightPct(0.11)
        .clamp(80.0, 110.0);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          ScrollConfiguration(
            behavior: ScrollConfiguration.of(
              context,
            ).copyWith(overscroll: false),
            child: CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: [
                _buildHeroAppBar(context, heroHeight),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      SizedBox(height: context.heightPct(0.02)),
                      _buildStatsRow(context),
                      SizedBox(height: context.heightPct(0.02)),
                      _buildKonstruksiCard(context),
                      SizedBox(height: context.heightPct(0.02)),
                      _buildBudgetCard(context),
                      SizedBox(height: context.heightPct(0.02)),
                      _buildDeskripsiCard(context),
                      SizedBox(height: context.heightPct(0.02)),
                      _buildFileDesainCard(context),
                      SizedBox(height: context.heightPct(0.02)),
                      _buildInsightPenawaranCard(context),
                      SizedBox(height: context.heightPct(0.02)),
                      _buildClientCard(context),
                      SizedBox(height: bottomButtonHeight),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _buildBottomButton(context),
        ],
      ),
    );
  }

  Widget _buildHeroAppBar(BuildContext context, double heroHeight) {
    final double backBtnSize = context.widthPct(0.10).clamp(36.0, 48.0);
    final double titleFontSize = context.widthPct(0.055).clamp(18.0, 24.0);
    final double subFontSize = context.widthPct(0.035).clamp(12.0, 14.0);

    return SliverAppBar(
      expandedHeight: heroHeight,
      stretch: false,
      pinned: true,
      backgroundColor: AppColors.background,
      surfaceTintColor: Colors.transparent,
      leading: Padding(
        padding: EdgeInsets.only(
          left: context.widthPct(0.03),
          top: 4,
          bottom: 4,
        ),
        child: GestureDetector(
          onTap: () => context.pop(),
          child: Container(
            width: backBtnSize,
            height: backBtnSize,
            decoration: BoxDecoration(
              color: AppColors.surface.withValues(alpha: 0.8),
              shape: BoxShape.circle,
            ),
            child: Icon(
              LucideIcons.arrowLeft,
              color: AppColors.textPrimary,
              size: backBtnSize * 0.5,
            ),
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              project.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: AppColors.surfaceCream,
                child: Icon(
                  LucideIcons.building2,
                  size: context.widthPct(0.16),
                  color: AppColors.primaryLight,
                ),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppColors.shadowDark.withValues(alpha: 0.87),
                  ],
                  stops: const [0.5, 1.0],
                ),
              ),
            ),
            Positioned(
              left: context.widthPct(0.04),
              right: context.widthPct(0.04),
              bottom: context.heightPct(0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    project.title,
                    style: GoogleFonts.inter(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textLight,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: context.heightPct(0.01)),
                  Row(
                    children: [
                      Icon(
                        LucideIcons.mapPin,
                        size: context.widthPct(0.04).clamp(14.0, 18.0),
                        color: AppColors.textLight,
                      ),
                      SizedBox(width: context.widthPct(0.01)),
                      Text(
                        project.city,
                        style: GoogleFonts.inter(
                          fontSize: subFontSize,
                          color: AppColors.textLight,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsRow(BuildContext context) {
    String tinggiStr = project.buildingHeight;
    if (tinggiStr.contains('(') && tinggiStr.contains(')')) {
      tinggiStr = tinggiStr.split('(').last.replaceAll(')', '').trim();
    }

    final stats = [
      (value: project.buildingArea, label: 'Luas', isHighlight: true),
      (value: tinggiStr, label: 'Tinggi', isHighlight: false),
      (value: project.startDate, label: 'Mulai', isHighlight: true),
      (value: project.endDate, label: 'Selesai', isHighlight: false),
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.widthPct(0.04)),
      child: Row(
        children: stats
            .map(
              (s) => Expanded(
                child: _buildStatChip(
                  context,
                  value: s.value,
                  label: s.label,
                  isHighlight: s.isHighlight,
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildStatChip(
    BuildContext context, {
    required String value,
    required String label,
    required bool isHighlight,
  }) {
    final double valueFontSize = context.widthPct(0.035).clamp(12.0, 16.0);
    final double labelFontSize = context.widthPct(0.028).clamp(10.0, 12.0);
    final double chipPadV = context.heightPct(0.015).clamp(10.0, 16.0);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: context.widthPct(0.01)),
      padding: EdgeInsets.symmetric(vertical: chipPadV),
      decoration: BoxDecoration(
        color: isHighlight ? AppColors.textOrangeDark : AppColors.surfaceCream,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: valueFontSize,
              fontWeight: FontWeight.w700,
              color: isHighlight
                  ? AppColors.textLight
                  : AppColors.textOrangeDark,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: context.heightPct(0.003)),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: labelFontSize,
              fontWeight: FontWeight.w500,
              color: isHighlight
                  ? AppColors.textLight.withValues(alpha: 0.9)
                  : AppColors.textDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKonstruksiCard(BuildContext context) {
    final String shortTitle = project.title.split(' – ').first;
    final double titleFontSize = context.widthPct(0.045).clamp(16.0, 20.0);

    return GlobalCard(
      margin: EdgeInsets.symmetric(horizontal: context.widthPct(0.05)),
      width: double.infinity,
      backgroundColor: AppColors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Detail Konstruksi',
            style: AppTextStyles.heading3.copyWith(
              fontSize: titleFontSize,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: context.heightPct(0.016)),
          DetailRow(label: 'Judul Projek', value: shortTitle),
          DetailRow(label: 'Lokasi Proyek', value: project.city),
          DetailRow(label: 'Luas Bangunan', value: project.buildingArea),
          DetailRow(label: 'Tinggi Bangunan', value: project.buildingHeight),
          DetailRow(label: 'Target Mulai', value: project.startDate),
        ],
      ),
    );
  }

  Widget _buildBudgetCard(BuildContext context) {
    final double titleFontSize = context.widthPct(0.045).clamp(16.0, 20.0);
    final double budgetFontSize = context.widthPct(0.045).clamp(16.0, 20.0);
    final double labelFontSize = context.widthPct(0.030).clamp(11.0, 14.0);

    return GlobalCard(
      margin: EdgeInsets.symmetric(horizontal: context.widthPct(0.05)),
      width: double.infinity,
      backgroundColor: AppColors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Budget Pembangunan',
            style: AppTextStyles.heading3.copyWith(
              fontSize: titleFontSize,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: context.heightPct(0.016)),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(context.widthPct(0.04)),
            decoration: BoxDecoration(
              color: AppColors.surfacePale,
              borderRadius: BorderRadius.circular(10),
              border: const Border(
                left: BorderSide(color: AppColors.textOrangeDark, width: 4),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Estimasi Total Budget',
                  style: GoogleFonts.inter(
                    fontSize: labelFontSize,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textDark,
                  ),
                ),
                SizedBox(height: context.heightPct(0.005)),
                Text(
                  '${project.budgetMin} - ${project.budgetMax}',
                  style: GoogleFonts.inter(
                    fontSize: budgetFontSize,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textOrangeDark,
                  ),
                ),
                SizedBox(height: context.heightPct(0.003)),
                Text(
                  'IDR · Negosiasi terbuka',
                  style: GoogleFonts.inter(
                    fontSize: labelFontSize - 1,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textOrangeDark.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeskripsiCard(BuildContext context) {
    final double titleFontSize = context.widthPct(0.045).clamp(16.0, 20.0);
    final double descFontSize = context.widthPct(0.035).clamp(12.0, 15.0);

    return GlobalCard(
      margin: EdgeInsets.symmetric(horizontal: context.widthPct(0.05)),
      width: double.infinity,
      backgroundColor: AppColors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Deskripsi Tambahan',
            style: AppTextStyles.heading3.copyWith(
              fontSize: titleFontSize,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: context.heightPct(0.016)),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(context.widthPct(0.04)),
            decoration: BoxDecoration(
              color: AppColors.surfacePale,
              borderRadius: BorderRadius.circular(10),
              border: const Border(
                left: BorderSide(color: AppColors.textOrangeDark, width: 4),
              ),
            ),
            child: Text(
              project.description,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textDark,
                height: 1.6,
                fontWeight: FontWeight.w500,
                fontSize: descFontSize,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFileDesainCard(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.widthPct(0.05)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'File Desain Klien',
                style: AppTextStyles.heading3.copyWith(
                  fontSize: context.widthPct(0.045).clamp(16.0, 20.0),
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                'Unduh Semua',
                style: GoogleFonts.inter(
                  fontSize: context.widthPct(0.033).clamp(12.0, 14.0),
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          SizedBox(height: context.heightPct(0.015)),
          ...project.files.map(
            (file) => FileRow(
              fileName: file.name,
              fileType: file.type,
              fileSize: file.size,
              onDownload: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightPenawaranCard(BuildContext context) {
    return GlobalCard(
      margin: EdgeInsets.symmetric(horizontal: context.widthPct(0.05)),
      width: double.infinity,
      backgroundColor: AppColors.surfacePale,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Insight Penawaran',
                style: AppTextStyles.heading3.copyWith(
                  fontSize: context.widthPct(0.045).clamp(16.0, 20.0),
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryDark,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryDark,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Live',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textLight,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: context.heightPct(0.02)),
          Row(
            children: [
              InsightItem(
                value: project.bidCount.toString(),
                label: 'Bid Masuk',
              ),
              SizedBox(width: context.widthPct(0.02)),
              InsightItem(value: project.avgBid, label: 'Rata Bid'),
              SizedBox(width: context.widthPct(0.02)),
              InsightItem(value: project.avgWorkDays, label: 'Rata Pekerjaan'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildClientCard(BuildContext context) {
    final client = project.client;
    final double avatarSize = context.widthPct(0.14).clamp(48.0, 64.0);
    final double nameFontSize = context.widthPct(0.040).clamp(14.0, 18.0);
    final double subFontSize = context.widthPct(0.030).clamp(11.0, 13.0);

    return GlobalCard(
      margin: EdgeInsets.symmetric(horizontal: context.widthPct(0.05)),
      width: double.infinity,
      backgroundColor: AppColors.surface,
      child: Row(
        children: [
          Container(
            width: avatarSize,
            height: avatarSize,
            decoration: const BoxDecoration(
              color: AppColors.textOrangeDark,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: context.widthPct(0.04)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                client.name,
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: nameFontSize,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: context.heightPct(0.005)),
              Row(
                children: [
                  Text(
                    client.isVerified ? 'Klien Terverifikasi ✓' : 'Klien',
                    style: GoogleFonts.inter(
                      fontSize: subFontSize,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    ' · ${client.location}',
                    style: GoogleFonts.inter(
                      fontSize: subFontSize,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButton(BuildContext context) {
    final double btnVertPad = context.heightPct(0.02).clamp(14.0, 20.0);
    final double btnFontSize = context.widthPct(0.045).clamp(16.0, 18.0);

    final String buttonText = isFromRequest
        ? 'Ajukan Penawaran'
        : 'Lihat Milestone';
    final VoidCallback onPressed = () {
      if (isFromRequest) {
        context.push('/contractor-proyek-offer');
      } else {
        context.push('/milestone-contractor');
      }
    };

    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: EdgeInsets.fromLTRB(
          context.widthPct(0.04),
          context.heightPct(0.015),
          context.widthPct(0.04),
          context.heightPct(0.034),
        ),
        decoration: BoxDecoration(
          color: AppColors.background,
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowDark.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SizedBox(
          width: double.infinity,
          child: MainButton(
            text: isFromRequest ? 'Kirim Penawaran' : 'Lihat Milestone',
            borderRadius: 24,
            fontSize: btnFontSize,
            padding: EdgeInsets.symmetric(vertical: btnVertPad),
            onPressed: () {
              if (isFromRequest) {
                context.pushNamed('contractor-proyek-offer');
              } else {
                final projectListEntity = ContractorProjectListEntity(
                  id: project.id,
                  name: project.title,
                  location: project.city,
                  startDate: DateTime.tryParse(project.startDate) ?? DateTime.now(),
                  clientName: project.client.name,
                  status: project.status == ProjectRequestStatus.ongoing
                      ? ProjectStatus.berjalan
                      : ProjectStatus.selesai,
                );
                context.pushNamed(
                  'milestone-contractor',
                  extra: projectListEntity,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
