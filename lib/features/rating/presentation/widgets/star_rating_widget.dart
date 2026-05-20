import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/screen_size.dart';

class StarRatingWidget extends StatelessWidget {
  final int selectedRating;
  final ValueChanged<int> onStarTapped;

  const StarRatingWidget({
    super.key,
    required this.selectedRating,
    required this.onStarTapped,
  });

  @override
  Widget build(BuildContext context) {
    final double baseStarSize = context.widthPct(0.12).clamp(36.0, 52.0);

    return Row(
      children: List.generate(5, (index) {
        final starNumber = index + 1;
        final isFilled = starNumber <= selectedRating;

        return GestureDetector(
          onTap: () => onStarTapped(starNumber),
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (child, animation) =>
                  ScaleTransition(scale: animation, child: child),
              child: Icon(
                isFilled ? Icons.star_rounded : LucideIcons.star,
                key: ValueKey('$starNumber-$isFilled'),
                size: isFilled ? baseStarSize : baseStarSize * 0.92,
                color: AppColors.primaryOrange,
              ),
            ),
          ),
        );
      }),
    );
  }
}