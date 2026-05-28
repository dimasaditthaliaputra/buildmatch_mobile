import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/chat_message_entity.dart';
import 'full_screen_attachment_viewer.dart';

class ChatBubbleWidget extends StatelessWidget {
  final ChatMessageEntity message;
  final String currentUserId;
  final bool showTimestamp;
  final String? senderName; // name of the other person (for reply header)
  final VoidCallback? onReply;
  final VoidCallback? onEdit;

  const ChatBubbleWidget({
    super.key,
    required this.message,
    required this.currentUserId,
    this.showTimestamp = false,
    this.senderName,
    this.onReply,
    this.onEdit,
  });

  bool get _isMe => message.senderId == currentUserId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => _showActionMenu(context),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Row(
          mainAxisAlignment:
              _isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (!_isMe) ...[_buildAvatar(), const SizedBox(width: 8)],
            Flexible(child: _buildBubbleColumn(context)),
            if (_isMe) const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 30,
      height: 30,
      decoration: const BoxDecoration(
        color: AppColors.surfaceCream,
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.person, color: AppColors.primary, size: 16),
    );
  }

  Widget _buildBubbleColumn(BuildContext context) {
    return Column(
      crossAxisAlignment:
          _isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        _buildBubble(context),
        if (showTimestamp) _buildTimestampRow(),
      ],
    );
  }

  Widget _buildBubble(BuildContext context) {
    final bubbleRadius = BorderRadius.only(
      topLeft: const Radius.circular(18),
      topRight: const Radius.circular(18),
      bottomLeft: Radius.circular(_isMe ? 18 : 4),
      bottomRight: Radius.circular(_isMe ? 4 : 18),
    );

    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.72,
      ),
      decoration: BoxDecoration(
        color: _isMe ? AppColors.primary : AppColors.surface,
        borderRadius: bubbleRadius,
        boxShadow: !_isMe
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: ClipRRect(
        borderRadius: bubbleRadius,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Reply preview
            if (message.hasReply) _buildReplyPreview(),
            // Attachment
            if (message.hasAttachment) _buildAttachment(context),
            // Message text
            if (message.message.isNotEmpty)
              Padding(
                padding: EdgeInsets.fromLTRB(
                  14,
                  message.hasReply || message.hasAttachment ? 6 : 10,
                  14,
                  message.isEdited ? 4 : 10,
                ),
                child: Text(
                  message.message,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: _isMe ? AppColors.textLight : AppColors.textPrimary,
                    height: 1.4,
                  ),
                ),
              ),
            // Edited label
            if (message.isEdited)
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 0, 14, 8),
                child: Text(
                  'diedit',
                  style: AppTextStyles.bodySmall.copyWith(
                    fontSize: 10,
                    color: _isMe
                        ? AppColors.textLight.withValues(alpha: 0.95)
                        : AppColors.textSecondaryDark,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildReplyPreview() {
    final isMyReply = message.replyToSenderId == currentUserId;
    return Container(
      margin: const EdgeInsets.fromLTRB(6, 6, 6, 0),
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
      decoration: BoxDecoration(
        color: _isMe
            ? Colors.white.withValues(alpha: 0.18)
            : AppColors.background,
        borderRadius: BorderRadius.circular(10),
        border: Border(
          left: BorderSide(
            color: _isMe ? AppColors.primaryLight : AppColors.primary,
            width: 3,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isMyReply ? 'Anda' : (senderName ?? 'Mitra'),
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textLight,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            message.replyToMessage ?? '',
            style: AppTextStyles.bodySmall.copyWith(
              color: _isMe
                  ? AppColors.textLight.withValues(alpha: 0.75)
                  : AppColors.textSecondaryDark,
              fontSize: 12,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildAttachment(BuildContext context) {
    final type = message.attachmentType ?? '';
    if (type == 'image') {
      final url = message.attachmentUrl;
      final isNetwork = url != null && (url.startsWith('http://') || url.startsWith('https://'));
      return GestureDetector(
        onTap: () {
          if (url != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => FullScreenAttachmentViewer(
                  url: url,
                  title: message.attachmentName ?? 'Gambar',
                  type: 'image',
                ),
              ),
            );
          }
        },
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(18)),
          child: Container(
            height: 180,
            width: double.infinity,
            color: AppColors.surfaceCream,
            child: url != null
                ? (isNetwork
                    ? Image.network(url, fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _attachmentPlaceholder())
                    : Image.file(File(url), fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _attachmentPlaceholder()))
                : _attachmentPlaceholder(),
          ),
        ),
      );
    }
    // Document / generic file
    final isVideo = type == 'video';
    final attachmentWidget = Container(
      margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _isMe
            ? Colors.white.withValues(alpha: 0.15)
            : AppColors.background,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isVideo
                ? Icons.videocam_rounded
                : Icons.insert_drive_file_rounded,
            color: _isMe ? AppColors.textLight : AppColors.primary,
            size: 22,
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              message.attachmentName ?? 'Lampiran',
              style: AppTextStyles.bodySmall.copyWith(
                color: _isMe ? AppColors.textLight : AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );

    if (isVideo) {
      return GestureDetector(
        onTap: () {
          final url = message.attachmentUrl;
          if (url != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => FullScreenAttachmentViewer(
                  url: url,
                  title: message.attachmentName ?? 'Video',
                  type: 'video',
                ),
              ),
            );
          }
        },
        child: attachmentWidget,
      );
    }

    return attachmentWidget;
  }

  Widget _attachmentPlaceholder() {
    return Center(
      child: Icon(Icons.image_rounded, color: AppColors.primaryGrey, size: 48),
    );
  }

  Widget _buildTimestampRow() {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _formatTime(message.createdAt),
            style: AppTextStyles.bodySmall.copyWith(
              fontSize: 11,
              color: AppColors.textSecondaryDark,
            ),
          ),
          if (_isMe && message.isRead) ...[
            const SizedBox(width: 4),
            Text(
              '· Terlihat',
              style: AppTextStyles.bodySmall.copyWith(
                fontSize: 11,
                color: AppColors.textSecondaryDark,
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _showActionMenu(BuildContext context) {
    HapticFeedback.mediumImpact();
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        _isMe ? offset.dx : offset.dx + size.width,
        offset.dy,
        _isMe ? offset.dx + size.width : offset.dx,
        offset.dy + size.height,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      color: AppColors.surface,
      elevation: 8,
      items: [
        _buildMenuItem(
          value: 'reply',
          icon: Icons.reply_rounded,
          label: 'Balas',
          color: AppColors.textPrimary,
        ),
        _buildMenuItem(
          value: 'copy',
          icon: Icons.copy_rounded,
          label: 'Salin',
          color: AppColors.textPrimary,
        ),
        if (_isMe && message.canEdit)
          _buildMenuItem(
            value: 'edit',
            icon: Icons.edit_rounded,
            label: 'Edit',
            color: AppColors.primary,
          ),
      ],
    ).then((value) {
      if (value == null) return;
      switch (value) {
        case 'reply':
          onReply?.call();
          break;
        case 'copy':
          Clipboard.setData(ClipboardData(text: message.message));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Pesan disalin'),
              behavior: SnackBarBehavior.floating,
              backgroundColor: AppColors.textPrimary,
              duration: const Duration(seconds: 2),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          );
          break;
        case 'edit':
          onEdit?.call();
          break;
      }
    });
  }

  PopupMenuItem<String> _buildMenuItem({
    required String value,
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 10),
          Text(label,
              style: AppTextStyles.bodyMedium.copyWith(color: color)),
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final diff = now.difference(time);
    if (diff.inMinutes < 1) return 'Baru saja';
    if (diff.inMinutes < 60) return '${diff.inMinutes} mnt lalu';
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}
