import 'package:buildmatch_mobile/core/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class AppCardInfo {
  final String label;
  final String value;

  const AppCardInfo({required this.label, required this.value});
}

class AppCard extends StatelessWidget {
  final String imageUrl;
  final String tag;
  final String location;
  final String title;
  final List<AppCardInfo> infoItems;
  final VoidCallback? onTap;
  final Color? tagColor;
  final Color? tagTextColor;

  const AppCard({
    super.key,
    required this.imageUrl,
    required this.tag,
    required this.location,
    required this.title,
    required this.infoItems,
    this.onTap,
    this.tagColor,
    this.tagTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        width: 358,
        height: 350,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _CardImage(imageUrl: imageUrl),
            _CardContent(
              tag: tag,
              location: location,
              title: title,
              infoItems: infoItems,
              tagColor: tagColor,
              tagTextColor: tagTextColor,
            ),
          ],
        ),
      ),
    );
  }
}

class _CardImage extends StatelessWidget {
  final String imageUrl;

  const _CardImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 157,
      width: double.infinity,
      child: Image.asset(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          height: 157,
          color: AppColors.surfaceCream,
          child: const Center(
            child: Icon(
              Icons.image_not_supported_outlined,
              size: 40,
              color: AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}

class _CardContent extends StatelessWidget {
  final String tag;
  final String location;
  final String title;
  final List<AppCardInfo> infoItems;
  final Color? tagColor;
  final Color? tagTextColor;

  const _CardContent({
    required this.tag,
    required this.location,
    required this.title,
    required this.infoItems,
    this.tagColor,
    this.tagTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              _CardTag(label: tag, bgColor: tagColor, textColor: tagTextColor),
              const SizedBox(width: 6),
              const Icon(
                Icons.location_on_outlined,
                size: 18,
                color: AppColors.primary,
              ),
              const SizedBox(width: 2),
              Expanded(
                child: Text(
                  location,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Text(
            title,
            style: AppTextStyles.heading3.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 10),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0; i < infoItems.length && i < 2; i++) ...[
                if (i > 0) const SizedBox(width: 18),
                Expanded(
                  child: _CardInfoBox(
                    label: infoItems[i].label,
                    value: infoItems[i].value,
                  ),
                ),
              ],
            ],
          ),

          const SizedBox(height: 10),

          SizedBox(
            width: double.infinity,
            height: 33,
            child: MainButton(
              text: 'Lihat Detail',
              // onPressed:() => context.push('/project/${project.id}'),
              borderRadius: 25,
              fontSize: 14,
              fontWeight: FontWeight.w900,
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }
}

class _CardTag extends StatelessWidget {
  final String label;
  final Color? bgColor;
  final Color? textColor;

  const _CardTag({required this.label, this.bgColor, this.textColor});

  Color get _defaultBg {
    switch (label.toUpperCase()) {
      case 'KOMERSIAL':
        return const Color(0xFFFFF3E0);
      default:
        return AppColors.surfacePale;
    }
  }

  Color get _defaultText {
    switch (label.toUpperCase()) {
      case 'KOMERSIAL':
        return AppColors.primaryDark;
      default:
        return AppColors.textMid;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bgColor ?? _defaultBg,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: textColor ?? _defaultText,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

class _CardInfoBox extends StatelessWidget {
  final String label;
  final String value;

  const _CardInfoBox({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surfacePale,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.textMid,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textMid,
            ),
          ),
        ],
      ),
    );
  }
}
