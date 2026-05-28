import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  final String id;
  final String userId;
  final String title;
  final String body;
  final String category; // chat, project_approval, milestone_update, payment_status, escrow_payout, system_alert
  final String? relatedId;
  final DateTime createdAt;
  final bool isRead;
  final String? avatarUrl; // Optional for joined user data

  const NotificationEntity({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
    required this.category,
    this.relatedId,
    required this.createdAt,
    required this.isRead,
    this.avatarUrl,
  });

  @override
  List<Object?> get props => [id, userId, title, body, category, relatedId, createdAt, isRead, avatarUrl];
}
