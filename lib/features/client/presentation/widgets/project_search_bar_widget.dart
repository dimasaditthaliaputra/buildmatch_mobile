import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class ProjectSearchBarWidget extends StatefulWidget {
  final ValueChanged<String>? onChanged;

  const ProjectSearchBarWidget({super.key, this.onChanged});

  @override
  State<ProjectSearchBarWidget> createState() => _ProjectSearchBarWidgetState();
}

class _ProjectSearchBarWidgetState extends State<ProjectSearchBarWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowDark.withOpacity(0.06),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              controller: _controller,
              onChanged: widget.onChanged,
              style: AppTextStyles.bodyMedium,
              decoration: InputDecoration(
                hintText: 'Cari proyek...',
                hintStyle: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.primaryGrey,
                ),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: AppColors.primaryGrey,
                  size: 20,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        _FilterButton(),
      ],
    );
  }
}

class _FilterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(
        Icons.tune_rounded,
        color: AppColors.textLight,
        size: 22,
      ),
    );
  }
}
