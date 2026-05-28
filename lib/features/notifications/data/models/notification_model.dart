import '../../domain/entities/notification_entity.dart';

class NotificationModel extends NotificationEntity {
  const NotificationModel({
    required super.id,
    required super.userId,
    required super.title,
    required super.body,
    required super.category,
    super.relatedId,
    required super.createdAt,
    required super.isRead,
    super.avatarUrl,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      category: json['category'] ?? 'system_alert',
      relatedId: json['related_id'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : DateTime.now(),
      isRead: json['is_read'] ?? false,
      avatarUrl: json['avatar_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'body': body,
      'category': category,
      'related_id': relatedId,
      'created_at': createdAt.toIso8601String(),
      'is_read': isRead,
      'avatar_url': avatarUrl,
    };
  }

  factory NotificationModel.fromEntity(NotificationEntity entity) {
    return NotificationModel(
      id: entity.id,
      userId: entity.userId,
      title: entity.title,
      body: entity.body,
      category: entity.category,
      relatedId: entity.relatedId,
      createdAt: entity.createdAt,
      isRead: entity.isRead,
      avatarUrl: entity.avatarUrl,
    );
  }
}
