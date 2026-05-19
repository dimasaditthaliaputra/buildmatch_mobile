import 'package:buildmatch_mobile/core/utils/screen_size.dart';
import 'package:buildmatch_mobile/core/widgets/global_background.dart';
import 'package:buildmatch_mobile/core/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../bloc/waiting_approval_bloc.dart';
import '../bloc/waiting_approval_event.dart';
import '../bloc/waiting_approval_state.dart';

class VerifikasiPerusahaanPage extends StatefulWidget {
  const VerifikasiPerusahaanPage({super.key});

  @override
  State<VerifikasiPerusahaanPage> createState() =>
      _VerifikasiPerusahaanPageState();
}

class _VerifikasiPerusahaanPageState extends State<VerifikasiPerusahaanPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
    _animationController.forward();

    // Fetch initial status on load
    context.read<WaitingApprovalBloc>().add(GetVerificationStatusEvent());
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double paddingHorizontal = (context.screenWidth * 0.06).clamp(
      16.0,
      32.0,
    );
    final double paddingVertical = (context.screenHeight * 0.025).clamp(
      16.0,
      28.0,
    );

    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthInitial) {
              context.go('/auth');
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GlobalBackground(
          child: SafeArea(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: paddingHorizontal,
                  vertical: paddingVertical,
                ),
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // TOP ROW: Header Badge (Logo Compass / Divider)
                          leftTopLogo(context),

                          const Spacer(),

                          // MAIN CARD / CONTENT BODY
                          const Center(child: WaitingWidget()),

                          const Spacer(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row leftTopLogo(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            // Action trigger: Can be a brief interactive feedback or simple branding info
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('BuildMatch - Modul Kontraktor'),
                duration: Duration(seconds: 1),
              ),
            );
          },
          child: Hero(
            tag: 'top_left_compass_logo',
            child: Logo(
              sizeContainer: context.screenWidth * 0.12,
              sizeLogo: context.screenWidth * 0.06,
            ),
          ),
        ),

        // Subtle logout button in the top right (inside the white space)
        IconButton(
          onPressed: () {
            _showLogoutConfirmationDialog(context);
          },
          icon: const Icon(
            LucideIcons.logOut,
            color: AppColors.primary,
            size: 22,
          ),
          tooltip: 'Logout',
        ),
      ],
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Konfirmasi Keluar',
          style: AppTextStyles.heading3.copyWith(fontWeight: FontWeight.bold),
        ),
        content: Text(
          'Apakah Anda yakin ingin keluar dari akun Anda?',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondaryDark,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              'Batal',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondaryDark,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<AuthBloc>().add(AuthLogoutRequested());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
  }
}

class WaitingWidget extends StatelessWidget {
  const WaitingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final double lottieSize = (context.screenWidth * 0.65).clamp(180.0, 260.0);
    final double titleFontSize = (context.screenWidth * 0.065).clamp(
      20.0,
      26.0,
    );
    final double subtitleFontSize = (context.screenWidth * 0.038).clamp(
      13.0,
      16.0,
    );

    return BlocBuilder<WaitingApprovalBloc, WaitingApprovalState>(
      builder: (context, state) {
        if (state is WaitingApprovalLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        } else if (state is WaitingApprovalLoaded) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated Lottie Pen & Clock Container
              Container(
                width: lottieSize,
                height: lottieSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withValues(alpha: 0.08),
                ),
                padding: const EdgeInsets.all(20),
                child: Lottie.asset(
                  'assets/lottie/waiting.json',
                  fit: BoxFit.contain,
                  repeat: true,
                ),
              ),
              SizedBox(height: (context.screenHeight * 0.04).clamp(16.0, 36.0)),

              // Title
              Text(
                'Menunggu Persetujuan',
                style: AppTextStyles.heading1.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                  fontSize: titleFontSize,
                  letterSpacing: -0.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),

              // Subtitle
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Kontraktor menunggu persetujuan verifikasi',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondaryDark,
                    fontSize: subtitleFontSize,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 16),

              // Detailed remarks from local database source
              if (state.status.remarks != null)
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.04),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    state.status.remarks!,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textMid,
                      fontStyle: FontStyle.italic,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          );
        } else if (state is WaitingApprovalError) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(LucideIcons.info, size: 48, color: AppColors.error),
              const SizedBox(height: 16),
              Text(
                state.message,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.error,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
