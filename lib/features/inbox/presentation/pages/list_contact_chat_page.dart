import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/global_app_bar.dart';
import '../bloc/inbox_list_bloc.dart';
import '../bloc/inbox_list_event.dart';
import '../bloc/inbox_list_state.dart';
import '../widgets/inbox_contact_tile_widget.dart';
import '../../domain/entities/consultation_room_entity.dart';

// Current user ID — ganti dengan auth provider yang sebenarnya
const String _kCurrentUserId = 'user-client-001';

class ListContactChatPage extends StatelessWidget {
  const ListContactChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<InboxListBloc>()
        ..add(const LoadInboxRoomsEvent(_kCurrentUserId)),
      child: const _ListContactChatBody(),
    );
  }
}

class _ListContactChatBody extends StatefulWidget {
  const _ListContactChatBody();

  @override
  State<_ListContactChatBody> createState() => _ListContactChatBodyState();
}

class _ListContactChatBodyState extends State<_ListContactChatBody> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            _buildSearchBar(),
            const SizedBox(height: 8),
            Expanded(
              child: BlocBuilder<InboxListBloc, InboxListState>(
                builder: (context, state) {
                  if (state is InboxListLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: AppColors.primary),
                    );
                  }
                  if (state is InboxListError) {
                    return _buildErrorState(context, state.message);
                  }
                  if (state is InboxListLoaded) {
                    final filtered = _searchQuery.isEmpty
                        ? state.rooms
                        : state.rooms
                            .where((r) =>
                                (r.otherUserName ?? '')
                                    .toLowerCase()
                                    .contains(_searchQuery.toLowerCase()) ||
                                (r.projectTitle ?? '')
                                    .toLowerCase()
                                    .contains(_searchQuery.toLowerCase()))
                            .toList();

                    if (filtered.isEmpty) return _buildEmptyState();
                    return _buildRoomList(filtered);
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
      child: Text(
        'Inbox',
        style: AppTextStyles.heading1.copyWith(
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: TextField(
        controller: _searchController,
        onChanged: (val) => setState(() => _searchQuery = val),
        style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary),
        decoration: InputDecoration(
          hintText: 'Cari percakapan..',
          hintStyle: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.primaryGrey,
          ),
          prefixIcon: const Icon(Icons.search, color: AppColors.primaryGrey),
          filled: true,
          fillColor: AppColors.surfacePale,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
          ),
        ),
      ),
    );
  }

  Widget _buildRoomList(List<ConsultationRoomEntity> rooms) {
    return ListView.separated(
      padding: const EdgeInsets.only(top: 4, bottom: 20),
      itemCount: rooms.length,
      separatorBuilder: (_, __) => const Divider(
        height: 1,
        indent: 86,
        color: AppColors.border,
      ),
      itemBuilder: (context, index) {
        final room = rooms[index];
        return InboxContactTileWidget(
          room: room,
          onTap: () {
            context.pushNamed(
              'room-chat',
              pathParameters: {'roomId': room.id},
              extra: room,
            );
          },
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              color: AppColors.primaryUltraLightGrey,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.chat_bubble_outline_rounded,
              size: 40,
              color: AppColors.primaryGrey,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Belum Ada Percakapan',
            style: AppTextStyles.heading3.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Percakapan konsultasi Anda akan muncul di sini',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondaryDark,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.wifi_off_rounded, size: 48, color: AppColors.primaryGrey),
          const SizedBox(height: 16),
          Text(
            'Gagal memuat percakapan',
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () => context
                .read<InboxListBloc>()
                .add(const LoadInboxRoomsEvent(_kCurrentUserId)),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: Text('Coba Lagi',
                style: AppTextStyles.bodyMedium
                    .copyWith(color: AppColors.textLight)),
          ),
        ],
      ),
    );
  }
}
