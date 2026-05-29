import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../../config/injection_container.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/utils/screen_size.dart';
import '../../../../../core/widgets/global_app_bar.dart';
import '../../../../../core/widgets/global_text_field.dart';
import '../../../../../core/widgets/main_button.dart';
import '../bloc/rating_client_bloc.dart';
import '../bloc/rating_client_event.dart';
import '../bloc/rating_client_state.dart';
import '../widgets/star_rating_widget.dart';

class RatingClientPage extends StatelessWidget {
  final String clientId;
  final String clientName;
  final String? clientImageUrl;

  const RatingClientPage({
    super.key,
    required this.clientId,
    required this.clientName,
    this.clientImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RatingClientBloc>()
        ..add(
          LoadRatingClientData(
            clientId: clientId,
            clientName: clientName,
            clientImageUrl: clientImageUrl,
          ),
        ),
      child: const _RatingClientView(),
    );
  }
}

class _RatingClientView extends StatefulWidget {
  const _RatingClientView();

  @override
  State<_RatingClientView> createState() => _RatingClientViewState();
}

class _RatingClientViewState extends State<_RatingClientView> {
  final TextEditingController _descController = TextEditingController();

  @override
  void dispose() {
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RatingClientBloc, RatingClientState>(
      listener: _blocListener,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: const GlobalAppBar(
          title: 'Klien Rating',
          showBackButton: true, // Menambahkan back button
        ),
        body: BlocBuilder<RatingClientBloc, RatingClientState>(
          builder: (context, state) {
            return _buildBody(context, state); // Parameter showlowBody dihapus
          },
        ),
      ),
    );
  }

  // Parameter showlowBody dihapus dari fungsi ini
  Widget _buildBody(BuildContext context, RatingClientState state) {
    final double padH = context.widthPct(0.05).clamp(16.0, 24.0);
    final double padV = context.heightPct(0.025).clamp(16.0, 24.0);

    final double avatarRadius = context.widthPct(0.07).clamp(24.0, 32.0);
    final double nameSize = context.widthPct(0.045).clamp(15.0, 18.0);

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: padH, vertical: padV),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: avatarRadius,
                      backgroundColor: AppColors.primaryLightGrey,
                      backgroundImage: state.clientImageUrl != null
                          ? NetworkImage(state.clientImageUrl!)
                          : null,
                      child: state.clientImageUrl == null
                          ? Icon(
                              Icons.person,
                              color: AppColors.textSecondaryDark,
                              size: avatarRadius,
                            )
                          : null,
                    ),
                    SizedBox(width: context.widthPct(0.035).clamp(12.0, 16.0)),
                    Expanded(
                      child: Text(
                        state.clientName.isNotEmpty ? state.clientName : 'Diyah Ramadhani Putri',
                        style: AppTextStyles.bodyLarge.copyWith(
                          fontSize: nameSize,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: context.heightPct(0.03).clamp(20.0, 28.0)),

                Text(
                  'Rating Client',
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),

                SizedBox(height: context.heightPct(0.015).clamp(10.0, 14.0)),

                StarRatingWidget(
                  selectedRating: state.selectedRating,
                  onStarTapped: (rating) {
                    context.read<RatingClientBloc>().add(
                      RatingStarSelected(rating),
                    );
                  },
                ),

                SizedBox(height: context.heightPct(0.03).clamp(20.0, 28.0)),

                Text(
                  'Deskripsi Tambahan',
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),

                SizedBox(height: context.heightPct(0.012).clamp(8.0, 12.0)),

                GlobalTextField(
                  controller: _descController,
                  hintText: 'Berikan diskripsi dan ulasan tentang client....',
                  maxLines: 5,
                  fillColor: AppColors.primaryLightGrey.withValues(alpha: 0.4),
                  keyboardType: TextInputType.multiline,
                  onChanged: (value) {
                    context.read<RatingClientBloc>().add(
                      RatingDescriptionChanged(value),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(padH, 16.0, padH, padV),
            child: SizedBox(
              width: double.infinity,
              child: state.status == RatingClientStatus.loading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    )
                  : MainButton(
                      text: 'Kirim Rating',
                      icon: LucideIcons.send,
                      borderRadius: 24,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      onPressed: () {
                        context.read<RatingClientBloc>().add(
                          SubmitRatingClientRequested(),
                        );
                      },
                    ),
            ),
          ),
        ),
      ],
    );
  }

  void _blocListener(BuildContext context, RatingClientState state) {
    if (state.status == RatingClientStatus.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Rating berhasil dikirim!'),
          backgroundColor: AppColors.success,
        ),
      );
      context.pop();
    } else if (state.status == RatingClientStatus.failure) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.errorMessage ?? 'Terjadi kesalahan.'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }
}
