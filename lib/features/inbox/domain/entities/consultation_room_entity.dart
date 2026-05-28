import 'package:equatable/equatable.dart';

class ConsultationRoomEntity extends Equatable {
  final String id;
  final String projectId;
  final String clientId;
  final String professionalId;
  final String status; // 'active' | 'closed'
  final DateTime createdAt;
  final DateTime updatedAt;

  // Joined fields (from users & projects)
  final String? projectTitle;
  final String? otherUserName;
  final String? otherUserAvatarUrl;

  // Last message preview
  final String? lastMessage;
  final DateTime? lastMessageTime;
  final int unreadCount;

  const ConsultationRoomEntity({
    required this.id,
    required this.projectId,
    required this.clientId,
    required this.professionalId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.projectTitle,
    this.otherUserName,
    this.otherUserAvatarUrl,
    this.lastMessage,
    this.lastMessageTime,
    this.unreadCount = 0,
  });

  @override
  List<Object?> get props => [
        id, projectId, clientId, professionalId, status,
        createdAt, updatedAt, projectTitle, otherUserName,
        otherUserAvatarUrl, lastMessage, lastMessageTime, unreadCount,
      ];
}
