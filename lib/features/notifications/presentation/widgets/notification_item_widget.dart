import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../domain/entities/notification_entity.dart';

class NotificationItemWidget extends StatelessWidget {
  final NotificationEntity notification;

  const NotificationItemWidget({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildIcon(),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        notification.title,
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      DateFormatter.timeAgo(notification.createdAt),
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                _buildMessageText(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    Color bgColor;
    Widget iconWidget;

    switch (notification.category) {
      case 'project_approval':
        bgColor = AppColors.surfaceCream;
        iconWidget = const Icon(Icons.work_outline, color: AppColors.primary, size: 20);
        break;
      case 'payment_status':
      case 'escrow_payout':
        bgColor = AppColors.successBackground;
        iconWidget = const Icon(Icons.payments_outlined, color: AppColors.success, size: 20);
        break;
      case 'milestone_update':
        bgColor = AppColors.clientBg;
        iconWidget = const Icon(Icons.insert_drive_file_outlined, color: AppColors.textMid, size: 20);
        break;
      case 'system_alert':
        bgColor = AppColors.error.withOpacity(0.1);
        iconWidget = const Icon(Icons.warning_amber_rounded, color: AppColors.error, size: 20);
        break;
      case 'chat':
        bgColor = AppColors.primaryUltraLightGrey;
        if (notification.avatarUrl != null) {
          iconWidget = CircleAvatar(
            radius: 10,
            backgroundImage: NetworkImage(notification.avatarUrl!),
          );
        } else {
          iconWidget = const Icon(Icons.person_outline, color: AppColors.primaryGrey, size: 20);
        }
        break;
      default:
        bgColor = AppColors.primaryUltraLightGrey;
        iconWidget = const Icon(Icons.notifications_none, color: AppColors.primaryGrey, size: 20);
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: notification.category == 'chat' && notification.avatarUrl != null
                ? CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(notification.avatarUrl!),
                  )
                : iconWidget,
          ),
        ),
        if (!notification.isRead)
          Positioned(
            top: -2,
            right: -2,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: AppColors.error,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.surface, width: 2),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildMessageText() {
    // Simple rich text parser for demonstration based on HTML-like tags, 
    // or we can just use normal text. 
    // For now, let's just use simple text since it's hard to guess the bold parts 
    // without a specific format. I will just render text as is.
    // In a real app we'd parse markdown or specific keywords.
    return Text(
      notification.body,
      style: AppTextStyles.bodySmall.copyWith(
        color: AppColors.textSecondaryDark,
        height: 1.4,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
