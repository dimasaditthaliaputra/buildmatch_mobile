import 'package:buildmatch_mobile/features/setting/domain/entities/setting_user_entity.dart';
import '../../../../config/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/screen_size.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../core/widgets/global_header_background.dart';
import '../bloc/setting_bloc.dart';
import '../bloc/setting_event.dart';
import '../bloc/setting_state.dart';
import '../widgets/customer_service_banner_widget.dart';
import '../widgets/setting_menu_card_widget.dart';
import '../widgets/setting_profile_header_widget.dart';

class SettingPageProvider extends StatelessWidget {
  const SettingPageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingBloc>(
      create: (_) => sl<SettingBloc>()..add(const LoadUserProfileEvent()),
      child: const SettingPage(),
    );
  }
}

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingBloc, SettingState>(
      listener: (context, state) {
        if (state is SettingUpdateSuccess) {
          SnackbarUtils.showSuccess('Profil berhasil diperbarui.');
          context.read<SettingBloc>().add(const LoadUserProfileEvent());
        } else if (state is SettingUpdateError) {
          SnackbarUtils.showError(state.message);
        } else if (state is SettingError) {
          SnackbarUtils.showError(state.message);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: BlocBuilder<SettingBloc, SettingState>(
          builder: (context, state) {
            if (state is SettingLoading) {
              return const _LoadingView();
            }

            final SettingUserEntity user;
            final bool notifEnabled;
            final String roleName;

            if (state is SettingLoaded) {
              user = state.user;
              notifEnabled = state.notificationEnabled;
              roleName = user.roleName ?? 'client';
            } else if (state is SettingUpdateLoading) {
              user = state.user;
              notifEnabled = true;
              roleName = user.roleName ?? 'client';
            } else if (state is SettingUpdateSuccess) {
              user = state.user;
              notifEnabled = true;
              roleName = user.roleName ?? 'client';
            } else if (state is SettingUpdateError) {
              user = state.user;
              notifEnabled = true;
              roleName = user.roleName ?? 'client';
            } else {
              // SettingError or SettingInitial: Show beautiful default placeholder view
              user = const SettingUserEntity(
                id: 'default-user',
                email: 'tamu@buildmatch.co.id',
                fullName: 'Tamu BuildMatch',
                avatarUrl: null,
                phoneNumber: '-',
                address: '-',
                roleId: 1,
                roleName: 'client',
              );
              notifEnabled = true;
              roleName = 'client';
            }

            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: _SettingHeader(
                    avatarUrl: user.avatarUrl,
                    displayName: user.fullName ?? user.email,
                    roleName: roleName,
                  ),
                ),

                SliverPadding(
                  padding: EdgeInsets.fromLTRB(
                    context.widthPct(0.05),
                    20,
                    context.widthPct(0.05),
                    100,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      // ---- Bantuan & Dukungan ----
                      _SectionLabel(label: 'Bantuan & Dukungan'),
                      const SizedBox(height: 10),
                      CustomerServiceBannerWidget(
                        onTap: () => SnackbarUtils.showInfo(
                          'Fitur Customer Service segera hadir!',
                        ),
                      ),
                      const SizedBox(height: 24),

                      // ---- Profil Saya ----
                      _SectionLabel(label: 'Profil Saya'),
                      const SizedBox(height: 10),
                      SettingMenuCardWidget(children: [
                        SettingMenuItemWidget(
                          icon: LucideIcons.userRoundPen,
                          title: 'Informasi Pribadi',
                          subtitle: 'Nama, email, nomor telepon',
                          trailing: const Icon(
                            Icons.chevron_right_rounded,
                            color: AppColors.textSecondaryDark,
                          ),
                          onTap: () => context.push(
                            '/setting-edit-profile',
                            extra: user,
                          ),
                        ),
                        if (roleName == 'arsitek' ||
                            roleName == 'kontraktor') ...[
                          SettingMenuItemWidget(
                            icon: LucideIcons.folderOpen,
                            title: 'Portofolio',
                            subtitle: 'Deskripsi proyek, foto',
                            trailing: const Icon(
                              Icons.chevron_right_rounded,
                              color: AppColors.textSecondaryDark,
                            ),
                            onTap: () => context.push('/detail-portofolio'),
                          ),
                          SettingMenuItemWidget(
                            icon: LucideIcons.star,
                            title: 'Ulasan & Rating',
                            subtitle: 'Rating dan Ulasan yang diberikan Klien',
                            trailing: const Icon(
                              Icons.chevron_right_rounded,
                              color: AppColors.textSecondaryDark,
                            ),
                            onTap: () => context.push('/ulasan-rating'),
                          ),
                        ],
                      ]),
                      const SizedBox(height: 24),

                      // ---- Pengaturan Aplikasi ----
                      _SectionLabel(label: 'Pengaturan Aplikasi'),
                      const SizedBox(height: 10),
                      SettingMenuCardWidget(children: [
                        SettingMenuItemWidget(
                          icon: LucideIcons.bell,
                          title: 'Notifikasi',
                          subtitle: 'Push, email & SMS',
                          trailing: Switch.adaptive(
                            value: notifEnabled,
                            activeThumbColor: Colors.white,
                            activeTrackColor: AppColors.primaryOrange,
                            onChanged: (val) => context
                                .read<SettingBloc>()
                                .add(ToggleNotificationEvent(isEnabled: val)),
                          ),
                        ),
                        SettingMenuItemWidget(
                          icon: LucideIcons.settings,
                          title: 'Syarat & Ketentuan',
                          subtitle: 'Kebijakan privasi & layanan',
                          trailing: const Icon(
                            Icons.chevron_right_rounded,
                            color: AppColors.textSecondaryDark,
                          ),
                          onTap: () => SnackbarUtils.showInfo(
                            'Fitur Syarat & Ketentuan segera hadir!',
                          ),
                        ),
                      ]),
                      const SizedBox(height: 24),

                      // ---- App Version ----
                      Center(
                        child: Text(
                          'Versi Aplikasi 2.4.1 · Build 241',
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.textSecondaryDark,
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────
// Private sub-widgets
// ──────────────────────────────────────────────

class _SettingHeader extends StatelessWidget {
  final String? avatarUrl;
  final String displayName;
  final String roleName;

  const _SettingHeader({
    required this.avatarUrl,
    required this.displayName,
    required this.roleName,
  });

  @override
  Widget build(BuildContext context) {
    final double avatarRadius = context.widthPct(0.15).clamp(48.0, 72.0);
    final double topPadding = MediaQuery.of(context).padding.top;
    final double backgroundHeight = topPadding + 52 + avatarRadius;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        GlobalHeaderBackground(
          height: backgroundHeight,
          curveHeight: 48,
        ),
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: topPadding + 32, bottom: 24),
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

class _SectionLabel extends StatelessWidget {
  final String label;

  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: AppTextStyles.bodyMedium.copyWith(
        fontWeight: FontWeight.w600,
        color: AppColors.textSecondaryDark,
      ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.primary,
        strokeWidth: 2.5,
      ),
    );
  }
}
