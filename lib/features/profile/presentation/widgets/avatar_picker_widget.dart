import 'dart:io';
import 'package:buildmatch_mobile/core/theme/app_colors.dart';
import 'package:buildmatch_mobile/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class AvatarPickerWidget extends StatelessWidget {
  final String? selectedImagePath;
  final ValueChanged<String?> onImageSelected;

  const AvatarPickerWidget({
    super.key,
    required this.selectedImagePath,
    required this.onImageSelected,
  });

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(
        source: source,
        imageQuality: 80,
      );
      if (image != null) {
        onImageSelected(image.path);
      }
    } catch (e) {
      // Handle picker error gracefully
    }
  }

  void _showImageSourcePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Pilih Foto Profil',
                  style: AppTextStyles.heading3.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Ambil foto baru menggunakan kamera atau pilih foto dari galeri Anda.',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondaryDark,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _SourceOption(
                      icon: LucideIcons.camera,
                      label: 'Kamera',
                      onTap: () {
                        Navigator.pop(context);
                        _pickImage(context, ImageSource.camera);
                      },
                    ),
                    _SourceOption(
                      icon: LucideIcons.image,
                      label: 'Galeri',
                      onTap: () {
                        Navigator.pop(context);
                        _pickImage(context, ImageSource.gallery);
                      },
                    ),
                    if (selectedImagePath != null)
                      _SourceOption(
                        icon: LucideIcons.trash2,
                        label: 'Hapus',
                        iconColor: Colors.redAccent,
                        onTap: () {
                          Navigator.pop(context);
                          onImageSelected(null);
                        },
                      ),
                  ],
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool hasSelection = selectedImagePath != null;

    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          GestureDetector(
            onTap: () => _showImageSourcePicker(context),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: 104,
              height: 104,
              decoration: BoxDecoration(
                color: AppColors.border,
                shape: BoxShape.circle,
                border: Border.all(
                  color: hasSelection ? AppColors.primary : Colors.white,
                  width: 3.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.textSecondaryDark.withValues(alpha: 0.08),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  )
                ],
                image: hasSelection
                    ? DecorationImage(
                        image: FileImage(File(selectedImagePath!)),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: !hasSelection
                  ? const Icon(
                      LucideIcons.user,
                      color: AppColors.primaryGrey,
                      size: 44,
                    )
                  : null,
            ),
          ),
          GestureDetector(
            onTap: () => _showImageSourcePicker(context),
            child: Container(
              width: 34,
              height: 34,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  )
                ],
              ),
              child: const Icon(
                LucideIcons.camera,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SourceOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? iconColor;
  final VoidCallback onTap;

  const _SourceOption({
    required this.icon,
    required this.label,
    this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: (iconColor ?? AppColors.primary).withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor ?? AppColors.primary,
              size: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
