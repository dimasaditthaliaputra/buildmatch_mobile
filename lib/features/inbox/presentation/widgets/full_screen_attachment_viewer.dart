import 'dart:io';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class FullScreenAttachmentViewer extends StatelessWidget {
  final String url;
  final String title;
  final String type; // 'image' or 'video'

  const FullScreenAttachmentViewer({
    super.key,
    required this.url,
    required this.title,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final isNetwork = url.startsWith('http://') || url.startsWith('https://');

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, color: Colors.white, size: 28),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          title,
          style: AppTextStyles.bodyMedium.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: type == 'image'
              ? InteractiveViewer(
                  panEnabled: true,
                  minScale: 0.5,
                  maxScale: 4.0,
                  child: isNetwork
                      ? Image.network(
                          url,
                          fit: BoxFit.contain,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                              ),
                            );
                          },
                          errorBuilder: (_, __, ___) => const Icon(
                            Icons.broken_image_rounded,
                            color: Colors.white54,
                            size: 64,
                          ),
                        )
                      : Image.file(
                          File(url),
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => const Icon(
                            Icons.broken_image_rounded,
                            color: Colors.white54,
                            size: 64,
                          ),
                        ),
                )
              : _buildVideoPlaceholder(),
        ),
      ),
    );
  }

  Widget _buildVideoPlaceholder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white24,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.play_arrow_rounded,
            color: Colors.white,
            size: 48,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Video Player',
          style: AppTextStyles.bodyLarge.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          url.split('/').last,
          style: AppTextStyles.bodySmall.copyWith(
            color: Colors.white60,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
