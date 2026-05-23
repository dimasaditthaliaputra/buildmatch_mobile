import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:buildmatch_mobile/core/theme/app_colors.dart';
import 'package:buildmatch_mobile/core/utils/screen_size.dart';
import 'package:buildmatch_mobile/core/widgets/main_button.dart';
import 'package:buildmatch_mobile/core/widgets/global_card.dart';

class AppCardInfo {
  final String label;
  final String value;

  const AppCardInfo({required this.label, required this.value});
}

class ProjectCard extends StatelessWidget {
  final String? imageUrl; 
  final List<AppCardInfo> infoItems;
  final Widget? child;
  final VoidCallback? onTap;

  const ProjectCard({
    super.key,
    this.imageUrl, 
    required this.infoItems,
    this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GlobalCard(
      onTap: onTap,
      padding: EdgeInsets.zero, 
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (imageUrl != null && imageUrl!.isNotEmpty) 
              _CardImage(imageUrl: imageUrl!),
            _CardContent(
              infoItems: infoItems,
              child: child,
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
    final double imgHeight = context.heightPct(0.18).clamp(140.0, 170.0);
    final double iconSize = context.widthPct(0.1).clamp(32.0, 48.0);

    return SizedBox(
      height: imgHeight,
      width: double.infinity,
      child: Image.asset(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          height: imgHeight,
          color: AppColors.surfaceCream,
          child: Center(
            child: Icon(
              Icons.image_not_supported_outlined,
              size: iconSize,
              color: AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}

class _CardContent extends StatelessWidget {
  final List<AppCardInfo> infoItems;
  final Widget? child;

  const _CardContent({required this.infoItems, this.child});

  @override
  Widget build(BuildContext context) {
    final double padH = context.widthPct(0.035).clamp(14.0, 16.0);
    final double padV = context.heightPct(0.01).clamp(8.0, 12.0);
    final double btnHeight = context.heightPct(0.04).clamp(33.0, 40.0);

    return Padding(
      padding: EdgeInsets.fromLTRB(padH, padV, padH, padV),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (child != null) child!,
          
          if (infoItems.isNotEmpty) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < infoItems.length && i < 2; i++) ...[
                  if (i > 0) SizedBox(width: context.widthPct(0.04)),
                  Expanded(
                    child: _CardInfoBox(
                      label: infoItems[i].label,
                      value: infoItems[i].value,
                    ),
                  ),
                ],
              ],
            ),
            SizedBox(height: context.heightPct(0.015)),
          ],
          SizedBox(
            width: double.infinity,
            height: btnHeight,
            child: MainButton(
              text: 'Lihat Detail',
              borderRadius: 25,
              fontSize: context.widthPct(0.035).clamp(12.0, 14.0),
              fontWeight: FontWeight.w900,
              padding: EdgeInsets.zero,
              onPressed: () {},
            ),
          ),
        ],
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
    final double textFs = context.widthPct(0.028).clamp(10.0, 12.0); 
    final double padH = context.widthPct(0.025).clamp(10.0, 12.0);
    final double padV = context.heightPct(0.005).clamp(4.0, 6.0);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: padH, vertical: padV),
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
              fontSize: textFs, 
              fontWeight: FontWeight.w400, 
              color: AppColors.textMid, 
            ),
          ),
          SizedBox(height: context.heightPct(0.003)),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: textFs, 
              fontWeight: FontWeight.w600, 
              color: AppColors.textDark, 
            ),
          ),
        ],
      ),
    );
  }
}