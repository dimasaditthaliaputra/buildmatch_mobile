import 'package:buildmatch_mobile/core/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/circle_button.dart';
import '../../../../core/widgets/main_button.dart';
import '../../../../config/injection_container.dart';
import '../../domain/entities/onboarding_entity.dart';
import '../bloc/onboarding_bloc.dart';
import '../bloc/onboarding_event.dart';
import '../bloc/onboarding_state.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusManager.instance.primaryFocus?.unfocus();
    });
  }

  void _nextPage(int currentIndex) {
    _pageController.animateToPage(
      currentIndex + 1,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void _skip() {
    context.go('/auth');
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.screenWidth;

    return BlocProvider(
      create: (context) => sl<OnboardingBloc>()..add(LoadOnboardingPages()),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            behavior: HitTestBehavior.opaque,
            child: BlocBuilder<OnboardingBloc, OnboardingState>(
              builder: (context, state) {
              if (state.pages.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              return Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 16,
                        right: 16,
                        bottom: 16,
                      ),
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: state.currentIndex < state.pages.length - 1
                            ? 1.0
                            : 0.0,
                        child: IgnorePointer(
                          ignoring:
                              state.currentIndex == state.pages.length - 1,
                          child: GestureDetector(
                            onTap: _skip,
                            child: Text(
                              'Skip',
                              style: GoogleFonts.inter(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: state.pages.length,
                      onPageChanged: (index) {
                        context.read<OnboardingBloc>().add(PageChanged(index));
                      },
                      itemBuilder: (context, index) {
                        return _buildPage(
                          state.pages[index],
                          index == state.pages.length - 1,
                        );
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 40),
                    child: _buildDotNavigator(
                      state.currentIndex,
                      state.pages.length,
                    ),
                  ),

                  Container(
                    height: 64,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    margin: const EdgeInsets.only(bottom: 24),
                    alignment: Alignment.center,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: state.currentIndex < state.pages.length - 1
                          ? Align(
                              key: const ValueKey('nav_next'),
                              alignment: Alignment.centerRight,
                              child: CircleIconButton(
                                icon: LucideIcons.arrowRight,
                                onPressed: () => _nextPage(state.currentIndex),
                              ),
                            )
                          : MainButton(
                              key: const ValueKey('nav_start'),
                              text: 'Mulai',
                              padding: const EdgeInsets.symmetric(
                                horizontal: 53,
                                vertical: 12,
                              ),
                              borderRadius: 50,
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              onPressed: _skip,
                            ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    ),
  );
  }

  Widget _buildPage(OnboardingEntity data, bool isLastPage) {
    final double imageHeight = MediaQuery.of(context).size.height * 0.45;
    final bool isAnimation =
        data.image.endsWith('.lottie') || data.image.endsWith('.json');
    final screenWidth = context.screenWidth;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          isAnimation
              ? Lottie.asset(
                  data.image,
                  height: imageHeight,
                  fit: BoxFit.contain,
                )
              : Image.asset(
                  data.image,
                  height: imageHeight,
                  fit: BoxFit.contain,
                ),

          Align(
            alignment: isLastPage ? Alignment.center : Alignment.centerLeft,
            child: RichText(
              textAlign: isLastPage ? TextAlign.center : TextAlign.left,
              text: TextSpan(
                style: AppTextStyles.heading1.copyWith(fontSize: 44),
                children: [
                  TextSpan(text: data.title),
                  TextSpan(
                    text: data.titleHighlight,
                    style: AppTextStyles.heading1.copyWith(
                      color: AppColors.primary,
                      fontSize: (screenWidth * 0.1).clamp(32.0, 44.0),
                    ),
                  ),
                  TextSpan(text: data.titleEnd),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          Align(
            alignment: isLastPage ? Alignment.center : Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(
                right: isLastPage ? 0.0 : screenWidth * 0.15,
              ),
              child: Text(
                data.description,
                textAlign: isLastPage ? TextAlign.center : TextAlign.justify,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  height: 1.5,
                ),
              ),
            ),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }

  Widget _buildDotNavigator(int currentIndex, int totalPages) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      height: 8,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(4),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: List.generate(totalPages, (index) {
          bool isActive = index <= currentIndex;
          return Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              color: isActive ? AppColors.primary : Colors.transparent,
              height: 8,
            ),
          );
        }),
      ),
    );
  }
}
