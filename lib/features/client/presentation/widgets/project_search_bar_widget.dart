import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/screen_size.dart';
import '../../../../core/widgets/search_bar_widget.dart';

class ProjectSearchBarWidget extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final VoidCallback? onFilterTap;

  const ProjectSearchBarWidget({super.key, this.onChanged, this.onFilterTap});

  @override
  State<ProjectSearchBarWidget> createState() => _ProjectSearchBarWidgetState();
}

class _ProjectSearchBarWidgetState extends State<ProjectSearchBarWidget> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SearchBarWidget(
      controller: _searchController,
      hintText: 'Cari proyek...',
      onChanged: widget.onChanged,
      fillColor: AppColors.surface,
      borderRadius: 12.0,
      borderSide: const BorderSide(
        color: AppColors.surfaceBeige,
        width: 1.0,
      ),
      contentPadding: EdgeInsets.symmetric(
        vertical: context.heightPct(0.015).clamp(14.0, 18.0),
        horizontal: 16.0,
      ),
      showFilter: true,
      onFilterTap: widget.onFilterTap,
    );
  }
}
