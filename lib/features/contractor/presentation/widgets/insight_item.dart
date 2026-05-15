import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/screen_size.dart';

class InsightItem extends StatelessWidget {
  final String value;
  final String label;

  const InsightItem({super.key, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    final double valueFontSize = context.widthPct(0.040).clamp(14.0, 18.0);
    final double labelFontSize = context.widthPct(0.025).clamp(9.0, 11.0);

    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: context.heightPct(0.015),
          horizontal: context.widthPct(0.01),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: GoogleFonts.inter(
                fontSize: valueFontSize,
                fontWeight: FontWeight.w700,
                color: AppColors.textOrangeDark, // Berubah ke textOrangeDark
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: context.heightPct(0.005)),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: labelFontSize,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryDark, // Berubah ke primaryDark
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}