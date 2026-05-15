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
import '../../domain/entities/project_detail_entity.dart';
import '../bloc/project_detail_bloc.dart';
import '../bloc/project_detail_event.dart';
import '../bloc/project_detail_state.dart';

import '../widgets/detail_row.dart';
import '../widgets/insight_item.dart';

class ProjectDetailPage extends StatelessWidget {
  final String projectId;

  const ProjectDetailPage({super.key, required this.projectId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProjectDetailBloc>()..add(LoadProjectDetail(projectId)),
      child: const _ProjectDetailView(),
    );
  }
}

class _ProjectDetailView extends StatelessWidget {
  const _ProjectDetailView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectDetailBloc, ProjectDetailState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Scaffold(
            backgroundColor: AppColors.background,
            body: Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          );
        }

        if (state.project == null) {
          return const Scaffold(
            backgroundColor: AppColors.background,
            body: Center(child: Text('Proyek tidak ditemukan')),
          );
        }

        return _ProjectDetailContent(project: state.project!);
      },
    );
  }
}

class _ProjectDetailContent extends StatelessWidget {
  final ProjectDetailEntity project;

  const _ProjectDetailContent({required this.project});

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
      _StatItem(value: project.buildingArea, label: 'Luas', isHighlight: true),
      _StatItem(value: tinggiStr, label: 'Tinggi', isHighlight: false),
      _StatItem(value: project.startDate, label: 'Mulai', isHighlight: true),
      _StatItem(value: project.endDate, label: 'Selesai', isHighlight: false),
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.widthPct(0.04)),
      child: Row(
        children: stats
            .map((s) => Expanded(child: _buildStatChip(context, s)))
            .toList(),
      ),
    );
  }

  Widget _buildStatChip(BuildContext context, _StatItem stat) {
    final double valueFontSize = context.widthPct(0.035).clamp(12.0, 16.0);
    final double labelFontSize = context.widthPct(0.028).clamp(10.0, 12.0);
    final double chipPadV = context.heightPct(0.015).clamp(10.0, 16.0);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: context.widthPct(0.01)),
      padding: EdgeInsets.symmetric(vertical: chipPadV),
      decoration: BoxDecoration(
        color: stat.isHighlight
            ? AppColors.textOrangeDark
            : AppColors.surfaceCream,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            stat.value,
            style: GoogleFonts.inter(
              fontSize: valueFontSize,
              fontWeight: FontWeight.w700,
              color: stat.isHighlight
                  ? AppColors.textLight
                  : AppColors.textOrangeDark,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: context.heightPct(0.003)),
          Text(
            stat.label,
            style: GoogleFonts.inter(
              fontSize: labelFontSize,
              fontWeight: FontWeight.w500,
              color: stat.isHighlight
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
            text: 'Buat Milestone',
            borderRadius: 20,
            fontSize: btnFontSize,
            padding: EdgeInsets.symmetric(vertical: btnVertPad),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}

class _StatItem {
  final String value;
  final String label;
  final bool isHighlight;

  const _StatItem({
    required this.value,
    required this.label,
    required this.isHighlight,
  });
}