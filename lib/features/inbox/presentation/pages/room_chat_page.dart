import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../domain/entities/consultation_room_entity.dart';
import '../bloc/chat_room_bloc.dart';
import '../bloc/chat_room_event.dart';
import '../bloc/chat_room_state.dart';
import '../widgets/chat_bubble_widget.dart';
import '../widgets/chat_date_divider_widget.dart';
import '../widgets/chat_input_bar_widget.dart';

// Current user ID — ganti dengan auth provider yang sebenarnya
const String _kChatCurrentUserId = 'user-client-001';

class RoomChatPage extends StatelessWidget {
  final String roomId;
  final ConsultationRoomEntity? room;

  const RoomChatPage({
    super.key,
    required this.roomId,
    this.room,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ChatRoomBloc>()
        ..add(LoadChatMessagesEvent(
          roomId: roomId,
          currentUserId: _kChatCurrentUserId,
        )),
      child: _RoomChatBody(room: room),
    );
  }
}

class _RoomChatBody extends StatefulWidget {
  final ConsultationRoomEntity? room;
  const _RoomChatBody({this.room});

  @override
  State<_RoomChatBody> createState() => _RoomChatBodyState();
}

class _RoomChatBodyState extends State<_RoomChatBody> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _onSend(BuildContext context) {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;
    _messageController.clear();
    context.read<ChatRoomBloc>().add(SendChatMessageEvent(
          roomId: widget.room?.id ?? '',
          senderId: _kChatCurrentUserId,
          message: text,
        ));
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatRoomBloc, ChatRoomState>(
              listener: (context, state) {
                if (state is ChatRoomLoaded) _scrollToBottom();
              },
              builder: (context, state) {
                if (state is ChatRoomLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  );
                }
                if (state is ChatRoomError) {
                  return Center(
                    child: Text(
                      'Gagal memuat pesan',
                      style: AppTextStyles.bodyMedium
                          .copyWith(color: AppColors.textSecondaryDark),
                    ),
                  );
                }
                if (state is ChatRoomLoaded) {
                  if (state.messages.isEmpty) {
                    return _buildEmptyChatState();
                  }
                  return _buildMessageList(state);
                }
                return const SizedBox();
              },
            ),
          ),
          BlocBuilder<ChatRoomBloc, ChatRoomState>(
            builder: (context, state) {
              return ChatInputBarWidget(
                controller: _messageController,
                onSend: () => _onSend(context),
                isSending:
                    state is ChatRoomLoaded && state.isSending,
              );
            },
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 0,
      leadingWidth: 40,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              size: 20, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
      ),
      title: Column(
        children: [
          Text(
            widget.room?.otherUserName ?? 'Konsultasi',
            style: AppTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          if (widget.room?.projectTitle != null)
            Text(
              widget.room!.projectTitle!,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
        ],
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
              image: widget.room?.otherUserAvatarUrl != null
                  ? DecorationImage(
                      image: NetworkImage(widget.room!.otherUserAvatarUrl!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: widget.room?.otherUserAvatarUrl == null
                ? const Icon(Icons.person, color: Colors.white, size: 20)
                : null,
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(color: AppColors.border, height: 1),
      ),
    );
  }

  Widget _buildMessageList(ChatRoomLoaded state) {
    final messages = state.messages;
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        final isLast = index == messages.length - 1;

        // Show date divider if this is the first message or date changes
        bool showDivider = false;
        String dividerLabel = '';
        if (index == 0) {
          showDivider = true;
          dividerLabel = _buildDateLabel(message.createdAt);
        } else {
          final prev = messages[index - 1];
          if (!_isSameDay(prev.createdAt, message.createdAt)) {
            showDivider = true;
            dividerLabel = _buildDateLabel(message.createdAt);
          }
        }

        return Column(
          children: [
            if (showDivider) ChatDateDividerWidget(label: dividerLabel),
            ChatBubbleWidget(
              message: message,
              currentUserId: _kChatCurrentUserId,
              showTimestamp: isLast || _isLastInSequence(messages, index),
            ),
          ],
        );
      },
    );
  }

  bool _isLastInSequence(List messages, int index) {
    if (index == messages.length - 1) return true;
    return messages[index].senderId != messages[index + 1].senderId;
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  String _buildDateLabel(DateTime date) {
    final now = DateTime.now();
    if (_isSameDay(date, now)) return 'Hari ini · ${DateFormatter.formatDate(date)}';
    final yesterday = now.subtract(const Duration(days: 1));
    if (_isSameDay(date, yesterday)) return 'Kemarin · ${DateFormatter.formatDate(date)}';
    return DateFormatter.formatDate(date);
  }

  Widget _buildEmptyChatState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.waving_hand_rounded,
              size: 48, color: AppColors.primary),
          const SizedBox(height: 12),
          Text(
            'Mulailah percakapan!',
            style: AppTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Kirim pesan pertama Anda untuk memulai konsultasi',
            style: AppTextStyles.bodyMedium
                .copyWith(color: AppColors.textSecondaryDark),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
