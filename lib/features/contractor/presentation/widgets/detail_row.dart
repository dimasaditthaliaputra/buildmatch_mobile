import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/screen_size.dart';

class DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const DetailRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final double fontSize = context.widthPct(0.035).clamp(12.0, 14.0);
    final double dotSize = context.widthPct(0.025).clamp(8.0, 12.0);
    
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.heightPct(0.010)),
      child: Row(
        children: [
          Container(
            width: dotSize,
            height: dotSize,
            margin: EdgeInsets.only(right: context.widthPct(0.03)),
            decoration: const BoxDecoration(
              color: AppColors.surfaceCream,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
                color: AppColors.textMid, 
              ),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: fontSize,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark, 
            ),
          ),
        ],
      ),
    );
  }
}