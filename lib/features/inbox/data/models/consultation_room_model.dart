import '../../domain/entities/consultation_room_entity.dart';

class ConsultationRoomModel extends ConsultationRoomEntity {
  const ConsultationRoomModel({
    required super.id,
    required super.projectId,
    required super.clientId,
    required super.professionalId,
    required super.status,
    required super.createdAt,
    required super.updatedAt,
    super.projectTitle,
    super.otherUserName,
    super.otherUserAvatarUrl,
    super.lastMessage,
    super.lastMessageTime,
    super.unreadCount,
  });

  factory ConsultationRoomModel.fromJson(Map<String, dynamic> json) {
    return ConsultationRoomModel(
      id: json['id'] ?? '',
      projectId: json['project_id'] ?? '',
      clientId: json['client_id'] ?? '',
      professionalId: json['professional_id'] ?? '',
      status: json['status'] ?? 'active',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(),
      projectTitle: json['project_title'],
      otherUserName: json['other_user_name'],
      otherUserAvatarUrl: json['other_user_avatar_url'],
      lastMessage: json['last_message'],
      lastMessageTime: json['last_message_time'] != null
          ? DateTime.parse(json['last_message_time'])
          : null,
      unreadCount: json['unread_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'project_id': projectId,
      'client_id': clientId,
      'professional_id': professionalId,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
