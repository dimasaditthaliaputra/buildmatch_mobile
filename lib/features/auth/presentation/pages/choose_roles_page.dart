import 'package:buildmatch_mobile/core/theme/app_text_styles.dart';
import 'package:buildmatch_mobile/core/utils/screen_size.dart';
import 'package:buildmatch_mobile/core/widgets/global_app_bar.dart';
import 'package:buildmatch_mobile/features/auth/domain/entities/roles_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../bloc/roles_bloc.dart';
import '../bloc/roles_event.dart';
import '../bloc/roles_state.dart';
import '../widgets/roles/role_card_widget.dart';

class ChooseRolesPage extends StatelessWidget {
  const ChooseRolesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RolesBloc>(
      create: (context) => sl<RolesBloc>()..add(GetRolesEvent()),
      child: const ChooseRolesView(),
    );
  }
}

class ChooseRolesView extends StatefulWidget {
  const ChooseRolesView({super.key});

  @override
  State<ChooseRolesView> createState() => _ChooseRolesViewState();
}

class _ChooseRolesViewState extends State<ChooseRolesView> {
  RolesEntity? _selectedRole;
  List<RolesEntity> _cachedRoles = [];

  @override
  Widget build(BuildContext context) {
    final double paddingHorizontal = context.widthPct(0.06).clamp(16.0, 24.0);
    final double appBarTitleFontSize = (context.screenWidth * 0.08).clamp(
      18.0,
      24.0,
    );
    final double titleFontSize = (context.screenWidth * 0.08).clamp(24.0, 32.0);
    final double subtitleFontSize = (context.screenWidth * 0.038).clamp(
      13.0,
      16.0,
    );
    final double buttonHeight = (context.screenHeight * 0.07).clamp(48.0, 56.0);
    final double buttonFontSize = (context.screenWidth * 0.04).clamp(
      14.0,
      17.0,
    );

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: GlobalAppBar(
        title: 'BuildMatch',
        titleFontWeight: FontWeight.w700,
        titleFontSize: appBarTitleFontSize,
        backgroundColor: Colors.transparent,
        titleSpacing: paddingHorizontal,
      ),
      body: BlocConsumer<RolesBloc, RolesState>(
        listener: (context, state) {
          if (state is RolesSubmitSuccess) {
            context.go('/setup-profile', extra: state.chosenRole.rolesName.toLowerCase());
          } else if (state is RolesFailure) {
            SnackbarUtils.showError(state.errorMessage);
          }
        },
        builder: (context, state) {
          // Update cached values based on incoming loaded/submitting states
          if (state is RolesLoaded) {
            _cachedRoles = state.roles;
            _selectedRole = state.selectedRole;
          } else if (state is RolesSubmitting) {
            _cachedRoles = state.roles;
            _selectedRole = state.selectedRole;
          } else if (state is RolesSubmitSuccess) {
            _selectedRole = state.chosenRole;
          }

          // Show loader only if we have no cached data to display
          if (_cachedRoles.isEmpty && (state is RolesLoading || state is RolesInitial)) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            );
          }

          final bool isSubmitting = state is RolesSubmitting;
          final bool isSuccess = state is RolesSubmitSuccess;

          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Scrollable content
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: paddingHorizontal,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: context.heightPct(0.01).clamp(4.0, 8.0),
                        ),
                        Text(
                          'Siapa Anda?',
                          style: AppTextStyles.heading1.copyWith(
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                            letterSpacing: -0.5,
                          ),
                        ),
                        SizedBox(
                          height: context.heightPct(0.015).clamp(8.0, 12.0),
                        ),
                        Text(
                          'Pilih peran Anda untuk menyesuaikan pengalaman proyek Anda.',
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontSize: subtitleFontSize,
                            color: AppColors.textSecondaryDark,
                            height: 1.4,
                          ),
                        ),
                        SizedBox(
                          height: context.heightPct(0.04).clamp(16.0, 32.0),
                        ),

                        // List of cards
                        ..._cachedRoles.map((role) {
                          final bool isSelected = _selectedRole?.id == role.id;
                          return RoleCardWidget(
                            role: role,
                            isSelected: isSelected,
                            onTap: (isSubmitting || isSuccess)
                                ? () {}
                                : () {
                                    context.read<RolesBloc>().add(
                                      SelectRoleEvent(role),
                                    );
                                  },
                          );
                        }),

                        SizedBox(
                          height: context.heightPct(0.03).clamp(12.0, 24.0),
                        ),
                      ],
                    ),
                  ),
                ),

                // Bottom button & notice
                Padding(
                  padding: EdgeInsets.all(paddingHorizontal),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        onPressed: (_selectedRole == null || isSubmitting || isSuccess)
                            ? null
                            : () {
                                context.read<RolesBloc>().add(
                                  SubmitRoleEvent(_selectedRole!),
                                );
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          disabledBackgroundColor: AppColors.primaryGrey
                              .withOpacity(0.3),
                          foregroundColor: Colors.white,
                          disabledForegroundColor: Colors.white70,
                          elevation: _selectedRole == null ? 0 : 4,
                          shadowColor: AppColors.primary.withOpacity(0.4),
                          minimumSize: Size.fromHeight(buttonHeight),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: (isSubmitting || isSuccess)
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                            : Text(
                                'Mulai',
                                style: AppTextStyles.button.copyWith(
                                  fontSize: buttonFontSize,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
