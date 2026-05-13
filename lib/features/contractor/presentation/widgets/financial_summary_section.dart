import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/idr_formatter.dart';
import '../../domain/entities/contractor_dashboard_entity.dart';

class FinancialSummarySection extends StatefulWidget {
  final FinancialSummaryEntity summary;

  const FinancialSummarySection({super.key, required this.summary});

  @override
  State<FinancialSummarySection> createState() => _FinancialSummarySectionState();
}

class _FinancialSummarySectionState extends State<FinancialSummarySection> {
  final PageController _pageController = PageController(viewportFraction: 0.88);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140, 
      child: PageView(
        controller: _pageController,
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: _FinancialSummaryCard(
              title: 'TOTAL PENDAPATAN',
              amount: widget.summary.totalIncome,
              subtitle: widget.summary.period,
              icon: Icons.monetization_on_outlined,
              themeColor: AppColors.primary,
              pageIndex: 0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: _FinancialSummaryCard(
              title: 'SUDAH CAIR',
              amount: widget.summary.disbursed,
              subtitle: '${widget.summary.disbursedTransactions} transaksi bulan ini',
              icon: Icons.check_circle_outline,
              themeColor: AppColors.success,
              pageIndex: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: _FinancialSummaryCard(
              title: 'BELUM CAIR',
              amount: widget.summary.notDisbursed,
              subtitle: '${widget.summary.pendingTransactions} transaksi menunggu',
              icon: Icons.hourglass_bottom_rounded,
              themeColor: AppColors.primaryDark,
              pageIndex: 2,
            ),
          ),
        ],
      ),
    );
  }
}

class _FinancialSummaryCard extends StatefulWidget {
  final String title;
  final double amount;
  final String subtitle;
  final IconData icon;
  final Color themeColor;
  final int pageIndex;

  const _FinancialSummaryCard({
    required this.title,
    required this.amount,
    required this.subtitle,
    required this.icon,
    required this.themeColor,
    required this.pageIndex,
  });

  @override
  State<_FinancialSummaryCard> createState() => _FinancialSummaryCardState();
}

class _FinancialSummaryCardState extends State<_FinancialSummaryCard> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 115,
      padding: const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowDark.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: AppTextStyles.labelSmall.copyWith(
                  color: widget.themeColor,
                  letterSpacing: 0.5,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Icon(
                widget.icon,
                color: widget.themeColor,
                size: 20,
              ),
            ],
          ),
          
          const SizedBox(height: 6),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (_isObscured)
                ...List.generate(
                  6,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: Icon(Icons.circle, color: widget.themeColor, size: 12),
                  ),
                )
              else
                Text(
                  IdrFormatter.formatRupiahShort(widget.amount),
                  style: AppTextStyles.heading2.copyWith(
                    color: widget.themeColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                  ),
                ),
              
              const SizedBox(width: 8),
              
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(
                    _isObscured ? Icons.visibility_outlined : Icons.visibility_off_outlined, 
                    color: AppColors.textPrimary,
                    size: 15,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 4),
          
          Text(
            widget.subtitle,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textMid,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
          
          const Spacer(),

          _buildCarouselDots(widget.pageIndex),
        ],
      ),
    );
  }

  Widget _buildCarouselDots(int currentIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        final isActive = index == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 2.5),
          width: isActive ? 14 : 6,
          height: 6,
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.primary
                : AppColors.border,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}