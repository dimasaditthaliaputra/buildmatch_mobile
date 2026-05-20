import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_progress_bar.dart';
import '../../../../core/widgets/global_card.dart';
import '../../../../core/utils/screen_size.dart';

class PersentaseManualCard extends StatelessWidget {
  final double persentase;
  final VoidCallback onTambah;
  final VoidCallback onKurangi;
  final ValueChanged<double> onChanged;

  const PersentaseManualCard({
    super.key,
    required this.persentase,
    required this.onTambah,
    required this.onKurangi,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final persen = (persentase * 100).toStringAsFixed(0);
    final double cardPadding = context.widthPct(0.05).clamp(16.0, 24.0);
    final double fontSizeBig = context.widthPct(0.09).clamp(30.0, 42.0);

    return GlobalCard(
      width: double.infinity,
      padding: EdgeInsets.all(cardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'PERSENTASE PEKERJAAN',
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.primary,
              letterSpacing: 0.8,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
          SizedBox(height: context.heightPct(0.01).clamp(6.0, 10.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$persen%',
                style: AppTextStyles.heading2.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w800,
                  fontSize: fontSizeBig,
                ),
              ),
              _PlusMinusControl(
                onTambah: onTambah,
                onKurangi: onKurangi,
                canKurangi: persentase > 0,
                canTambah: persentase < 1,
              ),
            ],
          ),
          SizedBox(height: context.heightPct(0.015).clamp(8.0, 16.0)),
          
          LayoutBuilder(
            builder: (context, constraints) {
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTapDown: (details) => _handleGesture(details.localPosition, constraints.maxWidth),
                onPanUpdate: (details) => _handleGesture(details.localPosition, constraints.maxWidth),
                child: Container(
                  height: context.heightPct(0.04).clamp(30.0, 40.0), 
                  alignment: Alignment.center,
                  child: CustomProgressBar(
                    percent: persentase,
                    height: context.heightPct(0.012).clamp(8.0, 12.0), 
                    backgroundColor: AppColors.primary.withOpacity(0.12), 
                    progressColor: AppColors.primary,
                    borderRadius: 20.0,
                  ),
                ),
              );
            },
          ),
          
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('0%', style: AppTextStyles.labelSmall.copyWith(color: AppColors.textSecondary)),
              Text('50%', style: AppTextStyles.labelSmall.copyWith(color: AppColors.textSecondary)),
              Text('100%', style: AppTextStyles.labelSmall.copyWith(color: AppColors.textSecondary)),
            ],
          ),
        ],
      ),
    );
  }

  void _handleGesture(Offset localPosition, double maxWidth) {
    double newPercent = (localPosition.dx / maxWidth).clamp(0.0, 1.0);
    double snappedPercent = (newPercent * 100).round() / 100;
    onChanged(snappedPercent);
  }
}

class _PlusMinusControl extends StatelessWidget {
  final VoidCallback onTambah;
  final VoidCallback onKurangi;
  final bool canTambah;
  final bool canKurangi;

  const _PlusMinusControl({
    required this.onTambah,
    required this.onKurangi,
    required this.canTambah,
    required this.canKurangi,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _ControlButton(
          icon: Icons.remove,
          onTap: canKurangi ? onKurangi : null,
          isEnabled: canKurangi,
        ),
        const SizedBox(width: 8),
        _ControlButton(
          icon: Icons.add,
          onTap: canTambah ? onTambah : null,
          isEnabled: canTambah,
        ),
      ],
    );
  }
}

class _ControlButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final bool isEnabled;

  const _ControlButton({
    required this.icon,
    required this.onTap,
    required this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    final double buttonSize = context.widthPct(0.09).clamp(32.0, 44.0);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: buttonSize,
        height: buttonSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
          border: Border.all(
            color: isEnabled
                ? AppColors.textPrimary.withOpacity(0.5)
                : AppColors.textPrimary.withOpacity(0.2),
            width: 1.5,
          ),
        ),
        child: Icon(
          icon,
          size: buttonSize * 0.5,
          color: isEnabled
              ? AppColors.textPrimary
              : AppColors.textPrimary.withOpacity(0.3),
        ),
      ),
    );
  }
}