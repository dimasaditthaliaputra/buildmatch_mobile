import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/icon_widget.dart';
import '../../../../core/widgets/global_card.dart';
import '../../../../core/widgets/section_header.dart';

import '../../data/datasources/milestone_document_local_data_source.dart';

class MilestoneDocumentWidget extends StatefulWidget {
  const MilestoneDocumentWidget({super.key});

  @override
  State<MilestoneDocumentWidget> createState() => _MilestoneDocumentWidgetState();
}

class _MilestoneDocumentWidgetState extends State<MilestoneDocumentWidget> {
  final MilestoneDocumentLocalDataSource _dataSource = MilestoneDocumentLocalDataSourceImpl();
  List<Map<String, dynamic>> _documents = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDocuments();
  }

  Future<void> _loadDocuments() async {
    try {
      final docs = await _dataSource.getDocuments();
      if (mounted) {
        setState(() {
          _documents = docs.take(2).toList();
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'Dokumen',
          actionText: 'Lihat Semua',
          actionTextColor: AppColors.primary,
          actionTextStyle: AppTextStyles.bodyMedium,
          onActionTap: () {
            context.push('/milestone-document');
          },
        ),
        const SizedBox(height: 16),
        if (_isLoading)
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            ),
          )
        else if (_documents.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: Text(
                'Tidak ada dokumen',
                style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
              ),
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _documents.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final doc = _documents[index];
              return _buildDocumentItem(
                doc['title'] as String,
                doc['subtitle'] as String,
                doc['icon'] as IconData,
              );
            },
          ),
      ],
    );
  }

  Widget _buildDocumentItem(String title, String subtitle, IconData icon) {
    return GlobalCard(
      width: null,
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      backgroundColor: AppColors.surface,
      borderRadius: 16.0,
      borderColor: AppColors.primaryLightGrey,
      borderWidth: 1,
      boxShadow: const [],
      child: Row(
        children: [
          IconWidget(
            icon: icon,
            backgroundColor: AppColors.primaryLightGrey.withValues(alpha: 0.5),
            iconColor: AppColors.primaryBlue,
            size: 36,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  subtitle,
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: const Icon(LucideIcons.download, color: AppColors.textPrimary, size: 24),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Mengunduh $title...'),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: AppColors.success,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
