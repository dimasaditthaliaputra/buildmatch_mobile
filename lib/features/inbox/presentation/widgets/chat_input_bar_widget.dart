import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/chat_message_entity.dart';

class ChatInputBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final VoidCallback? onAttachmentTap;
  final bool isSending;
  final ChatMessageEntity? replyingTo;
  final ChatMessageEntity? editingMessage;
  final String currentUserId;
  final VoidCallback? onCancelReply;
  final VoidCallback? onCancelEdit;

  const ChatInputBarWidget({
    super.key,
    required this.controller,
    required this.onSend,
    required this.currentUserId,
    this.onAttachmentTap,
    this.isSending = false,
    this.replyingTo,
    this.editingMessage,
    this.onCancelReply,
    this.onCancelEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Reply / Edit preview bar
        if (replyingTo != null) _buildReplyBar(context),
        if (editingMessage != null) _buildEditBar(context),
        // Input row
        Container(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 24),
          decoration: BoxDecoration(
            color: AppColors.surface,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Attachment button
              GestureDetector(
                onTap: onAttachmentTap,
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: AppColors.primaryUltraLightGrey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.attach_file_rounded,
                    color: AppColors.primaryGrey,
                    size: 22,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Text field
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: TextField(
                    controller: controller,
                    textInputAction: TextInputAction.newline,
                    onSubmitted: (_) => onSend(),
                    style: AppTextStyles.bodyMedium
                        .copyWith(color: AppColors.textPrimary),
                    decoration: InputDecoration(
                      hintText: editingMessage != null
                          ? 'Edit pesan...'
                          : 'Tulis pesan..',
                      hintStyle: AppTextStyles.bodyMedium
                          .copyWith(color: AppColors.primaryGrey),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                    maxLines: 5,
                    minLines: 1,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Send button
              GestureDetector(
                onTap: isSending ? null : onSend,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: isSending ? AppColors.primaryLight : AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: isSending
                      ? const Center(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2),
                          ),
                        )
                      : const Icon(
                          Icons.send_rounded,
                          color: AppColors.textLight,
                          size: 20,
                        ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReplyBar(BuildContext context) {
    final isMyReply = replyingTo!.senderId == currentUserId;
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(color: AppColors.border),
          left: BorderSide(color: AppColors.primary, width: 3),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.reply_rounded, color: AppColors.primary, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isMyReply ? 'Kamu' : 'Mitra',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                Text(
                  replyingTo!.message,
                  style: AppTextStyles.bodySmall
                      .copyWith(color: AppColors.textSecondaryDark),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onCancelReply,
            child: const Icon(Icons.close_rounded,
                size: 18, color: AppColors.primaryGrey),
          ),
        ],
      ),
    );
  }

  Widget _buildEditBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(color: AppColors.border),
          left: BorderSide(color: AppColors.primaryMedium, width: 3),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.edit_rounded, color: AppColors.primaryMedium, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Edit Pesan',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.primaryMedium,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                Text(
                  editingMessage!.message,
                  style: AppTextStyles.bodySmall
                      .copyWith(color: AppColors.textSecondaryDark),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onCancelEdit,
            child: const Icon(Icons.close_rounded,
                size: 18, color: AppColors.primaryGrey),
          ),
        ],
      ),
    );
  }
}
