import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
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

// Current user — ganti dengan auth provider yang sebenarnya
const String _kChatCurrentUserId = 'user-client-001';

class RoomChatPage extends StatelessWidget {
  final String roomId;
  final ConsultationRoomEntity? room;

  const RoomChatPage({super.key, required this.roomId, this.room});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ChatRoomBloc>()
        ..add(LoadChatMessagesEvent(
            roomId: roomId, currentUserId: _kChatCurrentUserId)),
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

  void _scrollToBottom({bool animated = true}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        if (animated) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        } else {
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        }
      }
    });
  }

  void _onSend(BuildContext context) {
    final text = _messageController.text.trim();
    final blocState = context.read<ChatRoomBloc>().state;
    if (blocState is! ChatRoomLoaded) return;

    if (text.isEmpty) return;

    if (blocState.editingMessage != null) {
      // Edit mode
      context.read<ChatRoomBloc>().add(EditChatMessageEvent(
            roomId: widget.room?.id ?? '',
            messageId: blocState.editingMessage!.id,
            newMessage: text,
          ));
    } else {
      // Send mode
      context.read<ChatRoomBloc>().add(SendChatMessageEvent(
            roomId: widget.room?.id ?? '',
            senderId: _kChatCurrentUserId,
            message: text,
            replyTo: blocState.replyingTo,
          ));
    }
    _messageController.clear();
    _scrollToBottom();
  }

  void _onReply(ChatRoomLoaded state, chatMsg) {
    context.read<ChatRoomBloc>().add(SetReplyMessageEvent(chatMsg));
  }

  void _onEdit(ChatRoomLoaded state, chatMsg) {
    _messageController.text = chatMsg.message;
    _messageController.selection = TextSelection.fromPosition(
        TextPosition(offset: _messageController.text.length));
    context.read<ChatRoomBloc>().add(SetEditingMessageEvent(chatMsg));
  }

  final ImagePicker _imagePicker = ImagePicker();

  Future<void> _pickFromCamera(BuildContext context) async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );
      if (image != null) {
        if (!context.mounted) return;
        context.read<ChatRoomBloc>().add(SendChatMessageEvent(
              roomId: widget.room?.id ?? '',
              senderId: _kChatCurrentUserId,
              message: '',
              attachmentType: 'image',
              attachmentName: image.name,
              attachmentUrl: image.path,
            ));
        _scrollToBottom();
      }
    } catch (e) {
      debugPrint('Kamera error: $e');
    }
  }

  Future<void> _pickMediaFromStorage(BuildContext context) async {
    try {
      final FilePickerResult? result = await FilePicker.pickFiles(
        type: FileType.media,
        allowMultiple: true,
      );
      if (result != null && result.files.isNotEmpty) {
        if (!context.mounted) return;
        for (final file in result.files) {
          final ext = file.extension?.toLowerCase() ?? '';
          final isImage = ['jpg', 'jpeg', 'png', 'gif', 'webp', 'heic'].contains(ext);
          context.read<ChatRoomBloc>().add(SendChatMessageEvent(
                roomId: widget.room?.id ?? '',
                senderId: _kChatCurrentUserId,
                message: '',
                attachmentType: isImage ? 'image' : 'video',
                attachmentName: file.name,
                attachmentUrl: file.path,
              ));
        }
        _scrollToBottom();
      }
    } catch (e) {
      debugPrint('Penyimpanan media error: $e');
    }
  }

  Future<void> _pickDocumentFromStorage(BuildContext context) async {
    try {
      final FilePickerResult? result = await FilePicker.pickFiles(
        type: FileType.any,
        allowMultiple: true,
      );
      if (result != null && result.files.isNotEmpty) {
        if (!context.mounted) return;
        for (final file in result.files) {
          context.read<ChatRoomBloc>().add(SendChatMessageEvent(
                roomId: widget.room?.id ?? '',
                senderId: _kChatCurrentUserId,
                message: '',
                attachmentType: 'document',
                attachmentName: file.name,
                attachmentUrl: file.path,
              ));
        }
        _scrollToBottom();
      }
    } catch (e) {
      debugPrint('Penyimpanan dokumen error: $e');
    }
  }

  void _showAttachmentSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Lampirkan File',
                style: AppTextStyles.heading3
                    .copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _attachmentOption(
                    Icons.camera_alt_rounded, 'Kamera', AppColors.primary, () {
                  Navigator.pop(context);
                  _pickFromCamera(context);
                }),
                _attachmentOption(
                    Icons.image_rounded, 'Galeri Media', AppColors.primaryBlue, () {
                  Navigator.pop(context);
                  _pickMediaFromStorage(context);
                }),
                _attachmentOption(
                    Icons.insert_drive_file_rounded, 'Dokumen', AppColors.primaryGreen, () {
                  Navigator.pop(context);
                  _pickDocumentFromStorage(context);
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _attachmentOption(
      IconData icon, String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 8),
          Text(label,
              style: AppTextStyles.bodySmall
                  .copyWith(color: AppColors.textPrimary)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(context),
      body: BlocConsumer<ChatRoomBloc, ChatRoomState>(
        listener: (context, state) {
          if (state is ChatRoomLoaded) {
            _scrollToBottom();
            // Fill text field when editing
          }
        },
        builder: (context, state) {
          if (state is ChatRoomLoading) {
            return const Center(
                child: CircularProgressIndicator(color: AppColors.primary));
          }
          if (state is ChatRoomError) {
            return Center(
                child: Text('Gagal memuat pesan',
                    style: AppTextStyles.bodyMedium
                        .copyWith(color: AppColors.textSecondaryDark)));
          }
          if (state is ChatRoomLoaded) {
            return Column(
              children: [
                Expanded(child: _buildMessageList(state)),
                ChatInputBarWidget(
                  controller: _messageController,
                  currentUserId: _kChatCurrentUserId,
                  onSend: () => _onSend(context),
                  onAttachmentTap: () => _showAttachmentSheet(context),
                  isSending: state.isSending,
                  replyingTo: state.replyingTo,
                  editingMessage: state.editingMessage,
                  onCancelReply: () => context
                      .read<ChatRoomBloc>()
                      .add(ClearReplyMessageEvent()),
                  onCancelEdit: () {
                    _messageController.clear();
                    context
                        .read<ChatRoomBloc>()
                        .add(ClearEditingMessageEvent());
                  },
                ),
              ],
            );
          }
          return const SizedBox();
        },
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
                      fit: BoxFit.cover)
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
    if (messages.isEmpty) return _buildEmptyChatState();

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        final isLast = index == messages.length - 1;

        // Date divider logic
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
              senderName: widget.room?.otherUserName,
              onReply: () => _onReply(state, message),
              onEdit: () => _onEdit(state, message),
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

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  String _buildDateLabel(DateTime date) {
    final now = DateTime.now();
    if (_isSameDay(date, now)) return 'Hari ini · ${DateFormatter.formatDate(date)}';
    final yesterday = now.subtract(const Duration(days: 1));
    if (_isSameDay(date, yesterday)) {
      return 'Kemarin · ${DateFormatter.formatDate(date)}';
    }
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
          Text('Mulailah percakapan!',
              style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
          const SizedBox(height: 6),
          Text('Kirim pesan pertama Anda untuk memulai konsultasi',
              style: AppTextStyles.bodyMedium
                  .copyWith(color: AppColors.textSecondaryDark),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
