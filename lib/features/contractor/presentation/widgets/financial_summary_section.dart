import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/idr_formatter.dart';
import '../../../../core/utils/screen_size.dart';
import '../../domain/entities/contractor_dashboard_entity.dart';

import '../../../../core/widgets/carousel_dot_indicator.dart';

import '../../../../core/widgets/global_card.dart'; 

class FinancialSummarySection extends StatefulWidget {
  final FinancialSummaryEntity summary;

  const FinancialSummarySection({super.key, required this.summary});

  @override
  State<FinancialSummarySection> createState() => _FinancialSummarySectionState();
}

class _FinancialSummarySectionState extends State<FinancialSummarySection> {
  final PageController _pageController = PageController(viewportFraction: 0.88);
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 125.0,
      child: Stack(
        children: [
          PageView(
            controller: _pageController,
            physics: const BouncingScrollPhysics(),
            onPageChanged: (int index) {
              setState(() {
                _currentPage = index;
              });
            },
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

          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: CarouselDotIndicator(
              itemCount: 3,
              currentIndex: _currentPage,
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
    return GlobalCard(
      margin: EdgeInsets.zero, 
      padding: const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 8),
      backgroundColor: AppColors.surface,
      borderRadius: 16.0,
      boxShadow: [
        BoxShadow(
          color: AppColors.shadowDark.withOpacity(0.06),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
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
                    padding: const EdgeInsets.only(right: 2),
                    child: Icon(Icons.circle, color: widget.themeColor, size: 16),
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
                    size: 20,
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
        ],
      ),
    );
  }
}