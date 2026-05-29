import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/global_app_bar.dart';
import '../../../../core/widgets/icon_widget.dart';
import '../../../../core/widgets/global_card.dart';
import '../../data/datasources/milestone_document_local_data_source.dart';

class MilestoneDocumentPage extends StatefulWidget {
  const MilestoneDocumentPage({super.key});

  @override
  State<MilestoneDocumentPage> createState() => _MilestoneDocumentPageState();
}

class _MilestoneDocumentPageState extends State<MilestoneDocumentPage> {
  final TextEditingController _searchController = TextEditingController();
  final MilestoneDocumentLocalDataSource _dataSource = MilestoneDocumentLocalDataSourceImpl();

  List<Map<String, dynamic>> _allDocuments = [];
  bool _isLoading = true;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadDocuments();
  }

  Future<void> _loadDocuments() async {
    try {
      final docs = await _dataSource.getDocuments();
      setState(() {
        _allDocuments = docs;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredDocuments = _allDocuments.where((doc) {
      final titleMatch = doc['title'].toString().toLowerCase().contains(_searchQuery.toLowerCase());
      final categoryMatch = doc['category'].toString().toLowerCase().contains(_searchQuery.toLowerCase());
      return titleMatch || categoryMatch;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const GlobalAppBar(
        title: 'Dokumen Proyek',
        showBackButton: true,
        backgroundColor: AppColors.surface,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            )
          : Column(
              children: [
                // Search Section
                Container(
                  color: AppColors.surface,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Cari dokumen...',
                      prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear, color: AppColors.textSecondary),
                              onPressed: () {
                                _searchController.clear();
                                setState(() {
                                  _searchQuery = '';
                                });
                              },
                            )
                          : null,
                      filled: true,
                      fillColor: AppColors.primaryLightGrey.withValues(alpha: 0.4),
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                // Documents List
                Expanded(
                  child: filteredDocuments.isEmpty
                      ? _buildEmptyState()
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                          itemCount: filteredDocuments.length,
                          itemBuilder: (context, index) {
                            final doc = filteredDocuments[index];
                            return _buildDocumentCard(doc);
                          },
                        ),
                ),
              ],
            ),
    );
  }

  Widget _buildDocumentCard(Map<String, dynamic> doc) {
    return GlobalCard(
      width: null,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      backgroundColor: AppColors.surface,
      borderRadius: 16.0,
      borderColor: AppColors.primaryLightGrey,
      borderWidth: 1,
      boxShadow: const [],
      child: Row(
        children: [
          IconWidget(
            icon: doc['icon'] as IconData,
            backgroundColor: AppColors.primaryLightGrey.withValues(alpha: 0.5),
            iconColor: AppColors.primaryBlue,
            size: 40,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    doc['category'] as String,
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.primary,
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  doc['title'] as String,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${doc['subtitle']} • Diunggah ${doc['date']}',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondaryDark,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(LucideIcons.download, color: AppColors.primaryBlack, size: 24),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Mengunduh ${doc['title']}...'),
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.folder_open_outlined,
            size: 64,
            color: AppColors.textLight.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'Dokumen Tidak Ditemukan',
            style: AppTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondaryDark,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Coba masukkan kata kunci pencarian yang lain.',
            style: AppTextStyles.caption,
          ),
        ],
      ),
    );
  }
}
