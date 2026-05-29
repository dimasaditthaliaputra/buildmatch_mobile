import '../../../../config/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/screen_size.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/global_header_background.dart';
import '../../../../core/widgets/main_button.dart';
import '../../domain/entities/setting_user_entity.dart';
import '../bloc/setting_bloc.dart';
import '../bloc/setting_event.dart';
import '../bloc/setting_state.dart';
import '../widgets/profile_edit_field_widget.dart';
import '../widgets/setting_profile_header_widget.dart';

class SettingProfilePageProvider extends StatelessWidget {
  final SettingUserEntity? initialUser;

  const SettingProfilePageProvider({super.key, this.initialUser});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingBloc>(
      create: (_) => sl<SettingBloc>()..add(const LoadUserProfileEvent()),
      child: SettingProfilePage(initialUser: initialUser),
    );
  }
}

class SettingProfilePage extends StatefulWidget {
  final SettingUserEntity? initialUser;

  const SettingProfilePage({super.key, this.initialUser});

  @override
  State<SettingProfilePage> createState() => _SettingProfilePageState();
}

class _SettingProfilePageState extends State<SettingProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameCtrl;
  late final TextEditingController _emailCtrl;
  late final TextEditingController _phoneCtrl;
  late final TextEditingController _addressCtrl;

  @override
  void initState() {
    super.initState();
    final u = widget.initialUser;
    _nameCtrl = TextEditingController(text: u?.fullName ?? '');
    _emailCtrl = TextEditingController(text: u?.email ?? '');
    _phoneCtrl = TextEditingController(text: u?.phoneNumber ?? '');
    _addressCtrl = TextEditingController(text: u?.address ?? '');
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _addressCtrl.dispose();
    super.dispose();
  }

  void _syncControllersFromUser(SettingUserEntity user) {
    if (_nameCtrl.text.isEmpty && (user.fullName?.isNotEmpty ?? false)) {
      _nameCtrl.text = user.fullName!;
    }
    if (_emailCtrl.text.isEmpty && user.email.isNotEmpty) {
      _emailCtrl.text = user.email;
    }
    if (_phoneCtrl.text.isEmpty && (user.phoneNumber?.isNotEmpty ?? false)) {
      _phoneCtrl.text = user.phoneNumber!;
    }
    if (_addressCtrl.text.isEmpty && (user.address?.isNotEmpty ?? false)) {
      _addressCtrl.text = user.address!;
    }
  }

  void _save() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    context.read<SettingBloc>().add(
          UpdateUserProfileEvent(
            fullName: _nameCtrl.text.trim(),
            phoneNumber: _phoneCtrl.text.trim(),
            address: _addressCtrl.text.trim(),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingBloc, SettingState>(
      listener: (context, state) {
        if (state is SettingUpdateSuccess) {
          SnackbarUtils.showSuccess('Profil berhasil diperbarui!');
          // Pop back to settings after a short delay so the snackbar is visible.
          Future.delayed(const Duration(milliseconds: 400), () {
            if (context.mounted && context.canPop()) context.pop();
          });
        } else if (state is SettingUpdateError) {
          SnackbarUtils.showError(state.message);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: BlocBuilder<SettingBloc, SettingState>(
          builder: (context, state) {
            SettingUserEntity? user;
            bool isUpdating = false;

            if (state is SettingLoaded) {
              user = state.user;
              _syncControllersFromUser(user);
            } else if (state is SettingUpdateLoading) {
              user = state.user;
              isUpdating = true;
            } else if (state is SettingUpdateSuccess) {
              user = state.user;
            } else if (state is SettingUpdateError) {
              user = state.user;
            }

            // Fallback to the initially passed user
            user ??= widget.initialUser;

            final roleName = user?.roleName ?? 'client';
            final displayName = user?.fullName ?? user?.email ?? '';
            final avatarUrl = user?.avatarUrl;

            return Stack(
              children: [
                _buildOrangeHeader(context, avatarUrl, displayName, roleName),
                SafeArea(
                  child: Column(
                    children: [
                      SizedBox(height: context.heightPct(0.22)),

                      Expanded(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.symmetric(
                            horizontal: context.widthPct(0.05),
                            vertical: 16,
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Section: Informasi Pribadi
                                Text(
                                  'Informasi Pribadi',
                                  style: AppTextStyles.heading3.copyWith(
                                    color: AppColors.primaryOrange,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 16),

                                ProfileEditFieldWidget(
                                  controller: _nameCtrl,
                                  label: 'Nama Lengkap',
                                  leadingIcon: LucideIcons.userRound,
                                  enabled: !isUpdating,
                                  validator: (v) =>
                                      Validators.required(v, 'Nama lengkap'),
                                ),
                                const SizedBox(height: 14),

                                ProfileEditFieldWidget(
                                  controller: _emailCtrl,
                                  label: 'Email',
                                  leadingIcon: LucideIcons.mail,
                                  keyboardType: TextInputType.emailAddress,
                                  // Email is read-only (managed by auth)
                                  enabled: false,
                                  validator: Validators.email,
                                ),
                                const SizedBox(height: 14),

                                ProfileEditFieldWidget(
                                  controller: _phoneCtrl,
                                  label: 'Nomor Telepon',
                                  leadingIcon: LucideIcons.phone,
                                  keyboardType: TextInputType.phone,
                                  enabled: !isUpdating,
                                  validator: Validators.phone,
                                ),
                                const SizedBox(height: 28),

                                // Section: Lokasi
                                Text(
                                  'Lokasi',
                                  style: AppTextStyles.heading3.copyWith(
                                    color: AppColors.primaryOrange,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 16),

                                ProfileEditFieldWidget(
                                  controller: _addressCtrl,
                                  label: 'Alamat',
                                  leadingIcon: LucideIcons.mapPin,
                                  enabled: !isUpdating,
                                  validator: (v) =>
                                      Validators.required(v, 'Alamat'),
                                ),
                                const SizedBox(height: 120),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // ---- Back button (floating over header) ----
                Positioned(
                  top: MediaQuery.of(context).padding.top + 12,
                  left: 16,
                  child: _BackButton(),
                ),

                // ---- Bottom save button ----
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: _SaveButtonBar(
                    isLoading: isUpdating,
                    onPressed: isUpdating ? null : _save,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildOrangeHeader(
    BuildContext context,
    String? avatarUrl,
    String displayName,
    String roleName,
  ) {
    final double avatarRadius = context.widthPct(0.15).clamp(48.0, 72.0);
    final double topPadding = MediaQuery.of(context).padding.top;
    final double backgroundHeight = topPadding + 48 + avatarRadius;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        GlobalHeaderBackground(
          height: backgroundHeight,
          curveHeight: 48,
        ),
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: topPadding + 48, bottom: 24),
          child: SettingProfileHeaderWidget(
            avatarUrl: avatarUrl,
            displayName: displayName,
            roleName: roleName,
          ),
        ),
      ],
    );
  }
}

// ──────────────────────────────────────────────
// Private sub-widgets
// ──────────────────────────────────────────────

class _BackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (context.canPop()) context.pop();
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.25),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(
          Icons.arrow_back_rounded,
          color: Colors.white,
          size: 22,
        ),
      ),
    );
  }
}

class _SaveButtonBar extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onPressed;

  const _SaveButtonBar({required this.isLoading, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        24,
        12,
        24,
        MediaQuery.of(context).padding.bottom + 16,
      ),
      decoration: BoxDecoration(
        color: AppColors.background,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        child: isLoading
            ? const Center(
                child: SizedBox(
                  height: 48,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                      strokeWidth: 2.5,
                    ),
                  ),
                ),
              )
            : MainButton(
                text: 'Simpan Perubahan',
                onPressed: onPressed,
                borderRadius: 32,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
      ),
    );
  }
}
